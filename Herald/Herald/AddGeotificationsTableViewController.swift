//
//  AddGeotificationsTableViewController.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 3/31/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

protocol AddGeotificationsViewControllerDelegate {
    func addGeotificationViewController(controller: AddGeotificationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D, radius: Double, identifier: String, note: String, eventType: EventType, recipients: [Contact])
}

class AddGeotificationViewController: UITableViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet var addButton: UIBarButtonItem!
    @IBOutlet var zoomButton: UIBarButtonItem!
    
    @IBOutlet weak var eventTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var radiusTextField: UITextField!
    @IBOutlet weak var noteTextField: UITextField!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var myMessage : String?
    var geotificationRecipients = [Contact]()
    
    var delegate: AddGeotificationsViewControllerDelegate!
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
        navigationItem.rightBarButtonItems = [addButton, zoomButton]
        addButton.enabled = false

        self.noteTextField.text = myMessage
        
        tableView.tableFooterView = UIView()
        
        //allows dismissal of keyboard on return key press
        self.radiusTextField.delegate = self
        self.noteTextField.delegate = self
        self.contactTextField.delegate = self
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
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
        let recipients = geotificationRecipients
        
        Utilities.invokeAlertMethod("Compose Message", strBody: "Message is scheduled for _________", delegate: self)
        
        delegate!.addGeotificationViewController(self, didAddCoordinate: coordinate, radius: radius, identifier: identifier, note: note!, eventType: eventType, recipients: recipients)
        
        self.resetInterface()
    }
    
    func resetInterface() {
        eventTypeSegmentedControl.selectedSegmentIndex = 0
        //let span = MKCoordinateSpanMake(0.075, 0.075)
        mapView.centerCoordinate = CLLocationCoordinate2D(latitude: 37.13283999999998, longitude: -95.785579999999996)
        //ZOOM
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
        
        if let templatesVc = segue.destinationViewController as? MessageTemplatesTableViewController {
            templatesVc.flag = 1
        }

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
