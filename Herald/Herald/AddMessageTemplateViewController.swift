//
//  AddMessageTemplateViewController.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 4/7/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit

class AddMessageTemplateViewController: UIViewController {

    var templatesList : MessageTemplates?
    
    @IBOutlet weak var messageText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelMessage(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveMessage(sender: UIBarButtonItem) {
        let newMessage = Message(messageText: messageText.text!)
        templatesList?.addCustomMessage(newMessage)
        
        //NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
        
        //let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        //defaults.setObject([console!.complete, console!.favorite], forKey: console!.consoleID)
        //defaults.setObject(newMessage, forKey:  "\(templatesList!.count)")
        //defaults.synchronize()
        
        navigationController?.popViewControllerAnimated(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
