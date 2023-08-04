//
//  VariablesDemo.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 09/03/2023.
//

import SwiftUI

struct VariablesDemo: View {
    @State private var count = 0
    
    var body: some View {
        NavigationView {
            
            VStack {
                Text("Count: \(count)")
               
                Button("Increment") {
                    count += 1
                }.buttonStyle(.borderedProminent)
            }
            .navigationTitle("Variables")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem {
                    NavigationLink(destination: ResultView(count: $count)) {
                        Text("Next")
                    }
                }
            }
        }
    }
}

struct VariablesDemo_Previews: PreviewProvider {
    static var previews: some View {
        VariablesDemo()
    }
}

struct ResultView : View{
    @Binding var count : Int
    var body: some View{
        VStack{
            Text("Result count : \(count)")
        }
    }
}
