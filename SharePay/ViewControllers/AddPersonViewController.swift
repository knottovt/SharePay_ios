//
//  AddFriendViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 17/11/2562 BE.
//  Copyright © 2562 knttx. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class AddPersonViewController: BaseViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    var addedCompletion:CocoaAction?
    private let bag = DisposeBag()
    
    class func create() -> AddPersonViewController {
        return self.newInstance(of: self, storyboard: .main)
    }
    
    class func present(at viewController: UIViewController, addedCompletion:CocoaAction) {
        let vc = self.newInstance(of: self, storyboard: .main)
        vc.addedCompletion = addedCompletion
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        viewController.present(vc, animated: true, completion: nil)
    }
    
    func configure() {
        self.backgroundView.rx.tapGesture { (_, delegate) in
            delegate.simultaneousRecognitionPolicy = .never
        }.when(.recognized).bind { [weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: self.bag)
        
        self.closeButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: self.bag)
    }
    
    func bindViewModel() {
        
    }
    
}
