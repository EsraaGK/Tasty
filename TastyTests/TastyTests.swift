//
//  TastyTests.swift
//  TastyTests
//
//  Created by EsraaGK on 4/11/20.
//  Copyright © 2020 EsraaGK. All rights reserved.
//

import XCTest
@testable import Tasty

class TastyTests: XCTestCase {
    let mockApiModel = MockApiModel()
    
    func testSearchRequest() {
        let expectation = self.expectation(description: "search for recipe")
        mockApiModel.searchFor(word: "rice meat spanich", from: 0) { (result) in
            
            switch result {
            case .success(let recipeApiObj):
                if recipeApiObj.hits.isEmpty {
                    XCTFail("no results")
                } else {
                    XCTAssertEqual(1, recipeApiObj.hits.count)
                    expectation.fulfill()
                }
                
            case .failure(let error):
                XCTAssertNil(error)
            }
           
        }
         self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    //    override func setUp() {
    //        super.setUp()
    //        // Put setup code here. This method is called before the invocation of each test method in the class.
    //    }
    //
    //    override func tearDown() {
    //        super.tearDown()
    //        // Put teardown code here. This method is called after the invocation of each test method in the class.
    //    }
    
}
