//
//  UIViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 25/4/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

extension UIViewController {
    
    class func identifier() -> String {
        return String(describing: self)
    }
    
    class func newInstance<T: UIViewController>(of type: T.Type, storyboard:Storyboard) -> T {
        return storyboard.load().instantiateViewController(withIdentifier: self.identifier()) as! T
    }
    
}
