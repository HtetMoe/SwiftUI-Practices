//
//  FuncErrorHandling.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 24/05/2023.
//

import SwiftUI

struct ErrorHandlingFunctionDemo: View {
    
    @State var password : String = "12345"
    @State var result : String = ""
    
    var body: some View {
        Form{
            TextField("Enter password", text: $password)
                .textFieldStyle(.roundedBorder)
            
            Button("Check") {
                do{
                    result = try checkPassword(password)
                }
                catch{
                    result = error.localizedDescription
                }
            }
            .buttonStyle(.borderedProminent)
            .frame(alignment: .center)
            .frame(maxWidth : .infinity)
            
            Text("RESULT : \(result)")
        }
    }
    
    func checkPassword(_ password : String) throws -> String{
        if password.count < 5 {
            throw PasswordError.short
        }
        if password == "12345" {
            throw PasswordError.obvious
        }
        
        if password.count < 8 {
            return "OK"
        } else if password.count < 10 {
            return "Good"
        }else {
            return "Excellent"
        }
    }
    
    enum PasswordError: Error {
        case short, obvious
    }
}

struct ErrorHandlingFunctionDemo_Previews: PreviewProvider {
    static var previews: some View {
        ErrorHandlingFunctionDemo()
    }
}
