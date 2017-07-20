//
//  BasketViewControllerUITests.swift
//  R3PI
//
//  Created by Marco Maddalena on 20/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest

class BasketViewControllerUITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddElementToBasket() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Peas").buttons["Add one unit"].tap()
        app.alerts["Attention"].buttons["OK"].tap()
        app.navigationBars["Products"].buttons["Basket"].tap()
        
        let cells: XCUIElementQuery = app.tables.cells
        let firstCell = cells.element(boundBy: 0)
        
        XCTAssertEqual(cells.count, 1)
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 0).label,"Peas")
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 1).label,"Amount: 1")
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 2).label,"Price: $  0.95")
        
    }
    
    func testAddElementTwoTimesToBasket() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Peas").buttons["Add one unit"].tap()
        app.alerts["Attention"].buttons["OK"].tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Peas").buttons["Add one unit"].tap()
        app.alerts["Attention"].buttons["OK"].tap()
        app.navigationBars["Products"].buttons["Basket"].tap()
        
        let cells: XCUIElementQuery = app.tables.cells
        let firstCell = cells.element(boundBy: 0)
        
        XCTAssertEqual(cells.count, 1)
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 0).label,"Peas")
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 1).label,"Amount: 2")
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 2).label,"Price: $  1.90")
    }
    
    func testAddTwoElementsToBasket() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Peas").buttons["Add one unit"].tap()
        app.alerts["Attention"].buttons["OK"].tap()
        app.collectionViews.cells.otherElements.containing(.staticText, identifier:"Eggs").buttons["Add one unit"].tap()
        app.alerts["Attention"].buttons["OK"].tap()
        app.navigationBars["Products"].buttons["Basket"].tap()
        
        let cells: XCUIElementQuery = app.tables.cells
        let firstCell = cells.element(boundBy: 0)
        let secondCell = cells.element(boundBy: 1)
        
        XCTAssertEqual(cells.count, 2)
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 0).label,"Peas")
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 1).label,"Amount: 1")
        XCTAssertEqual(firstCell.staticTexts.element(boundBy: 2).label,"Price: $  0.95")
        XCTAssertEqual(secondCell.staticTexts.element(boundBy: 0).label,"Eggs")
        XCTAssertEqual(secondCell.staticTexts.element(boundBy: 1).label,"Amount: 1")
        XCTAssertEqual(secondCell.staticTexts.element(boundBy: 2).label,"Price: $  2.10")
    }
    
    func testDeleteElementFromBasket() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let cellsQuery = app.collectionViews.cells
        let addOneUnitButton = cellsQuery.otherElements.containing(.staticText, identifier:"Peas").buttons["Add one unit"]
        addOneUnitButton.tap()
        
        let okButton = app.alerts["Attention"].buttons["OK"]
        okButton.tap()
        addOneUnitButton.tap()
        okButton.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Eggs").buttons["Add one unit"].tap()
        okButton.tap()
        app.navigationBars["Products"].buttons["Basket"].tap()
        
        let tablesQuery = app.tables
        let cells: XCUIElementQuery = tablesQuery.cells
        let firstCell = cells.element(boundBy: 0)
        firstCell.swipeLeft()
        tablesQuery.buttons["Delete"].tap()
        
        XCTAssertEqual(cells.count, 1)
    }
    
    func testClearElementFromBasket() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let app = XCUIApplication()
        let cellsQuery = app.collectionViews.cells
        cellsQuery.otherElements.containing(.staticText, identifier:"Peas").buttons["Add one unit"].tap()
        
        let okButton = app.alerts["Attention"].buttons["OK"]
        okButton.tap()
        cellsQuery.otherElements.containing(.staticText, identifier:"Eggs").buttons["Add one unit"].tap()
        okButton.tap()
        app.navigationBars["Products"].buttons["Basket"].tap()
        app.navigationBars["Basket"].buttons["Empty"].tap()
        
        let tablesQuery = app.tables
        let cells: XCUIElementQuery = tablesQuery.cells
        XCTAssertEqual(cells.count, 0)
    }
}
