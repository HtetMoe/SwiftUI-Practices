//
//  APIStatusDemoViewModel.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 22/06/2023.
//

import Foundation
import Alamofire

class APIStatusDemoViewModel : ObservableObject {
    @Published var status   : ApiStatus = .idle
    @Published var response : Joke?     = nil
    @Published var apiError : APIError? = nil
    
    //monitor the connection
    let monitor : NetworkMonitor
    
    init(){
        self.monitor = NetworkMonitor.shared
    }
    
    func fetchAJoke() {
        guard monitor.isConnected else {
            status = .noInternet
            return
        }
        
        let endPoint = "https://official-joke-api.appspot.com/random_joke"
        
        //check url first
        guard let url = URL(string: endPoint) else {
            self.apiError = .invalidURL(endPoint)
            return
        }
        
        //fetch REST
        fetchData(endPoint: endPoint) { data in
            do {
                self.response = try self.decodeResponse(data: data)
            } catch let error {
                self.apiError = .decodingError(error)
                self.status   = .fail(error : self.apiError!, showAlert: false)
            }
        }
    }
    
    //MARK: common REST fetching
    func fetchData(endPoint : String, successHandler : @escaping (Data) -> Void) {
        status = .loading
        AF.request(endPoint)
            .validate()
            .responseData { response in
                switch response.result {
                    
                case .success(let data):
                    successHandler(data)
                    self.status   = .success
                    
                case .failure(let error):
                    self.apiError = .serverError(error)
                    self.status   = .fail(error: self.apiError!, showAlert: false)
                }
            }
    }
    
    //MARK: common Decoder
    func decodeResponse<T: Decodable>(data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}

//status
enum ApiStatus {
    case idle
    case loading
    case success
    case fail(error : APIError, showAlert : Bool)
    case noInternet
}


//Error Handling
enum APIError: Error {
    case serverError(Error)
    case decodingError(Error)
    case invalidURL(String)
    case customError(String)
    
    var errorMessage : String {
        switch self{
        case .serverError(let error) :
            return "Server Error : \(error.localizedDescription)"
        case .decodingError(let error) :
            return "Decoding error occurred : \(error.localizedDescription)"
        case .invalidURL(let endPoint):
            return "Invalid URL error occurred : \(endPoint)"
        case .customError(let error):
            return error
        }
    }
}

//models
struct Joke : Codable {
    let type, setup, punchline: String
    let id: Int
}
