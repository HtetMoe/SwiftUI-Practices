//
//  AllCityListView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 04/05/2023.
//

import SwiftUI
import RealmSwift

struct AllCityListView: View {
    @ObservedResults(City.self, sortDescriptor: SortDescriptor(keyPath: "name")) var cities
    
    @State private var toggle = false
    var body: some View {
        NavigationView {
            List {
                ForEach(cities) { city in
                    HStack {
                        Text(city.name)
                        Spacer()
                        Text(city.country.first?.name ?? "No Country")
                    }
                }
                .onDelete(perform: $cities.remove)
            }
            .navigationTitle("All Cities")
        }
        
    }
}

struct AllCityListView_Previews: PreviewProvider {
    static var previews: some View {
        AllCityListView()
    }
}
