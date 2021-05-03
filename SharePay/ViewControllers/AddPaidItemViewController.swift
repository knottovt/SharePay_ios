//
//  AddPaidItemViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 3/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBinding
import RxBiBinding

class AddPaidItemViewModel {
    
    var name = BehaviorRelay<String?>(value: nil)
    var price = BehaviorRelay<String?>(value: nil)
    var dataSource = BehaviorRelay<[Person]>(value: [])
    
    private let bag = DisposeBag()
    
    init() {
        SessionManager.shared.persons.bind(to: self.dataSource).disposed(by: self.bag)
    }
    
    func createPaidItem(persons:[Person]) {
        guard let name = self.name.value, name.isValid(),
              let priceString = self.price.value,
              let price = Double(priceString) else {
            return
        }
        let paidItem = PaidItem(name: name, price: price, persons: persons)
    }
    
}


class AddPaidItemViewController: BaseViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var viewModel = AddPaidItemViewModel()
    private let bag = DisposeBag()
    
    class func present(at viewController: UIViewController) {
        let vc = self.newInstance(of: self, storyboard: .main)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        viewController.present(vc, animated: true, completion: nil)
    }
    
    func configure() {
        self.contentView.setViewCornerRadius(16)
        self.nameTextField.inputAccessoryView = self.doneToolbar()
        self.priceTextField.inputAccessoryView = self.doneToolbar()
        self.priceTextField.keyboardType = .decimalPad
        
        self.tableView.allowsMultipleSelection = true
        self.tableView.keyboardDismissMode = .onDrag
        self.tableView.tableFooterView = UIView()
        self.tableView.register(cell: PersonsListTableViewCell.self)
        self.tableView.rx.setDelegate(self).disposed(by: self.bag)
        
        self.addButton.setViewCornerRadius(10)
    }
    
    func bindViewModel() {
        self.viewModel.name <~> self.nameTextField.rx.text ~ self.bag
        self.viewModel.price <~> self.priceTextField.rx.text ~ self.bag
        
        self.viewModel.dataSource.bind(to: self.tableView.rx.items(cellIdentifier: PersonsListTableViewCell.identifier(), cellType: PersonsListTableViewCell.self)) {
            (row, item, cell) in
            cell.configure(person: item, isSelectMode: true)
        }.disposed(by: self.bag)
        
        self.backgroundView.rx.tapGesture { (_, delegate) in
            delegate.simultaneousRecognitionPolicy = .never
        }.when(.recognized).bind { [weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: self.bag)

        self.closeButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: self.bag)
        
        self.addButton.rx.tap.bind { [weak self] in
            self?.addPaidItem()
        }.disposed(by: self.bag)
    }
    
    func addPaidItem() {
        guard let selectedRow = self.tableView.indexPathsForSelectedRows?.map({ $0.row }) else { return }
        var persons:[Person] = []
        selectedRow.forEach { row in
            persons.append(SessionManager.shared.persons.value[row])
        }
        self.viewModel.createPaidItem(persons: [])
    }

}

extension AddPaidItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
