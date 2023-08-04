//
//  ApiStatusViewModifier.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 23/06/2023.
//

import Foundation
import SwiftUI

struct APIStatusViewModifier : ViewModifier {
    let status : ApiStatus
    let action : () -> Void //= {}
    
    func body(content: Content) -> some View {
       
        ZStack{
            switch status {
                
            case .idle:
                ProgressView("Loading")
                
            case .loading:
                ZStack(alignment: .bottom) {
                    content
                    
                    ProgressView("Loading")
                }
                
            case .success:
                content
                
//            case .fail(let error):
//                ErrorView(errorMessage: error.errorMessage) {
//                    action()
//                }
                
            case .fail(let error, let showAlert):
                if showAlert{
                    content.alert(isPresented: Binding<Bool>(
                        get: { !error.errorMessage.isEmpty },
                        set: { newValue in
                            if !newValue {
                                action()
                            }
                        }
                    )) {
                        Alert(title: Text("Error"),
                              message: Text(error.errorMessage),
                              dismissButton: .default(Text("OK")))
                    }
                }
                else{
                    ErrorView(errorMessage: error.errorMessage, action: {
                        action()
                    })
                }
                
            case .noInternet:
                NoInternetView {
                    action()
                }
            }
        }
    }
}


extension View {
    func apiStatusModifier(status: ApiStatus, action: @escaping () -> Void) -> some View {
        self.modifier(APIStatusViewModifier(status: status, action: action))
    }
}
