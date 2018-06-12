/*
 @header NetCoreNotificationService.h
 @brief This is the header file where my super-code is contained.
 NetCoreNotificationService : - use to provides the entry point for a Notification Service
 
 @author NetCore
 @copyright  2018 NetCore
 @version    2.2.0
 */

#import <UserNotifications/UserNotifications.h>
#import <UserNotifications/UNNotificationContent.h>
#import <UserNotificationsUI/UserNotificationsUI.h>
#import <UIKit/UIKit.h>

@interface NetCoreNotificationService : UNNotificationServiceExtension
/*
 @Method sharedInstance:- use to return NetCoreNotificationService manage class Object
 @return NetCoreNotificationService instance
 */
+ (instancetype)sharedInstance;
/*
 @Method contentViewDidLoad :- use to load the view controller for Carousel Push Notification.
 */
-(void)contentViewDidLoad:(UIView *)customView;
/*
 @Method didReceiveNotification :- use to call the notification to be displayed on the extension for Carousel Push Notification.
 */
-(void)didReceiveNotification:(UNNotification *)notification;
/*
 @Method didReceiveNotificationResponse :- use to call when the user taps on one of the notification action buttons. The completion handler can be called
     after handling the action to dismiss the notification and forward the
     action to the app if necessary for Carousel Push Notification.
 */
-(void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption))completion;

@end

