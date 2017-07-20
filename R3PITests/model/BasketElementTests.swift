//
//  BasketElementTests.swift
//  R3PI
//
//  Created by Marco Maddalena on 19/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest
@testable import R3PI

class BasketElementTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: test "totalPrice" property
    func testBasketElementTotalPricePriceNil() {
        let product = Product(name: nil, price: nil, unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        XCTAssertEqual(basketElement.totalPrice.floatValue, 0.0)
    }
    
    func testBasketElementTotalPricePriceZero() {
        let product = Product(name: nil, price: NSNumber(value: 0.0), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        XCTAssertEqual(basketElement.totalPrice.floatValue, 0.0)
    }
    
    func testBasketElementTotalPriceAmountZero() {
        let product = Product(name: nil, price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 0
        XCTAssertEqual(basketElement.totalPrice.floatValue, 0.0)
    }
    
    func testBasketElementTotalPriceOk() {
        let product = Product(name: nil, price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        XCTAssertEqual(basketElement.totalPrice.floatValue, 1.9)
    }
    
    // MARK: test "name" property
    func testBasketElementViewModelNameNil() {
        let product = Product(name: nil, price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        let basketElementViewModel = BasketElementViewModel(basketElement: basketElement)
        XCTAssertEqual(basketElementViewModel.nameText, "No Name")
    }
    
    func testBasketElementViewModelNameEmpty() {
        let product = Product(name: "", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        let basketElementViewModel = BasketElementViewModel(basketElement: basketElement)
        XCTAssertEqual(basketElementViewModel.nameText, "No Name")
    }
    
    func testBasketElementViewModelNameOK() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        let basketElementViewModel = BasketElementViewModel(basketElement: basketElement)
        XCTAssertEqual(basketElementViewModel.nameText, "Peas")
    }
    
    // MARK: test "amount" property
    func testBasketElementViewModelAmountZero() {
        let product = Product(name: nil, price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 0
        let basketElementViewModel = BasketElementViewModel(basketElement: basketElement)
        XCTAssertEqual(basketElementViewModel.amountText, "No Amount")
    }
    
    func testBasketElementViewModelAmountOK() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        let basketElementViewModel = BasketElementViewModel(basketElement: basketElement)
        XCTAssertEqual(basketElementViewModel.amountText, "Amount: 2")
    }
    
    // MARK: test "price" property
    func testBasketElementViewModelPriceAmountZero() {
        let product = Product(name: nil, price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 0
        let basketElementViewModel = BasketElementViewModel(basketElement: basketElement)
        XCTAssertEqual(basketElementViewModel.priceText, "No Price")
    }
    
    func testBasketElementViewModelPricePriceNil() {
        let product = Product(name: "Peas", price: nil, unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        let basketElementViewModel = BasketElementViewModel(basketElement: basketElement)
        XCTAssertEqual(basketElementViewModel.priceText, "No Price")
    }
    
    func testBasketElementViewModelPricePriceZero() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.0), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        let basketElementViewModel = BasketElementViewModel(basketElement: basketElement)
        XCTAssertEqual(basketElementViewModel.priceText, "No Price")
    }
    
    func testBasketElementViewModelPriceOk() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 2
        let basketElementViewModel = BasketElementViewModel(basketElement: basketElement)
        XCTAssertEqual(basketElementViewModel.priceText, "Price: $  1.90")
    }
}
