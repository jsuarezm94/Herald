//
//  MessageTemplates.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/3/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

class MessageTemplates {

    var templatesArray : [Message]
    
    var count : Int {
        return templatesArray.count
    }
    
    init(templatesArray: [Message]) {
        self.templatesArray = templatesArray
    }
    
    func addCustomMessage(newMessage: Message) {
        templatesArray.append(newMessage)
    }
    
    
    
}