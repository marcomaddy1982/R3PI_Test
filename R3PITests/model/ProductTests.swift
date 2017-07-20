//
//  ProductTests.swift
//  R3PI
//
//  Created by Marco Maddalena on 19/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest
@testable import R3PI

class ProductTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: test "name" property
    func testProductViewModelNameNil() {
        let product = Product(name: nil, price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertEqual(productViewModel.nameText, "No Name")
    }
    
    func testProductViewModelNameEmpty() {
        let product = Product(name: "", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertEqual(productViewModel.nameText, "No Name")
    }
    
    func testProductViewModelNameOK() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertEqual(productViewModel.nameText, "Peas")
    }
    
    // MARK: test "price" property
    func testProductViewModelPriceNil() {
        let product = Product(name: "Peas", price: nil, unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertEqual(productViewModel.priceText, "No Price")
    }
    
    func testProductViewModelPriceZero() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.0), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertEqual(productViewModel.priceText, "No Price")
    }
    
    func testProductViewModelPriceOk() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertEqual(productViewModel.priceText, "Price: $  0.95 per bag")
    }
    
    // MARK: test "unit" property
    func testProductViewModelUnitNil() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: nil, imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertEqual(productViewModel.priceText, "Price: $  0.95")
    }
    
    func testProductViewModelUnitEmpty() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertEqual(productViewModel.priceText, "Price: $  0.95")
    }
    
    func testProductViewModelUnitOk() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertEqual(productViewModel.priceText, "Price: $  0.95 per bag")
    }
    
    // MARK: test "imgUrl" property
    func testProductViewModelUrlNil() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: nil)
        let productViewModel = ProductViewModel(product: product)
        XCTAssertNil(productViewModel.imgURL)
    }
    
    func testProductViewModelUrlEmpty() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertNil(productViewModel.imgURL)
    }
    
    func testProductViewModelUrlOk() {
        let product = Product(name: "Peas", price: NSNumber(value: 0.95), unit: "bag", imageUrl: "https://edge.ua.edu/wp-content/uploads/2016/04/frozen-peas.jpg")
        let productViewModel = ProductViewModel(product: product)
        XCTAssertNotNil(productViewModel.imgURL)
    }
}
