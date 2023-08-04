//
//  Resource.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 22/06/2023.
//

import Foundation

class Resource<T>{
    let status: APIStatus
    let data: T?
    let errorMsg: String?
    
    private init(status: APIStatus, data: T?, errorMsg: String?) {
        self.status   = status
        self.data     = data
        self.errorMsg = errorMsg
    }
    
    static func success(data: T?) -> Resource<T> {
        return Resource(status: .success, data: data, errorMsg: nil)
    }
    
    static func error(errorMsg: String?) -> Resource<T> {
        return Resource(status: .error, data: nil, errorMsg: errorMsg)
    }
    
    static func loading(data: T?) -> Resource<T> {
        return Resource(status: .loading, data: data, errorMsg: nil)
    }
}


//MARK: API status
enum APIStatus {
    case success
    case error
    case loading
}
