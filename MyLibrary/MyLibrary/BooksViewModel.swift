//
//  BooksViewModel.swift
//  MyLibrary
//
//  Created by Tatum Manning on 11/29/23.
//

import Foundation


@MainActor class BooksViewModel : ObservableObject {
    
    @Published /*private(set)*/ var books = [BookItem]()
    @Published var hasError = false
    @Published var error : BookModelError?
    
//    , completion: @escaping (Books) -> Void
    
    @MainActor
    func getBookInfo(type: String, query: String) async {
        
        let formattedQuery = query.replacingOccurrences(of: " ", with: "+")
        var searchLine : String
        let apiKey = "&key=AIzaSyAIjX6s674HiQCW_dZ2m1qSQ5XH3c8bpTw"
        
        switch type {
        case "isbn":
            searchLine = "isbn:\(formattedQuery + apiKey)"
        case "title":
            searchLine = "intitle:\(formattedQuery + apiKey)"
        case "author":
            searchLine = "inauthor:\(formattedQuery + apiKey)"
        default:
            searchLine = (formattedQuery + apiKey)
        }
        
        if let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(searchLine)") {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let results = try JSONDecoder().decode(BookResults?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = BookModelError.decodeError
                    return
                }
                self.books = results.items
            } catch {
                self.hasError.toggle()
                self.error = BookModelError.customError(error: error)
                print(url)
            }
        }

    }
}

extension BooksViewModel {
    enum BookModelError : LocalizedError {
        case decodeError
        case customError(error: Error)

        var errorDescription: String? {
            switch self {
            case .decodeError:
                return "Decoding Error"
            case .customError(let error):
                return error.localizedDescription

            }
        }

    }
}
//        guard var URL = URL(string: urlString) else {
//            print("Invalid URL")
//            return
//        }
//        let URLParams = searchLine
//        if var URL = URL.appendingPathComponent(URLParams) {
//            //        if let url = URL(string: fullURL)


//        if let url = URL(string: (urlString + searchLine)) {
//            do {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                guard let results = try JSONDecoder().decode([BookItem]?.self, from: data) else {
//                    self.hasError.toggle()
//                    print(url)
//                    self.error = BookModelError.decodeError
//                    return
//                }
//                self.books = results
//            } catch {
//                self.hasError.toggle()
//                print(url)
//                self.error = BookModelError.customError(error: error)
//            }
//        }
//    func fetchData() async {
//        if let url = URL(string: url) {
//            do {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                guard let results = try JSONDecoder().decode(ParkResults?.self, from: data) else {
//                    self.hasError.toggle()
//                    self.error = ParkModelError.decodeError
//                    return
//                }
//                self.parksData = results.data
//            } catch {
//                self.hasError.toggle()
//                self.error = ParkModelError.customError(error: error)
//            }
//        }
//    }
//
//}





//
//extension ParksViewModel {
//    enum ParkModelError : LocalizedError {
//        case decodeError
//        case customError(error: Error)
//
//        var errorDescription: String? {
//            switch self {
//            case .decodeError:
//                return "Decoding Error"
//            case .customError(let error):
//                return error.localizedDescription
//            }
//        }
//
//    }
//
//}


//
//extension ParksViewModel {
//    enum ParkModelError : LocalizedError {
//        case decodeError
//        case customError(error: Error)
//
//        var errorDescription: String? {
//            switch self {
//            case .decodeError:
//                return "Decoding Error"
//            case .customError(let error):
//                return error.localizedDescription
//            }
//        }
//
//    }
//
//}


    
    /// Most recent trial
//        let task = URLSession.shared.dataTask(with: URL) { (data, response, error) in
//            if let error = error {
//                // error in search
//                print("Error: \(error.localizedDescription)")
//                return
//            }
//
//            guard let data = data else {
//                // No data received
//                print("No data received")
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                guard let bookResults = try decoder.decode([BookItem]?.self, from: data) else {
//                    print("Error decoding JSON while filling books array")
//                    return
//                }
//                self.books = bookResults
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//            }
//
//        }
//    }
    
//                    self.hasError.toggle()
//                    self.error = BookModelError.decodeError
    
//        let sessionConfig = URLSessionConfiguration.default
//        
//        let session = URLSession(configuration: sessionConfig, delegate: nil, delegateQueue: nil)
//        
//        guard var URL = URL(string: "https://www.googleapis.com/books/v1/volumes") else {return}
//        let URLParams = "\"q\": \(searchLine)"
//        URL = URL.appendingPathComponent(URLParams)
//        
//    }
//    
//    
//    
    
    
    

//    @Published private(set) var booksData = [ResultsData]()
//    @Published var hasError = false
//    @Published var error : BookModelError?
//    private let url = "https://openlibrary.org/search.json?"
//    
//    @MainActor
//    func fetchData(query: String) async {
//        if let url = URL(string: (url + query)) {
//            do {
//                let (data, _) = try await URLSession.shared.data(from: url)
//                guard let results = try JSONDecoder().decode([ResultsData]?.self, from: data) else {
//                    self.hasError.toggle()
//                    self.error = BookModelError.decodeError
//                    return
//                }
//                self.booksData = results
//            } catch {
//                self.hasError.toggle()
//                self.error = BookModelError.customError(error: error)
//            }
//
//        }
//    }
//    
//    
//}
//                                                 
//    
////    
//
////    
////}
//
//
//
//

////@MainActor
////func fetchBooks(query: String) async {
////    guard let url = URL(string: (url + query)) else {return}
////    URLSession.shared.dataTask(with: url) { data, _, _ in
////        guard let bookData = data else {return}
////        do {
////            let results = try await JSONDecoder().decode([BookResult].self, from: data ?? resultNotFound)
////            DispatchQueue.main.async {
////                self.booksData = results
////            }
////        } catch {
////            self.hasError.toggle()
////            self.error = BookModelError.customError(error: error)
////            
////        }
////    }.resume()
////    
////}
//



// the newest



//func getBookInfo(type: String, query: String, completion: @escaping (Books) -> Void) {
//    let urlString = "https://www.googleapis.com/books/v1/volumes?q="
//    var searchLine : String
//    
//    switch type {
//    case "isbn":
//        searchLine = "isbn:\(query)"
//    case "title":
//        searchLine = "title:\(query)"
//    case "author":
//        searchLine = "author:\(query)"
//    default:
//        searchLine = query
//    }
//    
//    guard var URL = URL(string: urlString) else {
//        print("Invalid URL")
//        return
//    }
//    let URLParams = searchLine
//    URL = URL.appendingPathComponent(URLParams)
//    
//    let task = URLSession.shared.dataTask(with: URL) { (data, response, error) in
//        if let error = error {
//            // error in search
//            print("Error: \(error.localizedDescription)")
//            return
//        }
//        
//        guard let data = data else {
//            // No data received
//            print("No data received")
//            return
//        }
//        
//        do {
//            let decoder = JSONDecoder()
//            guard let bookResults = try decoder.decode([BookItem]?.self, from: data) else {
//                print("Error decoding JSON while filling books array")
//                return
//            }
//            self.books = bookResults
//        } catch {
//            print("Error decoding JSON: \(error.localizedDescription)")
//        }
//        
//    }
//}
//}
