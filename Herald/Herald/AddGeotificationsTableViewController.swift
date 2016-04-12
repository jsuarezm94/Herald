//
//  AddGeotificationsTableViewController.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 3/31/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import MapKit

protocol AddGeotificationsViewControllerDelegate {
    func addGeotificationViewController(controller: AddGeotificationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D,
        radius: Double, identifier: String, note: String, eventType: EventType)
}

class AddGeotificationViewController: UITableViewController, UITextFieldDelegate {
    
    
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var zoomButton: UIBarButtonItem!
    
    @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var myMessage : String?
    
    var delegate: AddGeotificationsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItems = [addButton, zoomButton]
        addButton.enabled = false

        self.noteTextField.text = myMessage
        
        tableView.tableFooterView = UIView()
        
        //allows dismissal of keyboard on return key press
        self.radiusTextField.delegate = self
        self.noteTextField.delegate = self
        self.contactTextField.delegate = self
    }
    
    @IBAction func textFieldEditingChanged(sender: UITextField) {
        addButton.enabled = !radiusTextField.text!.isEmpty && !noteTextField.text!.isEmpty
    }

    @IBAction private func onAdd(sender: AnyObject) {
        self.noteTextField.resignFirstResponder()
        let coordinate = mapView.centerCoordinate
        let radius = (radiusTextField.text! as NSString).doubleValue
        let identifier = NSUUID().UUIDString
        let note = noteTextField.text
        let eventType = (eventTypeSegmentedControl.selectedSegmentIndex == 0) ? EventType.OnEntry : EventType.OnExit
        
        Utilities.invokeAlertMethod("Compose Message", strBody: "Message is scheduled for _________", delegate: self)
        
        delegate!.addGeotificationViewController(self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note!, eventType: eventType)
        
        self.resetInterface()
    }
    
    func resetInterface() {
        eventTypeSegmentedControl.selectedSegmentIndex = 0
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 37.13283999999998, longitude: -95.785579999999996)
        noteTextField.text! = ""
        radiusTextField.text! = "100"
        addButton.enabled = false

    }
    
    @IBAction private func onZoomToCurrentLocation(sender: AnyObject) {
        Utilities.zoomToUserLocationInMapView(mapView)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

    }
    
    @IBAction func unwindWithSelectedMessage(segue:UIStoryboardSegue) {
        if let messageTemplatesTableViewController = segue.sourceViewController as? MessageTemplatesTableViewController {
            noteTextField.text = messageTemplatesTableViewController.selectedMessage
            addButton.enabled = true
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {   //allows dismissal of keyboard on return key press
        self.view.endEditing(true)
        return false
    }

}
