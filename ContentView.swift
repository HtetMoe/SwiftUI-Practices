//
//  ContentView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 19/01/2023.
//

import SwiftUI

struct ContentView: View {
   
    @State var isActive = false
    var body: some View {
        
        
        NavigationView {
           
            VStack {
                NavigationLink(destination: TestView(), isActive: $isActive) {
                    EmptyView()
                }
                
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)

                Text("Hello, world!")
                
                Button("Go"){
                    self.isActive = true
                }
            }
            .padding()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
