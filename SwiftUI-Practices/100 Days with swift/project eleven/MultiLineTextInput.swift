//
//  MultiLineTextInput.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 11/07/2023.
//

import SwiftUI

struct MultiLineTextInput: View {
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationView {
            TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()
        }
    }
}

struct MultiLineTextInput_Previews: PreviewProvider {
    static var previews: some View {
        MultiLineTextInput()
    }
}
