//
//  UIViewController+Ext.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/29/20.
//

import UIKit

extension UIViewController {
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = THEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
