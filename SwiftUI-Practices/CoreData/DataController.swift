//
//  DataController.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 01/04/2023.
//

import Foundation
import CoreData

class DataController : ObservableObject{
    let container = NSPersistentContainer(name: "BookWorm")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error{
                print("CoreData, Failed to load. \(error.localizedDescription)")
            }
        }
    }
} 
