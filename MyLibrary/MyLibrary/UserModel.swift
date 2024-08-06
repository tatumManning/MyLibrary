//
//  UserModel.swift
//  MyLibrary
//
//  Created by Tatum Manning on 11/27/23.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseAuth

struct UserModel : Codable, Identifiable {
    @DocumentID var id : String?
    var username : String
    var email : String
    var password : String
    var accountID : String
//    var library : [BookModel]
//    var wishlist : [BookModel]
}

struct BookModel : Codable, Identifiable {
    @DocumentID var id : String?
    var title : String
    var author_name : String
    var key : String
    var isbn : String
}


