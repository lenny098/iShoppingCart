//
//  TestIBeaconReceiver.swift
//  iShoppingCartTests
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import XCTest

class TestIBeaconReceiver: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetNearby() {
        IBeaconReceiver.iBeacons = [IBeacon(uuid: 0, section: "Section 1")]
        let iBeacons = IBeaconReceiver.getNearby()
        // TODO: Replace with a proper check using a CLBeaconRegion stub.
        XCTAssertNotEqual(iBeacons, [])
    }
}
