//
//  NavButtons.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

protocol NavButtonsViewDelegate: class {
    func navButtonDidGetPressed(button: NavButtons)
}

class NavButtonsView: UIView {
    
    let stackView = UIStackView()
    
    let undoButton = THNavButton(color: Colors.yellow, image: SFSymbols.undoArticleSwipe!)
    let passOnArticleButton = THNavButton(color: Colors.red, image: SFSymbols.passOnArticleX!)
    let addToListButton = THNavButton(color: Colors.green, image: SFSymbols.favoriteStar!)
    let viewListButton = THNavButton(color: Colors.blue, image: SFSymbols.viewArticlesList!)
    
    weak var delegate: NavButtonsViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayout()
        configureButtons()
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
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -60),
        ])
    }
    
    
    private func configureButtons() {
        undoButton.tag = NavButtons.undo.rawValue
        undoButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        passOnArticleButton.tag = NavButtons.pass.rawValue
        passOnArticleButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        addToListButton.tag = NavButtons.add.rawValue
        addToListButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        viewListButton.tag = NavButtons.viewList.rawValue
        viewListButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let buttonSize: CGFloat = 60
        
        NSLayoutConstraint.activate([
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
    
    
    @objc private func buttonTapped(sender: UIButton) {
        switch sender.tag {
        case 1:
            delegate?.navButtonDidGetPressed(button: .undo)
        case 2:
            delegate?.navButtonDidGetPressed(button: .pass)
        case 3:
            delegate?.navButtonDidGetPressed(button: .add)
        case 4:
            delegate?.navButtonDidGetPressed(button: .viewList)
        default:
            print("sender unknown")
        }
    }
}
