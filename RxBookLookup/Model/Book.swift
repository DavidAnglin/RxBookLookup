//
//  Book.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import Foundation

//typealias AnyDict = [String: Any]

struct Book {
    
    let title : String
    let authors : [String]
    let imageURL : URL
    
    // MARK: - Init -
    init?(dictionary: [String : Any]) {
        guard let volumeInfo = dictionary["volumeInfo"] as? [String : Any],
        let title = volumeInfo["title"] as? String,
        let authors = volumeInfo["authors"] as? [String],
        let imageLinks = volumeInfo["imageLinks"] as? [String : Any],
        let bookURLString = imageLinks["smallThumbnail"] as? String,
        let bookURL = URL(string: bookURLString)
        else { return nil }
        
        self.title = title
        self.authors = authors
        self.imageURL = bookURL
    }
}
