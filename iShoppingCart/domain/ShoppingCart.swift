//
//  ShoppingCart.swift
//  iShoppingCart
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation

class ShoppingCart
{
    private var products: [Product: Int] = [:]
    
    func getProducts() -> [Product] {
        return [Product](products.keys)
    }
    
    func addProduct(product: Product) {
        if products[product] != nil {
            products[product]! += 1
        }
        else
        {
            products[product] = 1
        }
    }
    
    func removeProduct(product: Product) {
        products[product]! -= 1
        if products[product]! < 1 {
            products[product] = nil
        }
    }
    
    func clear() {
        products.removeAll()
    }
    
    func getCount(product: Product) -> Int {
        return products[product] ?? 0
    }
    
    func getActivatedDiscount(product: Product) -> Int {
        return products[product]! / (product.coupon?.productCount)!
    }
    
    func getTotalPrice() -> Double {
        var total = 0.0
        
        for (product, count) in products
        {
            total += Double(count) * product.price
            if let coupon = product.coupon
            {
                total += Double(count / coupon.productCount) * coupon.discount
            }
        }
        return total
    }
}
