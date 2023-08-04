//
//  TimeManagerTest.swift
//  MyCodesTests
//
//  Created by Htet Moe Phyu on 24/07/2023.
//

import XCTest

final class TimeManagerTest: XCTestCase {
    var timeManager : TimeManager!
    
    override func setUp() { //instantiate
        super.setUp()
        timeManager = TimeManager()
    }
    
    override func tearDown() { // deinstantiate
        timeManager = nil
    }
    
    func testTimeDisplay_ShouldReturnAppendingMessageForTime(){
        let post = POST(timeAgo: 30, time: .minute)
        let message = timeManager.displayTimeAgo(forPost: post)
        XCTAssertEqual(message, "30 minutes ago")
    }
}
