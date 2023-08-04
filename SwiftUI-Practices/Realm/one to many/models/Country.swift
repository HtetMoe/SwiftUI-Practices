//
//  Country.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 02/05/2023.
//

import Foundation
import RealmSwift

class Country : Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name : String
    @Persisted var cities : List<City>
    @Persisted var flag = "🏳️"
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
}
