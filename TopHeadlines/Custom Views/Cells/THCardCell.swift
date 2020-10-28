//
//  THCardCell.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/27/20.
//

import UIKit

class THCardCell: UICollectionViewCell {
    
    static let reuseID = "THCardCell"
    
    let cardView = UIView()
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
        if let imageUrl = article.urlToImage {
            NetworkManager.shared.downloadImage(from: imageUrl) { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async { self.imageView.image = image }
            }
        }
        
        sourceLabel.text = article.source.name
        dateLabel.text = "Jan 01, 2020"
        timeLabel.text = "6:00pm"
        titleLabel.text = article.title
        descLabel.text = article.description ?? "No description"
    }
    
    private func configure() {
        contentView.addSubview(cardView)
        cardView.layer.cornerRadius = 20
        cardView.backgroundColor = .systemBackground
        cardView.layer.shadowColor = UIColor.systemGray.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowRadius = 10
        cardView.layer.shadowOffset = CGSize(width: -1, height: 2)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.addSubviews(imageView, sourceLabel, dateLabel, timeLabel, titleLabel, descLabel)
        
        imageView.contentMode = .scaleAspectFit
        titleLabel.numberOfLines = 4
        titleLabel.adjustsFontSizeToFitWidth = true
        descLabel.numberOfLines = 5
        descLabel.adjustsFontSizeToFitWidth = true
        descLabel.minimumScaleFactor = 0.9
        
        let padding: CGFloat = 4
        NSLayoutConstraint.activate([
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            
            sourceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            sourceLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            sourceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            sourceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 14),
            
            timeLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: padding),
            timeLabel.leadingAnchor.constraint(equalTo: dateLabel.leadingAnchor),
            timeLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            timeLabel.heightAnchor.constraint(equalToConstant: 14),
            
            //insert line break here
            
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            titleLabel.bottomAnchor.constraint(equalTo: descLabel.topAnchor, constant: -(padding/2)),
            
            descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: padding/2),
            descLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            descLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            descLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -padding)
            
        ])
    }
}

