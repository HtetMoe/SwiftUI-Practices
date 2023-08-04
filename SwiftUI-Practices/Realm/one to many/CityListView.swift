//
//  CityListView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 02/05/2023.
//

import SwiftUI
import RealmSwift

struct CityListView: View {
    //realm
    @ObservedRealmObject var country: Country
    
    @State private var name = ""
    @FocusState private var isFocused: Bool?
    
    var body: some View {
        VStack {
            
            //add new city
            HStack {
                TextField("New City", text: $name)
                    .focused($isFocused, equals: true)
                    .textFieldStyle(.roundedBorder)
                
                Spacer()
               
                Button {
                    let newCity = City(name: name)
                    $country.cities.append(newCity)
                    
                    name = ""
                    isFocused = nil
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
                .disabled(name.isEmpty)
            }
            .padding()
            
            //show city list
            List {
                ForEach(country.cities) { city in
                    Text(city.name)
                }
                .onDelete(perform: $country.cities.remove)
                .onMove(perform: $country.cities.move)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
        }
        .animation(.default, value: country.cities)
        .navigationTitle(country.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement : .navigationBarTrailing){
                EditButton()
            }
            ToolbarItemGroup(placement: .keyboard) {
                HStack {
                    //Spacer()
                    Button {
                        isFocused = nil
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    }
                }
            }
        }
    }
}

struct CityListView_Previews: PreviewProvider {
    static var previews: some View {
        CityListView(country: Country())
    }
}
