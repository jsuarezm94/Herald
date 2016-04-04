//
//  Message.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/3/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

class Message {
    
    var messageText : String
    var messageContact : Contact
    
    init(messageText: String, messageContact: Contact) {
        self.messageText = messageText
        self.messageContact = messageContact
    }
    
}