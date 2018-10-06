//
//  BookCategoryTableViewController.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import UIKit
import RxSwift
import RxDataSources

class BookCategoryViewController: UIViewController, BindableType {
    
    var viewModel: CategoryViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        self.title = "Select a Category"
        tableView.rowHeight = 50.0
    }
    
    func bindViewModel() {
        viewModel.categories
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "BookCategoryCell", cellType: UITableViewCell.self)) { (_, category, cell) in
                cell.textLabel?.text = category
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .bind(to: viewModel.selectCategory)
            .disposed(by: disposeBag)
    }
    
    
    // MARK: - UITableViewDataSource -
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return BookCategory.count
//    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCategoriesTableViewCell.reuseIdentifier, for: indexPath) as? BookCategoriesTableViewCell, let category = BookCategory(rawValue: indexPath.row) else {
//            fatalError("Error with Book Category")
//        }
//
//        cell.configure(with: category)
//        return cell
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let category = BookCategory(rawValue: indexPath.row)
//
//        guard let bookResultsViewController = storyboard?.instantiateViewController(withIdentifier: "bookResults") as? BookResultsCollectionViewController else { return }
//
//        if let category = category?.description {
//            bookResultsViewController.title = category
//            bookResultsViewController.category = category
//
//            navigationController!.pushViewController(bookResultsViewController, animated: true)
//
//            tableView.deselectRow(at: indexPath, animated: true)
//
//        }
//    }
}




