//
//  MockApiModel.swift
//  TastyTests
//
//  Created by EsraaGK on 4/11/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import XCTest
@testable import Tasty

class MockApiModel: XCTestCase {
    
    func getRecipesArray(from data: Data) -> RecipeApiObj {
        var recipeApiObj = RecipeApiObj(from: 0, hits: [Hit](), to: 0, more: true)
        do {
            recipeApiObj = try JSONDecoder().decode(RecipeApiObj.self, from: data)
        } catch let error {
            print(error)
        }
        return recipeApiObj
    }
    //    override func setUp() {
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDown() {
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }
    
}

extension  MockApiModel: SearchModelProtocol {
    
    func searchFor(word: String,
                   from: Int,
                   completion: @escaping (Result<RecipeApiObj, Error>) -> Void) {
        
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
}
