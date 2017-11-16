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
    private var products: [Product] = []
    
    func getProducts() -> [Product] {
        return products
    }
    
    func addProduct(product: Product) {
        products.append(product)
    }
    
    func removeProduct(id: Int) -> Bool {
        if let i = products.index(where: {$0.id == id}) {
            products.remove(at: i)
            return true
        }
        return false
    }
    
    func getTotalPrice() -> Double {
        // TODO
        return 0
    }
}
