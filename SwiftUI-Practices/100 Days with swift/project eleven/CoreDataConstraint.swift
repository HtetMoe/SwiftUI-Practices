//
//  CoreDataConstraint.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 13/07/2023.
//

import SwiftUI
import CoreData

struct CoreDataConstraint: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var wizards : FetchedResults<Wizard>
    
    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }
            
            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }
            .buttonStyle(.bordered)
            .padding()
            
            Button("Save") {
                do {
                    try moc.save()
                } catch {
                    print(error.localizedDescription)
                }
            }.buttonStyle(.borderedProminent)
        }
    }
}

struct CoreDataConstraint_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataConstraint()
    }
}
