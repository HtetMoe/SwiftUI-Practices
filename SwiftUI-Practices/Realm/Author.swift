//
//  Author.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 10/05/2023.
//

import Foundation
import RealmSwift

class Author: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var name: String
    @Persisted var books = List<Book1>()
    
    convenience init(name: String) {
        self.init()
        self.name = name 
    }
}
