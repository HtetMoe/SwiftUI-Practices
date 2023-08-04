//
//  AlamofireWithCombineSample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 05/04/2023.
//  SwiftUI + MVVM + Combine + Alamofire.

import SwiftUI
import Alamofire
import Combine

struct AlamofireCombineProtocolDemo: View {
    @ObservedObject var viewModel = AFcombineViewModel()
    
    var body: some View {
        VStack(alignment : .leading){
            if let beerData = viewModel.beer{
                Text("Name  : \(beerData.name)")
                Text("Brand : \(beerData.brand)")
            }
        }
    }
}

struct AlamofireWithCombineSample_Previews: PreviewProvider {
    static var previews: some View {
        AlamofireCombineProtocolDemo()
    }
}

//MARK: - Network service
protocol ServiceProtocol {
    func fetchBeer() -> AnyPublisher<DataResponse<Beer, AFError>, Never>
}

class NetworkService : ServiceProtocol{
    static let shared: ServiceProtocol = NetworkService()
    
    //fetch beer
    func fetchBeer() -> AnyPublisher<DataResponse<Beer, AFError>, Never> {
        return AF.request("https://random-data-api.com/api/v2/beers", method: .get)
            .validate()
            .publishDecodable(type: Beer.self)
            .map { response in
                response.mapError { error in
                    return error
                }
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

//MARK: - view mode
class AFcombineViewModel : ObservableObject{
    private var cancellableSet: Set<AnyCancellable> = []
    @Published var beer : Beer? = nil
    @Published var errorMessage = ""
    
    var dataManager: ServiceProtocol
    init(dataManager : ServiceProtocol = NetworkService.shared){
        self.dataManager = dataManager
        self.fetchBeer()
    }
    
    func fetchBeer(){
        dataManager.fetchBeer()
            .sink { responseData in // .sink{} is to observe changes to this variable and perform some action when it changes
                switch responseData.result{
                case .success(let data) :
                    self.beer = data
                case .failure(let error) :
                    self.errorOccur(with: error)
                }
            }.store(in: &cancellableSet)
    }
    
    func errorOccur(with error: AFError){
        self.errorMessage = error.localizedDescription
        print("Error : \(errorMessage)")
    }
}

//MARK: - error
enum BaseError : LocalizedError{
    case defaultError(error : Error)
    case failedToDecode
    case worongURL
    
    var errorDescription: String?{
        switch self{
        case .defaultError(let error ) :
            return error.localizedDescription
        case .worongURL :
            return "URL is not correct"
        case .failedToDecode :
            return "Failed to decode the response Json."
        }
    }
}
