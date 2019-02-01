//
//  Product.swift
//  WeedConnectMobile
//
//  Created by javier j Calderon Jr on 1/20/19.
//  Copyright © 2019 Weed Coonect. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product {
    
    var id: Int?
    var name: String?
    var short_description: String?
    var image: String?
    var price: Float?
    
    init(json: JSON) {
        
        self.id = json["id"].int
        self.name = json["name"].string
        self.short_description = json["short_description"].string
        self.image = json["image"].string
        self.price = json["price"].float
    }
}
