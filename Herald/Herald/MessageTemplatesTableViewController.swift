//
//  MessageTemplatesTableViewController.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/6/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit

class MessageTemplatesTableViewController: UITableViewController {

    //var templates : [String] = ["Got to the airport", "My plane just landed", "Leaving home now!", "Got to the restaurant", "Leaving the office"]
    
    var templates = [Message]()
    var templatesList = MessageTemplates(templatesArray: [Message]())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let message1 = Message(messageText: "Got to the airport")
        let message2 = Message(messageText: "My plane just landed")
        let message3 = Message(messageText: "Leaving home now")
        let message4 = Message(messageText: "Got to the restaurant")
        let message5 = Message(messageText: "Leaving the office")
        let message6 = Message(messageText: "Leaving the party")
        
        templatesList.addCustomMessage(message1)
        templatesList.addCustomMessage(message2)
        templatesList.addCustomMessage(message3)
        templatesList.addCustomMessage(message4)
        templatesList.addCustomMessage(message5)
        templatesList.addCustomMessage(message6)

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
        return templatesList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("templateCell", forIndexPath: indexPath)

        // Configure the cell...
        
        //let template = templates[indexPath.row]
        //cell.textLabel?.text = template.messageText
        
        let message = templatesList.templatesArray[indexPath.row] as Message
        cell.textLabel?.text = message.messageText
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let newMessageTemplateViewController = segue.destinationViewController as? AddMessageTemplateViewController {
            newMessageTemplateViewController.templatesList = templatesList
        }
    }
 
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}
