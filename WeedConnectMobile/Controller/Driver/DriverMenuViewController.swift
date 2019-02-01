//
//  DriverMenuViewController.swift
//  WeedConnectMobile
//
//  Created by Javier J Calderon Jr on 1/23/19.
//  Copyright © 2019 Weed Coonect. All rights reserved.
//

import UIKit

class DriverMenuViewController: UITableViewController {

    @IBOutlet weak var imgAvatar: UIImageView!
    @IBOutlet weak var lbName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lbName.text = User.currentUser.name
        
        imgAvatar.image = try! UIImage(data: Data(contentsOf: URL(string: User.currentUser.pictureURL!)!))
        imgAvatar.layer.cornerRadius = 70 / 2
        imgAvatar.layer.borderWidth = 1.0
        imgAvatar.layer.borderColor = UIColor.white.cgColor
        imgAvatar.clipsToBounds = true
        
        view.backgroundColor = UIColor(red: 0.20, green: 1.00, blue: 0.11, alpha: 1.0)
        
    }

}
