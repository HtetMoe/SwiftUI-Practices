//
//  ShoppingItemView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 28/04/2023.
//

import SwiftUI
import RealmSwift

struct ShoppingItemListView: View {
    
    //realm
    @ObservedRealmObject var shoppingItem : Item
    
    @State private var showAddShoppingItemView = false
    @State private var selectedItemIds : [ObjectId] = []
    @State private var selectedCategory = "All"
    
    var items : [ShoppingItem] {
        if selectedCategory == "All"{
            return Array(shoppingItem.shoppingItems)
        }
        else{
            return shoppingItem.shoppingItems.sorted(byKeyPath: "title")
                .filter { $0.category == selectedCategory }
        }
    }
    var body: some View {
        VStack {
            
            CategoryFilterView(selectedCategory: $selectedCategory)
            
            if shoppingItem.shoppingItems.isEmpty{
                Text("No items found.")
            }
            else{
                List{
                    ForEach(shoppingItem.shoppingItems, id : \.id) { shopItem in
                        NavigationLink {
                            AddShoppingItemScreen(item: shoppingItem, itemToEdit: shopItem)
                        } label: {
                            ShoppingItemCell(item: shopItem, selected: selectedItemIds.contains(shopItem.id)) { selected  in
                                if selected{
                                    selectedItemIds.append(shopItem.id)
                                    
                                    //delete
                                    if let indexToDelete = shoppingItem.shoppingItems.firstIndex(where: { $0.id == shopItem.id }) {
                                        $shoppingItem.shoppingItems.remove(at: indexToDelete)
                                    }
                                    
                                }
                            }
                        }

                    }
                }
            }
        }
        .sheet(isPresented: $showAddShoppingItemView, content: {
            AddShoppingItemScreen(item: shoppingItem)
        })
        .toolbar {
            ToolbarItem(placement : .navigationBarTrailing){
                Button {
                    self.showAddShoppingItemView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
                
            }
        }
    }
}

struct ShoppingItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShoppingItemListView(shoppingItem: Item())
    }
}
