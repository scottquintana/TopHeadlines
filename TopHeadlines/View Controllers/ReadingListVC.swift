//
//  ReadingListVC.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/28/20.
//

import UIKit

class ReadingListVC: UIViewController {

    let articlesTableView = UITableView()
    var readingList: [Article] = []
    
    init(readingList: [Article]) {
        super.init(nibName: nil, bundle: nil)
        self.readingList = readingList
        title = "Your Headlines"
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    
    private func configureTableView() {
        view.addSubview(articlesTableView)
        
        articlesTableView.frame = view.bounds
        articlesTableView.rowHeight = 100
        articlesTableView.delegate = self
        articlesTableView.dataSource = self
        articlesTableView.register(ReadingListCell.self, forCellReuseIdentifier: ReadingListCell.reuseID)
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
    
    
}
