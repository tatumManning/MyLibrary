//
//  ExploreViewModel.swift
//  MyLibrary
//
//  Created by Tatum Manning on 12/1/23.
//

import Foundation

class ExploreViewModel : ObservableObject {
    @Published private(set) var listData = [NYTBookModel]()
    @Published var hasError = false
    @Published var error : ExploreModelError?
    private let url = "https://api.nytimes.com/svc/books/v3/lists/current/Combined Print and E-Book Fiction.json?api-key=jDPkVFJ8hKgiCCLEDySONC7ykBVZ4kDK"
    
    @MainActor
    func fetchList() async {
        if let url = URL(string: url) {
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard let results = try JSONDecoder().decode(NYTBSListModel?.self, from: data) else {
                    self.hasError.toggle()
                    self.error = ExploreModelError.decodeError
                    return
                }
                self.listData = results.books
            } catch {
                self.hasError.toggle()
                self.error = ExploreModelError.customError(error: error)
            }
        }
    }
}


extension ExploreViewModel {
    enum ExploreModelError : LocalizedError {
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
