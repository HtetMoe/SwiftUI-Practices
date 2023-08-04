//
//  APIStatusDemo.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 22/06/2023.
//

import SwiftUI

struct APIStatusDemo: View {
    @StateObject private var viewModel = APIStatusDemoViewModel()

   
    var body: some View {

        NavigationView {
           
            Form{
                if let data = viewModel.response{
                    Section {
                        Text("\(data.setup)")
                    } header: {
                        Text("Question")
                    }
                    
                    Section {
                        Text("\(data.punchline)")
                    } header: {
                        Text("Answer")
                    }
                }
                
                Button {
                    if viewModel.monitor.isConnected{
                        viewModel.fetchAJoke()
                    }
                } label: {
                    Text("Fetch Again")
                        .padding(8)
                        .foregroundColor(.white)
                        .background(.green)
                        .cornerRadius(12)
                }
            }
            .networkConnectionView()
            .apiStatusModifier(status: viewModel.status, action: {
                viewModel.fetchAJoke()
            })
            .task {
                viewModel.fetchAJoke()
            }
        }
    }
}

struct APIStatusDemo_Previews: PreviewProvider {
    static var previews: some View {
        APIStatusDemo()
    }
}


//MARK: ERROR View
struct ErrorView : View{
    let errorMessage : String
    let action : () -> Void
    
    var body: some View {
        VStack{
            Text(errorMessage)
                .padding()
            
            Button("Try Again") {
                action()
            }
        }
    }
}

//MARK: NO Internet view
struct NoInternetView : View{
    let action : () -> Void
    
    var body: some View{
        VStack {
            
            Image(systemName: "wifi.slash")
                .font(.system(size: 64))
                .foregroundColor(.orange)
            
            Text("No Internet")
                .font(.headline)
                .foregroundColor(.orange)
                .padding()
            
            Button("Try Again") {
                action()
            }
        }
    }
}
