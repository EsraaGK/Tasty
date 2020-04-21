//
//  TastyTests.swift
//  TastyTests
//
//  Created by EsraaGK on 4/11/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import XCTest
@testable import Tasty
import OHHTTPStubs

class TastyTests: XCTestCase {
    let mockApiModel = MockApiModel()
    
    func testSearchRequest() {
        
        var output: [Hit]?
        let expectation = self.expectation(description: "search for recipe ")
        mockApiModel.searchFor(word: "rice meat spanich", from: 0) { (result) in
            
            switch result {
            case .success(let recipeApiObj):
                if recipeApiObj.hits.isEmpty {
                    XCTFail("no results")
                } else {
                      output = recipeApiObj.hits
                    XCTAssertEqual(1, recipeApiObj.hits.count)
                  
                    expectation.fulfill()
                }
                
            case .failure(let error):
                XCTAssertNil(error)
            }
            
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
        XCTAssertNotNil(output)
    }
      
    func testStub() {
        let learn = Learn()
        let squareNoTwo = learn.square(number: 2)
        XCTAssertEqual(4, squareNoTwo)
    }
    
//    func test_getResponseUsing_OHHTTPStubs() { //rice%20meat%20spanich%20hhhhh
//         var output: [Hit]?
//        // Setup network stubs
//        var component = URLComponents()
//        component.scheme = "https"
//        component.host = "api.edamam.com"
//        component.path = "/search"
//        component.queryItems = [
//            URLQueryItem(name: "q", value: "rice meat spanich hhhhh"),
//            URLQueryItem(name: "app_id", value: "cb10bfcd"),
//            URLQueryItem(name: "app_key", value: "29ea9397f933d2184079ccb5078576b5"),
//            URLQueryItem(name: "from", value: "0"),
//            URLQueryItem(name: "to", value: "10")]
//        guard let finalLink = component.url else { return }
//        print(finalLink.query?.contains("q=rice%20meat%20spanich%20hhhhh") ?? false )
//        let stubExpectation = self.expectation(description: "calls the callback with a resource object")
//
//        stub(condition: { (URLRequest) -> Bool in
//            return URLRequest.url?.query?.contains("rice%20meat%20spanich") ?? false }) { _ in
//            return HTTPStubsResponse(
//                fileAtPath: OHPathForFile("SuccessResponse.json", type(of: self)) ?? "json",
//                statusCode: 200,
//                headers: ["Content-Type": "application/json"]
//            )
//        }
////        stub(condition: { (URLRequest) -> Bool in
////            return URLRequest.url?.query?.contains("rice%20meat%20spanich%20hhhhh") ?? false }) { _ in
////            return HTTPStubsResponse(
////                fileAtPath: OHPathForFile("EmptyResult.json", type(of: self)) ?? "json",
////                statusCode: 200,
////                headers: ["Content-Type": "application/json"]
////            )
////        }
//        // Setup system under test
//        let model = SearchModel()
//        model.searchFor(word: "rice meat spanich",
//                        from: 0) { (result) in
//                            switch result {
//                            case .success(let recipeApiObj):
//                                if recipeApiObj.hits.isEmpty {
//                                    XCTFail("no results")
//                                } else {
//                                      output = recipeApiObj.hits
//                                    XCTAssertEqual(1, recipeApiObj.hits.count)
//                                    stubExpectation.fulfill()
//
//                                }
//
//                            case .failure(let error):
//                                XCTAssertNil(error)
//                            }
//        }
//        self.waitForExpectations(timeout: 10, handler: nil)
//         XCTAssertNotNil(output)
//        XCTAssertEqual(1, output?.count)
//    }
}
