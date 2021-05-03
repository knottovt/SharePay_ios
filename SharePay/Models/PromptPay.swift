//
//  PromptPay.swift
//  SharePay
//
//  Created by Visarut Tippun on 25/4/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import Foundation

struct PromptPay:Codable {
    var id:String
    
    init(id:String) {
        self.id = id
    }
}

extension PromptPay {
    func qrCodeUrl() -> String {
        return "https://promptpay.io/\(self.id).png"
    }
}
