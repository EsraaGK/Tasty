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
    let searchWith: (String) -> Void
    let moveToDetails: (Recipe) -> Void
    var searchTableStates = SearchTableStates.searchHistoryWords {
        didSet {
            switch searchTableStates {
            case .firstView:
                searchWords.removeAll()
                recipes.removeAll()
                let imageView = UIImageView(image: Asset.search.image)
                imageView.contentMode = .scaleAspectFit
                searchTableView.backgroundView = imageView
            case .error:
                if !recipes.isEmpty {
                    searchTableView.backgroundView = UIView(frame: .zero)
                } else {
                    let imageView = UIImageView(image: Asset.error.image)
                    imageView.contentMode = .scaleAspectFit
                    searchTableView.backgroundView = imageView
                }
            case .noResults:
                let imageView = UIImageView(image: Asset.emptyResult.image)
                imageView.contentMode = .scaleAspectFit
                searchTableView.backgroundView = imageView
            case .loadMore:
                 searchTableView.backgroundView = UIView(frame: .zero)
            case .searchResults:
                 searchTableView.backgroundView = UIView(frame: .zero)
            case .endLoadMore:
            searchTableView.backgroundView = UIView(frame: .zero)
            case .searchHistoryWords:
            searchTableView.backgroundView = UIView(frame: .zero)
            default:
                let imageView = UIImageView(image: Asset.search.image)
                imageView.contentMode = .scaleAspectFit
                searchTableView.backgroundView = imageView
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
         loadMore: @escaping() -> Void,
         searchWith: @escaping(String) -> Void) {
        self.searchTableView = searchTableView
        self.reloadTableView = reloadTableView
        self.moveToDetails = moveToDetails
        self.searchWith = searchWith
        self.loadMore = loadMore
        recipes = [Recipe]()
        searchWords = [String]()
    }
    
    func setRecipes(array: [Recipe]) {
        searchWords.removeAll()
        if array.isEmpty && recipes.isEmpty { //first time and no results
            searchTableStates = .noResults
        } else if searchTableStates != .endLoadMore {
            searchTableStates = .searchResults
            recipes.append(contentsOf: array)
            reloadTableView()
        }
        print(recipes.count)
    }
    func sethistorySearch(array: [String]?) {
        searchWords.removeAll()
        guard let words = array else { return }
        searchWords.append(contentsOf: words)
        changeTableStatusTo(status: .searchHistoryWords)
        
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
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        switch searchTableStates {
//        case .searchHistoryWords:
//            return searchWords.count
//        default:
//            return recipes.count
//        }
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch searchTableStates {
        case .searchHistoryWords:
            return searchWords.count
        default:
            return recipes.count
        }
    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 20
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == recipes.count - 2, searchTableStates != .endLoadMore {
            searchTableStates = .loadMore
        }
        switch searchTableStates {
        case .searchHistoryWords:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.identifire)
                as? DetailsTableViewCell else { return UITableViewCell() }
            cell.configureCell(with: searchWords[indexPath.row])
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9572720462, green: 0.8271618151, blue: 0.3491812928, alpha: 1)
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchDataTableViewCell.identifire)
                as? SearchDataTableViewCell else { return UITableViewCell() }
            cell.configureSearchDataCell(with: recipes[indexPath.row])
            cell.contentView.backgroundColor = #colorLiteral(red: 0.9572720462, green: 0.8271618151, blue: 0.3491812928, alpha: 1)
           // cell.addShadowAndCornerRadius()
            return cell
        }
        
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//    let headerView = UIView()
//    headerView.backgroundColor = UIColor.clear
//
//    return headerView
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch searchTableStates {
        case .searchHistoryWords:
            searchWith(searchWords[indexPath.row])
        default:
            moveToDetails(recipes[indexPath.row])
        }
    }
//
//    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//    }
//
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = CGFloat(integerLiteral: 200)
        let bottomEdge = scrollView.contentOffset.y + scrollView.frame.size.height;
        if (bottomEdge + offset >= scrollView.contentSize.height) {
            if searchTableStates == .loadMore {
            // if indexPath.row == recipes.count - 2 {
                     loadMore()
                     searchTableStates = .searchResults
                 }
        }
    }
}
