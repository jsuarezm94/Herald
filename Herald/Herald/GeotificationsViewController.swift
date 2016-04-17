//
//  GeotificationsViewController.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 3/31/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
//import MessageUI

let kSavedItemsKey = "savedItems"

class GeotificationsViewController: UIViewController, AddGeotificationsViewControllerDelegate, MKMapViewDelegate, CLLocationManagerDelegate, UINavigationControllerDelegate { //MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var geotifications = [Geotification]()
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1
        locationManager.delegate = self
        // 2
        locationManager.requestAlwaysAuthorization()
        // 3
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "sendMessage", name: "sendMessageNotification", object: nil)
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "cancelMessage", name: "cancelMessageNotification", object: nil)
        
        loadAllGeotifications()
        
        setupNotificationSettings()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleSendMessageNotification", name: "sendMessageNotification", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "handleCancelMessageNotification", name: "cancelMessageNotification", object: nil)


    }
    
    func handleSendMessageNotification() {
        print("send message button")
    }
    
    func handleCancelMessageNotification() {
        print("cancel message button")
    }
    
    func setupNotificationSettings() {
        // Specify the notification types.
        var notificationTypes: UIUserNotificationType = [UIUserNotificationType.Alert, UIUserNotificationType.Sound]
        
        //Set up notification actions
        let sendMessageAction = UIMutableUserNotificationAction()
        sendMessageAction.identifier = "sendMessage"
        sendMessageAction.title = "Send"
        sendMessageAction.activationMode = .Foreground
        sendMessageAction.destructive = false
        sendMessageAction.authenticationRequired = true
        
        let cancelMessageAction = UIMutableUserNotificationAction()
        cancelMessageAction.identifier = "cancelMessage"
        cancelMessageAction.title = "Cancel"
        cancelMessageAction.activationMode = .Background
        cancelMessageAction.destructive = true
        cancelMessageAction.authenticationRequired = false
        
        let actionsArray = NSArray(objects: sendMessageAction, cancelMessageAction)
        let actionsArrayMinimal = NSArray(objects: sendMessageAction, cancelMessageAction)
        
        // Specify the category related to the above actions.
        var messageCategory = UIMutableUserNotificationCategory()
        messageCategory.identifier = "messageCategory"
        messageCategory.setActions(actionsArray as! [UIUserNotificationAction], forContext: UIUserNotificationActionContext.Default)
        messageCategory.setActions(actionsArrayMinimal as! [UIUserNotificationAction], forContext: UIUserNotificationActionContext.Minimal)

        let categoriesForSettings = NSSet(objects: messageCategory)

        // Register the notification settings.
        let newNotificationSettings = UIUserNotificationSettings(forTypes: notificationTypes, categories: categoriesForSettings as! Set<UIUserNotificationCategory>)
        UIApplication.sharedApplication().registerUserNotificationSettings(newNotificationSettings)
    }
    
    /*
    override func viewDidAppear(animated: Bool) {
        loadAllGeotifications()
        updateGeotificationsCount()
    }
    */
    /*
    func sendMessage() {
        print("SEND")
        self.shareiMessage()
    }
    
    func cancelMessage() {
        print("Cancel")
    }
    
    func shareiMessage()
    {
        let controller: MFMessageComposeViewController=MFMessageComposeViewController()
        if(MFMessageComposeViewController.canSendText())
        {
            controller.body = "TEST"
            
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
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let outboxListTableViewController = segue.destinationViewController as? OutboxMessagesTableViewController {
            outboxListTableViewController.geotificationsList = geotifications
        }
        
    }
    
    // MARK: Loading and saving functions
    
    func loadAllGeotifications() {
        geotifications = []
        
        if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(kSavedItemsKey) {
            for savedItem in savedItems {
                if let geotification = NSKeyedUnarchiver.unarchiveObjectWithData(savedItem as! NSData) as? Geotification {
                    addGeotification(geotification)
                }
            }
        }
    }
    
    func saveAllGeotifications() {
        let items = NSMutableArray()
        for geotification in geotifications {
            let item = NSKeyedArchiver.archivedDataWithRootObject(geotification)
            items.addObject(item)
        }
        NSUserDefaults.standardUserDefaults().setObject(items, forKey: kSavedItemsKey)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    // MARK: Functions that update the model/associated views with geotification changes
    
    func addGeotification(geotification: Geotification) {
        geotifications.append(geotification)
        mapView.addAnnotation(geotification)
        addRadiusOverlayForGeotification(geotification)
        updateGeotificationsCount()
    }
    
    func removeGeotification(geotification: Geotification) {
        if let indexInArray = geotifications.indexOf(geotification) {
            geotifications.removeAtIndex(indexInArray)
        }
        
        mapView.removeAnnotation(geotification)
        removeRadiusOverlayForGeotification(geotification)
        updateGeotificationsCount()
    }
    
    func updateGeotificationsCount() {
        title = "Outbox (\(geotifications.count))"
        navigationItem.rightBarButtonItem?.enabled = (geotifications.count < 20)  // Add this line
    }
    
    // MARK: AddGeotificationViewControllerDelegate
    
    func addGeotificationViewController(controller: AddGeotificationViewController, didAddCoordinate coordinate: CLLocationCoordinate2D, radius: Double, identifier: String, note: String, eventType: EventType) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        // 1
        let clampedRadius = (radius > locationManager.maximumRegionMonitoringDistance) ? locationManager.maximumRegionMonitoringDistance : radius
        
        let geotification = Geotification(coordinate: coordinate, radius: clampedRadius, identifier: identifier, note: note, eventType: eventType)
        addGeotification(geotification)
        // 2
        startMonitoringGeotification(geotification)
        
        saveAllGeotifications()
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView! {
        let identifier = "myGeotification"
        if annotation is Geotification {
            var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier) as? MKPinAnnotationView
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
                let removeButton = UIButton(type: .Custom)
                removeButton.frame = CGRect(x: 0, y: 0, width: 23, height: 23)
                removeButton.setImage(UIImage(named: "DeleteGeotification")!, forState: .Normal)
                annotationView?.leftCalloutAccessoryView = removeButton
            } else {
                annotationView?.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer! {
        if overlay is MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.lineWidth = 1.0
            circleRenderer.strokeColor = UIColor.redColor()
            circleRenderer.fillColor = UIColor.redColor().colorWithAlphaComponent(0.4)
            return circleRenderer
        }
        return nil
    }
    
    func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        // Delete geotification
        let geotification = view.annotation as! Geotification
        stopMonitoringGeotification(geotification)   // Add this statement
        removeGeotification(geotification)
        saveAllGeotifications()
    }
    
    // MARK: Map overlay functions
    
    func addRadiusOverlayForGeotification(geotification: Geotification) {
        mapView?.addOverlay(MKCircle(centerCoordinate: geotification.coordinate, radius: geotification.radius))
    }
    
    func removeRadiusOverlayForGeotification(geotification: Geotification) {
        // Find exactly one overlay which has the same coordinates & radius to remove
        if let overlays = mapView?.overlays {
            for overlay in overlays {
                if let circleOverlay = overlay as? MKCircle {
                    let coord = circleOverlay.coordinate
                    if coord.latitude == geotification.coordinate.latitude && coord.longitude == geotification.coordinate.longitude && circleOverlay.radius == geotification.radius {
                        mapView?.removeOverlay(circleOverlay)
                        break
                    }
                }
            }
        }
    }
    
    // MARK: Other mapview functions
    
    @IBAction func zoomToCurrentLocation(sender: AnyObject) {
        Utilities.zoomToUserLocationInMapView(mapView)
    }
    
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        mapView.showsUserLocation = (status == .AuthorizedAlways)
    }
    
    func regionWithGeotification(geotification: Geotification) -> CLCircularRegion {
        // 1
        let region = CLCircularRegion(center: geotification.coordinate, radius: geotification.radius, identifier: geotification.identifier)
        // 2
        region.notifyOnEntry = (geotification.eventType == .OnEntry)
        region.notifyOnExit = !region.notifyOnEntry
        return region
    }
    
    func startMonitoringGeotification(geotification: Geotification) {
        // 1
        if !CLLocationManager.isMonitoringAvailableForClass(CLCircularRegion) {
            Utilities.showSimpleAlertWithTitle("Error", message: "Geofencing is not supported on this device!", viewController: self)
            return
        }
        // 2
        if CLLocationManager.authorizationStatus() != .AuthorizedAlways {
            Utilities.showSimpleAlertWithTitle("Warning", message: "Your geotification is saved but will only be activated once you grant Geotify permission to access the device location.", viewController: self)
        }
        // 3
        let region = regionWithGeotification(geotification)
        // 4
        locationManager.startMonitoringForRegion(region)
    }
    
    func stopMonitoringGeotification(geotification: Geotification) {
        for region in locationManager.monitoredRegions {
            if let circularRegion = region as? CLCircularRegion {
                if circularRegion.identifier == geotification.identifier {
                    locationManager.stopMonitoringForRegion(circularRegion)
                }
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
        print("Monitoring failed for region with identifier: \(region.identifier)")
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Location Manager failed with the following error: \(error)")
    }
    
    
}
