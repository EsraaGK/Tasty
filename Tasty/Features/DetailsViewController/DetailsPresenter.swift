//
//  SearchPresenter.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

class DetailsPresenter: BasePresenter<DetailsViewController, DetailsModel> {
    let view: DetailsViewProtocol
    let model: DetailsModelProtocol
    var recipe: Recipe?
    override init(view: DetailsViewController, model: DetailsModel) {
        self.view = view
        self.model = model
        super.init(view: view, model: model)
        
    }
    convenience init(view: DetailsViewController, model: DetailsModel, recipe: Recipe) {
        self.init(view: view, model: model)
        self.recipe = recipe
    }
    
    func getDetailsViewData() -> Recipe {
        return recipe ?? Recipe(label: "",
                                image: "",
                                source: "",
                                url: "",
                                healthLabels: [String](),
                                ingredientLines: [String]())
    }
}
