//
//  Util.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 3/31/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import MapKit

class Utilities : NSObject {
    
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
        })
        alert.addAction(action)
        viewController.presentViewController(alert, animated: true, completion: nil)
    }
    
    class func zoomToUserLocationInMapView(mapView: MKMapView) {
        if let coordinate = mapView.userLocation.location?.coordinate {
            let region = MKCoordinateRegionMakeWithDistance(coordinate, 8000, 8000)
            mapView.setRegion(region, animated: true)
        }
    }
    
}
