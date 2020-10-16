//
//  ArticleTableViewCell.swift
//  CentralTest
//
//  Created by Kent Winder on 10/14/20.
//

import UIKit
import Kingfisher

class ArticleTableViewCell: UITableViewCell {
    static let identifier = "ArticleTableViewCell"
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var article: Article! {
        didSet {
            updateViews()
        }
    }
    
    private func updateViews() {
        articleTitleLabel.text = article.title
        articleDescriptionLabel.text = article.description
        timeLabel.text = "Published at: \(DateTimeHelper.displayedDate(from: article.publishedAt ?? ""))"
        
        // download image
        let url = URL(string: article.urlToImage ?? "")
        articleImageView.kf.setImage(with: url,
                                     placeholder: UIImage(named: "ic_news"),
                                     options: nil) { (_, _) in
            self.articleImageView.alpha = 0
        } completionHandler: { (_) in
            UIView.animate(withDuration: 1) {
                self.articleImageView.alpha = 1
            }
        }
    }
}
