//
//  DriverOrder.swift
//  WeedConnectMobile
//
//  Created by Javier J Calderon Jr on 1/23/19.
//  Copyright © 2019 Weed Connect. All rights reserved.
//

import Foundation
import SwiftyJSON

class DriverOrder {
    
    var id: Int?
    var customerName: String?
    var customerAddress: String?
    var customerAvatar: String?
    var disensaryName: String?
    
    init(json: JSON) {
        
        self.id = json["id"].int
        self.customerName = json["customer"]["name"].string
        self.customerAddress = json["address"].string
        self.customerAvatar = json["customer"]["avatar"].string
        self.disensaryName = json["dispensary"]["name"].string
    }
    
}
