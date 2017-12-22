//
//  ProductTableViewController.swift
//  iShoppingCart
//
//  Created by Lenny on 8/12/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import UIKit
import CoreLocation

class ProductTableViewController: UITableViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let beaconList = DataLoader.loadIBeacons()
    let region = CLBeaconRegion(proximityUUID: UUID(uuidString: "B5B182C7-EAB1-4988-AA99-B5C1517008D9")!, identifier: "iBeacon")
    
    var priorityProductList = PriorityProductList(products: [])
    var beaconStrengths = [Section: CLProximity]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadList), name: NSNotification.Name(rawValue: "reloadList"), object: nil)
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self)
        {

            //Assume all beacons has the same UUID
            locationManager.startMonitoring(for: region)
            
            print("===== Start Monitoring For Region \(region)")
        }
        
        priorityProductList = PriorityProductList(products: DataLoader.loadProducts())
        
        print("Dataloaded, size() \(DataLoader.loadProducts().count)")

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func reloadList() {
        self.tableView.reloadData()
    }
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        if region is CLBeaconRegion
        {
            if CLLocationManager.isRangingAvailable()
            {
                locationManager.startRangingBeacons(in: self.region)
                print("===== Beacon Found, Start Ranging \(self.region)")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        if region is CLBeaconRegion
        {
            if CLLocationManager.isRangingAvailable()
            {
                locationManager.stopRangingBeacons(in: self.region)
                print("===== Becon Lost, Stop Ranging =====")
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print("\(beacons.count) beacons found in this region")
        
        var nearbyBeacon: [IBeacon] = []
        var nearbySection = [Section: CLProximity]()
        
        for beacon in beacons
        {
            print("Beacon Found: UUID:\(beacon.proximityUUID.uuidString), major:\(beacon.major) minor:\(beacon.minor) proximity:\(beacon.proximity.rawValue)")
            
            if let index = beaconList.index(where: {$0.uuid == beacon.proximityUUID.uuidString &&
                                                    $0.major == beacon.major.intValue &&
                                                    $0.minor == beacon.minor.intValue
                                                    // && $0.strength == beacon.accuracy // this seems buggy
                                                    })
            {
                nearbyBeacon.append(beaconList[index])
                nearbySection[beaconList[index].section] = beacon.proximity
                print("\(beaconList[index].section.name) is nearby")
            }
        }
        let oldList = [Section](priorityProductList.getSections())
        priorityProductList.updateList(nearbyBeacons: nearbyBeacon)
        var indexSet = IndexSet()
        
        for i in 0..<oldList.count
        {
            if oldList[i] != priorityProductList.getSections()[i]
            {
                indexSet.insert(i)
            }
        }
        
        self.tableView.reloadSections(indexSet, with: .automatic)
        
        beaconStrengths = nearbySection
        
        print("===== Beacon updated, reloading =====")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        print("ppList Sections \(priorityProductList.getSections().count)")
        return priorityProductList.getSections().count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("For Section \(section), size: \(priorityProductList.getProductsBySection(priority: section).count)")
        return priorityProductList.getProductsBySection(priority: section).count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if section == 0 {
            return priorityProductList.getSections()[section].name + " (Possibly Near)"
        } else {
            return priorityProductList.getSections()[section].name
        }
        
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x:0, y:0, width:self.tableView.frame.width, height:22))
        headerView.backgroundColor = UITableView().separatorColor
        
        let sectionImage = UIImageView(frame: CGRect(x:2, y:4, width:29, height:20))
        
        /*let totalSectionCount = priorityProductList.getSections().count
        
        if section == 0 {
            sectionImage.image = UIImage(named: "wifiSignalHigh")
        }else if section < (totalSectionCount/2){
            sectionImage.image = UIImage(named: "wifiSignalMedium")
        }else{
            sectionImage.image = UIImage(named: "wifiSignalLow")
        }*/
        
        if let proximity = self.beaconStrengths[priorityProductList.getSections()[section]] {
            switch proximity {
                case .immediate:
                    sectionImage.image = UIImage(named: "wifiSignalHigh")
                case .near:
                    sectionImage.image = UIImage(named: "wifiSignalMedium")
                case .far:
                    sectionImage.image = UIImage(named: "wifiSignalLow")
                default:
                    sectionImage.image = UIImage(named: "wifiSignalNone")
            }
        }
        else
        {
            sectionImage.image = UIImage(named: "wifiSignalNone")
        }
        
        let sectionName = UILabel(frame: CGRect(x:35, y:2, width:self.tableView.frame.width-35, height:22))
        sectionName.text = priorityProductList.getSections()[section].name
        
        headerView.addSubview(sectionImage)
        headerView.addSubview(sectionName)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTableViewCell", for: indexPath) as? ProductTableViewCell
        let product = priorityProductList.getProductsBySection(priority: indexPath.section)[indexPath.row]
        
        cell?.product = product
        cell?.nameLabel.text = product.name
        cell?.priceLabel.text = String(format:"$ %.1f", product.price)
        let count = AppDelegate.shoppingCart.getCount(product: product)
        if count > 0 {
            cell?.countLabel.text = String(count)
        }
        else
        {
            cell?.countLabel.text = ""
        }
        
        
        if let coupon = product.coupon
        {
            cell?.discountLabel.text = coupon.name
            cell?.discountLabel.isHidden = false
            print("\(product.name) has coupon")
        }
        else
        {
            cell?.discountLabel.isHidden = true
            print("\(product.name) has no coupon")
        }
        // Configure the cell...
        
        return cell!
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
