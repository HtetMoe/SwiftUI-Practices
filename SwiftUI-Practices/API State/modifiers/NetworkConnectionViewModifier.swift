//
//  NetworkConnectionViewModifier.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 23/06/2023.
//

import Foundation
import SwiftUI

struct NetworkConnectionViewModifier : ViewModifier{
    @StateObject private var networkMonitor = NetworkMonitor()
    @State private var showPopUp = false
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .onChange(of: networkMonitor.isConnected, perform: { newValue in
                    self.showPopUp = !newValue
                })
                .popup(isPresented: $showPopUp) {
                    InternetConnectionToast()
                } customize: {
                    $0
                        .type(.toast)
                        .position(.bottom)
                        .animation(.spring())
                        .closeOnTapOutside(true)
                        .autohideIn(2)
                        .backgroundColor(.clear)
                }
        }
    }
}

extension View {
    func networkConnectionView() -> some View {
        self.modifier(NetworkConnectionViewModifier())
    }
}

//MARK: - No internet Toast
struct InternetConnectionToast : View {
    var body: some View{
        ZStack {
            Color.green
            
            HStack{
                Image(systemName: "wifi.slash")
                    .foregroundColor(.white)
                    .padding()
                
                Text("No internet connection!")
                    .foregroundColor(.white)
            }.frame(maxWidth : .infinity, alignment: .leading)
        }
        .frame(height : 50)
        .cornerRadius(12)
        .padding()
    }
}
