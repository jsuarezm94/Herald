//
//  Contact.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/3/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

let contactNameKey = "contactName"
let numberKey = "contactNumber"

class Contact: NSObject, NSCoding {
    
    var contactName : String
    var number : String
    
    
    init(contactName: String, number: String) {
        self.contactName = contactName
        self.number = number
    }
    
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(contactName, forKey: contactNameKey)
        aCoder.encodeObject(number, forKey: numberKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let contactName = aDecoder.decodeObjectForKey(contactNameKey) as! String
        let number = aDecoder.decodeObjectForKey(numberKey) as! String
        self.init(contactName: contactName, number: number)
    }
    
}