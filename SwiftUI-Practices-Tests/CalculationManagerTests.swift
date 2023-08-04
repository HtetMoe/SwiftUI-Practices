//
//  CalculationManagerTests.swift
//  MyCodesTests
//
//  Created by Htet Moe Phyu on 24/07/2023.
//

import XCTest

//Fundamental of unit testing
final class CalculationManagerTests: XCTestCase {
    
    //sut = system under test
    private var sut : CalculationManager!
    
    override func setUp() {
        super.setUp()
        sut = CalculationManager()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    //check for set values
    func testInit_whenGivenValues_TakeValues(){
        let manager = CalculationManager(valueA: 10, valueB: 2, currentOperant: .add, valueEntryArray: [])
        XCTAssertEqual(manager.valueA, 10)
        XCTAssertEqual(manager.valueB, 2)
        XCTAssertNotNil(manager.currentOperant)
        
        //use Equatable protocol to strut, then check
        let manager1 = CalculationManager(valueA: 10, valueB: 2, currentOperant: .add, valueEntryArray: [])
        XCTAssertEqual(manager, manager1)
    }
    
    //check for values A,B are initially zero
    func testValues_areInitiallyZero(){
        XCTAssertEqual(sut.valueA, 0)
        XCTAssertEqual(sut.valueB, 0)
    }
    
    //check for insert process
    func testValues_InsertingValues_ChangesValueA(){
        sut.insert(10)
        XCTAssertEqual(sut.valueA, 10)
    }
    
    //check operand, initially nil
    func testOperand_IsInitiallyNil(){
        XCTAssertNil(sut.currentOperant, "Operand should be nil")
    }
    
    //check for set operand process
    func testOperand_WhenGivenOperand_setOperand(){
        sut.insert(10)
        sut.set(.subtract)
        XCTAssertNotNil(sut.currentOperant)
    }
    
    //check for calculate process
    func testCalculation_forValues(){
        sut.insert(15)
        sut.set(.subtract)
        sut.insert(5)
        XCTAssertEqual(sut.calculate(), 10)
    }
    
    //check for clear process
    func testClear_WhenCalledClearValues(){
        sut.insert(10)
        _ = sut.clearValues()
        XCTAssertEqual(sut.valueA, 0)
        XCTAssertEqual(sut.valueB, 0)
        XCTAssertEqual(sut.valueEntryArray, [])
    }
    
}
