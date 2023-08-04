//
//  DynamicallyFiltering.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 15/07/2023.
//

/*
 - don't forget to change the codegen before creating the NSManageObject
 - use generic filtering
 */

import SwiftUI
import CoreData

struct DynamicallyFiltering : View {
    @Environment(\.managedObjectContext) var moc
    @State private var lastNameFilter = "A"
    
    var body: some View {
        VStack {
            
            // list of matching singers
            FilteredList(filterKey: "lastName", filterValue: lastNameFilter) { (singer : Singer) in
                Text("\(singer.wrappedFirstName) \(singer.wrappedLastName)")
            }
            
            Button("Add Examples") {
                let taylor = Singer(context: moc)
                taylor.firstName = "Taylor"
                taylor.lastName = "Swift"
                
                let ed = Singer(context: moc)
                ed.firstName = "Ed"
                ed.lastName = "Sheeran"
                
                let adele = Singer(context: moc)
                adele.firstName = "Adele"
                adele.lastName = "Adkins"
                
                try? moc.save()
            }
            
            //filter A
            Button("Show A") {
                lastNameFilter = "A"
            }
            .buttonStyle(.borderedProminent)
            
            
            //filter S
            Button("Show S") {
                lastNameFilter = "S"
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct DynamicallyFiltering_Previews: PreviewProvider {
    static var previews: some View {
        DynamicallyFiltering()
    }
}
