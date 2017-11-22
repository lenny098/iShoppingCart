//
//  Coupon.swift
//  iShoppingCart
//
//  Created by Lenny on 15/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation

class Coupon: Equatable
{
    let name: String
    let productCount: Int
    let discount: Double
    
    init(name: String, productCount: Int, discount: Double) {
        self.name = name
        self.productCount = productCount
        self.discount = discount
    }
    
    static func ==(lhs: Coupon, rhs: Coupon) -> Bool {
        return lhs.name==rhs.name && lhs.productCount==rhs.productCount &&
               lhs.discount == rhs.discount
    }
}
