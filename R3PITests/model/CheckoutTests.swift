//
//  CheckoutTests.swift
//  R3PI
//
//  Created by Marco Maddalena on 19/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest
@testable import R3PI

class CheckoutTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: test "currencyCode" property
    func testCheckoutViewModelCurrencyCodeNil() {
        let checkout = Checkout(timestamp: TimeInterval(1500456246), quote: NSNumber(value: 0.95), totalAmout: NSNumber(value: 1.00), currencyCode: nil)
        let checkoutViewModel = CheckoutViewModel(checkout: checkout)
        XCTAssertEqual(checkoutViewModel.checkoutText, "No currency.")
    }
    
    func testCheckoutViewModelCurrencyCodeEmpty() {
        let checkout = Checkout(timestamp: TimeInterval(1500456246), quote: NSNumber(value: 0.95), totalAmout: NSNumber(value: 1.00), currencyCode: "")
        let checkoutViewModel = CheckoutViewModel(checkout: checkout)
        XCTAssertEqual(checkoutViewModel.checkoutText, "No currency.")
    }
    
    // MARK: test "quote" property
    func testCheckoutViewModelQuoteNil() {
        let checkout = Checkout(timestamp: TimeInterval(1500456246), quote: nil, totalAmout: NSNumber(value: 1.00), currencyCode: "USD")
        let checkoutViewModel = CheckoutViewModel(checkout: checkout)
        XCTAssertEqual(checkoutViewModel.checkoutText, "No checkout.")
    }
    
    func testCheckoutViewModelQuoteZero() {
        let checkout = Checkout(timestamp: TimeInterval(1500456246), quote: NSNumber(value: 0.0), totalAmout: NSNumber(value: 1.00), currencyCode: "USD")
        let checkoutViewModel = CheckoutViewModel(checkout: checkout)
        XCTAssertEqual(checkoutViewModel.checkoutText, "No checkout.")
    }
    
    // MARK: test "totalAmount" property
    func testCheckoutViewModelTotalAmountNil() {
        let checkout = Checkout(timestamp: TimeInterval(1500456246), quote: NSNumber(value: 0.95), totalAmout: nil, currencyCode: "USD")
        let checkoutViewModel = CheckoutViewModel(checkout: checkout)
        XCTAssertEqual(checkoutViewModel.checkoutText, "No checkout.")
    }
    
    func testCheckoutViewModelTotalAmountZero() {
        let checkout = Checkout(timestamp: TimeInterval(1500456246), quote: NSNumber(value: 0.95), totalAmout: NSNumber(value: 0.0), currencyCode: "USD")
        let checkoutViewModel = CheckoutViewModel(checkout: checkout)
        XCTAssertEqual(checkoutViewModel.checkoutText, "No checkout.")
    }
    
    // MARK: test "timestamp" property
    func testCheckoutViewModelTimestampNil() {
        let checkout = Checkout(timestamp: nil, quote: NSNumber(value: 0.95), totalAmout: NSNumber(value: 1.00), currencyCode: "USD")
        let checkoutViewModel = CheckoutViewModel(checkout: checkout)
        XCTAssertEqual(checkoutViewModel.checkoutText, "Total Amount: $   0.95")
    }
    
    func testCheckoutViewModelTimestampZero() {
        let checkout = Checkout(timestamp: TimeInterval(0), quote: NSNumber(value: 0.95), totalAmout: NSNumber(value: 1.00), currencyCode: "USD")
        let checkoutViewModel = CheckoutViewModel(checkout: checkout)
        XCTAssertEqual(checkoutViewModel.checkoutText, "Total Amount: $   0.95")
    }
    
    // MARK: test checkout ok
    func testCheckoutViewModelCheckOutOK() {
        let checkout = Checkout(timestamp: TimeInterval(1500456246), quote: NSNumber(value: 1.00), totalAmout: NSNumber(value: 0.95), currencyCode: "USD")
        let checkoutViewModel = CheckoutViewModel(checkout: checkout)
        XCTAssertEqual(checkoutViewModel.checkoutText, "Date: 2017-07-19 11:24:06\nTotal Amount: $   0.95")
    }
    
}
