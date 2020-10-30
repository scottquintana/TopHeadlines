//
//  UITableView+Ext.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/29/20.
//

import UIKit

extension UITableView {
    
    func removeExcessCells() {
        tableFooterView = UITableView(frame: .zero)
        
    }
}
