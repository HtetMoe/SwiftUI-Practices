//
//  ArchivingSwiftObject.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 07/07/2023.
//

import SwiftUI
/*
 That accesses UserDefaults directly rather than going through @AppStorage, because the @AppStorage property wrapper just doesn’t work here.
 We can write straight into UserDefaults
 */

//object
struct User : Codable{ // to support archiving and unarchiving
    let firstName : String
    let lastName  : String
}

struct ArchivingSwiftObject: View {
    @State private var user = User(firstName: "Hello", lastName: "World")
    
    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()
            
            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
    }
}

struct ArchivingSwiftObject_Previews: PreviewProvider {
    static var previews: some View {
        ArchivingSwiftObject()
    }
}
