//
//  AddGeotificationsTableViewController.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 3/31/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import MapKit
import ContactsUI

protocol AddGeotificationsViewControllerDelegate {
    func addGeotificationViewController(controller: AddGeotificationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D, radius: Double, identifier: String, note: String, eventType: EventType, recipients: [Contact])
}

class AddGeotificationViewController: UITableViewController, UITextFieldDelegate, CNContactPickerDelegate, DeletedRecipientDelegate {
    
    
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var zoomButton: UIBarButtonItem!
    
    @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var numberOfRecipientsLabel: UILabel!
    
    var myMessage : String?
    var geotificationRecipients = [Contact]()
    var contactNames = ""
    
    var delegate: AddGeotificationsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        navigationItem.rightBarButtonItems = [addButton, zoomButton]
        addButton.enabled = false

        self.noteTextField.text = myMessage
        
        tableView.tableFooterView = UIView()
        
        //allows dismissal of keyboard on return key press
        self.radiusTextField.delegate = self
        self.noteTextField.delegate = self
        
        self.addDoneButtonOnKeyboard()
    }
    
    // Add the done button to dismiss the numberpad keyboard
    func addDoneButtonOnKeyboard() {
        let doneToolBar: UIToolbar = UIToolbar(frame: CGRectMake(0,0,320,40))
        doneToolBar.barStyle = UIBarStyle.Default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Done, target: self, action: Selector("doneButtonAction"))
        
        var items = [AnyObject]()
        items.append(flexSpace)
        items.append(done)
        doneToolBar.items = items as! [UIBarButtonItem]
        
        self.radiusTextField.inputAccessoryView = doneToolBar
    }
    
    
    func doneButtonAction(){
        self.radiusTextField.resignFirstResponder()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        //repeating this code here to update recipient count when the user deletes recipients
        if (geotificationRecipients.count == 0) {
            numberOfRecipientsLabel.text = "0 Recipients Selected"
        } else if (geotificationRecipients.count == 1) {
            numberOfRecipientsLabel.text = "1 Recipient Selected"
        } else if (geotificationRecipients.count > 1) {
            numberOfRecipientsLabel.text = "\(geotificationRecipients.count) Recipients Selected"
        }
        
        if (geotificationRecipients.count>0 && radiusTextField.text != "" && noteTextField.text != "") {
            addButton.enabled = true
        } else {
            addButton.enabled = false
        }
    }
    
    @IBAction func contactsButton(sender: AnyObject) {
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
                geotificationRecipients.append(newContact)
                contactNames = contactNames + newContact.contactName + ""
            }
        }
        
        if (geotificationRecipients.count == 0) {
            numberOfRecipientsLabel.text = "0 Recipients Selected"
        } else if (geotificationRecipients.count == 1) {
            numberOfRecipientsLabel.text = "1 Recipient Selected"
        } else if (geotificationRecipients.count > 1) {
            numberOfRecipientsLabel.text = "\(geotificationRecipients.count) Recipients Selected"
        }
        
        if (geotificationRecipients.count>0 && radiusTextField.text != "" && noteTextField.text != "") {
            addButton.enabled = true
        } else {
            addButton.enabled = false
        }
        
    }
    
    func indexPathForDeletedRecipient(controller: RecipientListTableViewController, didDeleteRecipient position: Int) {
        geotificationRecipients.removeAtIndex(position)
    }
    
    @IBAction func textFieldEditingChanged(sender: UITextField) {
        addButton.enabled = !radiusTextField.text!.isEmpty && !noteTextField.text!.isEmpty && geotificationRecipients.count>0
    }

    @IBAction private func onAdd(sender: AnyObject) {
        self.noteTextField.resignFirstResponder()
        let coordinate = mapView.centerCoordinate
        let radius = (radiusTextField.text! as NSString).doubleValue
        let identifier = NSUUID().UUIDString
        let note = noteTextField.text
        let eventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? EventType.OnEntry : EventType.OnExit
        let recipients = geotificationRecipients
        
        Utilities.invokeAlertMethod("Compose Message", strBody: "Message has been successfully scheduled", delegate: self)
        
        delegate!.addGeotificationViewController(self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note!, eventType: eventType, recipients: recipients)
        
        self.resetInterface()
    }
    
    func resetInterface() {
        eventTypeSegmentedControl.selectedSegmentIndex = 0
        Utilities.zoomToUserLocationInMapView(mapView)
        noteTextField.text! = ""
        radiusTextField.text! = ""
        addButton.enabled = false
        geotificationRecipients = []
        numberOfRecipientsLabel.text = "0 Recipients Selected"
    }
    
    @IBAction private func onZoomToCurrentLocation(sender: AnyObject) {
        Utilities.zoomToUserLocationInMapView(mapView)
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let templatesVc = segue.destinationViewController as? MessageTemplatesTableViewController {
            templatesVc.flag = 1
        }
        
        if let destVC = segue.destinationViewController as? RecipientListTableViewController {
            destVC.recipients = geotificationRecipients
            destVC.deletedRecipientDelegate = self
        }
    }
    
    @IBAction func unwindWithSelectedMessage(segue:UIStoryboardSegue) {
        
        if let templateSelectionTableViewcontroller = segue.sourceViewController as? TemplateSelectionTableViewController {
            let selectedTemplate = templateSelectionTableViewcontroller.selectedMessage
            noteTextField.text = selectedTemplate
            
            if (geotificationRecipients.count>0 && radiusTextField.text != "") {
                addButton.enabled = true
            } else {
                addButton.enabled = false
            }
            
        }
        
        if let groupSelectionTableViewController = segue.sourceViewController as? GroupSelectionTableViewController {
            let selectedGroup = groupSelectionTableViewController.selectedGroup
            for contact in selectedGroup!.members {
                geotificationRecipients.append(contact)
            }
            if (noteTextField.text != "" && radiusTextField.text != "") {
                addButton.enabled = true
            } else {
                addButton.enabled = false
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //allows dismissal of keyboard on return key press
        self.view.endEditing(true)
        return false
    }

}
