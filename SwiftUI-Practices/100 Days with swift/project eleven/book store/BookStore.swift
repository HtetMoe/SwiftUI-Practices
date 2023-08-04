//
//  BookStore.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 12/07/2023.
//

import SwiftUI
import CoreData

struct BookStore: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.title),
        SortDescriptor(\.author)
    ]) var books: FetchedResults<IBook>
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        HStack {
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading) {
                                Text(book.title ?? "Unknown Title")
                                    .font(.headline)
                                Text(book.author ?? "Unknown Author")
                                    .foregroundColor(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .listStyle(.grouped)
            .navigationTitle("Bookworm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //edit
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                //add book
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddScreen) {
                AddBookToBookStore()
            }
        }
    }
    
    //delete book
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
    
}

struct BookStore_Previews: PreviewProvider {
    static var previews: some View {
        BookStore()
    }
}
