//
//  DataLoader.swift
//  iShoppingCart
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation
import os.log

class DataLoader
{
    static func loadProducts() -> [Product]
    {
        if let file = Bundle.main.url(forResource: "products", withExtension: "json")
        {
            do
            {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data)
                
                let dict = json as! [String: Any]
                let products = dict["Products"] as! [Any]
                
                var result:[Product] = []

                for product in products
                {
                    let product = product as! [String:Any]
                    let id = product["id"] as! Int
                    let name = product["name"] as! String
                    let price = product["price"] as! Double
                    let section = product["section"] as! String
                    
                    if let coupon = product["coupon"] as? [String: Any]
                    {
                        let c_name = coupon["name"] as! String
                        let c_count = coupon["count"] as! Int
                        let c_discount = coupon["discount"] as! Double
                        
                        let coupon_object = Coupon(name: c_name, productCount: c_count, discount: c_discount)
                        let product_object = Product(id: id, name: name, price: price, section: section, coupon: coupon_object)
                        result.append(product_object)
                    }
                    else
                    {
                        let product_object = Product(id: id, name: name, price: price, section: section, coupon: nil)
                        result.append(product_object)
                    }
                }
                return result
            }
            catch {return []}
        }

        return []
    }
    
    static func loadIBeacons() -> [IBeacon]
    {
        if let file = Bundle.main.url(forResource: "beacons", withExtension: "json")
        {
            do
            {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data)
                
                let dict = json as! [String: Any]
                let beacons = dict["Beacons"] as! [Any]
                
                var result:[IBeacon] = []
                
                for beacon in beacons
                {
                    let beacon = beacon as! [String: Any]
                    result.append(IBeacon(uuid: beacon["uuid"] as! Int, section: beacon["section"] as! String))
                }
                
                return result
            }
            catch
            {
                return []
            }
        }
        return []
    }
}
