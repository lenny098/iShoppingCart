//
//  CartTableViewController.swift
//  iShoppingCart
//
//  Created by Lenny on 9/12/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import UIKit

class CartTableViewController: UITableViewController {
    @IBOutlet weak var checkoutPriceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCart), name: NSNotification.Name(rawValue: "reloadCart"), object: nil)
        
        checkoutPriceLabel.text = String(format:"Total: $ %.1f", AppDelegate.shoppingCart.getTotalPrice())

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @objc func reloadCart() {
        self.tableView.reloadData()
        checkoutPriceLabel.text = String(format:"Total: $ %.1f", AppDelegate.shoppingCart.getTotalPrice())
    }
    
    @IBAction func unwindToCart(sender: UIStoryboardSegue)
    {
        AppDelegate.shoppingCart.clear()
        checkoutPriceLabel.text = String(format:"Total: $ %.1f", AppDelegate.shoppingCart.getTotalPrice())
        self.tableView.reloadData()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadList"), object: nil)
        print("Clearing Shopping Cart")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return AppDelegate.shoppingCart.getProducts().count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as? CartTableViewCell
        let product = AppDelegate.shoppingCart.getProducts()[indexPath.row]
        
        cell?.product = product
        
        cell?.nameLabel.text = product.name
        print("Cart cell namelabel: \(String(describing: cell?.nameLabel.text!))")
        cell?.priceLabel.text = String(format:"$ %5.1f", product.price)
        let count = AppDelegate.shoppingCart.getCount(product: product)
        cell?.countLabel.text = String(format:"%3d", count)
        cell?.totalPriceLabel.text = String(format:"$ %5.1f", product.price * Double(count))
        
        if let coupon = product.coupon, AppDelegate.shoppingCart.getActivatedDiscount(product: product) > 0
        {
            cell?.discountNameLabel.text = coupon.name
            cell?.discountPriceLabel.text = String(format:"$ %5.1f", coupon.discount)
            let discountCount = AppDelegate.shoppingCart.getActivatedDiscount(product: product)
            cell?.discountCountLabel.text = String(format:"%3d", discountCount)
            cell?.totalDiscountLabel.text = String(format:"$ %5.1f", coupon.discount * Double(discountCount))
            
            cell?.discountNameLabel.isHidden = false
            cell?.discountPriceLabel.isHidden = false
            cell?.discountCountLabel.isHidden = false
            cell?.totalDiscountLabel.isHidden = false
        }
        else
        {
            cell?.discountNameLabel.isHidden = true
            cell?.discountPriceLabel.isHidden = true
            cell?.discountCountLabel.isHidden = true
            cell?.totalDiscountLabel.isHidden = true
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
