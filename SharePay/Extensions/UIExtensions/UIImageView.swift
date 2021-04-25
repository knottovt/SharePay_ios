//
//  UIImageView.swift
//  SharePay
//
//  Created by Visarut Tippun on 25/4/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit
import AlamofireImage

extension UIImageView {
    
    func setImageWith(stringUrl: String?) {
        guard let imageUrl = stringUrl, imageUrl.isValid(),
              let url = URL(string: imageUrl) else { return }
        self.af.setImage(withURL: url)
    }
    
    func prepareForReuse() {
        self.af.cancelImageRequest()
        self.image = nil
    }
    
}
