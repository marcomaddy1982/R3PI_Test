//
//  Currency.swift
//  R3PI
//
//  Created by Marco Maddalena on 19/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest
@testable import R3PI

class Currency: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAsyncGetConcurrency() {
        let networkService = NetworkService.getCurrencyList
        let provider = ApiProvider(service: networkService)
        let expectationRequest = expectation(description: "Currency List")
        
        provider.start { (data, response, error) in
            XCTAssertNotNil(data)
            XCTAssertNil(error)
            
            if let response = response as? HTTPURLResponse, let responseURL = response.url, let mimeType = response.mimeType
            {
                XCTAssertEqual(responseURL.absoluteString, networkService.url, "HTTP response URL should be equal to original URL")
                XCTAssertEqual(response.statusCode, 200, "HTTP response status code should be 200")
                XCTAssertEqual(mimeType, "application/json", "HTTP response content type should be application/json")
            } else {
                XCTFail("Response was not NSHTTPURLResponse")
            }
            
            expectationRequest.fulfill()
        }
        
        waitForExpectations(timeout: 1) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}
