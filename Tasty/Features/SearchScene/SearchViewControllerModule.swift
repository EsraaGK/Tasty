//
//  SearchViewControllerModule.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import UIKit

class SearchViewControllerModule {
 
    class func getSearchViewController() -> SearchViewController {
        let view = SearchViewController()
        let model = SearchModel()
        let presenter = SearchPresenter(view: view, model: model)
        view.presenter = presenter
        return view
    }
}
