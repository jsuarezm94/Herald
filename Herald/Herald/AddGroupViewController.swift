//
//  AddGroupViewController.swift
//  Herald
//
//  Created by Juan Tellez on 4/12/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit

class AddGroupViewController: UIViewController, UITextFieldDelegate {

    var groups: GroupList?
    
    @IBOutlet weak var groupNameTextField: UITextField!
    
    @IBAction func cancelButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func doneButton(sender: AnyObject) {
        
        if (groupNameTextField.text! == ""){
            
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            
            let group = Group(name: groupNameTextField.text!, members: [])
            groups?.addGroup(group)
            dismissViewControllerAnimated(true, completion: nil)
            saveGroups()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.groupNameTextField.delegate = self //allows dismissal of keyboard on return key press
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //dismisses keyboard on return key press
        self.view.endEditing(true)
        return false
    }
    
    
    func saveGroups() {
        NSKeyedArchiver.archiveRootObject(groups!, toFile: GroupList.archiveURL.path!)
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
