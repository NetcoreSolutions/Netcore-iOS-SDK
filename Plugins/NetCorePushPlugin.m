/*
 @header NetCorePushPlugin.m
 NetCorePushPlugin : - use to setup all Cordova communication methods
 
 @author NetCore
 @copyright  2018 NetCore
 @version    2.2.4

 */
#import "NetCorePushPlugin.h"
#import <NetCorePush/NetCorePush.h>
@implementation NetCorePushPlugin

-(void)sendInAppActivity:(CDVInvokedUrlCommand *)command {
    
    if ([command.arguments count]>0){
        NSInteger activityType= [[command.arguments objectAtIndex:0] integerValue];
        id activityMetaData = nil;
        if ([command.arguments count]>1){
            activityMetaData = [command.arguments objectAtIndex:1];
        }
        [[NetCoreAppTracking    sharedInstance]sendAppTrackingEventWithCustomPayload:activityType Payload:activityMetaData Block:^(NSInteger statusCode) {
        }];
    }
}
-(void)pushLogin:(CDVInvokedUrlCommand *)command{
    
    if ([command.arguments count]>0){
        NSString *strId = [command.arguments objectAtIndex:0];
        if (strId != nil){
            [[NetCoreInstallation sharedInstance]netCorePushLogin:strId Block:^(NSInteger statusCode) {
            }];
        }
    }
}
-(void)pushLogout:(CDVInvokedUrlCommand *)command{
    
    [[NetCoreInstallation sharedInstance]netCorePushLogout:^(NSInteger statusCode) {
    }];
}

-(void)profilePush:(CDVInvokedUrlCommand *)command{
    
    if ([command.arguments count]>0){
        NSString *strId = [command.arguments objectAtIndex:0];
        id activityMetaData = nil;
        if ([command.arguments count]>1){
            activityMetaData = [command.arguments objectAtIndex:1];
        }
        [[NetCoreInstallation sharedInstance]netCoreProfilePush:strId Payload:activityMetaData Block:^(NSInteger statusCode) {
         }];
    }
}

-(void)setUpIdentity:(CDVInvokedUrlCommand *)command{
    
    if ([command.arguments count]>0){
        NSString *strIdentity = [command.arguments objectAtIndex:0];

        [[NetCoreSharedManager sharedInstance] setUpIdentity:strIdentity];

    }
}

-(void)setUpApplicationId:(CDVInvokedUrlCommand *)command{
    
    if ([command.arguments count]>0){
        NSString *strAppID = [command.arguments objectAtIndex:0];

        [[NetCoreSharedManager sharedInstance] setUpApplicationId:strAppID];
    }
}

-(void)pushRegisteration:(CDVInvokedUrlCommand *)command{
    
    if ([command.arguments count]>0){
        NSString *strIdentity = [command.arguments objectAtIndex:0];
        
        [[NetCoreInstallation sharedInstance] netCorePushRegisteration:strIdentity Block:^(NSInteger statusCode) {
        }];
    }
}

-(NSArray *)getNotifications {
    return [[NetCoreSharedManager sharedInstance] getNotifications];
}

@end
