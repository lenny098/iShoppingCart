//
//  IBeaconReceiver.swift
//  iShoppingCart
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation

class IBeaconReceiver
{
    static var iBeacons: [IBeacon] = []
    
    static func getNearby() -> [IBeacon] {
        // TODO: Below is just for testing
        return [IBeacon(uuid: 12345, section: "Section 2")]
    }
}
