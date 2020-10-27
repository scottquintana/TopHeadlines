//
//  THNavButton.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

class THNavButton: UIButton {
    let buttonImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(color: UIColor, image: UIImage) {
        self.init(frame: .zero)
        self.buttonImage.image = image
        self.buttonImage.tintColor = color
        
        configure()
    }
    
    private func configure() {
        backgroundColor = .white
        frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        layer.cornerRadius =  0.5 * bounds.size.width
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.50
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowRadius = 3
        clipsToBounds = false
        
        addSubview(buttonImage)
        buttonImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            buttonImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonImage.widthAnchor.constraint(equalToConstant: 40),
            buttonImage.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
