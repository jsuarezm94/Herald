//
//  Util.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 3/31/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import MapKit
import MessageUI

class Utilities : NSObject, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        
    }
    
    class func invokeAlertMethod(strTitle: String, strBody: String, delegate: AnyObject?) {
        let alert: UIAlertView = UIAlertView()
        alert.message = strBody
        alert.title = strTitle
        alert.delegate = delegate
        alert.addButtonWithTitle("Ok")
        alert.show()
    }
    
    
    class func showSimpleAlertWithTitle(title: String!, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: "Dismiss reminder", style: .Default, handler: {
            (alert: UIAlertAction!) in print("IN SEND HANDLER")
            //let sendAction = UIAlertAction(title: "blah", style: .Cancel, handler: { (alert: UIAlertAction) in
//            let compose = RTF_BLACKHOLE
//            alert.presentingViewController.dismissViewController(true)
            
            
        //})
            /* THIS IS WHERE I HAVE TO CALL iMESSAGE FUNCTION */
            
            /* HOW TO GET THE RIGHT GEOTIFICATION TO PREPOPULATE THE FIELDS? */
            
            /* MUST DELETE THE GEOTIFICAITON ONCE THE USER HANDLES THE NOTIFICATION */
        })
        //let action2 = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
        //    (alert: UIAlertAction!) in print("IN CANCEL HANDLER")
            /* HOW TO GET THE RIGHT GEOTIFICATION? */
            
            /* MUST DELETE THE GEOTIFICAITON ONCE THE USER HANDLES THE NOTIFICATION */
        //})
        alert.addAction(action)
        //alert.addAction(action2)
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func zoomToUserLocationInMapView(mapView: MKMapView) {
        if let coordinate = mapView.userLocation.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 10000, 10000)
            mapView.setRegion(region, animated: true)
        }
    }
    
}
