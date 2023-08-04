//
//  UserActionCombine1.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 25/04/2023.
//

import SwiftUI

struct UserActionCombine1: View {
    @ObservedObject private var viewModel = UA1VeiwModel()
    
    var body: some View {
        VStack{
            TextField("Enter your text..", text: $viewModel.myText)
                .padding(5)
                .border(.gray)
            Text(viewModel.myMessage)
        }.padding()
    }
}

struct UserActionCombine1_Previews: PreviewProvider {
    static var previews: some View {
        UserActionCombine1()
    }
}

//MARK: - view model
class UA1VeiwModel : ObservableObject{
    @Published var myText : String    = ""
    @Published var myMessage : String = ""
    
    init() {
       
        $myText
            .map{$0.isEmpty ? "❌" : "✅"} //control the conditions depend on changes
            .assign(to: &$myMessage)
    }
}
