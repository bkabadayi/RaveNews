//
//  NewsSourceViewController.swift
//  RaveNews
//
//  Created by Berkin Kabadayı on 3.07.2023.
//

import UIKit
import DZNEmptyDataSet
import PromiseKit

class NewsSourceViewController: UIViewController, PullToReach {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var sourceTableView: UITableView!
    
    // MARK: - Constants
    
    private let spinningActivityIndicator = RaveSpinnerView()
    
    // MARK: - Variables
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    var scrollView: UIScrollView {
        return sourceTableView
    }
    
    private lazy var categoryBarButton = {
        return UIBarButtonItem(image: R.image.filter(),
                               style: .plain,
                               target: self,
                               action: #selector(presentCategories))
    }()
    
    private lazy var languageBarButton = {
        return UIBarButtonItem(image: R.image.language(),
                               style: .plain,
                               target: self,
                               action: #selector(presentNewsLanguages))
    }()
    
    private lazy var countryBarButton = {
        return UIBarButtonItem(image: R.image.country(),
                               style: .plain,
                               target: self,
                               action: #selector(presentCountries))
    }()
    
    private lazy var closeBarButton = {
        return  UIBarButtonItem(image: R.image.close(),
                                style: .plain,
                                target: self,
                                action: #selector(dismissViewController))
    }()
    
    private var sourceItems: [DailySourceModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.sourceTableView.reloadSections([0],
                                                    with: .automatic)
                self.setupSpinner(hidden: true)
            }
        }
    }
    
    private var filteredSourceItems: [DailySourceModel] = [] {
        didSet {
            self.sourceTableView.reloadSections([0],
                                                with: .automatic)
        }
    }
    
    var selectedItem: DailySourceModel?
    private var categories: [String] = []
    private var languages: [String] = []
    private var countries: [String] = []
    private var areFiltersPopulated: Bool = false
    
    private var resultsSearchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.obscuresBackgroundDuringPresentation = false
        controller.hidesNavigationBarDuringPresentation = true
        controller.searchBar.placeholder = "Search Sources..."
        controller.searchBar.searchBarStyle = .minimal
        controller.searchBar.sizeToFit()
        return controller
    }()
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        loadSourceData(sourceRequestParams: NewsSourceParameters())
        configurePullToReach()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        resultsSearchController.delegate = nil
        resultsSearchController.searchBar.delegate = nil
    }
    
    // MARK: - Helper Methods
    
    private func prepareUI() {
        configureSearch()
        configureTableView()
    }
    
    private func configureSearch() {
        resultsSearchController.searchResultsUpdater = self
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = resultsSearchController
            self.navigationItem.hidesSearchBarWhenScrolling = true
        } else {
            self.navigationItem.titleView = resultsSearchController.searchBar
        }
        
        self.definesPresentationContext = true
    }
    
    private func configureTableView() {
        sourceTableView.register(R.nib.dailySourceItemCell)
        sourceTableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                               y: 0,
                                                               width: sourceTableView.bounds.width,
                                                               height: 50))
    }
    
    private func configurePullToReach() {
        self.navigationItem.rightBarButtonItems = [closeBarButton,
                                                   categoryBarButton,
                                                   languageBarButton,
                                                   countryBarButton]
        self.activatePullToReach(on: navigationItem)
    }
    
    private func setupSpinner(hidden: Bool) {
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
    
    private func loadSourceData(sourceRequestParams: NewsSourceParameters) {
        setupSpinner(hidden: false)
        firstly {
            NewsAPI.getNewsSource(sourceRequestParams: sourceRequestParams)
        }.done { result in
            self.sourceItems = result.sources
            
            // The code below helps in persisting category and language items till the view controller is de-allocated
            
            if !self.areFiltersPopulated {
                self.categories = Array(Set(result.sources.map { $0.category }))
                self.languages = Array(Set(result.sources.map { $0.isoLanguageCode }))
                self.countries = Array(Set(result.sources.map { $0.country }))
                self.areFiltersPopulated = true
            }
        }.ensure {
            self.setupSpinner(hidden: true)
        }.catch { error in
            self.showError(error.localizedDescription) { _ in
                self.dismiss(animated: true,
                             completion: nil)
            }
        }
    }
    
    // MARK: - Deinitializers
    
    deinit {
        self.sourceTableView.delegate = nil
        self.sourceTableView.dataSource = nil
    }
    
    // MARK: - Actions
    
    @objc private func presentCategories() {
        let categoryActivityVC = UIAlertController(title: "Select a Category",
                                                   message: nil,
                                                   preferredStyle: .actionSheet)
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        categoryActivityVC.addAction(cancelButton)
        
        _ = categories.map {
            let categoryButton = UIAlertAction(title: $0,
                                               style: .default,
                                               handler: { [weak self] action in
                                                          guard let self else { return }
                                                          
                                                          if let category = action.title {
                                                              let newsSourceParams = NewsSourceParameters(category: category)
                                                              self.loadSourceData(sourceRequestParams: newsSourceParams)
                                                          } })
            
            categoryActivityVC.addAction(categoryButton)
        }
        
        self.present(categoryActivityVC,
                     animated: true,
                     completion: nil)
    }
    
    @objc private func presentNewsLanguages() {
        let languageActivityVC = UIAlertController(title: "Select a language",
                                                   message: nil,
                                                   preferredStyle: .actionSheet)
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        languageActivityVC.addAction(cancelButton)
        
        for lang in languages {
            let languageButton = UIAlertAction(title: lang.languageStringFromISOCode,
                                               style: .default,
                                               handler: { [weak self] _ in
                                                          guard let self else { return }
                                                          
                                                          let newsSourceParams = NewsSourceParameters(language: lang)
                                                          self.loadSourceData(sourceRequestParams: newsSourceParams) })
            
            languageActivityVC.addAction(languageButton)
        }
        
        self.present(languageActivityVC,
                     animated: true,
                     completion: nil)
    }
    
    @objc private func presentCountries() {
        let countriesActivityVC = UIAlertController(title: "Select a country",
                                                    message: nil,
                                                    preferredStyle: .actionSheet)
        
        let cancelButton = UIAlertAction(title: "Cancel",
                                         style: .cancel,
                                         handler: nil)
        
        countriesActivityVC.addAction(cancelButton)
        
        for country in countries {
            let countryButton = UIAlertAction(title: country.formattedCountryDescription,
                                              style: .default,
                                              handler: { [weak self] _ in
                                                         guard let self else { return }
                                                         
                                                         self.countryBarButton.image = nil
                                                         self.countryBarButton.title = country.countryFlagFromCountryCode
                                                         let newsSourceParams = NewsSourceParameters(country: country)
                                                         self.loadSourceData(sourceRequestParams: newsSourceParams) })
            
            countriesActivityVC.addAction(countryButton)
        }
        
        self.present(countriesActivityVC,
                     animated: true,
                     completion: nil)
    }
    
    @objc private func dismissViewController() {
        self.performSegue(withIdentifier: "sourceUnwindSegue", sender: self)
    }
}

// MARK: - UITableViewDataSource Methods
    
extension NewsSourceViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resultsSearchController.isActive {
            return filteredSourceItems.count
        } else {
            return sourceItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.dailySourceItemCell,
                                                 for: indexPath)!
        
        if resultsSearchController.isActive {
            cell.sourceImageView.downloadedFromLink(NewsAPI.getSourceNewsLogoUrl(source: filteredSourceItems[indexPath.row].sid))
        } else {
            cell.sourceImageView.downloadedFromLink(NewsAPI.getSourceNewsLogoUrl(source: sourceItems[indexPath.row].sid))
        }
        
        return cell
    }
}

// MARK: - UITableViewDelegate Methods

extension NewsSourceViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if resultsSearchController.isActive {
            selectedItem = filteredSourceItems[indexPath.row]
        } else {
            selectedItem = sourceItems[indexPath.row]
        }
        
        self.performSegue(withIdentifier: "sourceUnwindSegue",
                          sender: self)
    }
}
    
// MARK: - UISearchResultsUpdating Delegate

extension NewsSourceViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredSourceItems.removeAll(keepingCapacity: false)

        if let searchString = searchController.searchBar.text {
            let searchResults = sourceItems.filter { $0.name.lowercased().contains(searchString.lowercased()) }
            filteredSourceItems = searchResults
        }
    }
}
