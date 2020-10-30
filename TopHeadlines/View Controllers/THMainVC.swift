//
//  ViewController.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

class THMainVC: UIViewController {
    
    let cache = NSCache<NSString, NSString>()
    
    let swiperView = SwiperView()
    let navButtonsView = NavButtonsView()
    var headlines: Headline?
    var articles: [Article] = []
    var passList: [Article] = []
    var readingList: [Article] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        edgesForExtendedLayout = []
        navButtonsView.delegate = self
        swiperView.delegate = self
        configureLayout()
        loadLists(listType: .add)
        loadLists(listType: .pass)
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
                self.articles = self.filterArticles(incomingArticles: downloadedHeadlines.articles)
                self.swiperView.set(articles: self.articles)
            case .failure(let error):
                print("There was an error: \(error.rawValue)")
            }
        }
    }
    
    
    private func loadLists(listType: SwipeDecision) {
        PersistenceManager.retrieveArticles(from: listType.rawValue) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                if listType == .pass {
                    self.passList = articles
                } else {
                    self.readingList = articles
                }
            case.failure(let error):
                print("There was an error: \(error)")
            }
        }
    }
    
    
    private func filterArticles(incomingArticles: [Article]) -> [Article] {
        var filteredArticles: [Article] = []
        for article in incomingArticles {
            let cacheKey = NSString(string: article.title)
            if let title = cache.object(forKey: cacheKey) {
                print("This article has been seen: \(title)")
            } else {
                filteredArticles.append(article)
            }
        }
        return filteredArticles
    }
    
    
    func addToList(article: Article, listType: SwipeDecision) {
        let cacheKey = NSString(string: article.title)
        let listTypeSting = NSString(string: listType.rawValue)
        cache.setObject(listTypeSting, forKey: cacheKey)

        
        PersistenceManager.updateWith(article: article, from: listType.rawValue, actionType: .add) { error in
            guard let error = error else { return }
            print("There was an error: \(error)")
            return
        }
    }
    
    func pushReadingList() {
        let readingListVC = ReadingListVC()
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
    func didSwipeAllCards(with message: String, in view: UIView) {
        showEmptyStateView(with: message, in: view)
    }
    
    func didSwipeOnArticle(article: Article, swipeDecision: SwipeDecision) {
        addToList(article: article, listType: swipeDecision)
    }
}
