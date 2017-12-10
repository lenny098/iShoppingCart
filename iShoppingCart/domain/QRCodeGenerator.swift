//
//  QRCodeGenerator.swift
//  iShoppingCart
//
//  Created by Lenny on 16/11/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import Foundation
import UIKit

class QRCodeGenerator
{
    static func generate(shoppingCart: ShoppingCart) -> UIImage?
    {
        var cartString = ""
        
        for product in shoppingCart.getProducts() {
            cartString += String(product.id) + "=" + String(shoppingCart.getCount(product: product)) + "&"
        }
        
        let data = cartString.data(using: String.Encoding.ascii)
        
        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 5, y: 5)
            
            if let output = filter.outputImage?.transformed(by: transform)
            {
                return UIImage(ciImage: output)
            }
            
        }
        return nil
    }
}
