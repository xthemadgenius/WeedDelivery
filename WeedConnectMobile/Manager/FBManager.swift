//
//  FBManager.swift
//  WeedConnectMobile
//
//  Created by user149258 on 1/18/19.
//  Copyright © 2019 Weed Coonect. All rights reserved.
//

import Foundation
import FBSDKLoginKit
import SwiftyJSON

class FBManager {
    
    static let shared = FBSDKLoginManager()
    
    public class func getFBUserData(completionHandler: @escaping () -> Void) {
        
        if (FBSDKAccessToken.current() != nil) {
            
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, email, picture.type(normal)"]).start(completionHandler: { (connection, result, error) in
                
                if (error == nil) {
                    
                    let json = JSON(result!)
                    print(json)
                    
                    User.currentUser.setInfo(json: json)
                    
                    completionHandler()
                }
            })
        }
    }
}
