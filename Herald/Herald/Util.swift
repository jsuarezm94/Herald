//
//  Util.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 3/31/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit

class Util : NSObject {
    
    class func invokeAlertMethod(strTitle: String, strBody: String, delegate: AnyObject?) {
        let alert: UIAlertView = UIAlertView()
        alert.message = strBody
        alert.title = strTitle
        alert.delegate = delegate
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
}
