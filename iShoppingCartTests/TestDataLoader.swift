//
//  TestDataLoader.swift
//  iShoppingCartTests
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import XCTest

class TestDataLoader: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testLoadProduct() {
        let products = DataLoader.loadProducts()
        // TODO: Replace with a proper check when json is available
        XCTAssertNotEqual(products, [])
    }
    
    func testLoadIBeacons() {
        let iBeacons = DataLoader.loadIBeacons()
        // TODO: Replace with a proper check when json is available
        XCTAssertNotEqual(iBeacons, [])
        
    }
    
}
