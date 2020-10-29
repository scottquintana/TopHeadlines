//
//  Headline.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/27/20.
//

import Foundation

struct Headline: Codable, Hashable {
    var articles: [Article]
}

struct Article: Codable, Hashable {
    let source: Source
    var author: String?
    let title: String
    var description: String?
    let url: String
    var urlToImage: String?
    let publishedAt: Date
    var content: String?
    var hasBeenRead: Bool? = false
    
    mutating func setAsUnread() {
        hasBeenRead = false
    }
}

struct Source: Codable, Hashable {
    var id: String?
    let name: String
}
