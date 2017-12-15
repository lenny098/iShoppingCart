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
        update()
    }
    
    @IBAction func addProduct(_ sender: UIButton) {
        AppDelegate.shoppingCart.addProduct(product: product!)
        update()
    }

    func update() {
        let count = AppDelegate.shoppingCart.getCount(product: self.product!)
        if count > 0 {
            UIView.transition(with: countLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {self.countLabel.text = String(count)}, completion: nil)
            UIView.transition(with: totalPriceLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {self.totalPriceLabel.text = String(format:"$ %5.1f", (self.product?.price)! * Double(count))}, completion: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTotal"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadList"), object: nil)
        }
        else
        {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTotal"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadCart"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadList"), object: nil)
        }
    }
}
