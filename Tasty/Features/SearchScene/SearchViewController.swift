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
                                     moveToDetails: moveToDetails,
                                     loadMore: loadMore,
                                     searchWith: searchWith)
    var spinnerView: UIView?
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        searchController.isActive = false
//          self.searchTableStatus = .searchResults
//        //     DispatchQueue.main.async {
//        //        self.searchController.searchBar.becomeFirstResponder()
//        //      }
//    }
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
        searchTableView.register(DetailsTableViewCell.nib,
                                 forCellReuseIdentifier: DetailsTableViewCell.identifire)
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
            // Place the search bar in the navigation bar.
            navigationItem.searchController = searchController
            // Make the search bar always visible.
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // Fallback on earlier versions
        }
        //        searchController.searchBar.scopeButtonTitles = ["jhhgjkgkgkjgk",]
    }
    
    func moveToDetails(recipe: Recipe) {
        presenter?.moveToDetailsWith(recipe: recipe)
    }
    
    func reloadSearchTable() {
        searchTableView.reloadData()
    }
    func loadMore() {
        presenter?.searchFor(word: "", searchTableStates: .loadMore)
    }
    
    func searchWith(word: String) {
        searchTableStatus = .firstView
        adapter.changeTableStatusTo(status: searchTableStatus)
        spinnerView = self.showSpinner(onView: self.view)
        presenter?.searchFor(word: word, searchTableStates: .firstView)
        searchController.searchBar.text = word
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    //  UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces),
            !searchText.isEmpty {
            self.searchTableStatus = .searchHistoryWords
            adapter.changeTableStatusTo(status: searchTableStatus)
            adapter.sethistorySearch(array: presenter?.filterContentWith(searchText: searchText))
        } else if !searchController.searchBar.isFirstResponder {
            self.searchTableStatus = .firstView
            adapter.changeTableStatusTo(status: searchTableStatus) // i won't send data to make the adapter
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchTableStatus = .firstView
        adapter.changeTableStatusTo(status: searchTableStatus)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let strippedString = searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
        if strippedString != "" {
            searchWith(word: strippedString)
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchTableStatus = .searchHistoryWords
        adapter.changeTableStatusTo(status: searchTableStatus)
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchTableStatus = .searchHistoryWords
        adapter.sethistorySearch(array: presenter?.getSearchWordsHistory())
    }
    
}

extension SearchViewController: SearchViewProtocol {
    
    func setTableViewResult(with array: [Recipe]) {
        //        searchTableStatus = .searchResults
        //        adapter.changeTableStatusTo(status: searchTableStatus)
        adapter.setRecipes(array: array)
        self.removeSpinner(spinnerView: spinnerView ?? UIView())
    }
    func showSearchFailed() {
        searchTableStatus = .error
        adapter.changeTableStatusTo(status: searchTableStatus)
    }
    
    func showEndOfResults() {
        searchTableStatus = .endLoadMore
        adapter.changeTableStatusTo(status: searchTableStatus)
    }
}
