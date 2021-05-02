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

class HomeViewController: BaseViewController {
    
    @IBOutlet var addFriendButton: UIBarButtonItem!
    
    @IBOutlet var promptPayView:UIView!
    @IBOutlet var addPromptPayButton: UIButton!
    @IBOutlet var promptPayQRImage: UIImageView!
    
    private let bag = DisposeBag()
    
    func configure() {
        self.addPromptPayButton.setTitle("Add PromptPay", for: .normal)
        self.promptPayView.layer.borderWidth = 1.0
        self.promptPayView.layer.borderColor = UIColor.purple.cgColor
    }
    
    func bindViewModel() {
        self.addPromptPayButton.rx.tap.bind { [weak self] in
            self?.alertAddPromptPay()
        }.disposed(by: self.bag)
        
        self.addFriendButton.rx.tap.bind { [weak self] in
            let vc = AddPersonViewController.create()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .overFullScreen
            self?.present(vc, animated: true, completion: nil)
        }.disposed(by: self.bag)
    }
    
    
    func alertAddPromptPay() {
        let alert = UIAlertController(title: "PromtPay", message: "เบอร์มือถือ 10 หลัก,\n เลขบัตรประชาชน 13 หลัก", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.addTarget(alert, action: #selector(alert.textDidChangeInAlert), for: .editingChanged)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            // Should never happen
            guard let text = alert.textFields?.first?.text else { return }
            
            // Perform action
//            self.setPromptPaySection(promptPayID: textField)

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

