//
//  CountryRowView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 02/05/2023.
//

import SwiftUI
import RealmSwift

struct CountryRowView: View {
    @ObservedRealmObject var country: Country
    @FocusState var isFocused: Bool?
    @State private var showFlagPicker = false
    
    var body: some View {
        
        HStack {
            //button
            Button {
                showFlagPicker = true
            } label: {
                Text(country.flag)
            }
            .buttonStyle(.plain)
            
            //name
            TextField("Country Name", text: $country.name)
                .focused($isFocused, equals: true)
                .textFieldStyle(.roundedBorder)
            
            Spacer()
            
            Text("\(country.cities.count) cities")
        }
        .padding()
        .frame(height: 30)
        .sheet(isPresented: $showFlagPicker) {
            FlagPicker(country: country)
        }
    }
}

struct CountryRowView_Previews: PreviewProvider {
    static var previews: some View {
        CountryRowView(country: Country())
    }
}
