//
//  MessageTemplates.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/3/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

class MessageTemplates {

    var templatesArray : [String]
    
    var count : Int {
        return templatesArray.count
    }
    
    init(templatesArray: [String]) {
        self.templatesArray = templatesArray
    }

    func addCustomMessage(newMessage: String) {
        templatesArray.append(newMessage)
    }
    
    
    
}