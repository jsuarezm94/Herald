//
//  MessageTemplates.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/3/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

class MessageTemplates {

    var messages : [String] = ["Got to the airport", "My plane just landed", "Leaving home now!", "Got to the restaurant", "Leaving the office"]
    
    init(messages: [String]) {
        self.messages = messages
    }
    
    func addCustomMessage(newMessage: String) {
        messages.append(newMessage)
    }
    
}