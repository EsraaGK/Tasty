//
//  SearchViewController.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet private weak var searchTableView: UITableView!
    lazy var searchController = UISearchController(searchResultsController: nil)
    var presenter: SearchPresenter?
    var searchTableStatus = SearchTableStates.firstView
    lazy var adapter = SearchAdapter(searchTableView: searchTableView,
                                     reloadTableView: reloadSearchTable,
                                     moveToDetails: moveToDetails)
    var spinnerView: UIView?
    override func viewDidLoad() {
        self.title = "Tasty"
        super.viewDidLoad()
        instatiateSearchTableView()
        instatiateSearchBar()
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
        definesPresentationContext = true
    }
    
    func instatiateSearchTableView() {
        adapter.setDelegates()
        searchTableView.register(SearchDataTableViewCell.nib,
                                 forCellReuseIdentifier: SearchDataTableViewCell.identifire)
        searchTableView.backgroundView = UIImageView(image: Asset.search.image)
        searchTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func instatiateSearchBar() {
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
        }
        searchController.searchBar.placeholder = "Type something here..."
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
        }
    }
    
    func moveToDetails(recipe: Recipe) {
        presenter?.moveToDetailsWith(recipe: recipe)
    }
    
    func reloadSearchTable() {
        searchTableView.reloadData()
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
// UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text,
            !searchText.isEmpty { // display search cell
            self.searchTableStatus = .searchHistoryWords
            adapter.changeTableStatusTo(status: searchTableStatus)
            
        } else {
            self.searchTableStatus = .searchHistoryWords
            adapter.changeTableStatusTo(status: searchTableStatus)
        }
        
    }
    // UISearchControllerDelegate
    //    func willDismissSearchController(_ searchController: UISearchController) {
    //
    //    }
    //     func willPresentSearchController(_ searchController: UISearchController)
    //
    //       func didPresentSearchController(_ searchController: UISearchController)
    //
    // func didDismissSearchController(_ searchController: UISearchController)
    //
    //
    //       // Called after the search controller's search bar has agreed to begin editing or when 'active' is set to YES. If you choose not to present the controller yourself or do not implement this method, a default presentation is performed on your behalf.
    //       @available(iOS 8.0, *)
    //       optional func presentSearchController(_ searchController: UISearchController)

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchTableStatus = .searchResults
        adapter.changeTableStatusTo(status: searchTableStatus)
        searchTableView.backgroundView = UIImageView(image: Asset.search.image)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchTableStatus = .loading
        adapter.changeTableStatusTo(status: searchTableStatus)
        spinnerView = self.showSpinner(onView: self.view)
        let searchWord = searchController.searchBar.text ?? ""
        presenter?.searchFor(word: searchWord)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchTableStatus = .searchHistoryWords
        adapter.changeTableStatusTo(status: searchTableStatus)
    }
}

extension SearchViewController: SearchViewProtocol {
    
    func setTableViewResult(with array: [Recipe]) {
        searchTableStatus = .searchResults
        adapter.setRecipes(array: array)
        adapter.changeTableStatusTo(status: searchTableStatus)
        self.removeSpinner(spinnerView: spinnerView ?? UIView())
        searchTableView.backgroundView = UIView(frame: .zero)
        
    }
    func showSearchFailed() {
        self.searchTableStatus = .error
        self.searchTableView.backgroundView = UIImageView(image: Asset.error.image)
    }
}
