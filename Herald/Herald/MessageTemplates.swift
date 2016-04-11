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
    //var newTemplatesArray : [Message]
    
    var count : Int {
        return templatesArray.count
        //return templatesArray.count + newTemplatesArray.count
    }
    
    //init(templatesArray: [Message], newTemplatesArray: [Message]) {
    init(templatesArray: [String]) {
        self.templatesArray = templatesArray
        //self.newTemplatesArray = newTemplatesArray
    }
    /*
    func addOriginalMessage(newMessage: Message) {
        templatesArray.append(newMessage)
    }
    */
    func addCustomMessage(newMessage: String) {
        templatesArray.append(newMessage)
    }
    
    
    
}