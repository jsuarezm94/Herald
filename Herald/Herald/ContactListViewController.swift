//
//  ContactListViewController.swift
//  Herald
//
//  Created by Juan Tellez on 4/5/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

protocol AddContactsViewControllerDelegate {
    func didFetchContacts(contacts: [CNContact])
}

class ContactListViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, CNContactPickerDelegate {
    
    var delegate: AddContactsViewControllerDelegate!
    
    
    func showContacts() {
        
        let contactPickerViewController = CNContactPickerViewController()
        
        //contactPickerViewController.predicateForEnablingContact = NSPredicate(format: "birthday != nil")
        contactPickerViewController.delegate = self
        
        presentViewController(contactPickerViewController, animated: true, completion: nil)
    }
    
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContact contact: CNContact) {
        delegate.didFetchContacts([contact])
        navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showContacts()
        
        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

