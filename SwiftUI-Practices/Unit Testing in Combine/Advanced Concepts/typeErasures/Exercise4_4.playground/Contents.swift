import UIKit
import Foundation
import Combine

/*
 Type Erasures
    Combine also has an equivalent notion of implementation access, called Type
    Erasures. They let you design your Publishers so that you don’t have to
    overexposed inner details of that publisher.
 
 
 Abstract combine impls with TypeErasures
 Type Erasures :
    - Swift has access controls to restrict access to structs, classes and methods, or properties
    - Combine has type erasures to obfuscate inner workings of publishers
    - Any publisher structs, conforming to Publisher protocol
    - Can’t add values to AnyPublisher via .send()
 
 Cancellable
    - One subscriber side, AnyCancellable
    - This is another type of Erasures class enable cancelling of subscriptions
    - Also obfuscates inner details of a subscription
 
 */

struct Post: Codable{
    let userId : Int
    let id     : Int
    let title  : String
    let body   : String
}

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
let publisher = URLSession.shared.dataTaskPublisher(for: url!)
    .map {$0.data}
    .decode(type: Array<Post>.self, decoder: JSONDecoder())

//(1) Add `.eraseToAnyPublisher()`
    .eraseToAnyPublisher()

let cancellableSink = publisher

    .sink(receiveCompletion: {completion in
        print(String(describing: completion))
    }, receiveValue: {value in
        print("returned value \(value.count)")
    })
