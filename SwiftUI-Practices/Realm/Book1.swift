//
//  Book1.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 10/05/2023.
//

import Foundation
import RealmSwift

class Book1: Object, Identifiable {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var year: Int
    
    //inverse relationship
    @Persisted(originProperty: "books") var author: LinkingObjects<Author>
    
    convenience init(title: String, year : Int) {
        self.init()
        self.title = title
        self.year = year
    }
    
}
