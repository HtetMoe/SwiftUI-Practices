//
//  MyDataSource.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import Foundation
import Combine

protocol MyDataSource {
    func fetchPosts() -> AnyPublisher<[Post], Error>
}
