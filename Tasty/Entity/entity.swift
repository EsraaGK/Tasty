//
//  entity.swift
//  Tasty
//
//  Created by EsraaGK on 4/2/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation

struct RecipeApiObj: Decodable {
    let from: Int
    let  hits: [Hit]
    let to: Int
    let more: Bool
    //    init(json: [String: Any]) {
    //        hits = json["hits"] as? [Recipe] ??  [Recipe]()
    //    }
}
struct Hit: Decodable {
    let recipe: Recipe
}
struct Recipe: Decodable {
    var label: String
    var image: String
    var source: String
    var url: String
    var healthLabels: [String]?
    var ingredientLines: [String]
    
    //    init(json: [String: Any]) {
    //        label = json["label"] as? String ?? "label"
    //        image = json["image"] as? String ?? "image"
    //        source = json["source"] as? String ?? "source"
    //        url = json["url"] as? String ?? "url"
    //        healthLabels = json["healthLabels"] as? [String] ??  [String]()
    //        ingredientLines = json["ingredientLines"] as? [String] ??  [String]()
    //    }
}

enum SearchTableStates {
    case firstView
    case noInternet
    case noResults
    case loading
    case searchResults
    case searchHistoryWords
    case error
    case loadMore
}

//
// MARK: - Welcome
//struct Welcome: Codable {
//    let q: String
//    let from, to: Int
//    let more: Bool
//    let count: Int
//    let hits: [Hit]
//}
//
// MARK: - Hit
//struct Hit: Codable {
//    let recipe: Recipe
//    let bookmarked, bought: Bool
//}
//
// MARK: - Recipe
//struct Recipe: Codable {
//    let uri: String
//    let label: String
//    let image: String
//    let source: String
//    let url: String
//    let shareAs: String
//    let yield: Int
//    let dietLabels, healthLabels, cautions, ingredientLines: [String]
//    let ingredients: [Ingredient]
//    let calories, totalWeight: Double
//    let totalTime: Int
//    let totalNutrients, totalDaily: [String: Total]
//    let digest: [Digest]
//}
//
// MARK: - Digest
//struct Digest: Codable {
//    let label, tag: String
//    let schemaOrgTag: String?
//    let total: Double
//    let hasRDI: Bool
//    let daily: Double
//    let unit: Unit
//    let sub: [Digest]?
//}
//
//enum Unit: String, Codable {
//    case empty = "%"
//    case g = "g"
//    case iu = "IU"
//    case kcal = "kcal"
//    case mg = "mg"
//    case µg = "µg"
//}
//
// MARK: - Ingredient
//struct Ingredient: Codable {
//    let text: String
//    let weight: Double
//}
//
// MARK: - Total
//struct Total: Codable {
//    let label: String
//    let quantity: Double
//    let unit: Unit
//}
