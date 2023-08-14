import UIKit
import Foundation
import Combine
/*:

 Backpressure :
    Backpressure is a quite overlooked yet powerful control knob in the Publisher/Subscriber model, supported by the framework. I will spend a few minutes going through what Backpressure in Combine is, and why you would want to make use of it.

 Throttle publisher data with backPressure
    - Subscriber-centric pull design
    - Subscriber request values and demands how much
    - You control the backPressure(demand) flow to ingest how much you can handle
    - Demand is increased incrementally each time new value is received by subscriber.
*/

let cityPublisher = (["San Jose", "San Francisco", "Menlo Park", "Palo Alto", ]).publisher

final class CitySubscriber: Subscriber{

    func receive(subscription: Subscription) {
        subscription.request(.max(2)) // how many values we want to receive from the publisher
        //subscription.request(.unlimited)
    }
    
    //to output the results, and returns the requested number of items, sent to a publisher from a subscriber via the subscription.
    func receive(_ input: String) -> Subscribers.Demand {
        print("City: \(input)")
        return .none
    }
    
    //completion with an error
    func receive(completion: Subscribers.Completion<Never>) {
        print("Subscription \(completion)")
    }
    
    typealias Input = String
    typealias Failure = Never
    
}


let citySubscription = CitySubscriber()
cityPublisher.subscribe(citySubscription)
