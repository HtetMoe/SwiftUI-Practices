//
//  AddItemView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 28/04/2023.
//

import SwiftUI
import RealmSwift

struct AddItemView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var name  = ""
    
    //realm
    @ObservedResults(Item.self) var items
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text : $title)
                TextField("Name", text: $name)
                
                Button {
                    //create items
                    let newItem = Item()
                    newItem.title = title
                    newItem.name = name
                    
                    $items.append(newItem)
                    
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(maxWidth: .infinity)
                }.buttonStyle(.bordered)

            }
            .navigationTitle("Create new item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
    }
}
