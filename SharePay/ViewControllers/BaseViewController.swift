//
//  BaseViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 25/4/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit
import SimpleHUD

typealias BaseViewController = ViewController & ViewControllerProtocol

protocol ViewControllerProtocol {
    func configure()
    func bindViewModel()
}

class ViewController: UIViewController {
    
    var loading:SimpleHUD = SimpleHUD()

    override func viewDidLoad() {
        super.viewDidLoad()
        if let vc = self as? BaseViewController {
            vc.configure()
            vc.bindViewModel()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.loading.show(at: (self.tabBarController ?? self.navigationController ?? self).view, type: .fiveBars)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.loading.dismiss()
        }
    }
    
    func doneToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.didTapDoneToolbar))
        toolbar.items = [spacer, done]
        toolbar.isTranslucent = false
        toolbar.sizeToFit()
        return toolbar
    }
    
    @objc func didTapDoneToolbar() {
        self.view.endEditing(true)
    }
    
}
