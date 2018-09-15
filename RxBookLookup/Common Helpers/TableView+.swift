//
//  TableView+.swift
//  RxBookLookup
//
//  Created by David Anglin on 9/15/18.
//  Copyright (c) 2016-2017 Razeware LLC
//

import Foundation
import UIKit

extension UITableView {
    func dequeueCell<T>(ofType type: T.Type) -> T {
        return dequeueReusableCell(withIdentifier: String(describing: T.self)) as! T
    }
}


