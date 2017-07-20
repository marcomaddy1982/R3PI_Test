//
//  ProductTests.swift
//  R3PI
//
//  Created by Marco Maddalena on 19/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest
@testable import R3PI

class ProductViewModelMock : ProductsViewModel {
    
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
    
    override func addProduct(product: Product, completitionHandler: BasketCompletitionHandler?) {
        let basket = BasketProvider.sharedInstance.basket
        for basketElement in basket {
            if basketElement.product == product {
                self.basketProvider.updateBesketElementAmount(element: basketElement, completitionHandler: completitionHandler)
                return
            }
        }
        
        let basketElement = BasketElement()
        basketElement.product = product
        basketElement.amount = 1
        self.basketProvider.addBesketElement(element: basketElement, completitionHandler: completitionHandler)
    }
}


class ProductsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddNewProduct() {
        let beans = Product(name: "Beans", price: NSNumber(value: 0.73), unit: "can", imageUrl: "http://assets.bonappetit.com/photos/57daf5809f19b4610e6b7058/5:4/w_2056,c_limit/bas-best-640.jpg")
        
        let productViewModelMock = ProductViewModelMock()
        productViewModelMock.addProduct(product: beans, completitionHandler: nil)
        
        XCTAssertTrue(productViewModelMock.basketProvider.basketCount == 3)
    }
}
