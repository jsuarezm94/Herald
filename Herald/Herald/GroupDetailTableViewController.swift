//
//  GroupDetailTableViewController.swift
//  Herald
//
//  Created by Juan Tellez on 4/12/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


protocol AddedContactsDelegate {
    func groupModifiedAddedContacts(controller: GroupDetailTableViewController, didAddGroup group: Group)
}

protocol RemovedContactsDelegate {
    func groupModifiedRemovedContacts(controller: GroupDetailTableViewController, didRemoveGroup group: Group)
}


class GroupDetailTableViewController: UITableViewController, CNContactPickerDelegate {

    var group: Group?
    var addedContactsDelegate: AddedContactsDelegate?
    var removedContactsDelegate: RemovedContactsDelegate?
    
    
    @IBAction func addMember(sender: AnyObject) {
        let controller = CNContactPickerViewController()
        controller.delegate = self
        
        controller.predicateForEnablingContact = NSPredicate(format: "phoneNumbers.@count > 0", argumentArray: nil)
        navigationController?.presentViewController(controller, animated: true, completion: nil)
    }
    
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContacts contacts: [CNContact]) {
        
        let formatter = CNContactFormatter()
        
        for contact in contacts {
            if let stuff = contact.phoneNumbers[0].value as? CNPhoneNumber {
                let number = stuff.valueForKey("digits") as! String
                let newContact = Contact(contactName: formatter.stringFromContact(contact)!, number: number)
                group?.members.append(newContact)
            }
        }
        
        addedContactsDelegate!.groupModifiedAddedContacts(self, didAddGroup: group!)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if let table = self.view as? UITableView {
            table.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return group!.members.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupMemberCell", forIndexPath: indexPath)
        
        
        cell.textLabel!.text = group?.members[indexPath.row].contactName
        cell.detailTextLabel!.text = group?.members[indexPath.row].number
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
        
            tableView.beginUpdates()
            group?.members.removeAtIndex(indexPath.row)  // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.endUpdates()
            
            removedContactsDelegate!.groupModifiedRemovedContacts(self, didRemoveGroup: group!)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
