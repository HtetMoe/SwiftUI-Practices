//
//  CalculatorViewModel.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 24/07/2023.
//

import Foundation

class CalculatorViewModel : ObservableObject{
    private var manager = CalculationManager() //private let manager1 = CalculationManagerOne()
    
    @Published var valueLabel: String = "0"
    func handleButtonPressed(_ value : String){
        if !isOperand(value){
            print("pressed on number : \(value)")
            manager.append(Int(value) ?? 0)
            valueLabel = manager.stringifyValues()
        }
        else{
            print("pressed on operand : \(value)")
            if value == "="{ //calculate
                let calculationString = String(manager.calculate())
                self.valueLabel = calculationString
            }
            else if value == "AC"{ // clear
                self.valueLabel = manager.clearValues()
            }
            else{
                guard let operand = Operand(rawValue: value) else { return }
                manager.set(operand)
            }
        }
    }
    
    //check chars
    private func isOperand(_ char: String) -> Bool {
        let operands: [String] = ["%", "+/-", "AC", "÷", "×", "-", "+", "=", "."]
        return operands.contains(char)
    }
    
//    func handleButtonTap(_ title: String) {
//        switch title {
//        case "AC":
//            input = "0"
//        case "=":
//            self.calculateResult()
//        case "%":
//            input = String(Double(input)! / 100.0)
//        case "+/-":
//            input = String(Double(input)! * -1)
//        case "×":
//            input += "*"
//        default:
//            if input == "0" {
//                input = title
//            } else {
//                input += title
//            }
//        }
//    }
//
//    func calculateResult() {
//        input = manager1.calculate(input)
//    }
}
