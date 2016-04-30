//
//  GroupListTableViewController.swift
//  Herald
//
//  Created by Juan Tellez on 4/12/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit

class GroupListTableViewController: UITableViewController, AddedContactsDelegate, RemovedContactsDelegate {

    let newGroupSegueIdentifier = "newGroup"
    let groupDetailSegueIdentifier = "groupDetail"
    var groups: GroupList = GroupList(entries: [])
    
    
    
    func groupModifiedAddedContacts(controller: GroupDetailTableViewController, didAddGroup group: Group) {
        let indexPath = self.tableView.indexPathForSelectedRow
        groups.addGroupAtIndex(group, index: indexPath!.row)
        saveGroups()
    }
    
    func groupModifiedRemovedContacts(controller: GroupDetailTableViewController, didRemoveGroup group: Group) {
        let indexPath = self.tableView.indexPathForSelectedRow
        groups.addGroupAtIndex(group, index: indexPath!.row)
        saveGroups()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if let savedGroups = loadGroups() {
            groups = savedGroups
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        if let table = self.view as? UITableView {
            table.reloadData()
        }
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
        return groups.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == newGroupSegueIdentifier {
            if let destVC = segue.destinationViewController as? AddGroupViewController {
                destVC.groups = self.groups
            }
        } else if segue.identifier == groupDetailSegueIdentifier {
            if let destVC = segue.destinationViewController as? GroupDetailTableViewController,
                cell = sender as? UITableViewCell,
                indexPath = self.tableView.indexPathForCell(cell),
                entry = groups.entry(indexPath.row) {
                destVC.group = entry
                destVC.addedContactsDelegate = self
                destVC.removedContactsDelegate = self
            }
        }
    }
    

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath)
        
        if let label = cell.textLabel,
            entry = groups.entry(indexPath.row) {
            label.text = entry.name
            label.font = UIFont(name: "Avenir", size: 16)
        }
        
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
            groups.removeObject(indexPath.row) // Delete the row from the data source
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade) //delete row from view
            tableView.endUpdates()
            
            saveGroups()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    
    
    //MARK: NSCoding
    
    //save the groups--just the groups, not the contacts in each
    func saveGroups() {
        NSKeyedArchiver.archiveRootObject(groups, toFile: GroupList.archiveURL.path!)
    }
    
    //load the groups
    func loadGroups() -> GroupList? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(GroupList.archiveURL.path!) as? GroupList
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
