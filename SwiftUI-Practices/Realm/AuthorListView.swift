//
//  AuthorListView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 10/05/2023.
//

import SwiftUI
import RealmSwift

struct AuthorListView: View {
    
    //realm
    @ObservedResults(Author.self) var authors
    
    var body: some View {
        NavigationView {
            
            List(authors) { author in
                
                VStack(alignment: .leading) {
                    
                    NavigationLink(destination: AddBook1View(author: author)) {
                        Label("Add Book", systemImage: "plus.circle")
                    }
                    
                    Text(author.name)
                        .font(.headline)
                    
                    ForEach(author.books) { book in
                        Text("\(book.title) (\(book.year))")
                    }
                }
            }
            .navigationTitle("Authors")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        addAuthor()
                    }) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func addAuthor(){
        let newAuthor = Author(name: "Author")
        $authors.append(newAuthor)
    }
}

struct AuthorListView_Previews: PreviewProvider {
    static var previews: some View {
        AuthorListView()
    }
}
