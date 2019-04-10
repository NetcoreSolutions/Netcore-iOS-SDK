/*
 @header SmartechNotificationCell.m
 @brief SmartechNotificationCell is responsible to show the individual cells in the notification center.
 @author    Netcore Solutions
 @copyright 2019 Netcore Solutions
 @version   1.0.1
 */

#import <UIKit/UIKit.h>
#import <NetCorePush/NetCorePush.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SmartechNotificationCellDelegate <NSObject>

-(void)didReceiveDeeplinkActionWith:(NSString *)deeplinkString userInfo:(NSDictionary *)userInfo;
-(void)didReceivePlayerClickEvent:(NSString *)mediaUrl;
- (void)didReceiveReadMoreButtonClickWith:(NSIndexPath *)indexPath;

@end

@interface SmartechNotificationCell : UITableViewCell <UIScrollViewDelegate>

#pragma mark - Variable Definition

@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) NSInteger carouselPageIndex;

@property (strong, nonatomic) SMTNotification *notificationModel;
@property(weak, nonatomic) id<SmartechNotificationCellDelegate> delegate;

#pragma mark - Function Definition

- (void)configureNotificationReadStatus;

@end

NS_ASSUME_NONNULL_END
