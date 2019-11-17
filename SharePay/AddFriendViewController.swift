//
//  AddFriendViewController.swift
//  SharePay
//
//  Created by Visarut Tippun on 17/11/2562 BE.
//  Copyright © 2562 knttx. All rights reserved.
//

import UIKit

class AddFriendViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func didTapCloseButton() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
