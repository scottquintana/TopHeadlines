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
    var headlines: Headline?
    var articles: [Article] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        edgesForExtendedLayout = []
        navButtonsView.delegate = self
        swiperView.delegate = self
        configureLayout()
        
        getHeadlines()
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
    
    func getHeadlines() {
        NetworkManager.shared.getHeadlines { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let downloadedHeadlines):
                self.articles = downloadedHeadlines.articles
                self.swiperView.set(articles: self.articles)
                case .failure(let error):
                    print("There was an error: \(error.rawValue)")
            }
        }
    }
    
    func pushReadingList() {
        let readingListVC = ReadingListVC(readingList: articles)
        navigationController?.pushViewController(readingListVC, animated: true)
    }
}

//MARK: - NavButtonsViewDelegate

extension THMainVC: NavButtonsViewDelegate {
    func navButtonDidGetPressed(button: NavButtons) {
        switch button {
        case .undo:
            print("undo button tapped")
        case .pass:
            swiperView.buttonPressedToSwipe(buttonPressed: .pass)
        case .add:
            swiperView.buttonPressedToSwipe(buttonPressed: .add)
        case .viewList:
            pushReadingList()
        }
    }
}

extension THMainVC: SwiperViewDelegate {
    func didSwipeOnArticle(article: Article, swipeDecision: SwipeDecision) {
        switch swipeDecision {
        case .pass:
            print("pass on article: \(article.title)")
        case .add:
            print("added on article: \(article.title)")
        }
    }
    
    
}
