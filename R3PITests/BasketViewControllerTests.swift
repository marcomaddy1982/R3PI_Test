//
//  BasketViewControllerTests.swift
//  R3PI
//
//  Created by Marco Maddalena on 20/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest
@testable import R3PI

class BasketViewControllerTests: XCTestCase {
    
    var basketViewController: BasketViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        basketViewController = storyboard.instantiateViewController(withIdentifier: "BasketViewController") as! BasketViewController
        basketViewController.performSelector(onMainThread: #selector(basketViewController.loadView), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewLoads() {
        XCTAssertNotNil(basketViewController.view, "View not initiated properly")
    }
    
    func testTableViewLoads() {
        XCTAssertNotNil(basketViewController.tableBasket, "Table not initiated");
    }
    
    func testViewConformsToUITableViewDataSource() {
        XCTAssertTrue(basketViewController.conforms(to: UITableViewDataSource.self), "View does not conform to UITableView datasource protocol")
    }
    
    func testCollectionViewHasDataSource()
    {
        XCTAssertNotNil(basketViewController.tableBasket.dataSource, "Table datasource cannot be nil");
    }
    
    func testViewConformsToUICollectionViewDelegate() {
        XCTAssertTrue(basketViewController.conforms(to: UITableViewDelegate.self), "View does not conform to UITableView delegate protocol")
    }
    
    func testCollectionViewIsConnectedToDelegate() {
        XCTAssertNotNil(basketViewController.tableBasket.delegate, "Table datasource cannot be nil");
    }

}
