//
//  SwipeTown.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

protocol SwiperViewDelegate: class {
    func didSwipeOnArticle(article: Article, swipeDecision: SwipeDecision)
}

class SwiperView: UIView {
    
    var articleCollectionView: UICollectionView!
    let customLayout = ArticleStackLayout()
    var articles: [Article] = []
    
    weak var delegate: SwiperViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(articles: [Article]) {
        self.articles = articles
        
        DispatchQueue.main.async {
            self.articleCollectionView.reloadData()
        }
        
    }
    
    private func configureCollectionView() {
        articleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: customLayout)
        addSubview(articleCollectionView)
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.backgroundColor = .systemBackground
        articleCollectionView.register(THCardCell.self, forCellWithReuseIdentifier: THCardCell.reuseID)
        articleCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        customLayout.delegate = self
        
        NSLayoutConstraint.activate([
            articleCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            articleCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            articleCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            articleCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func buttonPressedToSwipe(buttonPressed: SwipeDecision) {
        if let topCard = customLayout.topCellWithIndexPath {
            customLayout.animateAndRemove(left: buttonPressed == .pass, cell: topCard.cell, completion: { [weak self] in
                guard let self = self else { return }
                
                self.customLayout.delegate?.articleShouldRemove(self.customLayout, swipeDecision: buttonPressed, indexPath: topCard.indexPath)
            })
        }
        
        if let bottomCard = customLayout.bottomCellWithIndexPath {
            customLayout.animateIntoPosition(cell: bottomCard.cell)
        }
    }
}

extension SwiperView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: THCardCell.reuseID, for: indexPath) as? THCardCell else {
            return UICollectionViewCell()
        }
        
        cell.set(article: articles[indexPath.row])
        
        return cell
    }
}

extension SwiperView: UICollectionViewDelegate { }


extension SwiperView: ArticleStackLayoutDelegate {
    func articleShouldRemove(_ flowLayout: ArticleStackLayout, swipeDecision: SwipeDecision, indexPath: IndexPath) {
        let swipedArticle = articles[indexPath.row]
        
        delegate?.didSwipeOnArticle(article: swipedArticle, swipeDecision: swipeDecision)
        articles.removeLast()
        articleCollectionView.reloadData()
    }
    
}
