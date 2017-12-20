//
//  IBeacon.swift
//  iShoppingCart
//
//  Created by Lenny on 15/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation

class IBeacon : Equatable
{
    let uuid : String
    let major: Int
    let minor: Int
    let section : Section
    let strength : Double
    
    init(uuid: String, major: Int, minor: Int, section: String) {
        self.uuid = uuid
        self.major = major
        self.minor = minor
        self.section = Section(name: section)
        self.strength = 0
    }
    
    static func ==(lhs: IBeacon, rhs: IBeacon) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.major == rhs.major &&
               lhs.minor == rhs.minor && lhs.section == rhs.section
    }
}
