 /*
 @header NetCoreAppTracking.h
 
 @brief This is the header file where my super-code is contained.
 
 NetCoreAppTracking : - use to setup all event communication methods
 
 @author NetCore
 @copyright  2016 NetCore
 @version    2.1.5
 */
#import <Foundation/Foundation.h>
#import "NetCoreConstant.h"

@interface NetCoreAppTracking : NSObject
/*
 @Method sharedInstance:- use to return NetCoreAppTracking manage class Object
 @return NetCoreAppTracking instance
 */
+ (instancetype)sharedInstance;


/*
  sendAppTrackingEvent takes event and return response block
 */
-(void)sendAppTrackingEvent:(NSInteger)event Block:(NetCoreStatusBlock)block;

/*
 sendAppTrackingEventWithCustomPayload takes event and custom payload and return response block
 */
-(void)sendAppTrackingEventWithCustomPayload:(NSInteger)event Payload:(NSMutableArray *)payload Block:(NetCoreStatusBlock)block;
@end
