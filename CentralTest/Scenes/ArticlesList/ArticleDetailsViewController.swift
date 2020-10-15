//
//  ArticleDetailsViewController.swift
//  CentralTest
//
//  Created by Kent Winder on 10/15/20.
//

import UIKit

class ArticleDetailsViewController: UIViewController {
    static let identifier = "ArticleDetailsViewController"
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var articleTitleLabel: UILabel!
    @IBOutlet weak var articleDescriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var article: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupViewModel()
    }
    
    func setupViews() {
        navigationController?.title = "News"
        
        let url = URL(string: article.urlToImage ?? "")
        articleImageView.kf.setImage(with: url, placeholder: UIImage(named: "ic_news"))
        
        articleTitleLabel.text = article.title
        articleDescriptionLabel.text = article.content
        timeLabel.text = "Published at: \(DateTimeHelper.displayedDate(from: article.publishedAt ?? ""))"
    }
    
    func setupViewModel() {
    }
}
