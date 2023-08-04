//
//  Bundle-Decodable.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 08/07/2023.
//

import Foundation

//objects
struct Astronaut : Codable, Identifiable {
    let id   : String
    let name : String
    let description : String
}

struct Mission: Codable, Identifiable {
    struct CrewRole : Codable {
        let name    : String
        let role    : String
    }
    
    let id          : Int
    let launchDate  : Date?
    let crew        : [CrewRole]
    let description : String
    
    var displayName: String {
        "Apollo \(id)"
    }

    var image: String {
        "apollo\(id)"
    }
    
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}

extension Bundle {
    func decode<T : Codable>(_ file: String) -> T {
        
        //locate the file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        //load data from file
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
        
        //decode the data
        let decoder = JSONDecoder()
       
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        return loaded
    }
}
