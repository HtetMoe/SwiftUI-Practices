//
//  Inject.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import Foundation

@propertyWrapper
struct Inject<T>{
    let wrappedValue: T

    init(){
        self.wrappedValue = Resolver.shared.resolve(T.self)
    }
}
