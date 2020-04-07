//
//  SearchModel.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

class SearchModel: BaseModel, SearchModelProtocol {

    func searchFor(word: String, from: Int, completion: @escaping(Result<RecipeApiObj, Error>) -> Void) {
        
        AppManger.shared.apiService.request(.search(searchWord: word,
                                                    fromResult: from,
                                                    toResult: 20 + from)) {(result) in
            switch result {
            case .success(let response):
                completion(.success(self.getRecipesArray(from: response.data)))
            case .failure(let moyaError):
                completion(.failure(moyaError))
                print(moyaError)
            }
            
        }
    }  
    func getRecipesArray(from data: Data) -> RecipeApiObj {
        var recipeApiObj = RecipeApiObj(from: 0, hits: [Hit](), to: 0, more: true)
        do {
            recipeApiObj = try JSONDecoder().decode(RecipeApiObj.self, from: data)
        } catch let error {
            print(error)
        }
        return recipeApiObj
    }
}
