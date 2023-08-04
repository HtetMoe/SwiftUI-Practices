//
//  AlamofireSample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 04/04/2023.
//

import SwiftUI
import Alamofire

struct AlamofireSample: View {
    @StateObject var viewModel = AFViewModel()
    var body: some View {
        
        VStack(alignment : .leading){
            if let beerData = viewModel.beer{
                Text("Name  : \(beerData.name)")
                Text("Brand : \(beerData.brand)")
            }
        }
        .onAppear{
            //fetch beer
            viewModel.fetchBeer()
        }
    }
}

struct AlamofireSample_Previews: PreviewProvider {
    static var previews: some View {
        AlamofireSample()
    }
}

//MARK: - view model
class AFViewModel : ObservableObject{
    @Published var beer : Beer? = nil
    
    //fetch data
    func fetchBeer(){
        AF.request("https://random-data-api.com/api/v2/beers")
            .validate()
            .responseData { response in
                switch response.result{
                case .success(let data):
                    do {
                        let responseData = try JSONDecoder().decode(Beer.self, from: data)
                        self.beer = responseData
                        
                    } catch let error {
                        print("Decoding error : \(error.localizedDescription)")
                    }
                case .failure(let error) :
                    print("error : \(error)")
                }
            }
    }
}

//MARK: common response
struct ResponseData <T:Codable> : Codable {
    var status : String
    var message     : String
    var data        : T? // multiple data models
}

// MARK: - Beer
struct Beer: Codable {
    let id: Int
    let uid, brand, name, style: String
    let hop, yeast, malts, ibu: String
    let alcohol, blg: String
}
