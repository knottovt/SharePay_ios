//
//  ViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 16/11/2562 BE.
//  Copyright © 2562 knttx. All rights reserved.
//

import UIKit
import AlamofireImage
import JGProgressHUD


class HomeViewController: UIViewController {
    
    @IBOutlet var addFriendButton: UIBarButtonItem!
    
    @IBOutlet var promptPayView:UIView!
    @IBOutlet var addPromptPayButton: UIButton!
    @IBOutlet var promptPayQRImage: UIImageView!
    
    let loading = JGProgressHUD(style: .dark)
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addPromptPayButton.setTitle("Add PromptPay", for: .normal)
        self.promptPayView.layer.borderWidth = 1.0
        self.promptPayView.layer.borderColor = UIColor.purple.cgColor
        
        
    }
    
    
    @IBAction func didTapAddPPNo() {
        let alert = UIAlertController(title: "PromtPay", message: "เบอร์มือถือ 10 หลัก,\n เลขบัตรประชาชน 13 หลัก", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
            textField.addTarget(alert, action: #selector(alert.textDidChangeInAlert), for: .editingChanged)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        let ok = UIAlertAction(title: "OK", style: .default) { (action) in
            
            // Should never happen
            guard let textField = alert.textFields?[0].text else { return }
            
            // Perform action
            self.setPromptPaySection(promptPayID: textField)

        }
        ok.isEnabled = false
        alert.addAction(cancel)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    
    func setPromptPaySection(promptPayID:String) {
        self.showLoading(text: "PromptPay:\n\(promptPayID)")
        let url = URL(string: "https://promptpay.io/\(promptPayID).png")
        self.promptPayQRImage.af_setImage(withURL: url!)
        self.addPromptPayButton.setTitle(promptPayID, for: .normal)
        self.hideLoading()
    }
    
    @IBAction func didTapAddFriendButton() {
        // Safe Present
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddFriendViewController") as? AddFriendViewController {
            vc.modalPresentationStyle = .overFullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    
    func showLoading(text: String? = "Loading") {
        loading.textLabel.text = text
        loading.show(in: self.view)
    }
    
    func hideLoading(){
        loading.dismiss(afterDelay: 1)
    }
    
}

extension UIAlertController {

    func isValidNumber(_ number: String) -> Bool {
        return (number.count == 10 || number.count == 13) && number.rangeOfCharacter(from: .whitespacesAndNewlines) == nil
    }

    @objc func textDidChangeInAlert() {
        if let number = textFields?[0].text,
            let action = actions.last {
            action.isEnabled = isValidNumber(number)
        }
    }
}

