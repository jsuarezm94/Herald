//
//  GroupList.swift
//  Herald
//
//  Created by Juan Tellez on 4/12/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import Foundation

let groupEntrieskey = "groupEntries"

class GroupList: NSObject, NSCoding {
    
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
    
    func addGroupAtIndex(entry: Group, index: Int) {
        self.entries[index] = entry
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
    
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(entries, forKey: groupEntrieskey)
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let entries = aDecoder.decodeObjectForKey(groupEntrieskey) as! [Group]
        self.init(entries: entries)
    }
    
    
    //MARK: Archiving paths
    static let documentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first!
    static let archiveURL = documentsDirectory.URLByAppendingPathComponent("groups")
    
    
}