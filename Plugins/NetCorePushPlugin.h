/*
 @header NetCorePushPlugin.h
 
 @brief This is the header file where all Cordova functions are written.
 
 NetCorePushPlugin : - use to setup all Cordova communication methods
 
 @author NetCore
 @copyright  2018 NetCore
 @version    2.2.1
 */

#import <Cordova/CDVPlugin.h>
@interface NetCorePushPlugin : CDVPlugin

/*
 sendInAppActivity takes event and return response block
 */
-(void)sendInAppActivity:(CDVInvokedUrlCommand *)command;
/*
 pushLogin taking input as Identity and return response block
 */
-(void)pushLogin:(CDVInvokedUrlCommand *)command;
/*
 pushLogout taking input as Identity and return response block
 */
-(void)pushLogout:(CDVInvokedUrlCommand *)command;
/*
 profilePush taking input as Identity and custom payload and return response block
 */
-(void)profilePush:(CDVInvokedUrlCommand *)command;
/*
 @Method setUpIdentity: this method use to setup identity
 @param  strIdentity - contain strIdentity
 */
-(void)setUpIdentity:(CDVInvokedUrlCommand *)command;
/*
 @Method setUpApplicationId: this method use to setup application id and Version
 @param  strApplicationId - contain applicatioId
 */
-(void)setUpApplicationId:(CDVInvokedUrlCommand *)command;
/*
 netCorePushRegisteration return response block
 */
-(void)pushRegisteration:(CDVInvokedUrlCommand *)command;
/*
 @Method getNotifications: this method use to get all the Push Notifications received
 @return - Array
 */
-(NSArray *)getNotifications;

@end
