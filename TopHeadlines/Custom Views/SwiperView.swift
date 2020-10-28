//
//  SwipeTown.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

class SwiperView: UIView {

    var articleCollectionView: UICollectionView!
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
            self.articleCollectionView.reloadData()
        }

    }
    
    private func configureCollectionView() {
        
        let customLayout = ArticleStackLayout()
        articleCollectionView = UICollectionView(frame: .zero, collectionViewLayout: customLayout)
        addSubview(articleCollectionView)
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        articleCollectionView.backgroundColor = .systemBlue
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
    func articleShouldRemove(_ flowLayout: ArticleStackLayout, indexPath: IndexPath) {
        print("swiped!")
    }
    
    
}
