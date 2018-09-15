//
//  BookCategoryTableViewController.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import UIKit
import RxSwift

class BookCategoryTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Book Categories"
    }
    
    // MARK: - UITableViewDataSource -
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return BookCategory.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BookCategoriesTableViewCell.reuseIdentifier, for: indexPath) as? BookCategoriesTableViewCell, let category = BookCategory(rawValue: indexPath.row) else {
            fatalError("Error with Book Category")
        }
        
        cell.configure(with: category)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = BookCategory(rawValue: indexPath.row)
        
        guard let bookResultsViewController = storyboard?.instantiateViewController(withIdentifier: "bookResults") as? BookResultsCollectionViewController else { return }
        
        if let category = category?.description {
            bookResultsViewController.title = category
            bookResultsViewController.category.value = category
            
            navigationController!.pushViewController(bookResultsViewController, animated: true)
            
            tableView.deselectRow(at: indexPath, animated: true)

        }
    }
}




