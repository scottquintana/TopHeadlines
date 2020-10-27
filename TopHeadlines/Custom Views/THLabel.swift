//
//  THLabel.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/27/20.
//

import UIKit

class THLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat, fontColor: UIColor, fontWeight: UIFont.Weight) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        textColor = fontColor
        
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
    }
}
