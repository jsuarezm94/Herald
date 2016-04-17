//
//  AppDelegate.swift
//  Herald
//
//  Created by Jose Alberto Suarez on 3/25/16.
//  Copyright © 2016 Jose Suarez. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {
    
    var window: UIWindow?
    
    let locationManager = CLLocationManager() // Add this statement
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        locationManager.delegate = self                // Add this line
        locationManager.requestAlwaysAuthorization()   // And this one

        //application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: [.Sound, .Alert, .Badge], categories: nil))
        UIApplication.sharedApplication().cancelAllLocalNotifications()
        
        if let tabBarController = window?.rootViewController as? UITabBarController,
        let nav1 = tabBarController.viewControllers![0] as? UINavigationController,
        let mapVc = nav1.topViewController as? GeotificationsViewController,
        let nav2 = tabBarController.viewControllers![1] as? UINavigationController,
        let createVc = nav2.topViewController as? AddGeotificationViewController {
            createVc.delegate = mapVc
        }
        
        //self.localNotificationSettings()
        
        return true
    }

 
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func handleRegionEvent(region: CLRegion!) {
        // Show an alert if application is active
        if UIApplication.sharedApplication().applicationState == .Active {
            if let message = notefromRegionIdentifier(region.identifier) {
                if let viewController = window?.rootViewController {
                    Utilities.showSimpleAlertWithTitle(nil, message: message, viewController: viewController)
                }
            }
        } else {
            // Otherwise present a local notification
            let notification = UILocalNotification()
            notification.alertBody = notefromRegionIdentifier(region.identifier)
            notification.soundName = "Default"
            //notification.alertAction = "Send"
            //notification.category = "geotifyCategory"
            notification.alertAction = "Send"
            notification.category = "messageCategory"
            UIApplication.sharedApplication().presentLocalNotificationNow(notification)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region: CLRegion!) {
        if region is CLCircularRegion {
            handleRegionEvent(region)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region: CLRegion!) {
        if region is CLCircularRegion {
            handleRegionEvent(region)
        }
    }
    
    /*
    func application(application: UIApplication, didRegisterUserNotificationSettings notificationSettings: UIUserNotificationSettings) {
        
        //print(notificationSettings.types.rawValue)
    }
    */
    /*
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        // Do something serious in a real app.
        print("Received Local Notification:")
        print(notification.alertBody)
    }
    */
    /*
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        if identifier == "sendMessage" {
            NSNotificationCenter.defaultCenter().postNotificationName("sendMessageNotification", object: nil)
        }
        else if identifier == "cancelMessage" {
            NSNotificationCenter.defaultCenter().postNotificationName("cancelMessageNotification", object: nil)
        }
        
        completionHandler()
    }
    */
    /*
    func localNotificationSettings() {
        let notificationSettings: UIUserNotificationSettings! = UIApplication.sharedApplication().currentUserNotificationSettings()
        
        //Check if the settings have already been set, otherwise, set them
        //if notificationSettings.types == .None {
            
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
            
            //Set up the two different contexts
            let defaultActions = [sendMessageAction, cancelMessageAction]
            let minimalActions = [sendMessageAction, cancelMessageAction]
            
            //Set up the category
            //This is only useful if you have multiple categories, but it is necessary every time
            let geotifyCategory = UIMutableUserNotificationCategory()
            geotifyCategory.identifier = "geotifyCateogry"
            geotifyCategory.setActions(defaultActions, forContext: .Default)
            geotifyCategory.setActions(minimalActions, forContext: .Minimal)
            
            // Register the notification settings.
            let newNotificationSettings = UIUserNotificationSettings(forTypes: [.Alert, .Sound, .Badge], categories: Set([geotifyCategory]))
            UIApplication.sharedApplication().registerUserNotificationSettings(newNotificationSettings)
        //}
        
    }
    */
    
    func application(application: UIApplication, handleActionWithIdentifier identifier: String?, forLocalNotification notification: UILocalNotification, completionHandler: () -> Void) {
        
        if identifier == "sendMessage" {
            NSNotificationCenter.defaultCenter().postNotificationName("sendMessageNotification", object: nil)
        }
        else if identifier == "cancelMessage" {
            NSNotificationCenter.defaultCenter().postNotificationName("cancelMessageNotification", object: nil)
        }
        
        completionHandler()
    }
    
    func notefromRegionIdentifier(identifier: String) -> String? {
        if let savedItems = NSUserDefaults.standardUserDefaults().arrayForKey(kSavedItemsKey) {
            for savedItem in savedItems {
                if let geotification = NSKeyedUnarchiver.unarchiveObjectWithData(savedItem as! NSData) as? Geotification {
                    if geotification.identifier == identifier {
                        return geotification.note
                    }
                }
            }
        }
        return nil
    }
    
}




