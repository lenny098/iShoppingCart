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
    
    @IBAction func doneButt(_ sender: Any) {
        let cleanAlert = UIAlertController(title: "Cleaning Alert", message: "Are you sure that you finished check-out?", preferredStyle: .alert)
        let cleanAction = UIAlertAction(title: "✓ Yes", style: .default){
            action in
            self.performSegue(withIdentifier: "backcart", sender: self)
            AppDelegate.shoppingCart.clear()
            print("Clearing Shopping Cart")
            self.saveCart()
        }
        let cancelAction = UIAlertAction(title: "✕ No", style: .default)
        cleanAlert.addAction(cleanAction)
        cleanAlert.addAction(cancelAction)
        
        present(cleanAlert, animated: true)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
