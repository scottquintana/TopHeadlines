//
//  THCardCell.swift
//  TopHeadlines
//
//  Created by Scott Quintana on 10/27/20.
//

import UIKit

class THCardCell: UICollectionViewCell {
    
    static let reuseID = "THCardCell"
    
    let shadowView = UIView()
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
                DispatchQueue.main.async {
                    self.imageView.image = image
                    self.imageView.sizeToFit()
                    self.setNeedsLayout()
                    self.layoutIfNeeded()
                }
            }
        }
        
        sourceLabel.text = article.source.name
        dateLabel.text = DateHelper.convertToMonthDayYearFormat(article.publishedAt)
        timeLabel.text = DateHelper.convertToTimeFormat(article.publishedAt)
        titleLabel.text = article.title
        descLabel.text = article.description ?? "No description"
    }
    
    private func configure() {
        
        contentView.addSubview(shadowView)
        shadowView.addSubview(cardView)

        shadowView.layer.shadowColor = UIColor.systemGray.cgColor
        shadowView.layer.shadowOpacity = 0.5
        shadowView.layer.shadowRadius = 8
        shadowView.layer.cornerRadius = 20
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 1)
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        
        cardView.clipsToBounds = true
        cardView.layer.cornerRadius = 20
        cardView.backgroundColor = .systemBackground
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubviews(imageView, sourceLabel, dateLabel, timeLabel, titleLabel, descLabel)
        
        imageView.contentMode = .scaleAspectFill
        titleLabel.numberOfLines = 4
        titleLabel.adjustsFontSizeToFitWidth = true
        descLabel.numberOfLines = 5
        descLabel.adjustsFontSizeToFitWidth = true
        descLabel.minimumScaleFactor = 0.9
        
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            
            shadowView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            shadowView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            shadowView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            shadowView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            cardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            cardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            cardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            imageView.topAnchor.constraint(equalTo: cardView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            imageView.heightAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 0.45),
            
            sourceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: padding),
            sourceLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            sourceLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding),
            sourceLabel.heightAnchor.constraint(equalToConstant: 24),
            
            dateLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: timeLabel.leadingAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 14),
            
            timeLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: padding),
            timeLabel.widthAnchor.constraint(equalToConstant: 100),
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

