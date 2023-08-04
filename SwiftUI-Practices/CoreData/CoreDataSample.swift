//
//  CoreDataSample.swift
//  MyCodes
//
//  Created by Htet Moe Phyu on 01/04/2023.
//

import SwiftUI

struct CoreDataSample: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.title),
                                    SortDescriptor(\.author)]) var books : FetchedResults<Book>
    
    @State private var showAddScreen = false
    
    var body: some View {
        
        NavigationView {
            List{
                ForEach(books){ book in
                    NavigationLink {
                        Text(book.title ?? "Unknown Title")
                    } label: {
                        //cell view
                        VStack(alignment: .leading, spacing: 5) {
                            
                            RatingView(rating: .constant(Int(book.rating)))
                            
                            Text(book.title ?? "Unknown Title")
                                .font(.headline)
                            
                            Text(book.author ?? "Unknown Author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("BookWorm ")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                //edit
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                
                //add
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddScreen.toggle()
                    } label: {
                        Label("Add Book", systemImage: "plus")
                    }
                }
            }
            .sheet(isPresented: $showAddScreen) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets : IndexSet){
        for offset in offsets{
            let book  = books[offset]
            moc.delete(book)
        }
        // try? moc.save()
    }
}

struct CoreDataSample_Previews: PreviewProvider {
    static var previews: some View {
        CoreDataSample()
    }
}
