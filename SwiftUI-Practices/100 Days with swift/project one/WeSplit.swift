//
//  MyView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 09/03/2023.
//  WeSplit

import SwiftUI
import PDFKit

struct WeSplit: View {
    @State private var checkAmount    = 0.0
    @State private var numberOfPeople = 1
    @State private var tipPercentage  = 10
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalAmount : Double {
        let tipSelection = Double(tipPercentage)
        let tipValue   = checkAmount / 100 * tipSelection
        
        return checkAmount + tipValue
    }
    
    //computed property
    var totalPerPerson: Double {
        let peopleCount  = Double(numberOfPeople + 2) // numOfPeople(index[1]) = 3, So to be 3 -> index + 2
        let tipSelection = Double(tipPercentage)
        
        let tipValue   = checkAmount / 100 * tipSelection
        //print("tip : \(tipValue)")
        
        let grandTotal = checkAmount + tipValue
        //print("total : \(grandTotal)")
        
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    //hide keyboard
    @FocusState private var amountIsFocused : Bool
    
    var body: some View {
        
        NavigationView {
            Form {
                //input amount
                Section {
                    TextField("Type your amount",
                              value  : $checkAmount,
                              format : .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    
                    //choose number of people
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<6){
                            Text("\($0) people")
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                //choose tips %
                Section {
                    //Text("How much tip do you want to leave?")
                    
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                //amount for a person
                Section {
                    Text(totalPerPerson,
                         format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
                
                //total amount
                Section {
                    Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Total amount for the check")
                }
            }
            .navigationTitle("We Split")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement : .keyboard) {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct MyView_Previews: PreviewProvider {
    static var previews: some View {
        WeSplit()
    }
}

