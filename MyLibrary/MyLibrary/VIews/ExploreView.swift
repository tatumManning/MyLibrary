//
//  ExploreView.swift
//  MyLibrary
//
//  Created by Tatum Manning on 12/1/23.
//

import SwiftUI

struct ExploreView: View {
    
    @ObservedObject var explore = ExploreViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(explore.listData) { book in                   NavigationLink {
                        // Book Detail()
                    } label: {
                        Text(book.title)
                    }
                }
                
            }
            .task {
                await explore.fetchList()
            }
            .listStyle(.grouped)
            .navigationTitle("Explore")
            .alert(isPresented: $explore.hasError, error: explore.error) {
                Text("")
            }
        }

        
        
    }
}

#Preview {
    ExploreView()
}
