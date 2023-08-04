//
//  Filtering.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 14/07/2023.
//

import SwiftUI
import CoreData


struct Filtering: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors : [],
                  predicate       : NSPredicate(format: "name CONTAINS[c] %@", "t") ) var ships: FetchedResults<Ship>
        
    /*
     -> filter equal
     NSPredicate(format: "universe == 'Star Wars'")
     NSPredicate(format: "universe == %@", "Star Wars"))
     
     
     `%@‘ means “insert some data here”
    
     -> one of three options from an array
     NSPredicate(format: "universe IN %@", ["Aliens", "Firefly", "Star Trek"])
     
     -> <> operator
     NSPredicate(format: "name < %@", "F"))
     
     -> begin with
     NSPredicate(format: "name BEGINSWITH %@", "E"))
     
     -> begin and  [c] -> case-sensitive
     NSPredicate(format: "name BEGINSWITH[c] %@", "e"))
     
     -> not begin
     NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
     
     -> contain
     NSPredicate(format: "name CONTAINS[c] %@", "t")
     
     */
    
    var body: some View {
        VStack {
            
            List(ships, id: \.self) { ship in
                Text(ship.name ?? "Unknown name")
            }
            
            Button("Add Examples") {
                
                let ship1 = Ship(context: moc)
                ship1.name     = "Enterprise"
                ship1.universe = "Star Trek"
                
                let ship2 = Ship(context: moc)
                ship2.name     = "Defiant"
                ship2.universe = "Star Trek"
                
                let ship3 = Ship(context: moc)
                ship3.name     = "Millennium Falcon"
                ship3.universe = "Star Wars"
                
                let ship4 = Ship(context: moc)
                ship4.name     = "Executor"
                ship4.universe = "Star Wars"
                
                try? moc.save()
            }
        }
    }
}

struct Filtering_Previews: PreviewProvider {
    static var previews: some View {
        Filtering()
    }
}
