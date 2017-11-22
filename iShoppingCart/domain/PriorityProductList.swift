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
        let nearbyBeacons = IBeaconReceiver.getNearby()
        
        // getNearby() should return a list of beacons sorted in descending signal strength
        for beaon in nearbyBeacons.reversed()
        {
            let filtered = products.filter({(product) -> Bool in product.section == beaon.section})
            for product in filtered
            {
                if let i = products.index(of: product)
                {
                    products.insert(products.remove(at: i), at: 0)
                }
            }
        }
    }
}
