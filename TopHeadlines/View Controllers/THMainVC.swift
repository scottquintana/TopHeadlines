//
//  ViewController.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

class THMainVC: UIViewController {

    let swiperView = SwiperView()
    let navButtonsView = NavButtonsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navButtonsView.delegate = self
        configureLayout()
        
        
    }
    
    
    private func configureLayout() {
        let stackView = UIStackView()
        
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(swiperView)
        stackView.addArrangedSubview(navButtonsView)
        stackView.axis = .vertical
   
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - NavButtonsViewDelegate

extension THMainVC: NavButtonsViewDelegate {
    func navButtonDidGetPressed(button: NavButtons) {
        switch button {
        case .undo:
            print("undo button tapped")
        case .pass:
            print("pass button tapped")
        case .add:
            print("add button tapped")
        case .viewList:
            print("view button tapped")
        }
    }
}
