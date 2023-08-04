//
//  ACAViewModel.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import Foundation
import Combine

//MARK: - view model
class ACAViewModel : ObservableObject{
    @Published var posts : [Post] = []
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(){
        self.fetchPosts()
    }
    
    @Inject var fethPostsUseCase : FetchPost
    func fetchPosts(){
        fethPostsUseCase.execute()
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    let errorOccur = error as! NetworkError
                    print(errorOccur.localizedDescription)
                case .finished:
                    break
                }
            } receiveValue: { posts in
                self.posts = posts
            }
            .store(in: &cancellableSet)
    }
}
