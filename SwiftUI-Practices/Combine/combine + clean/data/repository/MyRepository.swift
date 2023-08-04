//
//  MyRepository.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import Foundation
import Combine

protocol MyRepository{
    func fetchPosts() -> AnyPublisher<[Post], Error>
}
