//
//  BookListViewModel.swift
//  RxBookLookup
//
//  Created by David Anglin on 10/6/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import Foundation
import RxSwift

class BookListViewModel {
    
    /// Call to update current category. Causes reload of the books.
    let setCurrentCategory: AnyObserver<String>
    
    /// Call to show category list screen.
    let chooseCategory: AnyObserver<Void>
    
    /// Call to reload repositories.
    let reload: AnyObserver<Void>
    
    /// Emits an array of fetched Books.
    let books: Observable<[BookViewModel]>
    
    /// Emits a formatted title for a navigation item.
    let title: Observable<String>
    
    /// Emits an error messages to be shown.
    let alertMessage: Observable<String>
    
    /// Emits when we should show Category list.
    let showCategoryList: Observable<Void>
    
    init(category: String) {
        let _reload = PublishSubject<Void>()
        self.reload = _reload.asObserver()
        
        let _currentCategory = BehaviorSubject<String>(value: category)
        self.setCurrentCategory = _currentCategory.asObserver()
        
        self.title = _currentCategory.asObserver()
            .map { "\($0)" }
        
        let _alertMessage = PublishSubject<String>()
        self.alertMessage = _alertMessage.asObservable()
        
        self.books = BookService.books(forCategory: category)
            .map { books in books.compactMap(BookViewModel.init) }
                
        let _chooseCategory = PublishSubject<Void>()
        self.chooseCategory = _chooseCategory.asObserver()
        self.showCategoryList = _chooseCategory.asObservable()
    }
}
