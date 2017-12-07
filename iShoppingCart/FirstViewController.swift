//
//  FirstViewController.swift
//  iShoppingCart
//
//  Created by Lenny on 9/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import UIKit
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    @IBOutlet weak var firstLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        
        firstLabel.text = "View Loaded"
        
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)
        {
            locationManager.requestAlwaysAuthorization()
            
            firstLabel.text = "Monitoring available."
            
            let uuid = UUID(uuidString: "B5B182C7-EAB1-4988-AA99-B5C1517008D9")
            let region = CLBeaconRegion(proximityUUID: uuid!, major: 1, minor: 1544, identifier: "ibeacon")
            locationManager.startMonitoring(for: region)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        firstLabel.text = "iBeacon Found!"
        
        if region is CLBeaconRegion
        {
            if CLLocationManager.isRangingAvailable()
            {
                locationManager.startRangingBeacons(in: region as! CLBeaconRegion)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        var nearbyBeacon: [IBeacon] = []
        
        for beacon in beacons {
            nearbyBeacon.append(IBeacon(uuid: beacon.proximityUUID.uuidString, section: ""))
        }
        //ppList.update(nearbyBeacon)
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        firstLabel.text = "iBeacon Lost!"
        
        if region is CLBeaconRegion
        {
            if CLLocationManager.isRangingAvailable()
            {
                locationManager.stopRangingBeacons(in: region as! CLBeaconRegion)
            }
        }
    }
}

