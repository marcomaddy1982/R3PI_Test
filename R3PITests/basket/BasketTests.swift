//
//  BasketProviderTest.swift
//  R3PI
//
//  Created by Marco Maddalena on 19/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest
@testable import R3PI

class BasketViewModelMock : BasketViewModel {
    
    let basketProvider: BasketProvider = BasketProvider.sharedInstance
    
    override init() {
        let peas = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElementPeas = BasketElement()
        basketElementPeas.product = peas
        basketElementPeas.amount = 2
        
        let eggs = Product(name: "Eggs", price: NSNumber(value: 2.10), unit: "dozen", imageUrl: "http://www.thepeoplesmarketperth.com.au/order/image/cache/data/eggs/eggs%2012%20pack-600x600.jpg")
        let basketElementEggs = BasketElement()
        basketElementEggs.product = eggs
        basketElementEggs.amount = 1
        
        basketProvider.basket = [basketElementPeas, basketElementEggs]
    }
    
    override var basketElementsCount: Int {
        return basketProvider.basket.count
    }
    
    override func removeBasketElement(at index: Int, completitionHandler: BasketCompletitionHandler?) {
        basketProvider.removeBesketElement(at: index, completitionHandler: completitionHandler)
    }
    
    override func emptyBasket(completitionHandler: BasketCompletitionHandler?) {
        basketProvider.emptyBasket(completitionHandler: completitionHandler)
    }
}

class BasketTests: XCTestCase {
    
    let basketViewModelMock = BasketViewModelMock()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testBasketViewModelCount() {
        XCTAssertTrue(basketViewModelMock.basketElementsCount == 2)
    }
    
    func testBasketViewModelRemoveElement() {
        
        let peas = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElementPeas = BasketElement()
        basketElementPeas.product = peas
        basketElementPeas.amount = 2
        
        let eggs = Product(name: "Eggs", price: NSNumber(value: 2.10), unit: "dozen", imageUrl: "http://www.thepeoplesmarketperth.com.au/order/image/cache/data/eggs/eggs%2012%20pack-600x600.jpg")
        let basketElementEggs = BasketElement()
        basketElementEggs.product = eggs
        basketElementEggs.amount = 1
        
        basketViewModelMock.basketProvider.basket = [basketElementPeas, basketElementEggs]
        basketViewModelMock.removeBasketElement(at: 0, completitionHandler: nil)
        XCTAssertTrue(basketViewModelMock.basketProvider.basketCount == 1)
    }
    
    func testBasketViewModelEmptyBasket() {
        basketViewModelMock.emptyBasket(completitionHandler: nil)
        XCTAssertTrue(basketViewModelMock.basketProvider.basketCount == 0)
    }
    
    func testAsyncGetLiveConvert() {
        let networkService = NetworkService.getLiveConvert(to: "EUR")
        let provider = ApiProvider(service: networkService)
        let expectationRequest = expectation(description: "Live currency conversion async request")
        
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
