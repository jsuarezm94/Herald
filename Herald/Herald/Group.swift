//
//  Group.swift
//  Herald
//
//  Created by Juan Tellez on 4/12/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

let nameKey = "name"
let memberKey = "member"

class Group: NSObject, NSCoding {
    
    var name: String
    var members : [Contact]
    
    init(name: String, members: [Contact]) {
        self.name = name
        self.members = members
    }
    
    
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(members, forKey: memberKey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        
        let name = aDecoder.decodeObjectForKey(nameKey) as! String
        var members = [Contact]()
        if let groupMembers = aDecoder.decodeObjectForKey(memberKey) as? [Contact] {
            members = groupMembers
        }
        self.init(name: name, members: members)
    }
}