//
//  FetchWithURLSession.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 11/07/2023.
//

import SwiftUI

//objects
struct Response: Codable {
    var results : [Result]
}

struct Result: Codable {
    var trackId        : Int
    var trackName      : String
    var collectionName : String
}

struct FetchWithURLSession: View {
    @State private var results = [Result]()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                
                Text(item.collectionName)
            }
        }
        .task {
            await loadData()
        }
        
    }
    
    //fetch data
    func loadData() async {
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch {
            print("Invalid data")
        }
    }
    
}

struct FetchWithURLSession_Previews: PreviewProvider {
    static var previews: some View {
        FetchWithURLSession()
    }
}
