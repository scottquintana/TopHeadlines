//
//  NavButtons.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

class NavButtonsView: UIView {
    
    let stackView = UIStackView()
    
    let undoButton = THNavButton(color: Colors.yellow, image: SFSymbols.undoArticleSwipe!)
    let passOnArticleButton = THNavButton(color: Colors.red, image: SFSymbols.passOnArticleX!)
    let addToListButton = THNavButton(color: Colors.green, image: SFSymbols.favoriteStar!)
    let viewListButton = THNavButton(color: Colors.blue, image: SFSymbols.viewArticlesList!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureLayout() {
        addSubview(stackView)
        stackView.addArrangedSubview(undoButton)
        stackView.addArrangedSubview(passOnArticleButton)
        stackView.addArrangedSubview(addToListButton)
        stackView.addArrangedSubview(viewListButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        
        let padding: CGFloat = 30
        let buttonSize: CGFloat = 60
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
            
            undoButton.widthAnchor.constraint(equalToConstant: buttonSize),
            undoButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            passOnArticleButton.widthAnchor.constraint(equalToConstant: buttonSize),
            passOnArticleButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            addToListButton.widthAnchor.constraint(equalToConstant: buttonSize),
            addToListButton.heightAnchor.constraint(equalToConstant: buttonSize),
            
            viewListButton.widthAnchor.constraint(equalToConstant: buttonSize),
            viewListButton.heightAnchor.constraint(equalToConstant: buttonSize)
        
        ])
        
        
    }
    
}
