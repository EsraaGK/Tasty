//
//  SearchAdapter.swift
//  Tasty
//
//  Created by EsraaGK on 4/3/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation
import UIKit

class SearchAdapter: NSObject, UITableViewDataSource, UITableViewDelegate {
    let searchTableView: UITableView
    let reloadTableView: () -> Void
    let moveToDetails: (Recipe) -> Void
    var searchTableStates = SearchTableStates.searchHistoryWords
    var recipes: [Recipe] {
        didSet {
            reloadTableView()
        }
    }
    var searchWords: [String] {
        didSet {
            reloadTableView()
        }
    }
    
    init(searchTableView: UITableView, reloadTableView: @escaping() -> Void, moveToDetails:@escaping(Recipe) -> Void) {
        self.searchTableView = searchTableView
        self.reloadTableView = reloadTableView
        self.moveToDetails = moveToDetails
        recipes = [Recipe]()
        searchWords = [String]()
    }
    
    func setRecipes(array: [Recipe]) {
        recipes.append(contentsOf: array)
    }
    
    func setDelegates() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    func changeTableStatusTo(status: SearchTableStates) {
        searchTableStates = status
        reloadTableView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch searchTableStates {
        case .searchHistoryWords:
            return searchWords.count
        default:
            return recipes.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch searchTableStates {
        case .searchHistoryWords:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifire)
                as? DetailsTableViewCell else { return UITableViewCell() }
            
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchDataTableViewCell.identifire)
                as? SearchDataTableViewCell else { return UITableViewCell() }
            cell.configureSearchDataCell(with: recipes[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchTableStates {
        case .searchHistoryWords:
            print("search")
        default:
            moveToDetails(recipes[indexPath.row])
        }
        
    }
}
