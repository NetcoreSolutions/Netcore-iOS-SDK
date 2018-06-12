/*
 @header NetCoreSharedManager.h
 
 @brief This is the header file where my super-code is contained.
 
   NetCoreSharedManager is singleton class use to setup application id and Application version
 
 @author NetCore
 @copyright  2016 NetCore
 @version    2.2.0
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*
 @class NetCoreSharedManager
 
 @brief The NetCoreSharedManager class
 
 @discussion
 NetCoreSharedManager is singleton class use to setup application id and Application version
 
 @superclass SuperClass: NSObject
 @classdesign    No special design is applied here.
 @helps It helps no other classes.
 @helper    No helper exists for this class.
 */
@interface NetCoreSharedManager : NSObject
/*
 @Method sharedInstance:- use to return NetCoreSharedManager manage class Object
 @return NetCoreSharedManager instance
 */
+ (instancetype)sharedInstance;
/*
 @Method setUpApplicationId: this method use to setup application id and Version
 @param  strApplicationId - contain applicatioId
 */
-(void)setUpApplicationId:(NSString *)strApplicationId;

/*
 @Method setDeviceToken: this method use to set device toekn
 @param  data - contain push device token data
 */
-(void)setDeviceToken:(NSData *)data;
/*
 @Method getDeviceToken: this method use to get device toekn
 @return - Data
 */
-(NSData *)getDeviceToken;
/*
 @Method setUpIdentity: this method use to setup identity  
 @param  strIdentity - contain strIdentity
 */
-(void)setUpIdentity:(NSString *)strIdentity;
/*
 @Method getIdentity: this method use to get user dentity
 @return - string
 */
-(NSString *)getIdentity;
/*
 @Method registerForPushNotifications: this method use to register for Push Notifications
 @return - void
 */
-(void)registerForPushNotifications;
/*
 @Method getNotifications: this method use to get all the Push Notifications received
 @return - Array
 */
-(NSArray *)getNotifications;
/*
 @Method handleApplicationLaunchEvent: this method use to handle App launch Events and Setting Application ID
 @return - void
 */
-(void)handleApplicationLaunchEvent:(id)launchOptions forApplicationId:(NSString *)AppId;
/*
 @Method setDeepLinkQueryParameters: this method use to set query parameters
 @param  notiData - contains query parameters of url
 */
-(void)setDeepLinkQueryParameters:(NSDictionary *)notiData;

/*
 @Method checkSessionId: this method checks for session id expiration and renews it.
 */
-(void)checkSessionId;

/*
 @Method addDeepLinkParametersInDict: adds deeplink parameters to every request.
 */

-(void)addDeepLinkParametersInDict:(NSMutableDictionary *)requestDict;




 @end
