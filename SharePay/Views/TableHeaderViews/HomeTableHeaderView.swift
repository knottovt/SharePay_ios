//
//  HomeTableHeaderView.swift
//  SharePay
//
//  Created by Visarut Tippun on 3/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

class HomeTableHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var totalTitleLabel: UILabel!
    @IBOutlet weak var totalValueLabel: UILabel!
    
    @IBOutlet weak var promtPayContainerView:UIView!
    @IBOutlet weak var promtPayQRImageView:UIImageView!
    @IBOutlet weak var promtPayIdLabel:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.promtPayContainerView.setViewCornerRadius(6)
        self.promtPayContainerView.setViewBorder(width: 0.5, color: .lightGray)
    }
}
