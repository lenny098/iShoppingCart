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
    let uuid : Int
    let section : Section
    
    init(uuid: Int, section: String) {
        self.uuid = uuid
        self.section = Section(name: section)
    }
    
    static func ==(lhs: IBeacon, rhs: IBeacon) -> Bool {
        return lhs.uuid == rhs.uuid && lhs.section == rhs.section
    }
}
