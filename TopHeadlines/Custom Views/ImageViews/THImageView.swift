//
//  THImageView.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/27/20.
//

import UIKit

class THImageView: UIImageView {

   // let cache = NetworkManager.shared.cache
    
    let placeholderImage = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    

}
