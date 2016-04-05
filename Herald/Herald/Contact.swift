//
//  Contact.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/3/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

class Contact {
    
    var name : String
    var number : String
    
    var list : [Contact]
    
    init(name: String, number: String, list: [Contact]) {
        self.name = name
        self.number = number
        self.list = list
    }
    
    func addContactToList(newContact: Contact) {
        list.append(newContact)
    }
    
}