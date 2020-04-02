//
//  entity.swift
//  Tasty
//
//  Created by EsraaGK on 4/2/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

struct RecipeApiObj {
    let  recipe: Recipe
}
struct Recipe {
    let label: String
    let image: String
    let source: String
    let url: String
    let healthLabels: [String]
    let ingredientLines: [String]
}

enum SearchTableStates {
    case noInternet
    case noResults
    case loading
    case searchResults
    case searchHistoryWords
    case error
}
