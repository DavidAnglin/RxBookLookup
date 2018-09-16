//
//  BookResultsCollectionViewController.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let bookResultsCellIdentifier = "bookResultsId"

class BookResultsCollectionViewController: UICollectionViewController {
    
    var category = String()
    var books = Variable<[Book]>([])

    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        books.asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
            })
            .disposed(by: disposeBag)
        
        fetchBooks()
    }
    
    func fetchBooks() {
        BooksNetworking.books(forCategory: category)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] data in
                self?.books.value = data // I do not think this is correct, need to look into this more!
                self?.collectionView?.reloadData()
            })
            .disposed(by: disposeBag)
    }

    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return books.value.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bookResultsCellIdentifier, for: indexPath) as! BookCollectionViewCell
        
        // Configure the cell
        cell.configure(with: books.value[indexPath.row])
        return cell
    }
}
