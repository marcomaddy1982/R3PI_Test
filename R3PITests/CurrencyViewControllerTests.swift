//
//  CurrencyViewControllerTests.swift
//  R3PI
//
//  Created by Marco Maddalena on 20/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest
@testable import R3PI

class CurrencyViewControllerTests: XCTestCase {
    
    var currencyViewController: CurrencyViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        currencyViewController = storyboard.instantiateViewController(withIdentifier: "CurrencyViewController") as! CurrencyViewController
        currencyViewController.performSelector(onMainThread: #selector(currencyViewController.loadView), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewLoads() {
        XCTAssertNotNil(currencyViewController.view, "View not initiated properly")
    }
    
    func testTableViewLoads() {
        XCTAssertNotNil(currencyViewController.tableCurrency, "Table not initiated");
    }
    
    func testViewConformsToUITableViewDataSource() {
        XCTAssertTrue(currencyViewController.conforms(to: UITableViewDataSource.self), "View does not conform to UITableView datasource protocol")
    }
    
    func testCollectionViewHasDataSource()
    {
        XCTAssertNotNil(currencyViewController.tableCurrency.dataSource, "Table datasource cannot be nil");
    }
    
    func testViewConformsToUICollectionViewDelegate() {
        XCTAssertTrue(currencyViewController.conforms(to: UITableViewDelegate.self), "View does not conform to UITableView delegate protocol")
    }
    
    func testCollectionViewIsConnectedToDelegate() {
        XCTAssertNotNil(currencyViewController.tableCurrency.delegate, "Table datasource cannot be nil");
    }
}
