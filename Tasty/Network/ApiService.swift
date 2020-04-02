//
//  ApiService.swift
//  Tasty
//
//  Created by EsraaGK on 4/2/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import Foundation
import Moya

enum EdamamApiConsts: String {
    case baseURL = "https://api.edamam.com/"
    case appID = "cb10bfcd"
    case appKEY = "29ea9397f933d2184079ccb5078576b5"
}

enum EdamamApiUrlPathesAndParameters: String {
    //Pathes
    case search = "/search"
    //Parameters
    case appID = "app_id"
    case appKEY = "app_key"
    case qPram = "q"
    case fromResult = "from"
    case toResult = "to"
}
enum EdamamServices {
    case search (searchWord: String, fromResult: Int, toResult: Int)
}

extension EdamamServices: TargetType {
    
    var baseURL: URL {
        // swiftlint:disable all
        return URL(string: EdamamApiConsts.baseURL.rawValue)!
        // swiftlint:enable all
    }
    
    var path: String {
        switch self {
        case .search:
            return EdamamApiUrlPathesAndParameters.search.rawValue
            
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data { // for testing
        return Data()
    }
    
    var task: Task { // parameters to be passed in the url
        switch self {
        case .search(let searchWord, let fromResult, let toResult):
            var parametersArray = [String: Any]()
            parametersArray[EdamamApiUrlPathesAndParameters.qPram.rawValue] = searchWord
            parametersArray[EdamamApiUrlPathesAndParameters.appID.rawValue] = EdamamApiConsts.appID.rawValue
            parametersArray[EdamamApiUrlPathesAndParameters.appKEY.rawValue] = EdamamApiConsts.appKEY.rawValue
            parametersArray[EdamamApiUrlPathesAndParameters.fromResult.rawValue] = fromResult
            parametersArray[EdamamApiUrlPathesAndParameters.toResult.rawValue] = toResult
            return .requestParameters(parameters: parametersArray,
                                      encoding: URLEncoding.queryString)
            
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
