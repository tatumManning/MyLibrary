//
//  NYTBSModel.swift
//  MyLibrary
//
//  Created by Tatum Manning on 12/1/23.
//

import Foundation


struct NYTBSResults : Codable {
    var id = UUID()
    var results : [NYTBSListModel]
    
}

struct NYTBSListModel : Codable, Identifiable {
    var id = UUID()
    var num_results : Int
    var books : [NYTBookModel]
}

struct NYTBookModel : Codable, Identifiable {
    var id = UUID()
    var list_name : String
    var title : String
    var author : String
    var rank : Int
    var weeks_on_list : Int
    var book_image : URL
    var description : String
}
