//
//  MyDataSourceImpl.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import Foundation
import Combine
import Alamofire

struct MyDataSourceImpl : MyDataSource {
    
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        return AF.request(url)
            .publishDecodable(type: [Post].self)
            //.value()
            .tryMap { response in
                guard let posts = response.value else {
                    throw NetworkError.decodingError
                }
                return posts
            }
            .mapError { error -> Error in
                return error
            }
            .eraseToAnyPublisher()
    }
}


enum NetworkError : Error {
    case serverError(error : Error)
    case decodingError
    case invalidURL
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL!"
        case .decodingError:
            return "Failed to decode the response Json."
        case .serverError(let error):
            return error.localizedDescription
        }
    }
}
