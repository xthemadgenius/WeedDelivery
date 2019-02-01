//
//  ProductDetailsViewController.swift
//  WeedConnectMobile
//
//  Created by Javier J Calderon Jr on 1/17/19.
//  Copyright © 2019 Weed Coonect. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbProductShortDescription: UILabel!
    
    @IBOutlet weak var lbTotal: UILabel!
    @IBOutlet weak var lbQty: UILabel!
    
    var product: Product?
    var dispensary: Dispensary?
    var qty = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProduct()
    }
   
    func loadProduct() {
        
        if let price = product?.price{
            lbTotal.text = "$\(price)"
        }
        
        lbProductName.text = product?.name
        lbProductShortDescription.text = product?.short_description
        
        if let imageURL = product?.image {
            Helpers.loadImage(imgProduct, "\(imageURL)")
        }
    }
    
    @IBAction func addToTray(_ sender: Any) {
        
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        image.image = UIImage(named: "button_weed")
        image.center = CGPoint(x: self.view.frame.width/2, y: self.view.frame.height-100)
        self.view.addSubview(image)
        
        UIView.animate(withDuration: 1.0,
                       delay: 0.0,
                       options: UIView.AnimationOptions.curveEaseOut,
                       animations: { image.center = CGPoint(x: self.view.frame.width - 40, y: 24) },
                       completion: { _ in
                
            image.removeFromSuperview()
            
            let trayItem = TrayItem(product: self.product!, qty: self.qty)
                        
            guard let trayDispensary = Tray.currentTray.dispensary, let currentDispensary = self.dispensary else {
                // If those requirements are not met
                
                Tray.currentTray.dispensary = self.dispensary
                Tray.currentTray.items.append(trayItem)
                return
            }
                        
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
                        
            // if ordering product from the same dispensary
            if trayDispensary.id == currentDispensary.id {
                
                let inTray = Tray.currentTray.items.lastIndex(where: { (item) -> Bool in
                    
                    return item.product.id! == trayItem.product.id!
                })
                
                if let index = inTray {
                    
                    let alertView = UIAlertController(
                        title: "Add more?",
                        message: "Your tray already had this product. Do you want to add more?",
                        preferredStyle: .alert)
                    
                    let okAction = UIAlertAction(title: "Add more", style: .default, handler: { (action: UIAlertAction!) in
                        
                        Tray.currentTray.items[index].qty += self.qty
                    })
                    
                    alertView.addAction(okAction)
                    alertView.addAction(cancelAction)
                    
                    self.present(alertView, animated: true, completion: nil)
                } else {
                    Tray.currentTray.items.append(trayItem)
                }
                            
            }
            else {// if ordering product from another dispensary
               
                let alertView = UIAlertController(
                    title: "Start a new tray?",
                    message: "You're ordering a product from another dispensary. Would you like to clear the current tray?",
                    preferredStyle: .alert)
                
                let okAction = UIAlertAction(title: "New Tray", style: .default, handler: { (action: UIAlertAction!) in
                    
                    Tray.currentTray.items = []
                    Tray.currentTray.items.append(trayItem)
                    Tray.currentTray.dispensary = self.dispensary
                })
                
                alertView.addAction(okAction)
                alertView.addAction(cancelAction)
                
                self.present(alertView, animated: true, completion: nil)
            }
                        
                        
        })
    }
    
    @IBAction func removeQty(_ sender: Any) {
        
        if qty >= 2 {
            qty -= 1
            lbQty.text = String(qty)
            
            if let price = product?.price {
                lbTotal.text = "$\(price * Float(qty))"
            }
        }
    }
    
    @IBAction func addQty(_ sender: Any) {
        
        if qty < 99 {
            
            qty += 1
            lbQty.text = String(qty)
            
            if let price = product?.price {
                lbTotal.text = "$\(price * Float(qty))"
            }
        }
    }
}
