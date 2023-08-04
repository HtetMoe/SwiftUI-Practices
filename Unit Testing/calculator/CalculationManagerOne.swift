//
//  CalculationManager.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 24/07/2023.
//

import Foundation

class CalculationManagerOne{
    
    func calculate(_ input : String) -> String{
        var resultValue = ""
        let expression = NSExpression(format: input)
        if let result  = expression.expressionValue(with: nil, context: nil) as? Double {
            resultValue = String(result)
        } else {
            resultValue = "Error"
        }
        return resultValue
    }
    
}
