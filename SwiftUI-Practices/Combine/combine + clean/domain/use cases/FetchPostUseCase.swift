//
//  FetchPostUseCase.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import Foundation
import Combine

//MARK: use case
protocol FetchPost{
    func execute() -> AnyPublisher<[Post], Error>
}
struct FetchPostUseCase : FetchPost{
    @Inject var repo : MyRepository
    
    func execute() -> AnyPublisher<[Post], Error> {
        repo.fetchPosts()
    }
}
