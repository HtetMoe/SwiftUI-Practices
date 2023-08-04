//
//  URLSessionRequestCombine.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 09/02/2023.
//

import SwiftUI
import Combine

struct URLSessionRequestCombine: View {
    @ObservedObject private var viewModel = CombineViewModel()

    var body: some View {
        VStack{
            Text("posts : \(viewModel.posts.count)")
            
            Button("Fetch data") {
                self.viewModel.fetchData()
            }
            .buttonStyle(.borderedProminent)
        }
        .alert(isPresented: $viewModel.hasError) {
            Alert(title: Text("Error!"),
                  primaryButton: .default(Text("Retry"),action: {viewModel.fetchData()}),
                  secondaryButton: .cancel())
        }
    }
}

struct NetworkRequestCombine_Previews: PreviewProvider {
    static var previews: some View {
        URLSessionRequestCombine()
    }
}

//MARK: - view model
class CombineViewModel : ObservableObject{
    //@Published var data: String = ""
    
    @Published var posts : [Post] = []
    @Published var isLoading = false
    @Published var hasError  = false
    private var disposeBag   = Set<AnyCancellable>()
    
    //MARK: fetch data
    
    func fetchData() {
        isLoading = true
        hasError  = false
        
        let urlString = "https://jsonplaceholder.typicode.com/posts"
        if let url = URL(string: urlString){
            
            URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .map(\.data)
                .tryMap({ data in
                    let decoder = JSONDecoder()
                    guard let posts = try? decoder.decode([Post].self, from: data) else {
                        throw AppError.failedToDecode
                    }
                    return posts
                })
                .sink { [weak self] response in //completion
                    defer{ self?.isLoading = false }
                    
                    switch response {
                    case .failure(let error) :
                        self?.hasError = true
                        debugPrint("Failed : \(error.localizedDescription)")
                    default : break
                    }
                    
                } receiveValue: { posts in
                    self.posts = posts
                }
                .store(in: &disposeBag)
            
//            URLSession.shared
//                .dataTaskPublisher(for: url)
//                .map(\.data)
//                .decode(type: Post.self, decoder: JSONDecoder())
//                .map { $0.title }
//                .replaceError(with: "Error")
//                .receive(on: DispatchQueue.main)
//                .assign(to: \.data, on: self)
//                .store(in: &cancellables)
        }
    }
    
    enum AppError : LocalizedError{
        case defaultError(error : Error)
        case failedToDecode
        
        var errorDescription: String?{
            switch self{
            case .defaultError(let error ) :
                return error.localizedDescription
            case .failedToDecode :
                return "Failed to decode the response Json."
            }
        }
    }
}

//MARK: - data model
struct Post: Codable {
    let id: Int
    let userId : Int
    let title: String
    let body: String
}

