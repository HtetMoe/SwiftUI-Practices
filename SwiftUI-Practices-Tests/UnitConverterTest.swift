//
//  UnitConverterTest.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 24/07/2023.
//

import XCTest

final class UnitConverterTest: XCTestCase {
    
    private var sut : Converters! // sut santds for sys under testing
    
    //to manage memory allocation
    override func setUpWithError() throws { // before run ur code
        //super.setUpWithError()
        //initialize here
        sut = Converters()
    }
    
    override func tearDownWithError() throws { // after run ur code
        //deiniitiallize here
        sut = nil
        //super.tearDownWithError()
    }
    
    func testConverter_BahtToUsd(){
        let actual   = sut.convertBathToUSD(baht: "1000")
        let expected = "$30.00"
        
        XCTAssertEqual(actual, expected)
    }
    
    func testConverter_invalidNegativeInput(){
        let sut      = Converters()
        let actual   = sut.convertBathToUSD(baht: "-10")
        let expected = "Please enter a positive number."
        
        XCTAssertEqual(actual, expected)
    }
    
}
