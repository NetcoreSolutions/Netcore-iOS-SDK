/*
 @header NetCoreSharedManager.h
 
 @brief NetCoreSharedManager is singleton class use to setup application id and Application version
 
 @author Netcore Solutions
 @copyright  2019 Netcore Solutions
 @version    2.5.9 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "NCNotification.h"
#import "Smartech.h"
#import "SMTBoxxRequest.h"

NS_ASSUME_NONNULL_BEGIN

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
- (void)setUpApplicationId:(NSString *)strApplicationId;

/*
 @Method setDeviceToken: this method use to set device toekn
 @param  data - contain push device token data
 */
- (void)setDeviceToken:(NSString *)deviceTokenString;
/*
 @Method getDeviceToken: this method is used to get device token
 @return - String
 */
- (NSString *)getDeviceToken;
/*
 @Method getGUID: this method is used to get device unique identity
 @return - String
 */
- (NSString *)getGUID;
/*
 @Method setUpIdentity: this method use to setup identity  
 @param  strIdentity - contain strIdentity
 */
- (void)setUpIdentity:(NSString *)strIdentity;
/*
 @Method getIdentity: this method use to get user dentity
 @return - string
 */
- (NSString *)getIdentity;
/*
 @Method getNotifications: this method will return latest 10 Push Notifications received
 @return - Array
 */
- (NSArray *)getNotifications;
/*
 @Method handleApplicationLaunchEvent: this method use to handle App launch Events and Setting Application ID
 @return - void
 */
- (void)handleApplicationLaunchEvent:(_Nullable id)launchOptions forApplicationId:(NSString *)AppId;
/*
 @Method setDeepLinkQueryParameters: this method use to set query parameters
 @param  notiData - contains query parameters of url
 */
- (void)setDeepLinkQueryParameters:(NSDictionary *)notiData;
/*
 @Method resetSession: this method resets the session for the user.
 */
- (void)resetSession;

/*
 @Method setUpAppGroup: this method use to setup app groups
 @param  appGroup - contain appGroup string. Usually, group.<your-bundle-identifier>. eg., group.com.CompanyName.productName
 */
- (void)setUpAppGroup:(NSString *)appGroup;
/*
 @Method optOut: this method is used to opt for Data Protection Laws.
 @param  optFlag - If it is True, then it will stop processing user's events and user will not receive any kind of Push/InApp Notifications from Panel. Default Value is False.
 */
- (void)optOut:(BOOL)optFlag;
/*
@Method getOptOutStatus: this method is used get the status of GDPR compliance.
@return - BOOL
*/
- (BOOL)getOptOutStatus;
/*
 @Method printDeviceToken: this method is used to print device token.
 */
- (void)printDeviceToken;
/*!
 @Method The method will export all the keys which were accidently saved to NSUserDefault:initWithSuit provided the value exits.
 */
- (void)getAppGroupDataToUserDefault:(NSArray <NSString *> *)allKeys;

/*!
 @Method clearIdentity : The method will clear previously stored user's identity locally.
 */
- (void)clearIdentity;

/*!
 @Method getNotificationsWithCount: this method will return latest Push Notifications received
 @param  count - This will be the number of latest received Push Notifications to be fetched
 @return - NSArray
 */
- (NSArray *)getNotificationsWithCount:(NSInteger )count;

- (NSUInteger)getUnreadNotificationsCount;

- (void)setAssociateDomain:(NSArray *)associateDomain;

/*!
@Method setDebugLevel: this method will return set debug levels
@param level The debug level to set. Below are the values you can use to set the debug level.
 
 NC_LOG_LEVEL_VERBOSE  - enables all logging.
 NC_LOG_LEVEL_DEBUG - enables verbose debug logging.
 NC_LOG_LEVEL_INFO - enables minimal information related to SDK integration.
 NC_LOG_LEVEL_WARN - enables warning information related to SDK integration.
 NC_LOG_LEVEL_ERROR - enables errorn information related to SDK integration.
 NC_LOG_LEVEL_FATAL - enables crash information related to SDK integration.
 NC_LOG_LEVEL_NONE - turns off all SDK logging.
 */

- (void)setDebugLevel:(NCLogLevel)level;

/*!
 @Method setDebugLevel: this method will be used for default(boxx) Boxx recommendation.
 @param boxxRequest This model structure will create the boxx request.
 */
- (void)getReco:(SMTBoxxRequest *)boxxRequest withCompletionBlock:(BoxxAPICompletionBlock)completion;

/*!
@Method setDebugLevel: this method will be used for best seller Boxx recommendation.
@param boxxRequest This model structure will create the boxx request.
*/
- (void)getBestSellerReco:(SMTBoxxRequest *)boxxRequest withCompletionBlock:(BoxxAPICompletionBlock)completion;

/*!
@Method setDebugLevel: this method will be used for trending Boxx recommendation.
@param boxxRequest This model structure will create the boxx request.
*/
- (void)getTrendingReco:(SMTBoxxRequest *)boxxRequest withCompletionBlock:(BoxxAPICompletionBlock)completion;

/*!
@Method setDebugLevel: this method will be used for recently viewed Boxx recommendation.
@param boxxRequest This model structure will create the boxx request.
*/
- (void)getRecentlyViewedReco:(SMTBoxxRequest *)boxxRequest withCompletionBlock:(BoxxAPICompletionBlock)completion;

/*!
@Method setDebugLevel: this method will be used for new products Boxx recommendation.
@param boxxRequest This model structure will create the boxx request.
*/
- (void)getNewProductsReco:(SMTBoxxRequest *)boxxRequest withCompletionBlock:(BoxxAPICompletionBlock)completion;

/*
 @Method getNotificationsWithCount: this method will return count based of on notification status such as NCStatusRead, NCStatusUnread and NCStatusAll.
 @param  limit - This will be the number of latest received Push Notifications to be fetched.
 @param  notificationStatus - This will be the status of notification for which the count is expected.
 @return - NSUInteger
 */
- (NSUInteger)getNotificationsWithCount:(NSUInteger)limit withFilterStatus:(NCStatus)notificationStatus;


NS_ASSUME_NONNULL_END

 @end
