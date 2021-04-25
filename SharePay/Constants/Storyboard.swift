//
//  Storyboard.swift
//  SharePay
//
//  Created by Visarut Tippun on 25/4/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

enum Storyboard:String {
    case main  = "Main"
    
    var name:String {
        return self.rawValue
    }
    
    func load() -> UIStoryboard {
        return UIStoryboard(name: self.name, bundle: nil)
    }
    
}
