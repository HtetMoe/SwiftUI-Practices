//
//  Migrator.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 28/04/2023.
//

import Foundation
import RealmSwift

class Migrator{
    init(){
        updateSchema()
    }
    
    func updateSchema(){
        let config = Realm.Configuration(schemaVersion: 1){ migration, oldSchemaVersion in
            
//            if oldSchemaVersion < 1{
//                //add new field
//                migration.enumerateObjects(ofType: Item.className()) { oldObject, newObject in
//                    newObject!["shoppingItems"] = List<ShoppingItem>()
//                }
//            }
//
//            if oldSchemaVersion < 2 {
//                migration.enumerateObjects(ofType: ShoppingItem.className()) { oldObject, newObject in
//                    newObject!["category"] = ""
//                }
//            }
//            //for one to many proj
//            if oldSchemaVersion < 3{
//                migration.enumerateObjects(ofType: Country.className()) { oldObject, newObject in
//                    newObject!["flag"] = "🏳️"
//                }
//            }
        }
        
        Realm.Configuration.defaultConfiguration = config
        let _ = try! Realm()
    }
}
