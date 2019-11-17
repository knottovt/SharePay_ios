//
//  PromtPay.swift
//  SharePay
//
//  Created by Visarut Tippun on 17/11/2562 BE.
//  Copyright © 2562 knttx. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

struct PromptPay {
    var id: String!
    var QRCode: UIImage
}

//class PromptPayViewModel {
//    var QRCode: UIImage
//    func getImage(number: String) {
//        Alamofire.request("https://promptpay.io/\(number).png").responseImage { response in
//
//
//            if let image = response.result.value {
//                self.QRCode.image = image
//            }
//        }
//    }
//}
