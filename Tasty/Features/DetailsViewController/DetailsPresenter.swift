//
//  SearchPresenter.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

class DetailsPresenter: BasePresenter<DetailsViewController, DetailsModel> {
    var view: DetailsViewProtocol
    var model: DetailsModelProtocol
    
    override init(view: DetailsViewController, model: DetailsModel) {
        self.view = view
        self.model = model
        super.init(view: view, model: model)
    }
}
