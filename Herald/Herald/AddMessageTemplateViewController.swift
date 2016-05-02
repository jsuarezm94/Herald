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
    
    @IBOutlet weak var newMessageTemplateText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelMessage(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)

    }

    @IBAction func saveMessage(sender: AnyObject) {
        let newMessage = newMessageTemplateText.text!
        templatesList?.addCustomMessage(newMessage)
        
        NSUserDefaults.standardUserDefaults().setObject(templatesList?.templatesArray, forKey: "messageTemplates")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        dismissViewControllerAnimated(true, completion: nil)
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
