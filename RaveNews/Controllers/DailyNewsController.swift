//
//  DailyNewsController.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 2.07.2023.
//

import UIKit
import Lottie
import DZNEmptyDataSet
import PromiseKit

class DailyNewsController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var newsCollectionView: UICollectionView! {
        didSet {
            configureCollectionView()
        }
    }
    
    // MARK: - Constants
    
    private static let sourceName: String = "DailyNews"

    private let spinningActivityIndicator: RaveSpinnerView = .init()
    private let refreshControl: UIRefreshControl = .init()

    // MARK: - Variables
    
    private var newsItems: [DailyNewsModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.newsCollectionView?.reloadData()
            }
        }
    }

    private var source: String {
        get {
            guard let defaultSource = UserDefaults(suiteName: "group.com.sapio.today")?.string(forKey: "source") else {
                return "the-wall-street-journal"
            }

            return defaultSource
        }

        set {
           UserDefaults(suiteName: "group.com.sapio.today")?.set(newValue, forKey: "source")
        }
    }

    private var selectedIndexPath: IndexPath?
    private var selectedCell: UICollectionViewCell = .init()
    private var isLanguageRightToLeft: Bool = false
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        loadNewsData(source)
        Reach().monitorReachabilityChanges()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        newsCollectionView.collectionViewLayout.invalidateLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func prepareUI() {
        configureNavigationBar()
        configureCollectionView()
    }

    private func configureNavigationBar() {
        let sourceMenuButton = UIBarButtonItem(image: nil, style: .plain, target: self, action: #selector(sourceMenuButtonDidTap))
        navigationItem.rightBarButtonItem = sourceMenuButton
        navigationItem.title = Self.sourceName
    }

    private func configureCollectionView() {
        newsCollectionView.register(R.nib.dailyNewsItemCell)
        newsCollectionView.collectionViewLayout = DailySourceItemLayout()
        newsCollectionView.refreshControl = refreshControl
        refreshControl.addTarget(self,
                                 action: #selector(refreshData(_:)),
                                 for: UIControl.Event.valueChanged)
        newsCollectionView?.emptyDataSetDelegate = self
        newsCollectionView?.emptyDataSetSource = self

        if #available(iOS 11.0, *) {
            newsCollectionView.dragDelegate = self
            newsCollectionView.dragInteractionEnabled = true
        }
    }

    private func configureSpinner() {
        spinningActivityIndicator.setupSpinnerView()
    }
    
    private func loadNewsData(_ source: String) {
        switch Reach().connectionStatus() {

        case .offline, .unknown:
            self.showError("Internet connection appears to be offline",
                           message: nil,
                           handler: { _ in
                                     self.refreshControl.endRefreshing() })

        case .online(_):

            if !self.refreshControl.isRefreshing {
                configureSpinner()
            }

            spinningActivityIndicator.start()

            firstly {
                NewsAPI.getNewsItems(source: source)
            }.done { result in
                self.newsItems = result.articles
                self.navigationItem.title = Self.sourceName
            }.ensure(on: .main) {
                self.spinningActivityIndicator.stop()
                self.refreshControl.endRefreshing()
            }.catch(on: .main) { error in
                self.showError(error.localizedDescription)
            }
        }
    }

    // MARK: - Deinitiliazer
    
    deinit {
        newsCollectionView.delegate = nil
        newsCollectionView.dataSource = nil
    }

    // MARK: - Actions
    
    @objc private func refreshData(_ sender: UIRefreshControl) {
        loadNewsData(self.source)
    }

    @objc private func sourceMenuButtonDidTap() {
        self.performSegue(withIdentifier: "",
                          sender: self)
    }
    
    // MARK: - Data Passing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.dailyNewsController.newsDetailSegue.identifier {
            
            if let vc = segue.destination as? NewsDetailViewController {
                guard let cell = sender as? UICollectionViewCell else { return }
                guard let indexpath = self.newsCollectionView?.indexPath(for: cell) else { return }
                
                vc.modalPresentationStyle = .fullScreen
                vc.receivedNewsItem = DailyNewsRealmModel.toDailyNewsRealmModel(from: newsItems[indexpath.row])
                vc.receivedItemNumber = indexpath.row + 1
                vc.receivedNewsSource = Self.sourceName
                vc.isLanguageRightToLeftDetailView = isLanguageRightToLeft
            }
        }
    }
}

extension DailyNewsController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        newsCollectionView.collectionViewLayout.invalidateLayout()
        newsCollectionView.collectionViewLayout = DailySourceItemLayout()
    }
}

// MARK: - DZNEmptyDataSet Delegate Methods

extension DailyNewsController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {

    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "No Content 😥"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }

    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Connect to Internet or try another source."
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)]
        return NSAttributedString(string: str, attributes: attrs)
    }

    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return nil
    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}

// MARK: - UICollectionViewDataSource Methods

extension DailyNewsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {

            return self.newsItems.count
    }

    func collectionView(_ collectionView: UICollectionView,
                                 didSelectItemAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        collectionView.performBatchUpdates(nil, completion: nil)
        if let cell = collectionView.cellForItem(at: indexPath) {
            selectedCell = cell
            self.performSegue(withIdentifier: R.segue.dailyNewsController.newsDetailSegue,
                              sender: cell)
        }

    }

    func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dailyNewsItemCell,
                                                          for: indexPath)
        return gridCell!
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        
        let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: R.reuseIdentifier.newsFooterView.identifier,
                                                                         for: indexPath)
            
        return footerView
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.bounds.width,
                          height: collectionView.bounds.height / 10)
    }
}

  // MARK: - UICollectionViewDragDelegate Methods

@available(iOS 11.0, *)
extension DailyNewsController: UICollectionViewDragDelegate {
    
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return dragItems(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, itemsForAddingTo session: UIDragSession, at indexPath: IndexPath, point: CGPoint) -> [UIDragItem] {
        return dragItems(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, dragPreviewParametersForItemAt indexPath: IndexPath) -> UIDragPreviewParameters? {
        let dragPreviewParameters = UIDragPreviewParameters()
        if let cell = collectionView.cellForItem(at: indexPath) {
            dragPreviewParameters.backgroundColor = UIColor.white
            dragPreviewParameters.visiblePath = UIBezierPath(roundedRect:cell.bounds, cornerRadius:cell.contentView.layer.cornerRadius)
            
        }
        return dragPreviewParameters
    }
    
    func dragItems(indexPath: IndexPath) -> [UIDragItem] {
        let cell = newsCollectionView?.cellForItem(at: indexPath)
        cell?.clipsToBounds = true
        let draggedNewsItem = newsItems[indexPath.row]
        let itemProvider = NSItemProvider(object: draggedNewsItem)
        return [UIDragItem(itemProvider: itemProvider)]
    }
}
