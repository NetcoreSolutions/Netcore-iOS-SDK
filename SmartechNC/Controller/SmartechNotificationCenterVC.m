/*
 @header SmartechNotificationCenterVC.m
 @brief SmartechNotificationCenterVC is responsible to show notification center.
 @author    Netcore Solutions
 @copyright 2019 Netcore Solutions
 @version   1.0.1
*/

#import "SmartechNotificationCenterVC.h"
#import "SmartechNotificationCell.h"

#import <NetCorePush/NetCorePush.h>
#import <AVKit/AVKit.h>

// Constants
NSString *const kTextCellIdentifier = @"smtTextCell";
NSString *const kImageCellIdentifier = @"smtImageCell";
NSString *const kVideoCellIdentifier = @"smtVideoCell";
NSString *const kGifCellIdentifier = @"smtGifCell";
NSString *const kAudioCellIdentifier = @"smtAudioCell";
NSString *const kCarouselCellIdentifier = @"smtCarouselCell";
NSString *const kSmartechNavTitle = @"Notification Center";
NSString *const kSmartechEmptyNotificationImage = @"smartech-empty";


@interface SmartechNotificationCenterVC () <UITableViewDataSource, UITableViewDelegate, SmartechNotificationCellDelegate> {
    NSMutableArray <SMTNotification*> *notificationArray;
}

@property (weak, nonatomic) IBOutlet UITableView *notificationTableView;

@end

@implementation SmartechNotificationCenterVC

#pragma mark - View Lifecyle

- (void)viewDidLoad {
    [super viewDidLoad];
    notificationArray = [[SMTNotification getNotifications] mutableCopy];
    [self setupUI];
}


#pragma mark - User Defined Methods

// Setting the initial UI when the user comes to notification center screen.
- (void)setupUI {
    self.title = kSmartechNavTitle;
    [self handleEmptyNotification];
    [self configuringTableView];
}

- (void)handleEmptyNotification {
    if (notificationArray.count == 0 ) {
        UIImageView *emptyImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
        emptyImageView.center = self.view.center;
        emptyImageView.contentMode = UIViewContentModeCenter;
        emptyImageView.image = [UIImage imageNamed:kSmartechEmptyNotificationImage];
        [self.view addSubview:emptyImageView];
        self.navigationItem.rightBarButtonItem = nil;
    } else {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
        [self configureBarEditButton];
    }
}

- (void)configuringTableView {
    _notificationTableView.delegate = self;
    _notificationTableView.dataSource = self;
    _notificationTableView.estimatedRowHeight = 252.0;
    _notificationTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    _notificationTableView.rowHeight = UITableViewAutomaticDimension;
    _notificationTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)configureBarEditButton {
    if ([self.editButtonItem.title.lowercaseString containsString:@"edit"]) {
        self.editButtonItem.title = @"Delete";
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    [self configureBarEditButton];

    if (_notificationTableView.indexPathsForSelectedRows.count > 0 && _notificationTableView.editing) {
        NSInteger selectedNotificationCount = _notificationTableView.indexPathsForSelectedRows.count;
        NSString *confirmationAlertMessage = [NSString stringWithFormat:@"Are you sure you want to delete %@", [NSString stringWithFormat:selectedNotificationCount == 1 ? @"this notification?" : @"%ld notifications?", (long)selectedNotificationCount]];
        [self handleDeleteNotificationAlert:confirmationAlertMessage];
    } else {
        [_notificationTableView reloadData];
        [self.notificationTableView setEditing:editing animated:animated];
    }
}

- (void)handleDeleteNotificationAlert:(NSString *)confirmationAlertMessage {
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:confirmationAlertMessage preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.notificationTableView reloadData];
        [self.notificationTableView setEditing:false animated:true];
    }];
    UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        NSSortDescriptor* sortOrder = [NSSortDescriptor sortDescriptorWithKey: @"self" ascending: NO];
        NSArray <NSString *> *trids = [NSArray new];
        for (NSIndexPath *index in [self.notificationTableView.indexPathsForSelectedRows sortedArrayUsingDescriptors: [NSArray arrayWithObject: sortOrder]]) {
            trids = [trids arrayByAddingObject:self->notificationArray[index.row].trid];
            [self->notificationArray removeObjectAtIndex:index.row];
        }
        [[NetCorePushTaskManager sharedInstance] deleteNotification:trids];
        [self handleEmptyNotification];
        [self.notificationTableView reloadData];
        [self.notificationTableView setEditing:false animated:true];
    }];
    [alert addAction:noButton];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)sendOpenNotification:(NSDictionary *)userInfo andAutoHandleDeeplink:(BOOL)shouldHandle {
    [[NetCorePushTaskManager sharedInstance] markNotificationAsRead:userInfo autoHandleDeeplink:shouldHandle];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return notificationArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SmartechNotificationCell *cell;
    if (notificationArray[indexPath.row].mediaType == SMTMediaTypeText) {
        cell = [tableView dequeueReusableCellWithIdentifier:kTextCellIdentifier forIndexPath:indexPath];
    } else if (notificationArray[indexPath.row].mediaType == SMTMediaTypeCarousel) {
        cell = [tableView dequeueReusableCellWithIdentifier:kCarouselCellIdentifier forIndexPath:indexPath];
    } else if (notificationArray[indexPath.row].mediaType == SMTMediaTypeAudio) {
        cell = [tableView dequeueReusableCellWithIdentifier:kAudioCellIdentifier forIndexPath:indexPath];
    } else if (notificationArray[indexPath.row].mediaType == SMTMediaTypeVideo) {
        cell = [tableView dequeueReusableCellWithIdentifier:kVideoCellIdentifier forIndexPath:indexPath];
    } else if (notificationArray[indexPath.row].mediaType == SMTMediaTypeGif) {
        cell = [tableView dequeueReusableCellWithIdentifier:kGifCellIdentifier forIndexPath:indexPath];
    } else {
        cell = [tableView dequeueReusableCellWithIdentifier:kImageCellIdentifier forIndexPath:indexPath];
    }
    if (tableView.editing) {
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    } else {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.notificationModel = notificationArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!tableView.editing) {
        [self sendOpenNotification:notificationArray[indexPath.row].userInfo andAutoHandleDeeplink:true];
        notificationArray[indexPath.row].isNotificationRead = true;
        SmartechNotificationCell *cell = [_notificationTableView cellForRowAtIndexPath:indexPath];
        [cell configureNotificationReadStatus];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return true;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSArray <NSString *> *trid = [NSArray arrayWithObject:self->notificationArray[indexPath.row].trid];
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Confirmation" message:@"Are you sure you want to delete this notification?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *noButton = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:nil];
        UIAlertAction *yesButton = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[NetCorePushTaskManager sharedInstance] deleteNotification:trid];
            [self->notificationArray removeObjectAtIndex:indexPath.row];
            [self.notificationTableView reloadData];
        }];
        [alert addAction:noButton];
        [alert addAction:yesButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Smartech Notification Cell Delegate Methods

- (void)didReceiveReadMoreButtonClickWith:(NSIndexPath *)indexPath {
    if (!_notificationTableView.editing) {
        notificationArray[indexPath.row].isCellExpanded = !notificationArray[indexPath.row].isCellExpanded;
        notificationArray[indexPath.row].isNotificationRead = true;
//        [_notificationTableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_notificationTableView reloadData];
        [_notificationTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:true];
        [self sendOpenNotification:notificationArray[indexPath.row].userInfo andAutoHandleDeeplink:false];
    }
}

- (void)didReceiveDeeplinkActionWith:(NSString *)deeplinkString userInfo:(NSDictionary *)userInfo {
    if (!_notificationTableView.editing) {
        [self sendOpenNotification:userInfo andAutoHandleDeeplink:true];
    }
}

- (void)didReceivePlayerClickEvent:(NSString *)mediaUrl {
    AVPlayer *player = [AVPlayer playerWithURL:[NSURL URLWithString:mediaUrl]];
    AVPlayerViewController *controller = [AVPlayerViewController new];
    controller.player = player;
    [self presentViewController:controller animated:true completion:^{
        [controller.player play];
    }];
}

@end
