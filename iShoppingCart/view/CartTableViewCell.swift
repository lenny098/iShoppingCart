//
//  CartTableViewCell.swift
//  iShoppingCart
//
//  Created by Lenny on 9/12/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import UIKit

class CartTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var discountNameLabel: UILabel!
    @IBOutlet weak var discountPriceLabel: UILabel!
    @IBOutlet weak var discountCountLabel: UILabel!
    @IBOutlet weak var totalDiscountLabel: UILabel!
    
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func removeProduct(_ sender: UIButton) {
        AppDelegate.shoppingCart.removeProduct(product: product!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadCart"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadList"), object: nil)
    }
    
    @IBAction func addProduct(_ sender: UIButton) {
        AppDelegate.shoppingCart.addProduct(product: product!)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadCart"), object: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadList"), object: nil)
    }
}
