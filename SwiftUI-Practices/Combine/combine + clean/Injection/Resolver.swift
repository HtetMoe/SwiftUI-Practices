//
//  Resolver.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import Foundation
import Swinject

class Resolver{
    static let shared     = Resolver()
    private var container = buildContainer()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }

    func setDependencyContainer(_ container: Container){
        self.container = container
    }
}

//MARK: - Register Here
func buildContainer() -> Container{
    let container = Container() // build container

    //fetch posts
    container.register(FetchPost.self) { _ in
        return FetchPostUseCase()
    }.inObjectScope(.container)
    
    //repository
    container.register(MyRepository.self) { _ in
        return MyRepositoryImpl()
    }.inObjectScope(.container)
    
    //data source
    container.register(MyDataSource.self) { _ in
        return MyDataSourceImpl()
    }.inObjectScope(.container)
    
    return container
}
