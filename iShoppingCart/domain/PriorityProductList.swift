//
//  PriorityProductList.swift
//  iShoppingCart
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation

class PriorityProductList
{
    private var products: [Product]
    
    init(products: [Product]) {
        self.products = products
    }
    
    func getProducts() -> [Product] {
        return products
    }
    
    func updateList() {
        // TODO
    }
}
