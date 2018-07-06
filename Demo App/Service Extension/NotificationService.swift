//
//  NotificationService.swift
//  Service Extension
//
//  Created by Admin on 11/06/18.
//  Copyright © 2018 Manish Kumar. All rights reserved.
//

import UserNotifications
import NetCorePush

class NotificationService: UNNotificationServiceExtension {

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        
        NetCoreNotificationService.sharedInstance().setUpAppGroup("group.com.Smartech.com")
        NetCoreNotificationService.sharedInstance().didReceive(request) { (contentToDeliver:UNNotificationContent) in
            contentHandler(contentToDeliver)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        NetCoreNotificationService.sharedInstance().serviceExtensionTimeWillExpire()
    }

}
