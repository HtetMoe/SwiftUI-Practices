//
//  DecodingJsonString.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 07/07/2023.
//

import SwiftUI
//objects
struct iUser : Codable {
    let name    : String
    let address : Address
}

struct Address : Codable {
    let street : String
    let city   : String
}

struct DecodingJsonString: View {
    var body: some View {
        Button("Decode JSON") {
            let input = """
            {
                "name": "Taylor Swift",
                "address": {
                    "street": "555, Taylor Swift Avenue",
                    "city": "Nashville"
                }
            }
            """

            let data = Data(input.utf8)
            let decoder = JSONDecoder()
            if let user = try? decoder.decode(iUser.self, from: data) {
                print(user)
            }
        }
    }
}

struct DecodingJsonString_Previews: PreviewProvider {
    static var previews: some View {
        DecodingJsonString()
    }
}
