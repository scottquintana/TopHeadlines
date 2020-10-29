//
//  ReadingListCell.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/28/20.
//

import UIKit

class ReadingListCell: UITableViewCell {
    
    static let reuseID = "ReadingListCell"
    
    let articleImageView = THImageView(frame: .zero)
    let titleLabel = THLabel(textAlignment: .left, fontSize: 16, fontColor: .label, fontWeight: .medium)
    let dateLabel = THLabel(textAlignment: .left, fontSize: 12, fontColor: Colors.blue, fontWeight: .regular)
    let timeLabel = THLabel(textAlignment: .right, fontSize: 12, fontColor: Colors.blue, fontWeight: .regular)
    var articleHasBeenRead: Bool = false
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(article: Article) {
        if let imageUrl = article.urlToImage {
            NetworkManager.shared.downloadImage(from: imageUrl) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.articleImageView.image = image
                    self.articleImageView.sizeToFit()
                }
            }
        }
        self.titleLabel.text = article.title
        self.dateLabel.text = DateHelper.convertToMonthDayYearFormat(article.publishedAt)
        self.timeLabel.text = DateHelper.convertToTimeFormat(article.publishedAt)
        if let hasBeenRead = article.hasBeenRead {
            self.articleHasBeenRead = hasBeenRead
        }
    }
    
    
    private func configure() {
        addSubviews(articleImageView, titleLabel, dateLabel, timeLabel)
        
        backgroundColor = .systemBackground
        accessoryType = articleHasBeenRead ? .checkmark : .disclosureIndicator
        
        articleImageView.layer.cornerRadius = 14
        articleImageView.contentMode = .scaleAspectFill
        articleImageView.alpha = articleHasBeenRead ? 0.5 : 1
        
        titleLabel.numberOfLines = 3
        titleLabel.adjustsFontSizeToFitWidth = false
        titleLabel.lineBreakMode = .byTruncatingTail
        
        dateLabel.adjustsFontSizeToFitWidth = false
        timeLabel.adjustsFontSizeToFitWidth = false
        
        let padding: CGFloat = 6
        NSLayoutConstraint.activate([
            articleImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            articleImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            articleImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            articleImageView.widthAnchor.constraint(equalToConstant: 120),
            
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(padding + 30)),
            titleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -2),
            
            dateLabel.heightAnchor.constraint(equalToConstant: 14),
            dateLabel.leadingAnchor.constraint(equalTo: articleImageView.trailingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor, constant: -(padding + 30)),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding),
            
            timeLabel.widthAnchor.constraint(equalToConstant: 60),
            timeLabel.heightAnchor.constraint(equalToConstant: 14),
            timeLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -(padding + 30)),
            timeLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -padding)
        
        ])
        
    }
}
