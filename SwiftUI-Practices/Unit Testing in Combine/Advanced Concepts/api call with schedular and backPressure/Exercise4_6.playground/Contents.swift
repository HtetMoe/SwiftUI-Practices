import UIKit
import Foundation
import Combine

/*
 
 - This is to implemtnt for Delay, and Backpressure to control the data consumed
 
 API call using scheduler and backPressures
    - Create a delay of 3 secs on the publisher
    - Implement BackPressure through a custom subscriber
    - Toggle the threshold and observe the results

 */

var queue: DispatchQueue = DispatchQueue(label: "Queue")

let numberPublisher = (0...100)
    .publisher

//1. set a delay of 3 seconds before retrieving data
    .delay(for: 2.0, scheduler: queue)

//2. create a custom Subscriber that implements Backpressure.
final class CustomSubscriber: Subscriber{
    
    typealias Input = Int
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        subscription.request(.max(5)) //.unlimited
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Number: \(input)")
        return .none
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Subscription \(completion)")
    }
}
let subscription = CustomSubscriber()
numberPublisher.subscribe(subscription)

