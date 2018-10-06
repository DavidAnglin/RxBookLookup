//
//  CategoryViewModel.swift
//  RxBookLookup
//
//  Created by David Anglin on 10/6/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import Foundation
import RxSwift

class CategoryViewModel {
    
    let selectCategory: AnyObserver<String>
    
    let categories: Observable<[String]>
    let didSelectCategory: Observable<String>
    
    init(bookService: BookService = BookService()) {
        self.categories = bookService.getBookCategories()
        
        let _selectCategory = PublishSubject<String>()
        self.selectCategory = _selectCategory.asObserver()
        self.didSelectCategory = _selectCategory.asObserver()
    }
}
