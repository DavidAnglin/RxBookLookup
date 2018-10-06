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
import Then

class BookCategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: CategoryViewModel!
    private var navigator: Navigator!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        setupUI()
        bindUI()
    }
    
    static func createWith(navigator: Navigator, storyboard: UIStoryboard, viewModel: CategoryViewModel) -> BookCategoryViewController {
        return storyboard.instantiateViewController(ofType: BookCategoryViewController.self).then { vc in
            vc.navigator = navigator
            vc.viewModel = viewModel
        }
    }
    
    func setupUI() {
        self.title = "Book Categories"
        tableView.rowHeight = 65.0
        
    }
    
    func bindUI() {
        viewModel.categories
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "BookCategoryCell", cellType: UITableViewCell.self)) { (_, category, cell) in
                cell.textLabel?.text = category
                cell.selectionStyle = .none
            }
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] category in
                guard let strongSelf = self else { return }
                strongSelf.navigator.show(segue: .listOfBooks(category: category), sender: strongSelf)
            })
            .disposed(by: disposeBag)
    }
}




