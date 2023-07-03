//
//  BookmarkItemsCell.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 3.07.2023.
//

import UIKit
import RealmSwift

class BookmarkItemsCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var newsArticleImageView: RaveImageView! {
        didSet {
            newsArticleImageView.layer.cornerRadius = 5.0
            newsArticleImageView.layer.borderColor = UIColor(white: 0.1, alpha: 0.1).cgColor
            newsArticleImageView.layer.borderWidth = 0.5
            newsArticleImageView.clipsToBounds = true
        }
    }
    
    @IBOutlet private weak var newsArticleTitleLabel: UILabel!
    @IBOutlet private weak var newsArticleAuthorLabel: UILabel!
    @IBOutlet private weak var newsArticleTimeLabel: UILabel!
    
    // MARK: - Variables
    
    var cellTapped: ((UICollectionViewCell) -> Void)?

    // MARK: - Life Cycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 4
    }
    
    // MARK: - Helper Methods
    
    func configure(with newsitems: DailyNewsRealmModel) {
        newsArticleTitleLabel.text = newsitems.title
        newsArticleAuthorLabel.text = newsitems.author
        newsArticleTimeLabel.text = newsitems.publishedAt.dateFromTimestamp?.relativelyFormatted(short: true)
        newsArticleImageView.downloadedFromLink(newsitems.urlToImage)
    }
    
    // MARK: - Actions
    
    @IBAction func deleteBookmarkArticle(_ sender: UIButton) {
        cellTapped?(self)
    }
}

