//
//  ProductViewCell.swift
//  WeedConnectMobile
//
//  Created by Javier J Caderon Jr on 1/20/19.
//  Copyright © 2019 Weed Connect. All rights reserved.
//

import UIKit

class ProductViewCell: UITableViewCell {

    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbProductShortDescription: UILabel!
    @IBOutlet weak var lbProductPrice: UILabel!
    @IBOutlet weak var imgProductImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

   
}
