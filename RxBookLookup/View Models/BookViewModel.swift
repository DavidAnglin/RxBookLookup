//
//  BookViewModel.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BookViewModel {
    
    let title: String
    let author: String
    let imageURL: URL

    init(book: Book) {
        self.title = book.title
        self.author = book.authors.first ?? "Unknown"
        self.imageURL = book.imageURL
    }
}
