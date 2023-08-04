//
//  DisablingForm.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 11/07/2023.
//

import SwiftUI

struct DisablingForm: View {
    @State private var username = ""
    @State private var email    = ""
    
    //validate
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
    var body: some View {
        Form {
            
            Section {
                TextField("Username", text: $username)
                    .autocorrectionDisabled()
                
                TextField("Email", text: $email)
                    .autocorrectionDisabled()
            }
            
            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(disableForm)
            
        }
    }
}

struct DisablingForm_Previews: PreviewProvider {
    static var previews: some View {
        DisablingForm()
    }
}
