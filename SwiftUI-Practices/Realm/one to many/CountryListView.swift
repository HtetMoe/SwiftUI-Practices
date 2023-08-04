//
//  CountryListView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 02/05/2023.
//

import SwiftUI
import RealmSwift

struct CountryListView: View {
    //realm
    @ObservedResults(Country.self) var countries
    
    //keyboard control
    @FocusState private var isFocused: Bool?
    @State private var presentAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                if countries.isEmpty{
                    Text("Tap on the \(Image(systemName: "plus.circle.fill")) button above to create a new Country.")
                }
                else{
                    List {
                        ForEach(countries.sorted(byKeyPath: "name")) { country in
                            NavigationLink {
                                CityListView(country : country)
                            } label: {
                                CountryRowView(country: country, isFocused: _isFocused)
                            }
                        }
                        .onDelete(perform: deleteCountry)//$countries.remove
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                }
                
                Spacer()
            }
            .animation(.default, value: countries)
            .navigationTitle("Countries")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        $countries.append(Country())
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
                
                //for user experience, to hide keyboard
                ToolbarItemGroup(placement: .keyboard) {
                    HStack{
                        Button {
                            isFocused = nil
                        } label: {
                            Image(systemName: "keyboard.chevron.compact.down")
                        }
                    }
                }
            }
            .alert("You must first delete all of the cities in this country.",
                   isPresented: $presentAlert, actions: {})
        }
    }
    
    //for cascading delete
    func deleteCountry(indexSet: IndexSet){
        guard let index = indexSet.first else { return }
        let selectedCountry = Array(countries.sorted(byKeyPath: "name"))[index]
        
        guard selectedCountry.cities.isEmpty else {
            // show alert
            presentAlert.toggle()
            return
        }
        $countries.remove(selectedCountry)
    }
}

struct CountryListView_Previews: PreviewProvider {
    static var previews: some View {
        CountryListView()
    }
}
