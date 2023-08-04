//
//  CalculatorViewControllerTests.swift
//  MyCodesTests
//
//  Created by Htet Moe Phyu on 25/07/2023.
//

import XCTest

//This is UI test code for view controller 
final class CalculatorViewTests: XCTestCase {
//    /*
//     Important Note
//
//     In SwiftUI, you can use the XCTest framework to perform unit tests on the associated CalculatorViewModel.
//     However, keep in mind that SwiftUI views are generally more challenging to test directly due to their
//     stateful and declarative nature. In this case, you can focus on testing the ViewModel, which is
//     responsible for the underlying logic.
//
//     This is for using Storyboard and controller
//
//     */
//
//    var sut : CalculatorViewController!
//
//    override func setUp() {
//        super.setUp()
//
//        let storyboard = UIStoryboard(name : "main", bundle : nil)
//        sut = storyboard.instantiateViewController(withIdentifier : "CalculatorViewController") as! CalculatorViewController
//        sut.loadViewIfneeded()
//
//    }
//    override func tearDown() {
//        sut = nil
//        super.tearDown()
//    }
//
//    //check for Label of userInput when number buttons pressed
//    func testAddingValue_ShouldAppendUpdateInput(){
//        sut.twoButton.sendAction(for : .touchUpInside)
//        sut.fiveButton.sendAction(for : .touchUpInside)
//        XCTAssertEqual(sut.valueLavel.text, "25")
//    }
//
//    //check for equalButton pressed
//    func testEqualButton_ShouldPerformCalculationAndUpdateLabel(){
//        sut.twoButton.sendAction(for : .touchUpInside)
//        sut.fiveButton.sendAction(for : .touchUpInside)
//        sut.subtractButton.sendAction(for : .touchUpInside)
//        sut.fiveButton.sendAction(for : .touchUpInside)
//        sut.equalButton.sendAction(for : .touchUpInside)
//        XCTAssertEqual(sut.valueLabel.text, "20") // 25 - 5 = 20
//
//    }
//
//    //check for operands button pressed
//    func testOperandButtons_ShouldChangeOperandWhenPressed(){
//        sut.twoButton.sendAction(for : .touchUpInside) //2
//        sut.multiplyButton.sendAction(for : .touchUpInside) //*
//        sut.addButton.sendAction(for : .touchUpInside) //+
//        sut.fiveButton.sendAction(for : .touchUpInside) //5
//        sut.equalButton.sendAction(for : .touchUpInside) //= pressed
//
//        // 2 + 5 = 7, it should be 7 of addition result. not multiplication's result
//        XCTAssertEqual(sut.valueLabel.text, "20")
//    }
//
//    //check for AC button pressed
//    func testCleanButton_ShouldClearLabel(){
//        sut.twoButton.sendAction(for : .touchUpInside)
//        sut.ACButton.sendAction(for : .touchUpInside)
//        XCTAssertEqual(sut.valueLabel.text, "0")
//    }

}
