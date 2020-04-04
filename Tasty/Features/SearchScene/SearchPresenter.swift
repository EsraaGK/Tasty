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
        
        switch searchTableStates {
        case .firstView:
            searchWord = word
            more = true
            model.searchFor(word: word, from: 0) { result in
                switch result {
                case .success(let data):
                    self.view.setTableViewResult(with: self.getRecipesArray(from: data))
                case .failure(let error):
                    print(error)
                    self.view.showSearchFailed()
                }
                
            }
        default: // load more
            if more {
                model.searchFor(word: searchWord, from: toRecipeApiObj) { result in
                    switch result {
                    case .success(let data):
                        self.view.setTableViewResult(with: self.getRecipesArray(from: data))
                    case .failure(let error):
                        print(error)
                        self.view.showSearchFailed()
                    }
                }
                
            } else {
                return
            }
        }
        
    }
    
    func moveToDetailsWith(recipe: Recipe) {
        guard let moveToDetailsDelegate = self.moveToDetailsDelegate else { return }
        moveToDetailsDelegate.moveToDetails(recipe: recipe)
    }
    
    func getRecipesArray(from data: Data) -> [Recipe] {
        var recipeApiObj = RecipeApiObj(from: 0, hits: [Hit](), to: 0, more: true)
        var recipes = [Recipe]()
        do {
            recipeApiObj = try JSONDecoder().decode(RecipeApiObj.self, from: data)
            toRecipeApiObj = recipeApiObj.to
            more = recipeApiObj.more
        } catch let error {
            print(error)
        }
        for hit in recipeApiObj.hits {
            recipes.append(hit.recipe)
        }
        
        return recipes
    }
    
    func searchCompletion(result: Result<Data, Error>) {
        switch result {
        case .success(let data):
            self.view.setTableViewResult(with: self.getRecipesArray(from: data))
        case .failure(let error):
            print(error)
            self.view.showSearchFailed()
        }
    }
}
