//
//  BooksNetworking.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BooksNetworking {
    
    // MARK:  - API Points -
    fileprivate enum Address : CustomStringConvertible {
        case books(category : String)
        
        var description: String {
            switch self {
            case .books(let category):
                return "q=\(category)"
            }
        }
        
        private var baseURL: String { return "https://www.googleapis.com/books/v1/volumes?" }
        // TODO - Hide this key when I push to remote
        private var apiKey: String { return "AIzaSyDgjUeNtdYjPlUGhIIbWNKwCwzBdVFxVWI" } // Add your Google Books API Key
        var url: URL {
            let urlString = "\(self.baseURL)\(self.description)&\(self.apiKey)"
            return URL(string: urlString)!
        }
    }
    
    static func request(endPoint: String) -> Observable<[String: Any]> {
        do {
            let category = Address.books(category: endPoint)
            let request = URLRequest(url: category.url)
            
            return URLSession.shared.rx.response(request: request)
                .map { _, data in
                    guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                        let result = jsonObject as? [String : Any] else {
                            throw BookError.invalidJSON(category.url.absoluteString)
                    }
                    
                    return result
            }
        } catch {
            return Observable.empty()
        }
    }
    
    static func books(forCategory category: BookCategory) -> Observable<[Book]> {
        return request(endPoint: category.description)
            .map { json in
                guard let raw = json["items"] as? [[String:Any]] else {
                    throw BookError.invalidJSON(category.description)
                }
                
                return raw.compactMap(Book.init)
            }
            .catchErrorJustReturn([])
    }
}
