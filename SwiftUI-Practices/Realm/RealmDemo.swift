//
//  RealmDemo.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 28/04/2023.
//

import SwiftUI
import RealmSwift

struct RealmDemo: View {
    @State private var showAddItemView = false
    
    //realm
    @ObservedResults(Item.self) var items
    
    var body: some View {
        
        NavigationView {
            VStack{
                if items.isEmpty{
                    Text("No items here!")
                }
                else{
                    List{
                        ForEach(items, id : \.id) { item in
                            NavigationLink {
                                ShoppingItemListView(shoppingItem: item )
                            } label: {
                                VStack(alignment : .leading){
                                    Text(item.title)
                                    Text(item.name).opacity(0.4)
                                }
                            }

                        }.onDelete(perform: $items.remove)
                    }
                }
            }
            .sheet(isPresented: $showAddItemView, content: {
                AddItemView()
            })
            .toolbar {
                ToolbarItem(placement : .navigationBarTrailing){
                    Button {
                        self.showAddItemView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }

                }
            }
        }
    }
}

struct RealmDemo_Previews: PreviewProvider {
    static var previews: some View {
        RealmDemo()
    }
}
