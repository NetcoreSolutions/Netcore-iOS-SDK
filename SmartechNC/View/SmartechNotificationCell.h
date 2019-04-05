/*
 @header SmartechNotificationCell.m
 @brief SmartechNotificationCell is responsible to show the individual cells in the notification center.
 @author    Netcore Solutions
 @copyright 2019 Netcore Solutions
 @version   1.0.0
 */

#import <UIKit/UIKit.h>
#import <NetCorePush/NetCorePush.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SmartechNotificationCellDelegate <NSObject>

-(void)didReceiveDeeplinkActionWith:(NSString *)deeplinkString userInfo:(NSDictionary *)userInfo;
-(void)didReceivePlayerClickEvent:(NSString *)mediaUrl;

@end

@interface SmartechNotificationCell : UITableViewCell <UIScrollViewDelegate>

#pragma mark - Variable Definition
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *richDataDisplayView;
@property (weak, nonatomic) IBOutlet UIView *carouselView;
@property (weak, nonatomic) IBOutlet UIPageControl *carouselPageControl;
@property (weak, nonatomic) IBOutlet UILabel *carouselTitle;
@property (weak, nonatomic) IBOutlet UILabel *carouselBody;
@property (strong, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UIView *interactionButtonViewHolder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *interactionButtonHeightConstraint;

@property (nonatomic) NSIndexPath *indexPath;
@property (nonatomic) NSInteger carouselPageIndex;

@property (strong, nonatomic) SMTNotification *notificationModel;
@property(weak, nonatomic) id<SmartechNotificationCellDelegate> delegate;

#pragma mark - Function Definition

- (void)updateTitleReadStatus;

@end

NS_ASSUME_NONNULL_END
