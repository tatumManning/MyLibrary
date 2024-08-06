//
//  SearchView.swift
//  MyLibrary
//
//  Created by Tatum Manning on 11/29/23.
//

import SwiftUI

struct SearchView: View {
    
    @State var query = ""
    @State var type = ""
    @State var types = [
        "Title",
        "Author",
        "ISBN"
    ]
    @ObservedObject var booksvm = BooksViewModel()
    
    var body: some View {
        NavigationStack {
            Form {
                TextField(text: $query) {
                    Text("Type here")
                }
                Section {
                    Picker("Search Value", selection: $type) {
                        ForEach(types, id: \.self) { type in
                            Text(type)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                Section {
                    Button {
                        Task {
                            await booksvm.getBookInfo(type: type.lowercased(), query: query)
                        }
                    } label: {
                        Text("Search")
                    }
                }
            }

            List {
                ForEach($booksvm.books) { book in
                    NavigationLink {
                        // Book Detail
                        
                    } label: {
                        Text(book.volumeInfo.title.wrappedValue)
                    }
                }
                
            }

            .listStyle(.grouped)
            .navigationTitle("Search")
            .alert(isPresented: $booksvm.hasError, error: booksvm.error) {
                
            }
                

    }
        
    }
}

#Preview {
    SearchView()
}
