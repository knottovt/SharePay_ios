//
//  ViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 16/11/2562 BE.
//  Copyright © 2562 knttx. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewModel {
    
    var dataSource = BehaviorRelay<[PaidItem]>(value: [])
    
    init() {
        
    }
    
    func addPaidItem() {
        
    }
}

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView:UITableView!
    
    var viewModel = HomeViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func configure() {
        self.tableView.tableFooterView = UIView()
        self.tableView.rx.setDelegate(self).disposed(by: self.bag)
        self.configureBarButton()
    }
    
    func configureBarButton() {
        let personsListButton = UIBarButtonItem(image: UIImage(systemName: "person.2.circle"), style: .plain, target: self, action: #selector(self.showPersonsList))
        self.navigationItem.rightBarButtonItems = [personsListButton]
    }
    
    @objc func showPersonsList() {
        let vc = PersonsListViewController.create()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func bindViewModel() {
        
    }
    
    
    func alertAddPromptPay() {
        let alert = UIAlertController(title: "PromtPay", message: "เบอร์มือถือ 10 หลัก,\n เลขบัตรประชาชน 13 หลัก", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.addTarget(alert, action: #selector(alert.textDidChangeInAlert), for: .editingChanged)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            guard let promptPayNumber = alert.textFields?.first?.text else { return }
            SessionManager.shared.promptPay.accept(PromptPay(id: promptPayNumber))
        }
        ok.isEnabled = false
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension UIAlertController {

    func isValidNumber(_ number: String) -> Bool {
        return (number.count == 10 || number.count == 13) && number.rangeOfCharacter(from: .whitespacesAndNewlines) == nil
    }

    @objc func textDidChangeInAlert() {
        if let number = textFields?.first?.text,
            let action = actions.last {
            action.isEnabled = isValidNumber(number)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
