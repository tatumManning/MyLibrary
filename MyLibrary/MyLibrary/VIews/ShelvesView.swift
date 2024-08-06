//
//  SwiftUIView.swift
//  MyLibrary
//
//  Created by Tatum Manning on 11/27/23.
//

import SwiftUI

struct ShelvesView: View {
    
    
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
//                    ShelvesView()
                } label: {
                    Text("Sort by Title")
                }
                NavigationLink {
//                    WishView()
                } label: {
                    Text("Sort by Author")
                }
                NavigationLink {
//                    AddView()
                } label: {
                    Text("Sort by Genre")
                }
            }
            .listStyle(.grouped)
            .navigationTitle("The Shelves")
        }
    }
}

#Preview {
    ShelvesView()
}
