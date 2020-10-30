//
//  ReadingListVC.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/28/20.
//

import UIKit
import SafariServices

class ReadingListVC: UIViewController {

    let articlesTableView = UITableView()
    var readingList: [Article] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Headlines"
        configureTableView()
        loadReadingList()
    }
    
    
    private func configureTableView() {
        view.addSubview(articlesTableView)
        
        articlesTableView.frame = view.bounds
        articlesTableView.rowHeight = 100
        articlesTableView.delegate = self
        articlesTableView.dataSource = self
        articlesTableView.removeExcessCells()
        articlesTableView.register(ReadingListCell.self, forCellReuseIdentifier: ReadingListCell.reuseID)
    }
    
    private func loadReadingList() {
        PersistenceManager.retrieveArticles(from: SwipeDecision.add.rawValue) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let articles):
                if articles.isEmpty {
                    DispatchQueue.main.async {
                        self.readingList = articles
                        self.articlesTableView.reloadData()
                        self.showEmptyStateView(with: "No articles to read.", in: self.view)
                    }
                } else {
                    self.readingList = articles
                    DispatchQueue.main.async {
                        self.articlesTableView.reloadData()
                    }
                }
            case .failure(let error):
                print("There was an error: \(error)")
            }
        }
    }
    
    private func saveArticleStatus() {
        PersistenceManager.save(articles: readingList, saveTo: SwipeDecision.add.rawValue)
        loadReadingList()
    }
    
}

//MARK: - TableView Delegates

extension ReadingListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return readingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReadingListCell.reuseID) as! ReadingListCell
        cell.set(article: readingList[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        readingList[indexPath.row].hasBeenRead = true
        saveArticleStatus()
        guard let url = URL(string: readingList[indexPath.row].url) else {
            print("URL is invalid")
            return
        }
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .label
        present(safariVC, animated: true)

    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let article = self.readingList[indexPath.row]
        let articleHasBeenRead = article.hasBeenRead ?? false
        let title = articleHasBeenRead ? "Mark as unread" : "Mark as read"
        let markAsUnread = UIContextualAction(style: .normal, title: title) { (action, view, bool) in
            self.readingList[indexPath.row].hasBeenRead = !self.readingList[indexPath.row].hasBeenRead!
            self.saveArticleStatus()
            self.articlesTableView.reloadData()
        }
        markAsUnread.backgroundColor = Colors.blue
        return UISwipeActionsConfiguration(actions: [markAsUnread])
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let article = readingList[indexPath.row]
        
        PersistenceManager.updateWith(article: article, from: SwipeDecision.add.rawValue, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                print("There was an error: \(error)")
            } else {
                DispatchQueue.main.async {
                    self.loadReadingList()
                }
            }
            
        }
    }
    
}
