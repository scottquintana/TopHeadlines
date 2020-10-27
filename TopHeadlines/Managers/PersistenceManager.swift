//
//  PersistenceManager.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/27/20.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}


enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let articlesToRead = "articlesToRead"
        static let articlesPassedOn = "articlesPassedOn"
    }
    
    
    static func updateWith(article: Article, from list: String, actionType: PersistenceActionType, completed: @escaping (THError?) -> Void) {
        retrieveArticles(from: list) { result in
            switch result {
            case.success(var articles):
                switch actionType {
                case .add:
                    guard !articles.contains(article) else {
                        completed(.alreadyOnList)
                        return
                    }
                    articles.append(article)
                    
                case .remove:
                    articles.removeAll { $0.title == article.title }
                }
                
                completed(save(articles: articles, saveTo: list))
            
            case .failure(let error):
                completed(error)
            
            }
        }
    }
    
    
    static func retrieveArticles(from list: String, completed: @escaping (Result<[Article], THError>) -> Void) {
        guard let articlesData = defaults.object(forKey: list) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let articles = try decoder.decode([Article].self, from: articlesData)
            completed(.success(articles))
        } catch {
            completed(.failure(.unableToAdd))
        }
    }
    
    
    static func save(articles: [Article], saveTo list: String) -> THError? {
        do {
            let encoder = JSONEncoder()
            let encodedArticles = try encoder.encode(articles)
            defaults.setValue(encodedArticles, forKey: list)
            return nil
        } catch {
            return .unableToAdd
        }
    }
}
