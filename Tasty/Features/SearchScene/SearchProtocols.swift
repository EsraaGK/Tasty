//
//  SearchProtocols.swift
//  Tasty
//
//  Created by EsraaGK on 4/1/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol {
    func searchFor(word: String, completion: (Result<Any, Error>))
    
}

protocol SearchViewProtocol: BaseViewProtocol {
    func setTableViewResult(with array: [Recipe])
    func showSearchFailed()
}

protocol SearchModelProtocol: BaseModelProtocol {
   func searchFor(word: String, from: Int, completion: @escaping(Result<Data, Error>) -> Void)
}
