//
//  UIAlertController.swift
//  SharePay
//
//  Created by Visarut Tippun on 3/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

extension UIAlertController {
    
    func addActions(_ actions:[UIAlertAction]) {
        actions.forEach { [weak self] (action) in
            self?.addAction(action)
        }
    }
    
}
