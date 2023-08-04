//
//  AddBook1View.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 10/05/2023.
//

import SwiftUI
import RealmSwift

struct AddBook1View: View {
    //realm
    @ObservedRealmObject var author: Author
    
    
    @State private var title = ""
    @State private var year = ""
    
    var body: some View {
        Form {
            TextField("Title", text: $title)
            TextField("Year", text: $year)
        }
        .navigationBarTitle("Add Book")
        .navigationBarItems(trailing: Button("Save") {
            guard let yearInt = Int(year) else { return }
            let newBook = Book1(title: title, year: yearInt)
            $author.books.append(newBook)
        })
    }
    
}

struct AddBook1View_Previews: PreviewProvider {
    static var previews: some View {
        AddBook1View(author: Author())
    }
}
