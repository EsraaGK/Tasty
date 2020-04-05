//
//  SearchPresenter.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

class SearchPresenter: BasePresenter<SearchViewController, SearchModel> {
    var view: SearchViewProtocol
    var model: SearchModelProtocol
    var toRecipeApiObj = 0
    var searchWord = ""
    var more = true
    weak var moveToDetailsDelegate: SearchViewControllerDelegate?
    
    override init(view: SearchViewController, model: SearchModel) {
        self.view = view
        self.model = model
        super.init(view: view, model: model)
    }
    
    func searchFor(word: String, searchTableStates: SearchTableStates ) {
        var searchWord = ""
        var from = 0
        if searchTableStates != .firstView, more { //loadMORE
            searchWord = self.searchWord
            from = toRecipeApiObj
        } else {//firstSEARCH
            searchWord = word
            self.searchWord = word
            toRecipeApiObj = 0
            from = 0
            more = true
        }
        model.searchFor(word: searchWord, from: from) { result in
            switch result {
            case .success(let recipeApiObj):
                self.view.setTableViewResult(with: self.analizeApiObj(recipeApiObj: recipeApiObj))
            case .failure(let error):
                print(error)
                self.view.showSearchFailed()
            }
        }
    }
    
    func moveToDetailsWith(recipe: Recipe) {
        guard let moveToDetailsDelegate = self.moveToDetailsDelegate else { return }
        moveToDetailsDelegate.moveToDetails(recipe: recipe)
    }
    
    func analizeApiObj(recipeApiObj: RecipeApiObj) -> [Recipe] {
        toRecipeApiObj = recipeApiObj.to
        var  recipes = [Recipe]()
        if  recipeApiObj.hits.isEmpty {
            more = false
            print(more)
            view.showEndOfResults()
        } else {
            for hit in recipeApiObj.hits {
                recipes.append(hit.recipe)
            }
        }
        return recipes
    }
    
}
