//
//  String.swift
//  SharePay
//
//  Created by Visarut Tippun on 25/4/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import Foundation

extension String {
    
    func isValid() -> Bool {
        guard self.trimmingCharacters(in: CharacterSet.whitespaces).count > 0,
            self.replacingOccurrences(of: "\n", with: "").count > 0 else { return false }
        return true
    }
    
}
