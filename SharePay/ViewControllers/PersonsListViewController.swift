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
    
    var isSelectMode = BehaviorRelay<Bool>(value: false)
    var dataSource = BehaviorRelay<[Person]>(value: [])
    private let bag = DisposeBag()
    
    init() {
        SessionManager.shared.persons.bind(to: self.dataSource).disposed(by: self.bag)
    }
    
    func delete(persons:[Person]) {
        var newValues = SessionManager.shared.persons.value
        persons.forEach { person in
            newValues = newValues.filter({ $0.id != person.id })
        }
        SessionManager.shared.persons.accept(newValues)
        if self.isSelectMode.value {
            self.isSelectMode.accept(newValues.count > 0)
        }
        self.isSelectMode.accept(self.isSelectMode.value ? newValues.count > 0 : false)
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
        self.tableView.allowsMultipleSelection = true
        self.tableView.tableFooterView = UIView()
        self.tableView.register(cell: PersonsListTableViewCell.self)
        self.tableView.rx.setDelegate(self).disposed(by: self.bag)
        self.configureBarButton()
    }
    
    func configureBarButton() {
        let addPersonButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addPerson))
        let isSelectMode = self.viewModel.isSelectMode.value
        let selectButton = UIBarButtonItem(title: isSelectMode ? "Cancel" : "Select",
                                           style: isSelectMode ? .done : .plain,
                                           target: self, action: #selector(self.toggleEditMode))
        let trash = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.deleteSelected))
        let rightBarButtonItems = isSelectMode ? [trash, selectButton] : [addPersonButton, selectButton]
        self.navigationItem.rightBarButtonItems = rightBarButtonItems
    }
    
    @objc func addPerson() {
        AddPersonViewController.present(at: self)
    }
    
    @objc func toggleEditMode() {
        let isEditMode = self.viewModel.isSelectMode.value
        self.viewModel.isSelectMode.accept(!isEditMode)
    }
    
    @objc func deleteSelected() {
        guard let selectedRow = self.tableView.indexPathsForSelectedRows?.map({ $0.row }) else { return }
        var persons:[Person] = []
        selectedRow.forEach { row in
            persons.append(SessionManager.shared.persons.value[row])
        }
        self.alertConfirmDelete(persons: persons)
    }
    
    func bindViewModel() {
        self.viewModel.isSelectMode.bind { [weak self] _ in
            self?.tableView.reloadData()
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.configureBarButton()
            }
        }.disposed(by: self.bag)
        
        self.viewModel.dataSource.bind(to: self.tableView.rx.items(cellIdentifier: PersonsListTableViewCell.identifier(), cellType: PersonsListTableViewCell.self)) {
            [weak self] (row, item, cell) in
            let isSelectMode = self?.viewModel.isSelectMode.value ?? false
            cell.configure(person: item, isSelectMode: isSelectMode)
        }.disposed(by: self.bag)
    }

    func alertConfirmDelete(persons:[Person]) {
        let title = persons.count > 1 ? "selected items" : "\"\(persons.first?.name ?? "")\""
        let alertVc = UIAlertController(title: "Delete \(title)", message: "Are you sure you want to delete?", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let delete = UIAlertAction(title: "Delete", style: .destructive) { [weak self] (_) in
            self?.viewModel.delete(persons: persons)
        }
        alertVc.addActions([cancel, delete])
        self.present(alertVc, animated: true, completion: nil)
    }
}

extension PersonsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (action, view, completionHandler) in
            let person = SessionManager.shared.persons.value[indexPath.row]
            self.alertConfirmDelete(persons: [person])
            completionHandler(true)
        }
        deleteAction.image = UIImage(systemName: "trash")
        deleteAction.backgroundColor = .systemRed
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        return self.viewModel.isSelectMode.value ? nil : configuration
    }
    
}
