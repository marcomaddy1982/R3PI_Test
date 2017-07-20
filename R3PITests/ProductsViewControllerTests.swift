//
//  ProductsViewControllerTests.swift
//  R3PI
//
//  Created by Marco Maddalena on 20/07/2017.
//  Copyright © 2017 R3PI. All rights reserved.
//

import XCTest
@testable import R3PI

class ProductsViewControllerTests: XCTestCase {
    
    var productViewController: ProductsViewController!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        productViewController = storyboard.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        productViewController.performSelector(onMainThread: #selector(productViewController.loadView), with: nil, waitUntilDone: true)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testViewLoads() {
        XCTAssertNotNil(productViewController.view, "View not initiated properly")
    }
    
    func testCollectionViewLoads() {
        XCTAssertNotNil(productViewController.collectionProducts, "Collection not initiated");
    }
    
    func testViewConformsToUICollectionViewDataSource() {
        XCTAssertTrue(productViewController.conforms(to: UICollectionViewDataSource.self), "View does not conform to UICollectionView datasource protocol")
    }
    
    func testCollectionViewHasDataSource()
    {
        XCTAssertNotNil(productViewController.collectionProducts.dataSource, "Collection datasource cannot be nil");
    }
    
    func testViewConformsToUICollectionViewDelegate() {
        XCTAssertTrue(productViewController.conforms(to: UICollectionViewDelegate.self), "View does not conform to UICollectionView delegate protocol")
    }
    
    func testCollectionViewIsConnectedToDelegate() {
        XCTAssertNotNil(productViewController.collectionProducts.delegate, "Collection datasource cannot be nil");
    }    
}
