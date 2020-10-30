//
//  THEmptyStateView.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/29/20.
//

import UIKit

class THEmptyStateView: UIView {

    let messageLabel = THLabel(textAlignment: .center, fontSize: 26, fontColor: .label, fontWeight: .bold)
    let newspaperImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(message: String) {
        self.init()
        messageLabel.text = message
    }
    
    private func configure() {
        addSubview(newspaperImage)
        addSubview(messageLabel)
        
        
        messageLabel.numberOfLines = 3
        
        newspaperImage.image = SFSymbols.newspapger
        newspaperImage.tintColor = .secondarySystemBackground
        newspaperImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -100),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
        
            newspaperImage.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 10),
            newspaperImage.widthAnchor.constraint(equalTo: self.widthAnchor, constant: -16),
            newspaperImage.heightAnchor.constraint(equalTo: self.widthAnchor, constant: -16),
            newspaperImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -120)
        
        ])
    }
}
