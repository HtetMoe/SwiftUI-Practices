import UIKit
/*
    - Build a publisher
    - Filter the result to return only the 1st post and the title
 */

import Foundation
import Combine

struct Post: Codable{
    let userId : Int
    let id     : Int
    let title  : String
    let body   : String
}

let emptyPost = Post(userId: 0, id: 0, title: "Empty", body: "No Results")

//1. reate a `dataTaskPublisher`
let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
let publisher = URLSession.shared.dataTaskPublisher(for: url!)
    .map {$0.data}
    .decode(type: [Post].self, decoder: JSONDecoder())
    .map{$0.first}
    .replaceNil(with: emptyPost)
    .compactMap({$0.title})

//2. ubscribe to the publisher
let cancellableSink = publisher
    .sink(receiveCompletion: {completion in
        print(String(describing: completion))
    }, receiveValue: {value in
        print("returned title value :  \(value)")
    })
