//
//  File.swift
//  WeedConnectMobile
//
//  Created by user149258 on 1/21/19.
//  Copyright © 2019 Weed Coonect. All rights reserved.
//

import Foundation

class TrayItem {
    
    var product: Product
    var qty: Int
    
    init(product: Product, qty: Int) {
        self.product = product
        self.qty = qty
    }
}

class Tray {
    
    static let currentTray = Tray()
    
    var dispensary: Dispensary?
    var items = [TrayItem]()
    var address: String?
    
    func getTotal() -> Float {
        var total: Float = 0
        
        for item in self.items {
            total = total + Float(item.qty) * item.product.price!
        }
        
        return total
    }
    
    func reset() {
        self.dispensary = nil
        self.items = []
        self.address = nil
    }
}
