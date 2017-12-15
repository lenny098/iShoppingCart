//
//  ProductTableViewCell.swift
//  iShoppingCart
//
//  Created by Lenny on 7/12/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var discountLabel: UILabel!
    
    var product: Product?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addToCart(_ sender: UIButton)
    {
        AppDelegate.shoppingCart.addProduct(product: product!)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadCart"), object: nil)
        saveCart()
        
        UIView.transition(with: countLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {self.countLabel.text = String(AppDelegate.shoppingCart.getCount(product: self.product!))}, completion: nil)
    }
    
    @IBAction func delItem(_ sender: UIButton) {
        AppDelegate.shoppingCart.removeProduct(product: product!)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadCart"), object: nil)
        saveCart()
        
        UIView.transition(with: countLabel, duration: 0.5, options: .transitionFlipFromBottom, animations: {self.countLabel.text = String(AppDelegate.shoppingCart.getCount(product: self.product!))}, completion: nil)
    }
    
    private func saveCart()
    {
        let successful = NSKeyedArchiver.archiveRootObject(AppDelegate.shoppingCart, toFile: (ShoppingCart.ArchiveURL?.path)!)
        if successful
        {
            print("Saved")
        }
        else
        {
            print("Saving Failed")
        }
    }
}
