//
//  ContentView.swift
//  MyLibrary
//
//  Created by Tatum Manning on 11/27/23.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth



struct HomeView: View {
    
    @StateObject var libApp = CredentialsViewModel()
    @State var accountID = Auth.auth().currentUser?.uid
    @State var notLogged : Bool = false
    @State var user = UserModel(username: "", email: "", password: "", accountID: "")
    
//library:[BookModel](), wishlist: [BookModel]()
    
    
    var body: some View {
        
        
        
        
        NavigationStack {
            List {
                
                NavigationLink {
                    ShelvesView()
                } label: {
                    Text("Your Shelves")
                }
                NavigationLink {
                    //                    WishView()
                } label: {
                    Text("Wish List")
                }
                NavigationLink {
                    ExploreView()
                } label: {
                    Text("Explore")
                }
                NavigationLink {
                    SearchView()
                } label: {
                    Text("Search")
                }
                
            }
            .listStyle(.grouped)
            .navigationTitle("Your Library")
        }
//        .onAppear {
//            libApp.fetchUsers()
//            if accountID == nil {
//                notLogged.toggle()
//            }
////            @State var users = libApp.users
////            @State var user = libApp.fetchUserData(accountID: accountID!, users: users)
//        }
//        .refreshable {
//            libApp.fetchUsers()
//            if accountID == nil {
//                notLogged.toggle()
//            }
//        }
//
//        .navigationDestination(isPresented: $notLogged) {
//            OpeningView()
//        }
    }
    
    
    
}

#Preview {
    HomeView()
}

