//
//  MessageViewController.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 3/31/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import MessageUI

class MessageViewController: UIViewController, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var messageContent: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendMessage(sender: UIButton) {
        
        shareiMessage()
        
    }

    func shareiMessage()
    {
        let controller: MFMessageComposeViewController=MFMessageComposeViewController()
        if(MFMessageComposeViewController.canSendText())
        {
            controller.body = messageContent.text
            
            let sendTo : [String]? = ["7088376127"]
            
            controller.recipients = sendTo
                        
            controller.delegate=self
            controller.messageComposeDelegate=self
            self.presentViewController(controller, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Text messaging is not available", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult)
    {
        switch result.rawValue
        {
        case MessageComposeResultCancelled.rawValue:
            Utilities.invokeAlertMethod("Warning", strBody: "Message cancelled", delegate: self)
        case MessageComposeResultFailed.rawValue:
            Utilities.invokeAlertMethod("Warning", strBody: "Message failed", delegate: self)
        case MessageComposeResultSent.rawValue:
            Utilities.invokeAlertMethod("Success", strBody: "Message sent", delegate: self)
        default:
            Utilities.invokeAlertMethod("Warning", strBody: "error", delegate: self)
        }
        self.dismissViewControllerAnimated(false, completion: nil)
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
