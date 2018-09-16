//
//  BookCollectionViewCell.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright © 2018 David Anglin. All rights reserved.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbailImage: UIImageView!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    
    func configure(with book: Book) {
        thumbailImage.kf.setImage(with: book.imageURL)
        bookTitle.text = book.title
        bookAuthor.text = book.authors.first
    }
}
