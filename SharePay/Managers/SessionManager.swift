//
//  SessionManager.swift
//  SharePay
//
//  Created by Visarut Tippun on 2/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import Foundation

class SessionManager: NSObject {
    
    static let shared:SessionManager = SessionManager()
    
    var promptPay:PromptPay?
    
    var persons:[Person] = []
    
    override init() {
        super.init()
        
    }
    
    func loadSession() {
        
    }
    
}
