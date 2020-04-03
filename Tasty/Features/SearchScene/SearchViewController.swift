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
    var presenter: SearchPresenter?
    // weak var delegate: SearchViewControllerDelegate?
    var searchTableStatus = SearchTableStates.firstView
    lazy var adapter = SearchAdapter(searchTableView: searchTableView,
                                     reloadTableView: reloadSearchTable,
                                     moveToDetails: moveToDetails)
     var spinnerView: UIView?
    override func viewDidLoad() {
        super.viewDidLoad()
        instatiateSearchTableView()
        instatiateSearchBar()
        self.searchTableStatus = .loading
         spinnerView = self.showSpinner(onView: self.view)
        presenter?.searchFor(word: "f")
        //      { result in
        //
        //            switch result {
        //            case .success(let recipesArray):
        //
        //            case .failure(let error):
        //
        //            }
        //        })
    }
    
    func instatiateSearchTableView() {
        adapter.setDelegates()
        searchTableView.register(SearchDataTableViewCell.nib,
                                 forCellReuseIdentifier: SearchDataTableViewCell.identifire)
        //  let background = UIImageView(frame: searchTableView.frame)
        // background.image = Asset.search.image
        searchTableView.backgroundView = UIImageView(image: Asset.search.image)
        searchTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    func instatiateSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        if #available(iOS 9.1, *) {
            search.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
        }
        search.searchBar.placeholder = "Type something here..."
        if #available(iOS 11.0, *) {
            navigationItem.searchController = search
        } else {
            // Fallback on earlier versions
        }
    }
    
    func setTableViewResult(with array: [Recipe]) {
        self.adapter.setRecipes(array: array)
        self.removeSpinner(spinnerView: spinnerView ?? UIView())
        searchTableView.backgroundView = UIView(frame: .zero)
        self.searchTableStatus = .searchResults
    }
    func showSearchFailed() {
        self.searchTableStatus = .error
        self.searchTableView.backgroundView = UIImageView(image: Asset.error.image)
    }
    
    func moveToDetails(recipe: Recipe) {
        presenter?.moveToDetailsWith(recipe: recipe)
    }
    
    func reloadSearchTable() {
        searchTableView.reloadData()
    }
}
//
//extension SearchViewController:  {
//
//}

extension SearchViewController: SearchViewProtocol {
    
}
