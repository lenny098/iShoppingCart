//
//  TestShoppingCart.swift
//  iShoppingCartTests
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import XCTest

class TestShoppingCart: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testAddAndGetProducts() {
        let cart = ShoppingCart()
        
        XCTAssertEqual(cart.getProducts(), [])
        
        let product1 = Product(id: 0, name: "Product 1", price: 5.5, section: "Section 1", coupon: nil)
        let product2 = Product(id: 1, name: "Product 2", price: 4.5, section: "Section 1", coupon: nil)
        cart.addProduct(product: product1)
        cart.addProduct(product: product2)
        
        XCTAssertEqual(cart.getProducts(), [product1, product2])
    }
    
    func testRemoveProduct() {
        let cart = ShoppingCart()
        
        XCTAssertFalse(cart.removeProduct(id: 0))
        
        let product1 = Product(id: 0, name: "Product 1", price: 5.5, section: "Section 1", coupon: nil)
        cart.addProduct(product: product1)
        
        XCTAssertTrue(cart.removeProduct(id: 0))
    }
    
    func testTotalPrice() {
        let cart = ShoppingCart()
        
        XCTAssertEqual(cart.getTotalPrice(), 0.0)
        
        let product1 = Product(id: 0, name: "Product 1", price: 5.5, section: "Section 1", coupon: nil)
        let product2 = Product(id: 1, name: "Product 2", price: 4.5, section: "Section 1", coupon: nil)
        cart.addProduct(product: product1)
        cart.addProduct(product: product2)
        cart.addProduct(product: product1)
        
        XCTAssertEqual(cart.getTotalPrice(), 15.5)
    }
    
    func testTotalPriceWithCoupon() {
        let cart = ShoppingCart()
        
        XCTAssertEqual(cart.getTotalPrice(), 0.0)
        
        let coupon1 = Coupon(name: "Buy 1 get 1 free", productCount: 2, discount: -5.5)
        let product1 = Product(id: 0, name: "Product 1", price: 5.5, section: "Section 1", coupon: coupon1)
        let product2 = Product(id: 1, name: "Product 2", price: 4.5, section: "Section 1", coupon: nil)
        cart.addProduct(product: product1)
        cart.addProduct(product: product1)
        cart.addProduct(product: product2)
        cart.addProduct(product: product1)
        
        XCTAssertEqual(cart.getTotalPrice(), 15.5)
    }
}
