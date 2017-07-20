//
//  R3PIUITests.swift
//  R3PIUITests
//
//  Created by Marco Maddalena on 17/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest

class ProductsViewControllerUITests: XCTestCase {
    
    var application = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        application.launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testProductElementNumber() {
        let cells: XCUIElementQuery = application.collectionViews.cells
        XCTAssertEqual(cells.count, 4, "found instead: \(cells.debugDescription)")
    }
    
    func testProductsCollectioView() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let cells: XCUIElementQuery = application.collectionViews.cells
        let firstCell = cells.element(boundBy: 0)
        
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 0).label,"Peas")
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 1).label,"Price: $  0.95 per bag")
        
        let secondCell = cells.element(boundBy: 1)
        
        XCTAssertEqual(secondCell.staticTexts.element(boundBy: 0).label,"Eggs")
        XCTAssertEqual(secondCell.staticTexts.element(boundBy: 1).label,"Price: $  2.10 per dozen")
        
        let thirdCell = cells.element(boundBy: 2)
        
        XCTAssertEqual(thirdCell.staticTexts.element(boundBy: 0).label,"Milk")
        XCTAssertEqual(thirdCell.staticTexts.element(boundBy: 1).label,"Price: $  1.30 per bottle")
        
        let fourthCell = cells.element(boundBy: 3)
        
        XCTAssertEqual(fourthCell.staticTexts.element(boundBy: 0).label,"Beans")
        XCTAssertEqual(fourthCell.staticTexts.element(boundBy: 1).label,"Price: $  0.73 per can")
        
    }
    
}
