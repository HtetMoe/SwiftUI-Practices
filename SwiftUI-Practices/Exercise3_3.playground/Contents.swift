import UIKit

/*
    Like error handling, testing is also a fundamental part of development.
    - Create subscribers in your test case to test your publishers.
 */

import Foundation
import Combine

import XCTest

class MyTests : XCTestCase {
    var subscriptions = Set<AnyCancellable>()
    let expectedTitle = "sunt aut facere repellat provident occaecati excepturi optio reprehenderit"
    let expectedId    = 1
    
    func testPublisher() {
        let _ = APIService.getPosts()
            .sink(receiveCompletion: { error in
                print("Completed subscription \(String(describing:error))")
            }, receiveValue: {results in
                print("Got \(results.count) posts back")
                
                XCTAssert(results.count > 0)
                
                XCTAssert(results.count == 100,
                          "We got \(results.count) instead of 100 posts back")
                
                XCTAssert(results[0].title == self.expectedTitle,
                          "We got back the title \(results[0].title) instead of \(self.expectedTitle)")
            })
            .store(in: &subscriptions)
    }
}


class TestObserver : NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase, didFailWithDescription description: String, inFile filePath: String?, atLine lineNumber: Int) {
        print("🚫 \(description) line:\(lineNumber)")
    }
    
    func testCaseDidFinish(_ testCase: XCTestCase) {
        if testCase.testRun?.hasSucceeded == true {
            print("✅ \(testCase)")
        }
    }
}

let observer = TestObserver()
XCTestObservationCenter.shared.addTestObserver(observer)

MyTests.defaultTestSuite.run()


//MARK: - implement APIService

enum ApiError: Error{
    case invalidRequest
}

class APIService{
   
    //get the post from REST
    public static func getPosts() -> AnyPublisher<[Post], Error>{
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        return URLSession.shared.dataTaskPublisher(for: url!)
            .tryMap { data, response -> Data in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw ApiError.invalidRequest
                }
                return data
            }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

//MARK: - data model
struct Post: Codable {
    let id     : Int
    let userId : Int
    let title  : String
    let body   : String
}





