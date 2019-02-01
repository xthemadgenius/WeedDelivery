//
//  TrayViewCell.swift
//  WeedConnectMobile
//
//  Created by Javier J Calderon Jr on 1/22/19.
//  Copyright © 2019 Weed Connect. All rights reserved.
//

import UIKit

class TrayViewCell: UITableViewCell {

    @IBOutlet weak var lbQty: UILabel!
    @IBOutlet weak var lbProductName: UILabel!
    @IBOutlet weak var lbSubTotal: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        lbQty.layer.borderColor = UIColor.gray.cgColor
        lbQty.layer.borderWidth = 1
        lbQty.layer.cornerRadius = 10
    }

}
