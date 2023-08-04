//
//  StatusBarExample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 23/06/2023.
//

import SwiftUI
import PopupView

struct SnackBarExample: View {
    @State private var showPopUp = false
    
    var body: some View {
        VStack {
            Button("Show popup") {
                showPopUp.toggle()
            }.buttonStyle(.bordered)
        }
        .popup(isPresented: $showPopUp) {
            Toast()
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

struct StatusBarExample_Previews: PreviewProvider {
    static var previews: some View {
        SnackBarExample()
    }
}

//MARK: Toast view
struct Toast : View{
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
