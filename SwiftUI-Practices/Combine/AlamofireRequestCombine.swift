//
//  AlamofireRequestCombine.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import SwiftUI
import Combine
import Alamofire

struct AlamofireRequestCombine: View {
    @StateObject var viewModel = AFCombineViewModel()
    
    var body: some View {
        List{
            ForEach(viewModel.posts, id : \.id) { post in
                Text(post.title)
            }
        }
    }
}

struct AlamofireRequestCombine_Previews: PreviewProvider {
    static var previews: some View {
        AlamofireRequestCombine()
    }
}

//MARK: view model
class AFCombineViewModel : ObservableObject{
    @Published var posts : [Post] = []
    
    private var task : Cancellable? = nil
    let  baseURL = "https://jsonplaceholder.typicode.com/posts"
    
    
    init(){
        fetchData()
    }
    
    func fetchData(){
        self.task = AF.request(baseURL, method: .get)
            .publishDecodable(type: [Post].self)
            .sink(receiveCompletion: { completion in
                switch completion{
                case .finished : break
                case .failure(let error) : print("Failed : \(error.localizedDescription)")
                }
            }, receiveValue: {[weak self] response in
                switch response.result{
                case .success(let response) :
                    self?.posts = response
                case .failure(let error) :
                    print("Failed : \(error.localizedDescription)")
                }
            })
    }
}
