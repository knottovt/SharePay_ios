//
//  PersonsListViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 2/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class PersonsListViewModel {
    var dataSource = BehaviorRelay<[Person]>(value: [])
    
    init() {
        
    }
}

class PersonsListViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    
    var viewModel = PersonsListViewModel()
    private let bag = DisposeBag()

    class func create() -> PersonsListViewController {
        return self.newInstance(of: self, storyboard: .main)
    }
    
    func configure() {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(cell: PersonsListTableViewCell.self)
        self.tableView.rx.setDelegate(self).disposed(by: self.bag)
    }
    
    func bindViewModel() {
        self.viewModel.dataSource.bind(to: self.tableView.rx.items(cellIdentifier: PersonsListTableViewCell.identifier(), cellType: PersonsListTableViewCell.self)) {
            (row, item, cell) in
            cell.configure(person: item)
        }.disposed(by: self.bag)
    }
    
    func addPerson() {
        AddPersonViewController.present(at: self, addedCompletion: CocoaAction {
            //
            return .empty()
        })
    }

}

extension PersonsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}
