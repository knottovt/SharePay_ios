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
import RxBinding
import RxBiBinding
import UnderKeyboard

class AddPersonViewModel {
    
    var name = BehaviorRelay<String?>(value: nil)
    var image = BehaviorRelay<UIImage?>(value: nil)
    
    init() {
        
    }
    
    func addPerson(completion: @escaping () -> ()) {
        guard let name = self.name.value, name.isValid() else {
            completion()
            return
        }
        let person = Person(name: name, image: self.image.value)
        var values = SessionManager.shared.persons.value
        values.append(person)
        SessionManager.shared.persons.accept(values)
        completion()
    }
    
}

class AddPersonViewController: BaseViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    let underKeyboard = UnderKeyboardLayoutConstraint()
    var viewModel = AddPersonViewModel()
    private let bag = DisposeBag()
    
    class func create() -> AddPersonViewController {
        return self.newInstance(of: self, storyboard: .main)
    }
    
    class func present(at viewController: UIViewController) {
        let vc = self.newInstance(of: self, storyboard: .main)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        viewController.present(vc, animated: true, completion: nil)
    }
    
    func configure() {
        self.contentView.setViewCornerRadius(16)
        self.imageContainerView.setViewCircle()
        self.imageView.setViewCircle()
        self.addButton.setViewCornerRadius(10)
        self.underKeyboard.setup(self.bottomConstraint, view: self.view, minMargin: 8)
        self.nameTextField.autocorrectionType = .no
        self.nameTextField.autocapitalizationType = .none
        self.nameTextField.inputAccessoryView = self.doneToolbar()
        self.nameTextField.becomeFirstResponder()
    }
    
    func bindViewModel() {
        self.viewModel.name <~> self.nameTextField.rx.text ~ self.bag
        self.viewModel.image ~> self.imageView.rx.image ~ self.bag
        
        self.backgroundView.rx.tapGesture { (_, delegate) in
            delegate.simultaneousRecognitionPolicy = .never
        }.when(.recognized).bind { [weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: self.bag)
        
        self.closeButton.rx.tap.bind { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: self.bag)
        
        self.contentView.rx.tapGesture { (_, delegate) in
            delegate.simultaneousRecognitionPolicy = .never
        }.when(.recognized).bind { [weak self] (_) in
            self?.view.endEditing(true)
        }.disposed(by: self.bag)
        
        self.imageContainerView.rx.tapGesture { (_, delegate) in
            delegate.simultaneousRecognitionPolicy = .never
        }.when(.recognized).bind { [weak self] (_) in
            self?.view.endEditing(true)
            self?.addImage()
        }.disposed(by: self.bag)
        
        self.addButton.rx.tap.bind { [weak self] in
            self?.addPerson()
        }.disposed(by: self.bag)
    }
    
    func addImage() {
        //
    }
    
    func addPerson() {
        self.viewModel.addPerson { [weak self] in
            self?.dismiss(animated: true, completion: nil)
        }
    }
}
