//
//  SearchViewController.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    var presenter: SearchPresenter?
    weak var delegate: SearchViewControllerDelegate?
    var searchTableStatus = SearchTableStates.firstView
    
    @IBOutlet private weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        instatiateSearchTableView()
        instatiateSearchBar()
        
        AppManger.shared.apiService.request(.search(searchWord: "chicken", fromResult: 10, toResult: 11)) { (result) in
            switch result {
            case .success(let response):
                
                print(try? JSONSerialization.jsonObject(with: response.data, options: []))
            case .failure(let moyaError):
                print(moyaError)
            }
            
        }
    }
    
    func instatiateSearchTableView() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchDataTableViewCell.nib,
                                 forCellReuseIdentifier: SearchDataTableViewCell.identifire)
        searchTableView.backgroundView = UIImageView(image: UIImage(named: "hhhhh"))
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
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchDataTableViewCell.identifire)
            as? SearchDataTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else { return }
        delegate.moveToDetails()
    }
}

extension SearchViewController: SearchViewProtocol {
    
}
