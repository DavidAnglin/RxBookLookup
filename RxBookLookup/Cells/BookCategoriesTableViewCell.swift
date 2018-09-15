//
//  BookCategoriesTableViewCell.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import UIKit

class BookCategoriesTableViewCell: UITableViewCell {

    static let reuseIdentifier = "BookCategoryCell"
    
    @IBOutlet weak var title: UILabel!

    func configure(with bookCategory: BookCategory) {
        title.text = bookCategory.description
    }
}
