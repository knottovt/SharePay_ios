//
//  PersonsListTableViewCell.swift
//  SharePay
//
//  Created by Visarut Tippun on 2/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

class PersonsListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel:UILabel!
    @IBOutlet weak var personImageView:UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.personImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.personImageView.setViewCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(person:Person) {
        self.nameLabel.text = person.name
        self.personImageView.image = person.image
    }
    
}
