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
    let loadMore: () -> Void
    let moveToDetails: (Recipe) -> Void
    var searchTableStates = SearchTableStates.searchHistoryWords {
        didSet {
            switch searchTableStates {
            case .firstView:
                recipes.removeAll()
                searchTableView.backgroundView = UIImageView(image: Asset.search.image)
            case .error:
                if !recipes.isEmpty {
                    searchTableView.backgroundView = UIView(frame: .zero)
                } else {
                    searchTableView.backgroundView = UIImageView(image: Asset.error.image)
                }
            case .noResults:
                searchTableView.backgroundView = UIImageView(image: Asset.emptyResult.image)
            case .loadMore:
                 searchTableView.backgroundView = UIView(frame: .zero)
            default:
                searchTableView.backgroundView = UIImageView(image: Asset.search.image)
            }
        }
    }
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
    
    init(searchTableView: UITableView,
         reloadTableView: @escaping() -> Void,
         moveToDetails:@escaping(Recipe) -> Void,
         loadMore: @escaping() -> Void) {
        self.searchTableView = searchTableView
        self.reloadTableView = reloadTableView
        self.moveToDetails = moveToDetails
        self.loadMore = loadMore
        recipes = [Recipe]()
        searchWords = [String]()
    }
    
    func setRecipes(array: [Recipe]) {
        if array.isEmpty && recipes.isEmpty { //first time and no results
            searchTableStates = .noResults
//            switch searchTableStates {
//            case .firstView, .searchResults:
//                searchTableStates = .noResults
//            default:
//                searchTableView.backgroundView = UIImageView(image: Asset.search.image)
//            }
        } else {
            searchTableStates = .searchResults
            recipes.append(contentsOf: array)
        }
        
        print(array.count)
        print(recipes.count)
    }
    
    func setDelegates() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        self.searchTableStates = .firstView
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
        
        if indexPath.row == recipes.count - 2 {
            loadMore()
            searchTableStates = .loadMore
        }
        
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
