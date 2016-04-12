//
//  Group.swift
//  Herald
//
//  Created by Juan Tellez on 4/12/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

class Group {
    
    var name: String
    var members : [Contact]
    
    init(name: String, members: [Contact]) {
        self.name = name
        self.members = members
    }
}