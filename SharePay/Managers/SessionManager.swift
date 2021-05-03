//
//  SessionManager.swift
//  SharePay
//
//  Created by Visarut Tippun on 2/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SessionManager: NSObject {
    
    static let shared:SessionManager = SessionManager()
    private let bag = DisposeBag()
    
    var promptPay = BehaviorRelay<PromptPay?>(value: nil)
    
    var persons = BehaviorRelay<[Person]>(value: [])
    
    var paidItems = BehaviorRelay<[PaidItem]>(value: [])
    
    override init() {
        super.init()
        self.loadSession()
        
        self.promptPay.bind { (promptPay) in
            UserDataManager.shared.saveObject(promptPay, key: Keys.promptPay)
        }.disposed(by: self.bag)
        
        self.persons.bind { (persons) in
            UserDataManager.shared.saveObject(persons, key: Keys.persons)
        }.disposed(by: self.bag)
        
        self.paidItems.bind { (promptPay) in
            UserDataManager.shared.saveObject(promptPay, key: Keys.paidItems)
        }.disposed(by: self.bag)
    }
    
    func loadSession() {
        if let promptPay = UserDataManager.shared.retrieveObject(type: PromptPay.self, key: Keys.promptPay) {
            self.promptPay.accept(promptPay)
        }
        if let persons = UserDataManager.shared.retrieveObject(type: [Person].self, key: Keys.persons) {
            self.persons.accept(persons)
        }
        if let paidItems = UserDataManager.shared.retrieveObject(type: [PaidItem].self, key: Keys.paidItems) {
            self.paidItems.accept(paidItems)
        }
    }
    
}
