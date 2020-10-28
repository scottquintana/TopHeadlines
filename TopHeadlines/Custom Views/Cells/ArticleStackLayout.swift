//
//  ArticleStackLayout.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/28/20.
//

import UIKit

protocol ArticleStackLayoutDelegate: class {
    func articleShouldRemove(_ flowLayout: ArticleStackLayout, indexPath: IndexPath)
}

class ArticleStackLayout: UICollectionViewLayout {
    weak var delegate: ArticleStackLayoutDelegate?
}
