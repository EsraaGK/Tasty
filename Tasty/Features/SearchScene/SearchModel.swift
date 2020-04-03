//
//  SearchModel.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

class SearchModel: BaseModel, SearchModelProtocol {
    
    func searchFor(word: String, from: Int, completion: @escaping(Result<Data, Error>) -> Void) {
        
        AppManger.shared.apiService.request(.search(searchWord: word, fromResult: 0, toResult: 2)) { (result) in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let moyaError):
                completion(.failure(moyaError))
                print(moyaError)
            }
            
        }
    }
}
