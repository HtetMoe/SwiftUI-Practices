//
//  ScrollingGridView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 07/07/2023.
//

import SwiftUI

struct ScrollingGridView: View {
    
//    let layout = [
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80)),
//        GridItem(.fixed(80))
//    ]
    
//    let layout = [
//        GridItem(.adaptive(minimum: 80)),
//    ]
    
    let layout = [
        GridItem(.adaptive(minimum: 80, maximum: 120)),
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: layout) {
                ForEach(0..<1000) {
                    Text("Item \($0)")
                }
            }
        }
    }
}

struct ScrollingGridView_Previews: PreviewProvider {
    static var previews: some View {
        ScrollingGridView()
    }
}
