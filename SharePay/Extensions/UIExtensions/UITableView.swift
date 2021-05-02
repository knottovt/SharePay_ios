//
//  UITableView.swift
//  SharePay
//
//  Created by Visarut Tippun on 2/5/21.
//  Copyright © 2021 knttx. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(cell:UITableViewCell.Type) {
        let nib = UINib(nibName: cell.identifier(), bundle: nil)
        self.register(nib, forCellReuseIdentifier: cell.identifier())
    }
    
    func register(cells:[UITableViewCell.Type]) {
        cells.forEach { [weak self] (cell) in
            self?.register(cell: cell)
        }
    }
    
    func dequeueCell<T:UITableViewCell>(of type: T.Type ,for indexPath:IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: T.identifier(), for: indexPath) as! T
    }
    
    func setTableHeaderView(_ tableHeaderView:UIView) {
        if self.tableHeaderView == nil {
            self.tableHeaderView = tableHeaderView
        }
    }
    
    func setTableFooterView(_ tableFooterView:UIView) {
        if self.tableFooterView == nil {
            self.tableFooterView = tableFooterView
        }
    }
    
}

