/*
 @header NetCorePushTaskManager.h
 
 @brief This is the header file where my super-code is contained.
 
 NetCorePushTaskManager : -  use to setup all pushHandler event
 
 @author NetCore
 @copyright  2016 NetCore
 @version    2.1.5
 */
#import <Foundation/Foundation.h>
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

/*
  define protocol to return push notifcation deeplinking event
 */
@protocol NetCorePushTaskManagerDelegate<NSObject>
-(void)handleNotificationOpenAction:(NSDictionary *)userInfo DeepLinkType:(NSString *)strType;
@end

@interface NetCorePushTaskManager : NSObject

/*
 @Method sharedInstance:- use to return NetCorePushTaskManager manage class Object
 @param  -
 @return NetCorePushTaskManager instance
 */
+ (instancetype)sharedInstance;

/*
 delare delegate inorder support protocol delegation
 */
@property(nonatomic,weak) id <NetCorePushTaskManagerDelegate>delegate;

/*
  @Method handelApplicationLaunchEvent :- use to handle push notification open event when application not launched
 */
-(void)handelApplicationLaunchEvent:(id)launchOptions;

/*
 @Method didReceiveRemoteNotification :- use to handle push notification event (before ios 10)
 */
-(void)didReceiveRemoteNotification:(NSDictionary *)userInfo;

/*
 @Method didReceiveLocalNotification :- use to handle local notification event (before ios 10)
 */
-(void)didReceiveLocalNotification:(NSDictionary *)userInfo;

/*
 @Method userNotificationdidReceiveNotificationResponse :- use to manage notification tap/open event(onward ios 10)
 */
-(void)userNotificationdidReceiveNotificationResponse:(UNNotificationResponse *)response;

/*
 @Method userNotificationWillPresentNotification :- use to manage notification present event(onward ios 10)
 */
-(void)userNotificationWillPresentNotification:(UNNotification *)notification;


@end
