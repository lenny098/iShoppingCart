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
        
        let coupon1 = Coupon(name: "Buy 1 get 1 free", productCount: 2, discount: -5.5)
        let product1 = Product(id: 0, name: "Potato Chips", price: 5.5, section: "Snacks", coupon: coupon1)
        let product2 = Product(id: 1, name: "Biscuits", price: 7.0, section: "Snacks", coupon: nil)
        
        XCTAssertEqual(products, [product1, product2])
    }
    
    func testLoadIBeacons() {
        let iBeacons = DataLoader.loadIBeacons()
        
        let iBeacon1 = IBeacon(uuid: 0, section: "Snacks")
        let iBeacon2 = IBeacon(uuid: 1, section: "Soft Drinks")
        
        XCTAssertEqual(iBeacons, [iBeacon1, iBeacon2])
        
    }
    
}
