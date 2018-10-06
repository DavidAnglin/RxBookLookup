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

class BookResultsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: BookListViewModel!
    private var navigator: Navigator!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true

        bindUI()
    }
    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: BookListViewModel) -> BookResultsViewController {
        return storyboard.instantiateViewController(ofType: BookResultsViewController.self).then { vc in
            vc.navigator = navigator
            vc.viewModel = viewModel
        }
    }
    
    func bindUI() {
        
        viewModel.books
            .observeOn(MainScheduler.instance)
            .bind(to: collectionView.rx.items(cellIdentifier: bookResultsCellIdentifier, cellType: BookCollectionViewCell.self)) { [weak self] (_, book, cell) in
                self?.setupBookCell(cell, book: book)
            }
            .disposed(by: disposeBag)
        
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
 
    }
    
    private func setupBookCell(_ cell: BookCollectionViewCell, book: BookViewModel) {
        cell.setBookTitle(book.title)
        cell.setBookAuthor(book.author)
        cell.setThumbnailImage(book.imageURL)
    }
}
