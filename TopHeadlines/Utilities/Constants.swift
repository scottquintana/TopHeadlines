//
//  Constants.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/26/20.
//

import UIKit

enum SFSymbols {
    static let favoriteStar = UIImage(systemName: "star.fill")
    static let passOnArticleX = UIImage(systemName: "xmark")
    static let viewArticlesList = UIImage(systemName: "list.star")
    static let undoArticleSwipe = UIImage(systemName: "arrow.uturn.right")
    static let newspapger = UIImage(systemName: "newspaper")
}

enum Colors {
    static let titleBlue = UIColor(red: 0.20, green: 0.36, blue: 0.40, alpha: 1.00)
    static let red = UIColor(red: 0.86, green: 0.31, blue: 0.29, alpha: 1.00)
    static let yellow = UIColor(red: 0.99, green: 0.67, blue: 0.06, alpha: 1.00)
    static let green = UIColor(red: 0.35, green: 0.66, blue: 0.42, alpha: 1.00)
    static let blue = UIColor(red: 0.17, green: 0.62, blue: 0.70, alpha: 1.00)
}

enum NavButtons: Int {
    case undo = 1
    case pass = 2
    case add = 3
    case viewList = 4
}

enum Images {
    static let placeholder = UIImage(named: "no-image")
}

enum SwipeDecision: String {
    case add = "readingList"
    case pass = "passList"
}
