//
//  OneToManyRelationship.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 17/07/2023.
//

import SwiftUI
import CoreData

struct OneToManyRelationship: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<ICountry>
    
    var body: some View {
       
        VStack {
            //nested list
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            //add data
            Button("Add") {
                let candy1 = ICandy(context: moc)
                candy1.name   = "Mars"
                candy1.origin = ICountry(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName  = "United Kingdom"
                
                let candy2 = ICandy(context: moc)
                candy2.name   = "KitKat"
                candy2.origin = ICountry(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName  = "United Kingdom"
                
                let candy3 = ICandy(context: moc)
                candy3.name   = "Twix"
                candy3.origin = ICountry(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName  = "United Kingdom"
                
                let candy4 = ICandy(context: moc)
                candy4.name   = "Toblerone"
                candy4.origin = ICountry(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName  = "Switzerland"
                
                try? moc.save()
            }
            .buttonStyle(.borderedProminent)
        }
    }
}

struct OneToManyRelationship_Previews: PreviewProvider {
    static var previews: some View {
        OneToManyRelationship()
    }
}
