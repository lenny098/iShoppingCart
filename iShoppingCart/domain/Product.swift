//
//  File.swift
//  iShoppingCart
//
//  Created by Lenny on 15/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation

class Product: Equatable, Hashable
{
    var hashValue: Int {
        return id.hashValue
    }
    
    let id: Int
    let name: String
    let price: Double
    let section: Section
    let coupon: Coupon?
    
    init(id: Int, name: String, price: Double, section: String, coupon: Coupon?) {
        self.id = id
        self.name = name
        self.price = price
        self.section = Section(name : section)
        self.coupon = coupon
    }
    
    static func ==(lhs: Product, rhs: Product) -> Bool
    {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.price == rhs.price &&
               lhs.section == rhs.section && lhs.coupon == rhs.coupon
    }
}
