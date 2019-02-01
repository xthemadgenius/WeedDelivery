//
//  ProductListTableViewController.swift
//  WeedConnectMobile
//
//  Created by Javier J Calderon Jr on 1/16/19.
//  Copyright © 2019 Weed Coonect. All rights reserved.
//

import UIKit

class ProductListTableViewController: UITableViewController {
    
    var dispensary: Dispensary?
    var products = [Product]()
    
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dispensaryName = dispensary?.name {
            self.navigationItem.title = dispensaryName
        }
        
        loadProducts()

    }
    
    func loadProducts() {
        
        Helpers.showActivityIndicator(activityIndicator,view)
        
        if let dispensaryId = dispensary?.id {
            
            APIManager.shared.getProducts(dispensaryId: dispensaryId, completionHandler: { (json) in
                
                if json != nil {
                   self.products = []
                    
                    if let tempProducts = json["products"].array {
                        
                        for item in tempProducts {
                            let product = Product(json: item)
                            self.products.append(product)
                        }
                        
                        self.tableView.reloadData()
                        Helpers.hideActivityIndicator(self.activityIndicator)
                    }
                }
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ProductDetails" {
            let controller = segue.destination as! ProductDetailsViewController
            controller.product = products[(tableView.indexPathForSelectedRow?.row)!]
            controller.dispensary = dispensary
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! ProductViewCell
        
        let product = products[indexPath.row]
        cell.lbProductName.text = product.name
        cell.lbProductShortDescription.text = product.short_description
        
        if let price = product.price {
            cell.lbProductPrice.text = "$\(price)"
        }
        
        if let image = product.image {
            Helpers.loadImage(cell.imgProductImage, "\(image)")
        }
        
        return cell
    }

}
