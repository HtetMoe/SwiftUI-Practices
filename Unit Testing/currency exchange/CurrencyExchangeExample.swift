//
//  UnitTestingSample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 19/01/2023.
//

import SwiftUI
import Foundation

struct CurrencyExchangeExample: View {
    @StateObject var vm = UnitTestingViewModel()
    
    var body: some View {
        Form{
            VStack(spacing : 20){
                Text(vm.convertedText)
                    .font(.headline)
                
                TextField("Enter a value (Baht)", text: $vm.inputText)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.decimalPad)
                    .submitLabel(.done)
                
                Button("Convert") {
                    vm.convertMoney()
                }
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
    }
}

struct UnitTestingSample_Previews: PreviewProvider {
    static var previews: some View {
        CurrencyExchangeExample()
    }
}


//MARK: - view model
class UnitTestingViewModel : ObservableObject{
    @Published var inputText     = ""
    @Published var convertedText = "$0"
    private let converter = Converters()
    
    //convert
    func convertMoney(){
        self.convertedText = converter.convertBathToUSD(baht: inputText)
        self.hideKeyboard()
    }
    
    //hide ke yboard
    private func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//MARK: Converter class
class Converters {
   
    func convertBathToUSD(baht : String) -> String{
        let usdRate  = 0.03 // 1 Baht = $0.03
        let bathValue = Double(baht) ?? 0
        
        if bathValue <= 0 {
            return "Please enter a positive number."
        }
        
        if bathValue >= 1_000_000{
            return "Value is too big to convert."
        }

        return "$\(String(format: "%.2f", bathValue * usdRate))" // format in $0.03
    }
}

