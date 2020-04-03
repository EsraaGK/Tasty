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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //   presenter?.moveToDetailsDelegate = delegate
        instatiateSearchTableView()
        instatiateSearchBar()
        presenter?.searchFor(word: "chicken", completion: { result in
            self.searchTableStatus = .loading
           let spinnerView = self.showSpinner(onView: self.view)
            switch result {
            case .success(let recipesArray):
                self.adapter.setRecipes(array: recipesArray)
                 self.removeSpinner(spinnerView: spinnerView)
                self.searchTableStatus = .searchResults
            case .failure(let error):
                self.searchTableStatus = .error
               
                print(error.localizedDescription)
            }
        })
    }
    
    func instatiateSearchTableView() {
        adapter.setDelegates()
        searchTableView.register(SearchDataTableViewCell.nib,
                                 forCellReuseIdentifier: SearchDataTableViewCell.identifire)
     //   searchTableView.backgroundView = UIImageView(image: UIImage(named: "hhhhh"))
        searchTableView.backgroundView = UIView(frame: CGRect.zero)
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
