//
//  BookModel.swift
//  MyLibrary
//
//  Created by Tatum Manning on 11/29/23.
//

import Foundation
import FirebaseFirestoreSwift

struct BookResults : Codable, Identifiable {
    var id = UUID()
    var items: [BookItem]
}


struct BookItem : Codable, Identifiable {
    let id : String
    var volumeInfo : VolumeInfo
    
}

struct VolumeInfo : Codable {
    var title : String
    var subtitle : String?
    var authors : [String]
    var publisher : String
    var publishedDate : String
    var description : String
    var industryIdentifiers : [ISBNData]
}

struct ISBNData : Codable {
    var type : String
    var identifier : String
}



//    var id = UUID()
//    var key : String?
//    var title : String?
//    var author_name: String?
//    var isbn : String?
//    var cover_i : String?
