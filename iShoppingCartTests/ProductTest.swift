//
//  ProductTest.swift
//  iShoppingCartTests
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import XCTest

class ProductTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSession() {
        let s1 = Section(name: "Section 1")
        let s2 = Section(name: "Section 1")
        let s3 = Section(name: "Section 2")
        
        XCTAssertEqual(s1, s2)
        XCTAssertNotEqual(s1, s3)
    }
    
    func testProduct() {
        let p = Product(id : 0, name : "Sample Product", price : 5.5, section : "Sample Section", coupon : nil)
        XCTAssertEqual(p.id, 0)
        XCTAssertEqual(p.name, "Sample Product")
        XCTAssertEqual(p.price, 5.5)
        XCTAssertEqual(p.section, Section(name : "Sample Section"))
        XCTAssertNil(p.coupon)
    }
    
    func testCoupon() {
        let c = Coupon(id: 0, name: "Sample Coupon", productCount: 2, discount: 0.5) // Buy 1 get 1 free
        let p = Product(id : 0, name : "Sample Product", price : 5.5, section : "Sample Section", coupon : c)
        XCTAssertNotNil(p.coupon)
        
        let c2 = p.coupon!
        XCTAssertEqual(c.id, c2.id)
        XCTAssertEqual(c.name, c2.name)
        XCTAssertEqual(c.productCount, c2.productCount)
        XCTAssertEqual(c.discount, c2.discount)
    }
    
    func testIBeacon() {
        let b = IBeacon(uuid: 0, section: "Sample Section")
        XCTAssertEqual(b.uuid, 0)
        XCTAssertEqual(b.section, Section(name: "Sample Section"))
    }
}
