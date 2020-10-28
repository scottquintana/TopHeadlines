//
//  SwipeTown.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

class SwiperView: UIView {

    var collectionView: UICollectionView!
    var articles: [Article] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemPink
        
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func set(articles: [Article]) {
        self.articles = articles
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }

    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: ArticleStackLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(THCardCell.self, forCellWithReuseIdentifier: THCardCell.reuseID)
        
        if let layout = collectionView.collectionViewLayout as? ArticleStackLayout {
            layout.delegate = self
        }
    }
}

extension SwiperView: UICollectionViewDelegate, UICollectionViewDataSource {
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

extension SwiperView: ArticleStackLayoutDelegate {
    func articleShouldRemove(_ flowLayout: ArticleStackLayout, indexPath: IndexPath) {
        print("swiped!")
    }
    
    
}
