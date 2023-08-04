//
//  Item.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 28/04/2023.
//

import Foundation
import RealmSwift

class Item : Object, Identifiable {
    @Persisted(primaryKey: true) var id : ObjectId
    @Persisted var title : String
    @Persisted var name : String
    
    @Persisted var shoppingItems : List<ShoppingItem> = List<ShoppingItem>() // empty list
    
    override class func primaryKey() -> String? {
        "id"
    }
}
