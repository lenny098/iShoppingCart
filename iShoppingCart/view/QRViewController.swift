//
//  QRViewController.swift
//  iShoppingCart
//
//  Created by Lenny on 10/12/2017.
//  Copyright © 2017 Group8. All rights reserved.
//

import UIKit

class QRViewController: UIViewController {
    @IBOutlet weak var qrView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        qrView.image = QRCodeGenerator.generate(shoppingCart: AppDelegate.shoppingCart)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
