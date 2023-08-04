//
//  City.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 02/05/2023.
//

import Foundation
import RealmSwift

class City : Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name : String
    
    //inverse relationship
    @Persisted(originProperty: "cities") var country: LinkingObjects<Country>
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
