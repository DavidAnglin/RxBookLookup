//
//  BooksService.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BookService {
    
    static let API = "https://www.googleapis.com/books/v1/volumes?"
    static let APIKey = "AIzaSyDT2zulAU6zBs-C2EM7Kj2P055pPgNZKuo" // Add Google Books API Key Here
    
    static func request(endpoint: String, query: [String: Any] = [:]) -> Observable<[String: Any]> {
        do {
            guard let url = URL(string: API),
                var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                    throw BookError.invalidURL(endpoint)
            }
            
            components.queryItems = try query.compactMap { (key, value) in
                guard let v = value as? CustomStringConvertible else {
                    throw BookError.invalidParameter(key, value)
                }
                
                return URLQueryItem(name: key, value: v.description)
            }
            
            guard let finalURL = components.url else {
                throw BookError.invalidURL(endpoint)
            }
            
            let request = URLRequest(url: finalURL)
            
            return URLSession.shared.rx.response(request: request)
                .map { _, data in
                    guard let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                        let result = jsonObject as? [String: Any] else {
                            throw BookError.invalidJSON(finalURL.absoluteString)
                    }
                    return result
            }
        } catch {
           return Observable.empty()
        }
    }
    
    // Return a List of Predefined Book Categories
    func getBookCategories() -> Observable<[String]> {
        return Observable.just([
            "Swift",
            "Objective-C",
            "Java",
            "Kotlin",
            "Sports",
            "Action",
            "Fiction",
            "Non Fiction",
            "Horror",
            "Mystery",
            "Drama",
            "Satire"
            ])
    }
    
    static func books(forCategory category: String) -> Observable<[Book]> {
        return request(endpoint: category, query: [
                "maxResults" : NSNumber(value: 40),
                "orderBy" : "newest",
                "q" : "\(category)",
                "key" : APIKey
            ])
            .map { json in
                guard let raw = json["items"] as? [[String : Any]] else {
                    throw BookError.invalidJSON(category)
                }
                
                return raw.compactMap(Book.init)
            }
            .catchErrorJustReturn([])
    }
}
