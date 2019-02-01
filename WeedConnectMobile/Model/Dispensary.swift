//
//  Dispensary.swift
//  WeedConnectMobile
//
//  Created by user149258 on 1/20/19.
//  Copyright © 2019 Weed Coonect. All rights reserved.
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
