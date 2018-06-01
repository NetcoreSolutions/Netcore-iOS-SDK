/*
 @header NetCoreInstallation.h
 
 @brief This is the header file where my super-code is contained.
 
 NetCoreInstallation : -use to setup all network communication methods
 
 @author NetCore
 @copyright  2016 NetCore
 @version    2.1.5
 */
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NetCoreConstant.h"
@interface NetCoreInstallation : NSObject

/*
 @Method sharedInstance:- use to return NetCoreSharedManager manage class Object
 @return NetCoreSharedManager instance
 */
+(instancetype)sharedInstance;
/*
 netCorePushRegisteration return response block
 */
-(void)netCorePushRegisteration:(NSString *)strIdentity Block:(NetCoreStatusBlock)block;
/*
 netCorePushLogin taking input as Identity and return response block
 */
-(void)netCorePushLogin:(NSString *)strIdentity Block:(NetCoreStatusBlock)block;
/*
 netCorePushLogout taking input as Identity and return response block
 */
-(void)netCorePushLogout:(NetCoreStatusBlock)block;
/*
 netCoreProfilePush taking input as Identity and custom payload and return response block
 */
-(void)netCoreProfilePush:(NSString *)strIdentity Payload:(NSDictionary *)payload Block:(NetCoreStatusBlock)block;

/*
 netCoreProfilePush taking input as Identity and custom payload and devicetoken and return response block
 */
-(void)netCorePushRegisteration:(NSString *)strIdentity withDeviceToken:(NSData *)deviceToken Block:(NetCoreStatusBlock)block;

@end
