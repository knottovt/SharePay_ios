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
    @IBOutlet weak var checkmarkContainerView:UIView!
    @IBOutlet weak var checkmarkIcon:UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.personImageView.image = nil
        self.checkmarkIcon.image = nil
        self.checkmarkIcon.tintColor = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.checkmarkContainerView.isHidden = true
        self.personImageView.setViewCircle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.checkmarkIcon.image = UIImage(systemName: selected ? "checkmark.circle.fill" : "circle")
        self.checkmarkIcon.tintColor = selected ? .systemBlue : .systemGray5
    }
    
    func configure(person:Person, isSelectMode:Bool) {
        self.nameLabel.text = person.name
        self.personImageView.image = person.image
        self.checkmarkContainerView.isHidden = !isSelectMode
    }
    
}
