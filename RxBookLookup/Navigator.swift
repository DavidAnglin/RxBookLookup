/*
 * Copyright (c) 2016-2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation
import UIKit
import RxCocoa

class Navigator {
    lazy private var defaultStoryboard = UIStoryboard(name: "Main", bundle: nil)
    
    // MARK: - segues list
    enum Segue {
        case bookCategories
        case listOfBooks(category: String)
    }
    
    // MARK: - invoke a single segue
    func show(segue: Segue, sender: UIViewController) {
        switch segue {
        case .bookCategories:
            //show the combined timeline for the list
            let vm = CategoryViewModel()
            show(target: BookCategoryViewController.createWith(navigator: self, storyboard: sender.storyboard ?? defaultStoryboard, viewModel: vm), sender: sender)
        case .listOfBooks(let category):
            //show the list of user accounts in the list
            let vm = BookListViewModel(category: category)
            show(target: BookResultsViewController.createWith(navigator: self, storyboard: sender.storyboard ?? defaultStoryboard, viewModel: vm), sender: sender)
        }
    }
    
    private func show(target: UIViewController, sender: UIViewController) {
        if let nav = sender as? UINavigationController {
            //push root controller on navigation stack
            nav.pushViewController(target, animated: false)
            return
        }
        
        if let nav = sender.navigationController {
            //add controller to navigation stack
            nav.pushViewController(target, animated: true)
        } else {
            //present modally
            sender.present(target, animated: true, completion: nil)
        }
    }
}
