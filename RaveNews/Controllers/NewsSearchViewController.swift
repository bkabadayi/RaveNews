//
//  NewsSearchViewController.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 3.07.2023.
//

import UIKit
import PromiseKit
import DZNEmptyDataSet

class NewsSearchViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var searchCollectionView: UICollectionView!
    
    // MARK: - Constants
    
    private let spinningActivityIndicator = RaveSpinnerView()
    
    // MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    var scrollView: UIScrollView {
        return searchCollectionView
    }
    
    private var searchItems: [DailyNewsModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.searchCollectionView.reloadSections([0])
                self.searchCollectionView.reloadEmptyDataSet()
                self.configureSpinner(hidden: true)
            }
        }
    }
    
    private var selectedCell = UICollectionViewCell()
    
    private var resultsSearchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = true
        controller.searchBar.placeholder = "Search Anything..."
        controller.searchBar.searchBarStyle = .prominent
        controller.searchBar.sizeToFit()
        return controller
    }()
    
    // MARK: - Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard !resultsSearchController.isActive else { return }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.resultsSearchController.searchBar.becomeFirstResponder()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resultsSearchController.delegate = nil
        resultsSearchController.searchBar.delegate = nil
    }
    
    // MARK: - Helper Methods
    
    private func prepareUI() {
        configureSearch()
        configureCollectionView()
    }
    
    private func configureSearch() {
        resultsSearchController.searchResultsUpdater = self
        
        if #available(iOS 11.0, *) {
            navigationItem.searchController = resultsSearchController
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            navigationItem.titleView = resultsSearchController.searchBar
        }
        
        definesPresentationContext = true
    }
    
    private func configureCollectionView() {
        searchCollectionView.register(R.nib.dailyNewsItemCell)
        searchCollectionView?.collectionViewLayout = DailySourceItemLayout()
        searchCollectionView.emptyDataSetDelegate = self
        searchCollectionView.emptyDataSetSource = self
    }
    
    private func configureSpinner(hidden: Bool) {
        DispatchQueue.main.async {
            self.spinningActivityIndicator.containerView.isHidden = hidden
            
            if !hidden {
                self.spinningActivityIndicator.setupSpinnerView()
                self.spinningActivityIndicator.start()
            } else {
                self.spinningActivityIndicator.stop()
            }
        }
    }
    
    func loadNews(with query: String) {
        switch Reach().connectionStatus() {
        case .offline, .unknown:
            self.showError("Internet connection appears to be offline", message: nil)
            break
        case .online(_):
            firstly {
                NewsAPI.searchNews(with: query)
            }.done { result in
                self.searchItems = result.articles
            }.catch(on: .main) { err in
                self.showError(err.localizedDescription)
            }
            
            break
        }
    }
    
    // MARK: - Data Passing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == R.segue.newsSearchViewController.newsSearchSegue.identifier {
            if let vc = segue.destination as? NewsDetailViewController {
                guard let cell = sender as? UICollectionViewCell else { return }
                guard let indexPath = self.searchCollectionView?.indexPath(for: cell) else { return }
                
                selectedCell = cell
                vc.modalPresentationStyle = .fullScreen
                vc.receivedNewsItem = DailyNewsRealmModel.toDailyNewsRealmModel(from: searchItems[indexPath.row])
                vc.receivedItemNumber = indexPath.row + 1
            }
        }
    }
    
    // MARK: - Deinitializers
    
    deinit {
        self.searchCollectionView.delegate = nil
        self.searchCollectionView.dataSource = nil
    }
}
        
extension NewsSearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.dailyNewsItemCell, for: indexPath)!
        cell.configure(with: searchItems[indexPath.row], ltr: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let cell = collectionView.cellForItem(at: indexPath) {
            self.performSegue(withIdentifier: R.segue.newsSearchViewController.newsSearchSegue,
                              sender: cell)
        }
    }
}
    
// MARK: - UISearchResultsUpdating Delegate

extension NewsSearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        searchItems.removeAll(keepingCapacity: false)
        
        if let searchString = searchController.searchBar.text, searchString.count > 3 {
            loadNews(with: searchString)
        }
    }
}


extension NewsSearchViewController {
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        searchCollectionView?.collectionViewLayout.invalidateLayout()
        searchCollectionView?.collectionViewLayout = DailySourceItemLayout()
    }
}

// MARK: - DZNEmptyDataSetDelegate Methods

extension NewsSearchViewController: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let str = "Search for Articles above"
        let attrs = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)]
        return NSAttributedString(string: str, attributes: attrs)
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return R.image.search()
    }
    
    func imageTintColor(forEmptyDataSet scrollView: UIScrollView) -> UIColor? {
        return .lightGray
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView) -> Bool {
        return true
    }
    
    func emptyDataSetShouldAnimateImageView(_ scrollView: UIScrollView) -> Bool {
        return true
    }
}
