//
//  Student.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 02/05/2023.
//

import Foundation
import RealmSwift

class Student : Object, Identifiable{
    @Persisted var userID : String
    @Persisted var userName : String
    @Persisted var attendenceYear : String
    
    override class func primaryKey() -> String? {
        "userID"
    }
}
