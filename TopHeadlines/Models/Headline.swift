//
//  Headline.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/27/20.
//

import Foundation

struct Headline: Codable {
    let articles: [Article]
}

struct Article: Codable {
    var author: String?
    let title: String
    var description: String?
    let url: String
    var urlToImage: String?
    let publishedAt: Date
    var content: String?
}

struct Source: Codable {
    var id: String?
    let name: String
}
