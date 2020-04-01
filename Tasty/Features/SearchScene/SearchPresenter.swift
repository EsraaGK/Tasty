//
//  SearchPresenter.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

class SearchPresenter: BasePresenter<SearchViewController, SearchModel> {
    var view: SearchViewController
    var model: SearchModel
    
    override init(view: SearchViewController, model: SearchModel) {
        self.view = view
        self.model = model
        super.init(view: view, model: model)
    }
}
