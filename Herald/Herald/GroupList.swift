//
//  GroupList.swift
//  Herald
//
//  Created by Juan Tellez on 4/12/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

class GroupList {
    
    var entries: [Group]
    
    init(entries: [Group]) {
        self.entries = entries
    }
    
    var count: Int {
        return entries.count
    }
    
    func addGroup(entry: Group) {
        entries.append(entry)
    }
    
    func entry(index: Int) -> Group? {
        if index >= 0 && index < count {
            return entries[index]
        }
        else {
            return nil
        }
    }
    
    func removeObject(index: Int) -> Group? {
        return entries.removeAtIndex(index)
    }
}