//
//  Coupon.swift
//  iShoppingCart
//
//  Created by Lenny on 15/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation

class Coupon: NSObject, NSCoding
{
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(productCount, forKey: "productCount")
        aCoder.encode(discount, forKey: "discount")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as! String
        let productCount = aDecoder.decodeInteger(forKey: "productCount")
        let discount = aDecoder.decodeDouble(forKey: "discount")
        
        self.init(name: name, productCount: productCount, discount: discount)
    }
    
    override var hash: Int
    {
        return name.hashValue
    }
    
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
    
    override func isEqual(_ object: Any?) -> Bool {
        if let other = object as? Coupon {
            return self == other
        }
        return false
    }
}
