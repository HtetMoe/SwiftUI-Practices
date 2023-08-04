//
//  CombineCoreData.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 11/07/2023.
//

import SwiftUI
import CoreData

//view model
class iDataController: ObservableObject {
    let container = NSPersistentContainer(name: "iBookWorm")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
            
            //merge duplicate objects based on their properties
            self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        }
    }
}

struct CombineCoreData: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var students : FetchedResults<IStudent>
    
    var body: some View {
        VStack {
            List(students) { student in
                Text(student.name ?? "Unknown")
            }
            
            Button("Add") {
                let firstNames = ["Ginny", "Harry", "Hermione", "Luna", "Ron"]
                let lastNames = ["Granger", "Lovegood", "Potter", "Weasley"]
                
                let chosenFirstName = firstNames.randomElement()!
                let chosenLastName = lastNames.randomElement()!
                
                let student = IStudent(context: moc)
                student.id = UUID()
                student.name = "\(chosenFirstName) \(chosenLastName)"
                try? moc.save()
            }
        }
    }
}

struct CombineCoreData_Previews: PreviewProvider {
    static var previews: some View {
        CombineCoreData()
    }
}
