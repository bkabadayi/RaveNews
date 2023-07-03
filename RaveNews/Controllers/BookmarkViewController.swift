//
//  BookmarkViewController.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 3.07.2023.
//

import UIKit
import RealmSwift
import CoreSpotlight
import MobileCoreServices
import DZNEmptyDataSet

class BookmarkViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var bookmarkCollectionView: UICollectionView!
    
    // MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var newsItems: Results<DailyNewsRealmModel>!
    var notificationToken: NotificationToken? = nil
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookmarkCollectionView.register(R.nib.bookmarkItemsCell)
        bookmarkCollectionView.emptyDataSetDelegate = self
        bookmarkCollectionView.emptyDataSetSource = self
        
        if #available(iOS 11.0, *) {
            bookmarkCollectionView?.dropDelegate = self
        }
        
        observeDatabase()
    }
    
    // MARK: - Helper Methods
    
    func observeDatabase() {
        let realm = try! Realm()
        
        newsItems = realm.objects(DailyNewsRealmModel.self)
        
        notificationToken = newsItems.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self else { return }
            
            switch changes {
            case .initial:
                self.bookmarkCollectionView.reloadData()
                break
            case .update(_, let deletions, let insertions, _):
                self.bookmarkCollectionView.performBatchUpdates({ self.bookmarkCollectionView.deleteItems(at: deletions.map{ IndexPath(row: $0, section: 0) })
                                                                  self.bookmarkCollectionView.insertItems(at: insertions.map { IndexPath(row: $0, section: 0) }) },
                                                                completion: nil)
                
                if self.newsItems.isEmpty || self.newsItems.count == 1 {
                    self.bookmarkCollectionView.reloadEmptyDataSet()
                }
                
                break
            case .error(let error):
                fatalError("\(error)")
                break
            }
        }
    }
    
    // MARK: - Data Passing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.bookmarkViewController.bookmarkSourceSegue.identifier {
            
            if let vc = segue.destination as? NewsDetailViewController {
                guard let cell = sender as? UICollectionViewCell else { return }
                guard let indexpath = self.bookmarkCollectionView.indexPath(for: cell) else { return }
                
                vc.receivedItemNumber = indexpath.row + 1
                vc.receivedNewsItem = newsItems[indexpath.row]
            }
        }
    }
    
    // MARK: - Deinitializer
    
    deinit {
        notificationToken?.invalidate()
    }
}

// MARK: - CollectionView Delegate Methods

extension BookmarkViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.bookmarkItemsCell,
                                                          for: indexPath)!
        
        newsCell.configure(with: newsItems[indexPath.row])
        newsCell.cellTapped = { [weak self] (cell) -> Void in
            guard let self else { return }
            
            if let cellToDelete = self.bookmarkCollectionView.indexPath(for: cell)?.row {
                let item = self.newsItems[cellToDelete]
                let realm = try! Realm()
                
                try! realm.write {
                    realm.delete(item)
                }
            }
        }
        
        return newsCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bookmarkCollectionView.bounds.width, height: bookmarkCollectionView.bounds.height / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        self.performSegue(withIdentifier: R.segue.bookmarkViewController.bookmarkSourceSegue,
                          sender: cell)
    }
}

// MARK: - DZNEmptyDataSet Delegate Methods

extension BookmarkViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Articles Bookmarked"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Your Bookmarks will appear here."
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .body)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return R.image.bookmark()
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return UIColor.lightGray
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}

// MARK: - Drop Delegate Methods

@available(iOS 11.0, *)
extension BookmarkViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        
        for coordinatorItem in coordinator.items {
            let itemProvider = coordinatorItem.dragItem.itemProvider
            if itemProvider.canLoadObject(ofClass: DailyNewsModel.self) {
                itemProvider.loadObject(ofClass: DailyNewsModel.self) { (object, error) -> Void in
                    DispatchQueue.main.async {
                        let realm = try! Realm()
                        
                        if let dailyNews = object as? DailyNewsModel {
                            let dailyNewsForRealm = DailyNewsRealmModel.toDailyNewsRealmModel(from: dailyNews)
                            
                            try! realm.write {
                                realm.add(dailyNewsForRealm, update: .all)
                            }
                        } else {
                            //self.displayError(error)
                        }
                    }
                }
            }
        }
    }
}
