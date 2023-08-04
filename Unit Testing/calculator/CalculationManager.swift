//
//  CalculationManager.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 24/07/2023.
//

import Foundation

struct CalculationManager : Equatable {
    var valueA = 0
    var valueB = 0
    var currentOperant : Operand?
    var valueEntryArray : [Int] = []
    
    //asign the value A and B
    mutating func insert(_ value : Int){
        if valueA == 0{
            self.valueA = value
        }
        else{
            self.valueB = value
        }
    }
    
    //set operand and values
    mutating func set(_ operand : Operand){
        currentOperant = operand
        setValues()
    }
    
    //append value
    mutating func append(_ value : Int){
        valueEntryArray.append(value)
    }
    
    //clear
    mutating func clearValues() -> String{
        valueEntryArray = []
        valueA = 0
        valueB = 0
        return "\(valueEntryArray.count)"
    }
    
    //convert int[] to string[] -> [1,2,3] to 123
    func stringifyValues() -> String{
        var stringAry : [String] = []
        for int in valueEntryArray{
            stringAry.append(String(int))
        }
        return stringAry.joined()
    }
    
    //set values
    mutating func setValues(){
        var valueString = ""
        _ = valueEntryArray.map {  valueString += "\($0)" }
        guard let intValue = Int(valueString) else { return }
        insert(intValue)
        valueEntryArray = []
    }
    
    //calculate
    mutating func calculate() -> Int{
        setValues()
        
        guard let currentOperant = currentOperant else {fatalError()}
        switch currentOperant{
            
        case .add:
            return valueA + valueB
        case .subtract:
            return valueA - valueB
        case .multiply:
            return valueA * valueB
        case .divide:
            return valueA / valueB
        case .decimal:
            print("do nth")
            return 0
        case .percentage:
            print("do nth")
            return 0
        case .plusMinus:
            print("do nth")
            return 0
        }
    }
}

//MARK: operands
enum Operand : String {
    case add      = "+"
    case subtract = "-"
    case multiply = "×"
    case divide   = "÷"
    case decimal    = "."
    case percentage = "%"
    case plusMinus = "+/-"
}
