//
//  ShoppingItem.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 28/04/2023.
//

import Foundation
import RealmSwift

class ShoppingItem : Object, Identifiable{
    
    @Persisted(primaryKey: true) var id : ObjectId
    @Persisted var title : String
    @Persisted var qty : Int
    @Persisted var category : String 
    
    override class func primaryKey() -> String? {
        "id"
    }
}
