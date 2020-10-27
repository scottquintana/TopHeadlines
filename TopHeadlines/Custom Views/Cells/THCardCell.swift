//
//  THCardCell.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/27/20.
//

import UIKit

class THCardCell: UICollectionViewCell {
    
    static let reuseID = "THCardCell"
    
    let imageView = THImageView(frame: .zero)
    let sourceLabel = THLabel(textAlignment: .left, fontSize: 26, fontColor: .label, fontWeight: .bold)
    let dateLabel = THLabel(textAlignment: .left, fontSize: 12, fontColor: Colors.titleBlue, fontWeight: .medium)
    let timeLabel = THLabel(textAlignment: .right, fontSize: 12, fontColor: Colors.titleBlue, fontWeight: .medium)
    let titleLabel = THLabel(textAlignment: .left, fontSize: 22, fontColor: .label, fontWeight: .medium)
    let descLabel = THLabel(textAlignment: .left, fontSize: 19, fontColor: .secondaryLabel, fontWeight: .regular)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(article: Article) {
        if let imageURL = article.urlToImage {
            imageView.downloadImage(fromURL: imageURL)
        }
        sourceLabel.text = article.source.name
        dateLabel.text = "Jan 01, 2020"
        timeLabel.text = "6:00pm"
        titleLabel.text = article.title
        descLabel.text = article.description ?? "No description"
    }
    
    private func configure() {
        addSubviews(imageView, sourceLabel, dateLabel, timeLabel, titleLabel, descLabel)
        
        imageView.contentMode = .scaleAspectFit
        
        let padding: CGFloat = 4
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            sourceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            sourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            sourceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 14),
            
            timeLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: padding),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            timeLabel.heightAnchor.constraint(equalToConstant: 14),
            
            //insert line break here
            
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: descLabel.topAnchor, constant: -(padding/2)),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding/2),
            descLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            descLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            descLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding)
            
            
        
        
        ])
        
    }
    
}

