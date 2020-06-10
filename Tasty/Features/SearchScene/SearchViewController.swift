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
    
//    override func viewWillAppear(_ animated: Bool) {
//           super.viewWillAppear(animated)
//
//           self.navigationController?.transitionCoordinator?.animate(alongsideTransition: { (_) in
//               self.navigationController?.navigationBar.shadowOpacity = 0.0
//           }, completion: { (_) in
//               self.navigationController?.navigationBar.shadowOpacity = 0.0
//           })
//       }
       
       override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)
           
//           self.navigationController?.transitionCoordinator?.animate(alongsideTransition: { (_) in
//               self.navigationController?.navigationBar.shadowOpacity = 1.0
//           }, completion: { (_) in
//               self.navigationController?.navigationBar.shadowOpacity = 1.0
//           })
           
           navigationController?.view.setNeedsLayout() // force update layout
           navigationController?.view.layoutIfNeeded() // to fix height of the navigation bar
       }
    
    override func viewDidLoad() {
        self.title = "Tasty"
        super.viewDidLoad()
        
        instatiateSearchTableView()
        instatiateSearchBar()
        
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
        searchController.searchBar.placeholder = "Type something here..."
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.titleView = searchController.searchBar
        if #available(iOS 9.1, *) {
            searchController.obscuresBackgroundDuringPresentation = false // the ui is darker when searchbar has focus
        } else {
            // Fallback on earlier versions
        }
    }
    
    func moveToDetails(recipe: Recipe) {
        searchTableStatus = .searchResults
        searchController.searchBar.text = ""
        presenter?.moveToDetailsWith(recipe: recipe)
    }
    
    func reloadSearchTable() {
        searchTableView.reloadData()
    }
    func loadMore() {
        presenter?.searchFor(word: "", searchTableStates: .loadMore)
    }
    
    func searchWith(word: String) {
        var finalSearchString = word
        searchTableStatus = .firstView
        adapter.changeTableStatusTo(status: searchTableStatus)
        spinnerView = self.showSpinner(onView: self.view)
        
        if #available(iOS 13.0, *) {
            let tokens = searchController.searchBar.searchTextField.tokens
            if !tokens.isEmpty {
                 finalSearchString = getTockenString(tokens: tokens) + word
                searchController.searchBar.searchTextField.removeToken(at: 0)
            }
            let iosToken = UISearchToken(icon: UIImage(systemName: "tag"), text: finalSearchString)
            searchController.searchBar.searchTextField.insertToken(iosToken, at: 0)
            searchController.searchBar.searchTextField.tokenBackgroundColor = .gray
            searchController.searchBar.text = ""

        } else {
            // Fallback on earlier versions
            searchController.searchBar.text = finalSearchString
        }
        presenter?.searchFor(word: finalSearchString, searchTableStates: .firstView)
        searchController.view.endEditing(true)
        searchController.searchBar.resignFirstResponder()
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate, UISearchResultsUpdating {
    //  UISearchResultsUpdating
    
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespaces),
            !searchText.isEmpty else { return }
        self.searchTableStatus = .searchHistoryWords
        adapter.changeTableStatusTo(status: searchTableStatus)
        adapter.sethistorySearch(array: presenter?.filterContentWith(searchText: searchText))
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if adapter.isSearchArrayEmpty() {
            self.searchTableStatus = .firstView
            adapter.changeTableStatusTo(status: searchTableStatus)
        } else {
            self.searchTableStatus = .searchResults
            adapter.changeTableStatusTo(status: searchTableStatus)
        }
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let strippedString = searchBar.text?.trimmingCharacters(in: .whitespaces) else { return }
        if strippedString != ""{
        searchWith(word: strippedString)
        }
        
    }
    
    @available(iOS 13.0, *)
    func getTockenString(tokens: [UISearchToken]) -> String {
        var tokensString = ""
        for token in tokens {
            let dictionary = token.dictionaryWithValues(forKeys: ["text"])
            let string = (dictionary["text"] as? String ?? "") + " "
            tokensString += string
            
        }
        return tokensString
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if adapter.isSearchArrayEmpty() {
            self.searchTableStatus = .firstView
            adapter.changeTableStatusTo(status: searchTableStatus)
        } else {
            self.searchTableStatus = .searchResults
            adapter.changeTableStatusTo(status: searchTableStatus)
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchTableStatus = .searchHistoryWords
        adapter.sethistorySearch(array: presenter?.getSearchWordsHistory())
    }
    
}

extension SearchViewController: SearchViewProtocol {
    
    func setTableViewResult(with array: [Recipe]) {
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
