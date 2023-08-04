//
//  AddBookToBookStore.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 12/07/2023.
//

import SwiftUI

struct AddBookToBookStore: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title  = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre  = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationView {
            
            Form {
                //book
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                //rating and review
                Section {
                    TextEditor(text: $review)
                    
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6) {
//                            Text(String($0))
//                        }
//                    }
                    
                    RatingView(rating: $rating)
                    
                } header: {
                    Text("Write a review")
                }
                
                //save
                Section {
                    Button("Save") {
                        saveBook()
                        dismiss()
                    }
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func saveBook(){
        let newBook = IBook(context: moc)
        
        newBook.id    = UUID()
        newBook.title = title
        newBook.author = author
        newBook.rating = Int16(rating)
        newBook.genre  = genre
        newBook.review = review
        
        try? moc.save()
    }
}

struct AddBookToBookStore_Previews: PreviewProvider {
    static var previews: some View {
        AddBookToBookStore()
    }
}
