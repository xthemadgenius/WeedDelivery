//
//  Dispensary.swift
//  WeedConnectMobile
//
//  Created by Javier J Calderon Jr on 1/20/19.
//  Copyright © 2019 Weed Connect. All rights reserved.
//

import Foundation
import SwiftyJSON

class Dispensary {
    
    var id: Int?
    var name: String?
    var address: String?
    var logo: String?
    
    init(json: JSON) {
        self.id = json["id"].int
        self.name = json["name"].string
        self.address = json["address"].string
        self.logo = json["logo"].string
    }
}
