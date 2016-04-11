//
//  MessageTemplatesTableViewController.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/6/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit


class MessageTemplatesTableViewController: UITableViewController {

    var templates = [String]()
    var templatesList = MessageTemplates(templatesArray: [String]())
    
    let kArray = "messageTemplates"
    
    var selectedMessage : String = ""
    var myMessageTemplate : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        loadAllMessages()

    }
    
    func loadAllMessages() {
        templatesList.templatesArray = []

        if let savedItems = NSUserDefaults.standardUserDefaults().objectForKey(kArray) as? [String] {
            for savedItem in savedItems {
                if let messageToAdd = savedItem as? String {
                    templatesList.addCustomMessage(messageToAdd)
                }
            }
        } else {
            
            let message1 = "Got to the airport"
            let message2 = "My plane just landed"
            let message3 = "Leaving home now"
            let message4 = "Got to the restaurant"
            let message5 = "Leaving the office"
            let message6 = "Leaving the party"
            
            templatesList.addCustomMessage(message1)
            templatesList.addCustomMessage(message2)
            templatesList.addCustomMessage(message3)
            templatesList.addCustomMessage(message4)
            templatesList.addCustomMessage(message5)
            templatesList.addCustomMessage(message6)
        }
    }
    
    func loadList(notification: NSNotification){
        //load data here
        self.tableView.reloadData()
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
        let message = templatesList.templatesArray[indexPath.row] as String
        cell.textLabel?.text = message
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //let createVc = self.presentingViewController as? AddGeotificationViewController
        selectedMessage = self.templatesList.templatesArray[indexPath.row]
        
        myMessageTemplate = self.templatesList.templatesArray[indexPath.row]
        //createVc?.myMessage = message
        //print(createVc?.myMessage)
        //createVc?.noteTextField.text! = message
        
        //createVc?.addButton.enabled = true
        self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
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
        
        
        if segue.identifier == "saveSelectedMessage" {
            if let cell = sender as? UITableViewCell {
                let indexPath = tableView.indexPathForCell(cell)
                if let index = indexPath?.row {
                    myMessageTemplate = templatesList.templatesArray[index]
                }
            }
        }
        
        
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

}
