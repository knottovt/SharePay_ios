//
//  PromptPayQRCodeViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 25/4/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxBinding
import RxGesture

class PromptPayQRCodeViewModel {
    var promptPay = BehaviorRelay<PromptPay?>(value: nil)
    
    init(promptPayId:String) {
        self.promptPay.accept(PromptPay(id: promptPayId))
    }
}

class PromptPayQRCodeViewController: BaseViewController {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    @IBOutlet weak var promptPayIdLabel: UILabel!

    var viewModel:PromptPayQRCodeViewModel!
    private let bag = DisposeBag()
    
    class func present(at viewController:UIViewController, promptPayId:String) {
        let vc = self.newInstance(of: self, storyboard: .main)
        vc.viewModel = .init(promptPayId: promptPayId)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        viewController.present(vc, animated: true, completion: nil)
    }
    
    func configure() {
        self.contentView.setViewCornerRadius(16)
        
        self.backgroundView.rx.tapGesture { (_, delegate) in
            delegate.simultaneousRecognitionPolicy = .never
        }.when(.recognized).bind { [weak self] (_) in
            self?.dismiss(animated: true, completion: nil)
        }.disposed(by: self.bag)
    }
    
    func bindViewModel() {
        self.viewModel.promptPay.map({$0?.id}) ~> self.promptPayIdLabel.rx.text ~ self.bag
        self.qrCodeImageView.setImageWith(stringUrl: self.viewModel.promptPay.value?.qrCodeUrl())
    }
    
}
