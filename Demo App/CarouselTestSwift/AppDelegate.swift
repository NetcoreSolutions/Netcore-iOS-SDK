//
//  AppDelegate.swift
//  CarouselTestSwift
//
//  Created by Admin on 11/06/18.
//  Copyright © 2018 Manish Kumar. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import NetCorePush

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let appGroup = "group.com.Smartech.com"
        NetCoreSharedManager.sharedInstance().setUpAppGroup(appGroup)
        
        let netCore_AppID = "0e3164f1e0b5a556a372b5fc83a5d333"
        NetCoreSharedManager.sharedInstance().handleApplicationLaunchEvent(launchOptions, forApplicationId: netCore_AppID)
        
        //set up push delegate
        NetCorePushTaskManager.sharedInstance().delegate = self
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        // Register device token with third party SDK as per their document
        //Identity must be “”(blank) or as per Primary key which defined on smartech Panel
    NetCoreInstallation.sharedInstance().netCorePushRegisteration("manish.kumar@netcore.co.in", withDeviceToken: deviceToken) { (status) in }
        
        NetCoreSharedManager.sharedInstance()?.printDeviceToken()

    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]){

        NetCorePushTaskManager.sharedInstance().didReceiveRemoteNotification(userInfo)
        
    }
    // MARK: - didReceiveLocalNotification method
    func application(_ application: UIApplication, didReceive notification: UILocalNotification){
        NetCorePushTaskManager.sharedInstance().didReceiveLocalNotification(notification.userInfo)
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool{
        // handle URL link here
        return true
        
    }
    
    //Handle Action buttons here
    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        
        NetCorePushTaskManager.sharedInstance().handleAction(withIdentifier: identifier, forRemoteNotification: userInfo, withResponseInfo: responseInfo)
        
        completionHandler()

    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    // called when application is open when user click on notification
    @objc(userNotificationCenter:didReceiveNotificationResponse:withCompletionHandler :) @available(iOS 10.0, *)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        NetCorePushTaskManager.sharedInstance().userNotificationdidReceive(response)
    }
}

extension AppDelegate : NetCorePushTaskManagerDelegate{
    func handleNotificationOpenAction(_ userInfo: [AnyHashable : Any]!, deepLinkType strType: String!) {
        if strType.lowercased().contains ("smartechdeeplink"){
            // handle deep link here
            print("Deeplink received:\(strType)")
        }
    }
}

