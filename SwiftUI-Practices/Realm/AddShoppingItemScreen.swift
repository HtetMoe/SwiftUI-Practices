//
//  AddShoppingItemScreen.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 28/04/2023.
//

import SwiftUI
import RealmSwift

struct AddShoppingItemScreen: View {
    @Environment(\.dismiss) var dismiss
    @State private var title = ""
    @State private var qty = ""
    @State private var selectedCategory = ""
    
    var itemToEdit: ShoppingItem?
    
    //realm
    @ObservedRealmObject var shop : Item
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    let data = ["Produce", "Fruit", "Meat", "Condiments", "Beverages", "Snacks", "Dairy"]
    
    init(item: Item, itemToEdit: ShoppingItem? = nil) {
        self.shop = item
        self.itemToEdit = itemToEdit
        
        if let itemToEdit = itemToEdit{
            _title = State(initialValue: itemToEdit.title)
            _qty = State(initialValue: String(itemToEdit.qty))
            _selectedCategory = State(initialValue: itemToEdit.category)
        }
    }
    
    private var isEditing: Bool {
        itemToEdit == nil ? false: true
    }
    
    var body: some View {
        
        NavigationView{
            
            VStack{
                LazyVGrid(columns: columns) {
                    ForEach(data, id: \.self) { itemType in
                        Text(itemType)
                            .padding(.horizontal, 5)
                            .padding(.vertical)
                            .frame(width :  130)
                            .background(selectedCategory == itemType ? .red : .green)
                            .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                            .foregroundColor(.white)
                            .onTapGesture {
                                self.selectedCategory = itemType
                            }
                    }
                }
                
                Spacer().frame(height : 60)
                
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                TextField("Quantity", text: $qty)
                    .textFieldStyle(.roundedBorder)
                
                Button {
                    if let _ = itemToEdit{
                        //update
                        update()
                    }else{
                        //save the item
                       save()
                    }
                    
                    dismiss()
                    
                } label: {
                    Text(isEditing ? "Update" : "Save")
                        .frame(maxWidth : .infinity, maxHeight: 40)
                }.buttonStyle(.bordered)
                
                Spacer()
                
            }
            .padding()
            .navigationTitle(isEditing ? "Update Shopping item" : "Add shopping item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func save(){
        let newShoppingItem = ShoppingItem()
        newShoppingItem.title = title
        newShoppingItem.qty = Int(qty) ?? 1
        newShoppingItem.category = selectedCategory
        
        $shop.shoppingItems.append(newShoppingItem)
    }
    
    private func update(){
        if let itemToEdit = itemToEdit{
            
            do {
                let realm = try Realm()
                guard let objectToUpdate = realm.object(ofType: ShoppingItem.self, forPrimaryKey: itemToEdit.id) else{
                    return
                }
                
                try realm.write{
                    objectToUpdate.title = title
                    objectToUpdate.qty =  Int(qty) ?? 1
                    objectToUpdate.category = selectedCategory
                }
            }
            catch{
                print(error)
            }
        }
    }
}

struct AddShoppingItemScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddShoppingItemScreen(item: Item())
    }
}
