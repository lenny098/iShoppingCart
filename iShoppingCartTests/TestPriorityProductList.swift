//
//  TestPriorityProductList.swift
//  iShoppingCartTests
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import XCTest

class TestPriorityProductList: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetProducts() {
        let p1 = Product(id: 0, name: "Product 1", price: 5.5, section: "Section 1", coupon: nil)
        let p2 = Product(id: 1, name: "Product 2", price: 4.5, section: "Section 2", coupon: nil)
        let ppList = PriorityProductList(products: [p1, p2])
        
        XCTAssertEqual(ppList.getProducts(), [p1, p2])
    }
    
    func testUpdateList() {
        class IBeaconReceiver
        {
            static func getNearby() -> [IBeacon] {
                return [IBeacon(uuid: 12345, section: "Section 2")]
            }
        }
        
        let p1 = Product(id: 0, name: "Product 1", price: 5.5, section: "Section 1", coupon: nil)
        let p2 = Product(id: 1, name: "Product 2", price: 4.5, section: "Section 2", coupon: nil)
        let ppList = PriorityProductList(products: [p1, p2])
        
        ppList.updateList()
        XCTAssertEqual(ppList.getProducts(), [p2, p1])
    }
}
