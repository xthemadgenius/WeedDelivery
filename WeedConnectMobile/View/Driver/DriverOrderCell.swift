//
//  DriverOrderCell.swift
//  WeedConnectMobile
//
//  Created by Javier J Calderon Jr on 1/23/19.
//  Copyright © 2019 Weed Connect. All rights reserved.
//

import UIKit

class DriverOrderCell: UITableViewCell {

    @IBOutlet weak var lbDispensaryName: UILabel!
    @IBOutlet weak var lbCustomerName: UILabel!
    @IBOutlet weak var lbCustomerAddress: UILabel!
    @IBOutlet weak var imgCustomerAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
