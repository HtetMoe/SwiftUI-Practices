import UIKit

/*
 Chapter-4 : Advanced concepts
 
    Schedulers allow you to orchestrate where and when to publish, and Knowing how to queue your upstream publishers, or downstream subscription streams, whether they should be processing in the background, in your main thread, sequence serially or concurrently. When using Combine to update your application’s UI elements, it is crucial you optimize your streams to use the main thread, but to also not degrade the user experiences.
 
 Manage Threads with schedular
    - Define when and how to execute a closure
    - Applied upstream with publishers or downstream via subscriptions
    - 2 common types of operators for orchestrating thread or queue : receive(on:), subscribe(on:)
    - Operators like .delay, .throttle, and .debounce also support Scheduler protocol.
    - Goal : to perform heavy computation in bg thread but all UI-related tasks on the main thread.

 Immediate Scheduler :
    - By default, we are scheduling immediately on the same thread currently
    - .receive(on: ImmediateSchedular.shared)
 
 */


import Foundation
import Combine

struct Post: Codable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

print("Publisher: On main thread?: \(Thread.current.isMainThread)")
print("Publisher: thread info: \(Thread.current)")

let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
let queue = DispatchQueue(label: "a queue")

let publisher = URLSession.shared.dataTaskPublisher(for: url!)
    .map {$0.data}
    .decode(type: Array<Post>.self, decoder: JSONDecoder())
    .receive(on: ImmediateScheduler.shared)

let cancellableSink = publisher
    .subscribe(on: queue)
    //.receive(on: DispatchQueue.global())
    .sink(receiveCompletion: {completion in
        print("Subscriber: On main thread?: \(Thread.current.isMainThread)")
        print("Subscriber: thread info: \(Thread.current)")
    }, receiveValue: {value in
        print("Subscriber: On main thread?: \(Thread.current.isMainThread)")
        print("Subscriber: thread info: \(Thread.current)")
    })
