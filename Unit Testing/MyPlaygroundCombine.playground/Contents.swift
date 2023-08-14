import UIKit
import Combine
////var greeting = "Hello, playground"
//
////MARK: - 1. A simple publisher using Just, to produce once for each subscriber
//let _ = Just("Hello world")
//    .sink { (value) in
//        print("value is \(value)")
//    }
//
////MARK: - 2. Taking advantage of NotificationCenter's publisher
//let notification = Notification(name: .NSSystemClockDidChange, object: nil, userInfo: nil)
//let notificationClockPublisher = NotificationCenter.default.publisher(for: .NSSystemClockDidChange)
//    .sink(receiveValue: { (value) in
//        print("value is \(value)")
//    })
//NotificationCenter.default.post(notification)
//
////---------------------------
//
////MARK: - 1. create a new publisher operator, to square each value, using `map()`
//[1,5,9]
//    .publisher
//    .map { $0 * $0 }
//    .sink { print($0) } // output : 1, 25, 81
//
//
////MARK: - 2. use `decode()` with `map()` to convert a REST respones to an object
//let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
////model
//struct Task: Decodable {
//    let id: Int
//    let title: String
//    let userId: Int
//    let body: String
//}
////REST API call with combine and decode the response
//let dataPublisher = URLSession.shared.dataTaskPublisher(for: url)
//    .map{$0.data}
//    .decode(type: [Task].self, decoder: JSONDecoder())
//let cancellableSink = dataPublisher
//    .sink(receiveCompletion: { completion in
//        print(completion)
//    }, receiveValue: { items in
//        print( "Result \(items[0])")
//    })
//
////---------------------------
//
///*
// Subscriber protocol
//
// - Contract to receive sequence of values
// - Has 2 possible outcomes : input and failure
// - Continues to receive as publisher transmits ( demand)
// - Handle data in 2 ways : sink and assign for receiving values
// - Sink : provides 2 types of closures 1) receiving a completion event 2) receiving values
// - Assign : let you assign the received value
// - When it doesn’t want to continue to receive values, conform to Anycancellable method to cancel
// */
//
////MARK: - wroking with sink and assign
//[1, 5, 9]
//    .publisher
//    .sink { print($0) }
//
//let label = UILabel()
//Just("John")
//    .map {"My name is \($0)"}
//    .assign(to: \.text, on: label) // output : "My name is John"
//
////---------------------------
///*
// Subject protocol
//
// - Apple defines subjects as publishers that exposes a method for outside callers to publish elements
// - Commonly used this approach for bridging code from the old imperative world into the modern, new combine world.
// - .send() method used to emit select values to one or more subscribers.
// - A subject is an aggregator for multiple subscribers, via subscriber demands signaling unlimited demand from connected publishers.
// - There are 2 build-in subjects : currentValueSubject and passthroughSubject
// - currentValueSubject persists initial state values for subscribers, unlike passThroughSubject.
// - However, they both emit data to subscribers through the .send() method.
// - Then create publishers from objects which conform to ObservableObject protocol
//
// */
//
////MARK: - passThroughSubject, CurrentValueSubject
//
////1.declare an Int PassthroughSubject
//let subject = PassthroughSubject<Int, Never>()
//
////2.attach a subscriber to the subject
//let subscription = subject
//    .sink{ print($0)}
//
////3.publish the value `94`, via the subject, directly
//subject.send(94)
//
////4.connect subject to a publisher, and publish the value `29`
//Just(29)
//    .subscribe(subject)
//
////5.declare amnother subject, a CurrentValueSubject, with an initial `I am a...` value cached
//let anotherSubject = CurrentValueSubject<String, Never>("I am a....")
//
////6.attach a subscriber to the subject
//let anotherSubscription = anotherSubject
//    .sink{print($0)}
//
////7.publish the value `Subject`, via the subject, directly
//anotherSubject.send("Subject")
//
//
////---------------------------------------------
///*:
// Future and Just
// Future and Just are two special types of Publishers.
// Just emits just once, before terminating, whereas Future culminates in a single result, either an output value or failure completion, initialized by wrapping any asynchronous call.
// */
//
////1.a simple publisher using Just, to produce once to each subscriber, before 💀
//let _ = Just("A data stream")
//    .sink { (value) in
//        print("value is \(value)")
//    }
//
////2. connect subject to a publisher, and publish the value `29`
//let subject = PassthroughSubject<Int, Never>()
//
//Just(29)
//    .subscribe(subject)
//
////3. a simple use of Future, in a function
//enum FutureError: Error{
//    case notMultiple
//}
//
//let future = Future<String, FutureError> { promise in
//    let calendar = Calendar.current
//    let second = calendar.component(.second, from: Date())
//    print("second is \(second)")
//    if second.isMultiple(of: 3){
//        promise(.success("We are successful: \(second)"))
//    }else{
//        promise(.failure(.notMultiple))
//    }
//}.catch{error in
//    Just("Caught the error")
//}
//    .delay(for: .init(1), scheduler: RunLoop.main)
//    .eraseToAnyPublisher()
//
//future.sink(receiveCompletion: {print($0)},
//            receiveValue: {print($0)})
//
////-----------------------------------------------------------------
///*
// Create a simple Combine Data Stream
//
// 1. A publisher that will emit the values of a Bool array.
// 2. A subscriber that will listen to the values and assign to a textField’s isEnable property.
// 3. An operator that will drop the first two elements before allowing the publisher to publish.
// */
//
//let textField = UITextField()
//
////1. create a publisher, which publishes the following boolean array
//let array = [true, false, false, false, false, true, true]
//let publisher = array.publisher
//
////2. create a subscriber, to assign to the textfield's isEnabled property, when publisher emits new data, from the publisher
//let subscriber = publisher.assign(to: \.isEnabled, on: textField)
//textField.publisher(for: \.isEnabled)
//    .sink{
//        print($0)
//    }
////3. add an operator, to drop the first 2 elements from the publisher, before the subscriber assigns to the button
//let _ = publisher.dropFirst(2)
//    .sink{
//        print($0)
//    }
//------------------------------------------------------
///*
// # Chapter 3.1 - REST api call with DataTaskPublisher
// */
//
//struct Post: Codable{
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//}
//
//let samplePost = Post(userId : 1, id: 2,
//                      title  : "This is title.",
//                      body   : "This is body.")
//
////1. create a `dataTaskPublisher`
//let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
//let publisher = URLSession.shared.dataTaskPublisher(for: url!)
//    .map {$0.data}
//    .decode(type: Array<Post>.self, decoder: JSONDecoder())
//
////2. subscribe to the publisher
//let cancellableSink = publisher
//
//    // map error with error handling
//    .retry(2)
//    .mapError{ error -> Error in
//        switch error{
//        case URLError.cannotFindHost:
//            return APIError.networkError(error: error.localizedDescription)
//        default:
//            return APIError.responseError(error: error.localizedDescription)
//        }
//    }
//    //handle completion
//    .sink(receiveCompletion: {completion in
//        print(String(describing: completion))
//    }, receiveValue: {value in
//        print("returned value \(value.count)")
//    })
//
//enum APIError: Error{
//    case networkError(error: String)
//    case responseError(error: String)
//    case unknownError
//}
//----------------------------------------------
////Throw and catch in combine
//
//
////(3) A simple Publisher example with `.tryMap` and `.catch`
//Just(7)
//    .tryMap{ _ in
//        throw APIError.unknownError
//    }
//    .catch { result in
//        Just(2)
//    }
//    .sink {print($0)}
//



