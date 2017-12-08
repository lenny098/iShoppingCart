//
//  Section.swift
//  iShoppingCart
//
//  Created by Lenny on 15/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation

class Section: Equatable, Hashable
{
    var hashValue: Int {
        return name.hashValue
    }
    
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    static func ==(lhs: Section, rhs: Section) -> Bool
    {
        return lhs.name == rhs.name
    }
}
