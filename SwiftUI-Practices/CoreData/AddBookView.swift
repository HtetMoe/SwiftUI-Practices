//
//  AddBookView.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 03/04/2023.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title  = ""
    @State private var author = ""
    @State private var rating = 0
    @State private var genre  = ""
    @State private var review = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        
        NavigationView {
            Form{
                
                Section {
                    TextField("Name of book", text: $title)
                    
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id : \.self) {
                            Text($0)
                        }
                    }.pickerStyle(.navigationLink)
                }
                
                Section {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                    
//                    Picker("Rating", selection: $rating) {
//                        ForEach(0..<6, id : \.self) {
//                            Text(String($0))
//                        }
//                    }.pickerStyle(.navigationLink)
                    
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        
                        //add the book
                        let book = Book(context: moc)
                        book.id     = UUID()
                        book.title  = title
                        book.author = author
                        book.genre  = genre
                        book.rating = Int16(rating)
                        
                        try? moc.save()
                        dismiss()
                    }
                    .frame(maxWidth : .infinity)
                }
            }
            .navigationTitle("Add Book")
            
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
