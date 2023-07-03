//
//  NewsDetailViewController.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import UIKit
import SafariServices
import RealmSwift

class NewsDetailViewController: UIViewController, SFSafariViewControllerDelegate, UIViewControllerTransitioningDelegate {

    // MARK: - Variables
    
    var receivedNewsItem: DailyNewsRealmModel?
    var receivedNewsSource: String?
    private var articleStringURL: String?
    var receivedItemNumber: Int?
    var isLanguageRightToLeftDetailView: Bool = false
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Outlets
    
    @IBOutlet private weak var newsImageView: RaveImageView! {
        didSet {
            newsImageView.layer.masksToBounds = true
            guard let imageURL = receivedNewsItem?.urlToImage else { return }
            newsImageView.downloadedFromLink(imageURL)
        }
    }

    @IBOutlet private weak var newsTitleLabel: UILabel! {
        didSet {
            newsTitleLabel.text = receivedNewsItem?.title
            newsTitleLabel.alpha = 0.0
            newsTitleLabel.textAlignment = isLanguageRightToLeftDetailView ? .right : .left
        }
    }

    @IBOutlet private weak var contentTextView: UITextView! {
        didSet {
            contentTextView.text = receivedNewsItem?.articleDescription
            contentTextView.alpha = 0.0
            contentTextView.font = UIFont.preferredFont(forTextStyle: .subheadline)
            contentTextView.sizeToFit()
            contentTextView.textAlignment = isLanguageRightToLeftDetailView ? .right : .left
        }
    }

    @IBOutlet private weak var newsAuthorLabel: UILabel! {
        didSet {
            newsAuthorLabel.text = receivedNewsItem?.author
            newsAuthorLabel.alpha = 0.0
            newsAuthorLabel.textAlignment = isLanguageRightToLeftDetailView ? .right : .left
        }
    }

    @IBOutlet private weak var backButton: UIButton! {
        didSet {
            backButton.layer.shadowColor = UIColor.black.cgColor
            backButton.layer.shadowRadius = 2.0
            backButton.layer.shadowOpacity = 1.0
            backButton.layer.shadowOffset = CGSize(width: 0,
                                                   height: 1)
        }
    }

    @IBOutlet private weak var shareButton: UIButton! {
        didSet {
            shareButton.layer.shadowColor = UIColor.black.cgColor
            shareButton.layer.shadowRadius = 2.0
            shareButton.layer.shadowOpacity = 1.0
            shareButton.layer.shadowOffset = CGSize(width: 0,
                                                    height: 1)
        }
    }

    @IBOutlet private weak var swipeLeftButton: UIButton! {
        didSet {
            swipeLeftButton.layer.cornerRadius = 10.0
            guard let publishedDate = receivedNewsItem?.publishedAt.dateFromTimestamp?.relativelyFormatted(short: false) else {
                return swipeLeftButton.setTitle("Read More...", for: .normal)
            }
            
            swipeLeftButton.setTitle("\(publishedDate) • Read More...", for: .normal)
            
            switch Reach().connectionStatus() {
            case .unknown, .offline:
                swipeLeftButton.isEnabled = false
                swipeLeftButton.backgroundColor = .lightGray
                break
            case .online(_):
                swipeLeftButton.isEnabled = true
                break
            }
        }
    }

    @IBOutlet weak var newsSourceLabel: UILabel! {
        didSet {
            newsSourceLabel.text = receivedNewsSource
        }
    }
    
    @IBOutlet weak var newsItemNumberLabel: UILabel! {
        didSet {
            guard let newsItemNumber = receivedItemNumber else { return }
            newsItemNumberLabel.text = String(newsItemNumber)
            newsItemNumberLabel.alpha = 1.0
            newsItemNumberLabel.clipsToBounds = true
            newsItemNumberLabel.layer.cornerRadius = 5.0
        }
    }

    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        newsImageView.addGradient([UIColor(white: 0, alpha: 0.6).cgColor,
                                   UIColor.clear.cgColor,
                                   UIColor(white: 0, alpha: 0.6).cgColor],
                                  locations: [0.0, 0.05, 0.85])

        articleStringURL = receivedNewsItem?.url
        
        if #available(iOS 11.0, *) {
            let dragInteraction = UIDragInteraction(delegate: self)
            dragInteraction.isEnabled = true
            newsImageView.addInteraction(dragInteraction)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        newsTitleLabel.center.y += 20
        newsAuthorLabel.center.y += 20
        contentTextView.center.y += 20

        UIView.animate(withDuration: 0.07,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: { self.newsTitleLabel.alpha = 1.0
                                     self.newsTitleLabel.center.y -= 20
                                     self.newsAuthorLabel.alpha = 1.0
                                     self.newsAuthorLabel.center.y -= 20
                                     self.newsItemNumberLabel.alpha = 1.0 })
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: { self.contentTextView.center.y -= 20
                                     self.contentTextView.alpha = 1.0 })
    }
    
    // MARK: - Helper Methods
    
    private func fadeUIElements(with alpha: CGFloat) {
       UIView.animate(withDuration: 0.1) {
           self.backButton.alpha = alpha
           self.shareButton.alpha = alpha
           self.swipeLeftButton.alpha = alpha
       }
   }
    
    func captureScreenShot() -> UIImage? {
       let bounds = UIScreen.main.bounds
       UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
       self.view.drawHierarchy(in: bounds, afterScreenUpdates: false)
       let image = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return image
   }

    // MARK: - Actions
    
    @IBAction private func dismissButtonTapped() {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func swipeToDismiss(_ sender: UISwipeGestureRecognizer) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction private func shareArticle(_ sender: UIButton) {
        fadeUIElements(with: 0.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.11) {
            
            guard let shareURL = self.articleStringURL,
                  let articleImage = self.captureScreenShot(),
                  let articleToBookmarkData = self.receivedNewsItem else { return }
            
            let bookmarkActivity = BookmarkActivity()
            
            bookmarkActivity.bookMarkSuccessful = {
                self.showErrorWithDelay("Bookmarked Successfully!")
            }
            
            let activityVC = UIActivityViewController(activityItems: [shareURL, articleImage, articleToBookmarkData],
                                                      applicationActivities: [bookmarkActivity])
            
            activityVC.excludedActivityTypes = [.saveToCameraRoll,
                                                .copyToPasteboard,
                                                .airDrop,
                                                .addToReadingList,
                                                .assignToContact,
                                                .postToTencentWeibo,
                                                .postToVimeo,
                                                .print,
                                                .postToWeibo]
            
            activityVC.completionWithItemsHandler = { [weak self] (_, _, _, _) in
                guard let self else { return }
                
                self.fadeUIElements(with: 1.0)
            }
            
            self.present(activityVC,
                         animated: true,
                         completion: nil)
        }
    }

    @IBAction private func openArticleInSafari(_ sender: UIButton) {
        guard let articleString = articleStringURL, let url = URL(string: articleString) else { return }
        
        let svc = DFSafariViewController(url: url)
        svc.delegate = self
        self.present(svc, animated: true, completion: nil)
    }
}

// MARK: - UIDragInteractionDelegate Methods

@available(iOS 11.0, *)
extension NewsDetailViewController: UIDragInteractionDelegate {
    
    func dragInteraction(_ interaction: UIDragInteraction, itemsForBeginning session: UIDragSession) -> [UIDragItem] {
        guard let image = newsImageView.image else { return [] }
        let provider = NSItemProvider(object: image)
        let item = UIDragItem(itemProvider: provider)
        return [item]
    }
}

// MARK: - UIStateRestoring Methods

extension NewsDetailViewController {

    override func encodeRestorableState(with coder: NSCoder) {
        if let newsImage = newsImageView.image {
            coder.encode(newsImage.jpegData(compressionQuality: 1.0),
                         forKey:"newsImage")
        }
        
        if let title = newsTitleLabel.text {
            coder.encode(title,
                         forKey: "title")
        }
        
        if let contentText = contentTextView.text {
            coder.encode(contentText,
                         forKey: "contentText")
        }
        
        if let newsAuthor = newsAuthorLabel.text {
            coder.encode(newsAuthor,
                         forKey: "newsAuthor")
        }
        
        if let publishedDate = receivedNewsItem?.publishedAt {
            coder.encode(publishedDate,
                         forKey: "publishedDate")
        }
        
        if let url = self.articleStringURL {
            coder.encode(url,
                         forKey: "newsURL")
        }
        
        if let newsSource = newsSourceLabel.text {
            coder.encode(newsSource,
                         forKey: "newsSource")
        }
        
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        if let newsImageData = coder.decodeObject(forKey: "newsImage") as? Data {
            newsImageView.image = UIImage(data: newsImageData)
        }
        
        if let title = coder.decodeObject(forKey: "title") as? String {
            newsTitleLabel.text = title
        }
        
        if let contentText = coder.decodeObject(forKey: "contentText") as? String {
            contentTextView.text = contentText
        }
        
        if let newsAuthorText = coder.decodeObject(forKey: "newsAuthor") as? String {
            newsAuthorLabel.text = newsAuthorText
        }
        
        if let publishedAtDate = coder.decodeObject(forKey: "publishedDate") as? String {
            guard let publishedDate = publishedAtDate.dateFromTimestamp?.relativelyFormatted(short: false) else {
                return swipeLeftButton.setTitle("Read More...",
                                                for: .normal)
            }
            swipeLeftButton.setTitle("\(publishedDate) • Read More...",
                                     for: .normal)
        }
        
        if let urlString = coder.decodeObject(forKey: "newsURL") as? String {
            articleStringURL = urlString
        }
        
        if let newsSource = coder.decodeObject(forKey: "newsSource") as? String {
            newsSourceLabel.text = newsSource
        }
        
        super.decodeRestorableState(with: coder)
    }
}
