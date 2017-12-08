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
    private var products = [Section: [Product]]()
    private var sections = [Section]()
    
    init(products: [Product]) {
        for product in products {
            if self.products[product.section] != nil
            {
                self.products[product.section]!.append(product)
            }
            else
            {
                self.products[product.section] = [product]
            }
            if !sections.contains(product.section)
            {
                self.sections.append(product.section)
            }
        }
    }
    
    func getSections() -> [Section] {
        return sections
    }
    
    func getProductsBySection(priority:Int) -> [Product] {
        return products[sections[priority]] ?? []
    }
    
    func getAllProducts() -> [Product] {
        var result = [Product]()
        for section in sections {
            result += products[section]!
        }
        return result
    }
    
    func updateList(nearbyBeacons: [IBeacon]) {
        // getNearby() should return a list of beacons sorted in descending signal strength
        for beacon in nearbyBeacons.reversed()
        {
            print("updating section: \(beacon.section.name)")
            if let i = sections.index(of: beacon.section)
            {
                print("Beacon section: \(beacon.section)")
                sections.insert(sections.remove(at: i), at: 0)
                print("After update: sections[0] is \(sections[0].name)")
            }
        }
    }
}
