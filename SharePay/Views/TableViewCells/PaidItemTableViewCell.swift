//
//  PaidItemTableViewCell.swift
//  SharePay
//
//  Created by Visarut Tippun on 3/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

class PaidItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var priceLabel:UILabel!
    @IBOutlet weak var pricePerPersonLabel:UILabel!
    @IBOutlet weak var personsLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    func configure(item:PaidItem) {
        self.nameLabel.text = item.name
        self.priceLabel.text = String(format: "%.2f", item.price ?? 0) + " THB"
        self.pricePerPersonLabel.text = String(format: "%.2f", item.pricePerPerson()) + " THB/Person"
        self.personsLabel.text = item.persons.compactMap({$0.name}).joined(separator: ", ")
    }
    
}
