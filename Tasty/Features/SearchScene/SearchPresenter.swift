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
    var from = 0 
    weak var moveToDetailsDelegate: SearchViewControllerDelegate?
    
    override init(view: SearchViewController, model: SearchModel) {
        self.view = view
        self.model = model
        super.init(view: view, model: model)
    }
    
    func searchFor(word: String) {
        model.searchFor(word: word, from: from) { result in
            switch result {
            case .success(let data):
                self.view.setTableViewResult(with: self.getRecipesArray(from: data))
            case .failure(let error):
                print(error)
                self.view.showSearchFailed()
            }
            
        }
        
    }
    
    func moveToDetailsWith(recipe: Recipe) {
        guard let moveToDetailsDelegate = self.moveToDetailsDelegate else { return }
        moveToDetailsDelegate.moveToDetails()
    }
    
    func getRecipesArray(from data: Data) -> [Recipe] {
        var recipeApiObj = RecipeApiObj(hits: [Hit]())
        var recipes = [Recipe]()
        do {
            recipeApiObj = try JSONDecoder().decode(RecipeApiObj.self, from: data)
        } catch let error {
            print(error)
        }
        for hit in recipeApiObj.hits {
            recipes.append(hit.recipe)
        }
        
        return recipes
    }
}
