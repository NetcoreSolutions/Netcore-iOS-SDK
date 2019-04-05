/*
 @header SmartechNotificationCell.h
 @brief SmartechNotificationCell is responsible to show the individual cells in the notification center.
 @author    Netcore Solutions
 @copyright 2019 Netcore Solutions
 @version   1.0.0
 */

#import "SmartechNotificationCell.h"
#import "UIImageView+WebCache.h"
#import "FLAnimatedImage.h"

#import <AVKit/AVKit.h>

NSString *const kPlaceholder = @"smartech-image-placeholder";
NSString *const kAudioPlaceholder = @"smartech-audio-placeholder";
NSString *const kVideoPlaceholder = @"smartech-video-placehoder";
NSString *const kPlayerPlaybutton = @"smartech-play-button";


@interface SmartechNotificationCell()

@property (strong, nonatomic) UISegmentedControl *interactionButtonsSegmentControl;
@property (strong, nonatomic) UIImageView *mediaImageView;
@property (strong, nonatomic) FLAnimatedImageView *gifImageView;
@property (strong, nonatomic) UIScrollView *carouselScrollView;
@property (strong, nonatomic) UIImageView *thumbnailImageView;

@end

@implementation SmartechNotificationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

#pragma mark - Loading methods
- (void)loadInteractionButtonsSegmentControl {
    if (_interactionButtonsSegmentControl == nil) {
        NSArray <NSString *> *titles = [NSArray new];
        for (int i = 0; i<_notificationModel.actionButtonArray.count; i++) {
            NSString *title = [_notificationModel.actionButtonArray objectAtIndexedSubscript:i].titleString;
            titles = [titles arrayByAddingObject:title];
        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.interactionButtonsSegmentControl = [[UISegmentedControl alloc] initWithItems:titles];
            self.interactionButtonsSegmentControl.frame = CGRectMake(0.0, 0.0, self.interactionButtonViewHolder.frame.size.width, self.interactionButtonViewHolder.frame.size.height);
            NSDictionary *attributes = @{NSForegroundColorAttributeName: [UIColor blackColor],NSFontAttributeName:[UIFont systemFontOfSize:16.0]};
            [self.interactionButtonsSegmentControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
            [self.interactionButtonsSegmentControl addTarget:self action:@selector(segmentSelected:) forControlEvents: UIControlEventValueChanged];
            self.interactionButtonsSegmentControl.tintColor = [UIColor clearColor];
            [self.interactionButtonViewHolder addSubview:self.interactionButtonsSegmentControl];
        });
    }
}

//display image view code
- (void)loadViewForImage {
    if (_mediaImageView == nil) {
        _mediaImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, _richDataDisplayView.frame.size.width, _richDataDisplayView.frame.size.height)];
        [_richDataDisplayView addSubview:_mediaImageView];
    }
    [_mediaImageView sd_setImageWithURL:[NSURL URLWithString:_notificationModel.mediaurl] placeholderImage:[UIImage imageNamed:kPlaceholder]];
    
    [_thumbnailImageView removeFromSuperview];
    [_gifImageView removeFromSuperview];
    [_carouselView removeFromSuperview];
    
    _thumbnailImageView = nil;
    _gifImageView = nil;
    _carouselView = nil;
}

//display gif view code
- (void)loadViewForGif {
    if (_gifImageView == nil) {
        _gifImageView  = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, _richDataDisplayView.frame.size.width, _richDataDisplayView.frame.size.height)];
        _gifImageView.backgroundColor = [UIColor redColor];
        _gifImageView.clipsToBounds = true;
        self.gifImageView.contentMode =  UIViewContentModeScaleToFill;
        [_richDataDisplayView addSubview:_gifImageView];
    }
    [_gifImageView sd_setImageWithURL:[NSURL URLWithString:_notificationModel.mediaurl] placeholderImage:[UIImage imageNamed:kPlaceholder]];
    
    [_thumbnailImageView removeFromSuperview];
    [_mediaImageView removeFromSuperview];
    [_carouselView removeFromSuperview];
    
    _thumbnailImageView = nil;
    _mediaImageView = nil;
    _carouselView = nil;
}

- (void)loadPlayerView {
    if (_thumbnailImageView == nil) {
        _thumbnailImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, _richDataDisplayView.frame.size.width, _richDataDisplayView.frame.size.height)];
        _thumbnailImageView.userInteractionEnabled = true;
        [_richDataDisplayView addSubview:_thumbnailImageView];
        UIView *view = [[UIView alloc] initWithFrame:_thumbnailImageView.bounds];
        
        if (_notificationModel.mediaType == SMTMediaTypeVideo) {
            view.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3];
            _thumbnailImageView.image = [UIImage imageNamed:kVideoPlaceholder];
        } else {
            view.backgroundColor = [UIColor clearColor];
            _thumbnailImageView.image = [UIImage imageNamed:kAudioPlaceholder];
        }
       
        [_thumbnailImageView addSubview:view];
        
        CGFloat width = _thumbnailImageView.frame.size.height * 0.35;
        UIButton *playerPlayButton = [[UIButton alloc] initWithFrame:CGRectMake(0.0, 0.0, width, width)];
        playerPlayButton.center = CGPointMake(_thumbnailImageView.frame.size.width/2, _thumbnailImageView.frame.size.height/2);
        [playerPlayButton setBackgroundImage:[UIImage imageNamed:kPlayerPlaybutton] forState:UIControlStateNormal];
        [playerPlayButton addTarget:self action:@selector(playerPlayButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:playerPlayButton];
    }
    if (_notificationModel.mediaType == SMTMediaTypeVideo) {
        _thumbnailImageView.image = [UIImage imageNamed:kVideoPlaceholder];
    }
    else {
        _thumbnailImageView.image = [UIImage imageNamed:kAudioPlaceholder];
    }
    [_mediaImageView removeFromSuperview];
    [_gifImageView removeFromSuperview];
    [_carouselView removeFromSuperview];
    
    _mediaImageView = nil;
    _gifImageView = nil;
    _carouselView = nil;
}

//display carousel view code
- (void)loadViewForCarousel {
    if (_carouselScrollView == nil) {
        _carouselScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 0.0, _carouselView.frame.size.width, _carouselView.frame.size.height)];
        _carouselScrollView.delegate = self;
        _carouselScrollView.pagingEnabled = true;
        _carouselScrollView.bounces = false;
        _carouselScrollView.showsVerticalScrollIndicator = false;
        _carouselScrollView.showsHorizontalScrollIndicator = false;
        [_carouselView addSubview:_carouselScrollView];
    }
    CGFloat posX = 0.0;
    
    for (int i = 0; i<_notificationModel.carouselArray.count; i++) {
        SMTCarousel *carousel = [_notificationModel.carouselArray objectAtIndexedSubscript:i];
        UIImageView *carouselImageView = [[UIImageView alloc] initWithFrame:CGRectMake(posX, 0.0, _carouselScrollView.frame.size.width, _carouselScrollView.bounds.size.height)];
        [carouselImageView sd_setImageWithURL:[NSURL URLWithString:carousel.imageUrlString] placeholderImage:[UIImage imageNamed:kPlaceholder]];
        [carouselImageView setUserInteractionEnabled:true];
        [carouselImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(carouselImageViewGestureEvent:)]];
        [_carouselScrollView addSubview:carouselImageView];
        posX = posX + carouselImageView.frame.size.width;
    }
    [self configureCarouselTexts];
    _carouselScrollView.contentSize = CGSizeMake(posX, _carouselScrollView.frame.size.height);
    _carouselPageControl.numberOfPages = _notificationModel.carouselArray.count;
    _carouselPageControl.currentPage = 0;
    
    [_thumbnailImageView removeFromSuperview];
    [_mediaImageView removeFromSuperview];
    [_gifImageView removeFromSuperview];
    
    _thumbnailImageView = nil;
    _mediaImageView = nil;
    _gifImageView = nil;
}

#pragma mark - Local Helpers
- (void)setNotificationModel:(SMTNotification *)notificationModel {
    _notificationModel = notificationModel;
    _carouselPageIndex = 0;
    _titleLabel.text = notificationModel.titleString;
    _bodyLabel.text = notificationModel.subtitleString;
    _dateLabel.text = notificationModel.dateString;
    if (!notificationModel.isNotificationRead) {
        _titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
    } else {
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
    }
    [self setMediaView];
    if (notificationModel.actionButtonArray) {
        _interactionButtonHeightConstraint.constant = kInteractionButtonView;
        [_interactionButtonViewHolder setHidden:false];
        [self layoutIfNeeded];
        [self loadInteractionButtonsSegmentControl];
    } else {
        _interactionButtonHeightConstraint.constant = 0.0;
        [_interactionButtonViewHolder setHidden:true];
    }
}

- (void)setMediaView {
    switch (_notificationModel.mediaType) {
        case SMTMediaTypeText:
            [_richDataDisplayView setHidden:true];
            break;
        case SMTMediaTypeImage:
            [self loadViewForImage];
            [_richDataDisplayView setHidden:false];
            break;
        case SMTMediaTypeVideo:
            [self loadPlayerView];
            [_richDataDisplayView setHidden:false];
            break;
        case SMTMediaTypeGif:
            [self loadViewForGif];
            [_richDataDisplayView setHidden:false];
            break;
        case SMTMediaTypeCarousel:
            [self loadViewForCarousel];
            [_richDataDisplayView setHidden:true];
            break;
        case SMTMediaTypeAudio:
            [self loadPlayerView];
            [_richDataDisplayView setHidden:false];
            break;
        default:
            break;
    }
}


- (void)updateTitleReadStatus {
    _titleLabel.font = [UIFont systemFontOfSize:14.0];
}

- (void)configureCarouselTexts {
    _carouselTitle.text = _notificationModel.carouselArray[_carouselPageIndex].imageTitleString;
    _carouselBody.text = _notificationModel.carouselArray[_carouselPageIndex].imageMessageString;
}

#pragma mark - UIScrollViewDelegate Method
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = _carouselScrollView.frame.size.width;
    CGFloat fractionalPage = _carouselScrollView.contentOffset.x / pageWidth;
    _carouselPageIndex = (NSInteger) fractionalPage;
    _carouselPageControl.currentPage = _carouselPageIndex;
    [self configureCarouselTexts];
}

#pragma mark - UISegmentedControl Event
- (void)segmentSelected:(UISegmentedControl *)segment {
    if (_delegate) {
        NSString *deepLink = _notificationModel.actionButtonArray[segment.selectedSegmentIndex].deeplinkString;
        [_delegate didReceiveDeeplinkActionWith:deepLink userInfo:_notificationModel.userInfo];
    }
}

#pragma mark - UIButton Event
- (void)playerPlayButtonClicked:(UIButton *)sender {
    if (_delegate) {
        [_delegate didReceivePlayerClickEvent:_notificationModel.mediaurl];
    }
}

- (void)carouselImageViewGestureEvent:(UIGestureRecognizer *)sender {
    if (_delegate) {
        [_delegate didReceiveDeeplinkActionWith:_notificationModel.deeplinkString userInfo:_notificationModel.userInfo];
    }
}

@end
