//
//  File.swift
//  iShoppingCart
//
//  Created by Lenny on 15/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation

class Product: NSObject, NSCoding, NSCopying
{
    func copy(with zone: NSZone? = nil) -> Any
    {
        if let coupon = coupon
        {
            let couponCopy = Coupon(name: coupon.name, productCount: coupon.productCount, discount: coupon.discount)
            return Product(id: id, name: name, price: price, section: section.name, coupon: couponCopy)
        }
        else
        {
            return Product(id: id, name: name, price: price, section: section.name, coupon: nil)
        }
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "pid")
        aCoder.encode(name, forKey: "pname")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(section.name, forKey: "psection")
        aCoder.encode(coupon, forKey: "coupon")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: "pid")
        let name = aDecoder.decodeObject(forKey: "pname") as! String
        let price = aDecoder.decodeDouble(forKey: "price")
        let section = aDecoder.decodeObject(forKey: "psection") as! String
        let coupon = aDecoder.decodeObject(forKey: "coupon") as! Coupon?
        
        self.init(id: id, name: name, price: price, section: section, coupon: coupon)
    }
    
    override var hashValue: Int {
        return id.hashValue
    }
    
    override var hash: Int {
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
               lhs.section == rhs.section
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let other = object as? Product {
            return self==other
        }
        return false
    }
}
