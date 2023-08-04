//
//  ViewModifierBootCamp.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 18/03/2023.
//

import SwiftUI

struct ViewModifierBootCamp: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .withDefaultBtnFormatting()
    }
}

struct ViewModifierBootCamp_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifierBootCamp()
    }
}

extension View {
    func withDefaultBtnFormatting() -> some View{
       modifier(DefaultButtonViewModifier())
    }
}

//MARK: View modifier
struct DefaultButtonViewModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundColor(.white)
            .frame(height : 55)
            .frame(maxWidth : .infinity)
            .background(.blue)
            .cornerRadius(10)
            .shadow(radius: 10)
            .padding()
    }
}
