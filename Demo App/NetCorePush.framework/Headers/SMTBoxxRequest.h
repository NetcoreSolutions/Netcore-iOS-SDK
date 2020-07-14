//
//  BoxxRequest.h
//  NetCorePush
//
//  Created by jainish on 23/06/20.
//  Copyright © 2020 NetCore. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SMTBoxxRequestQuery.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^BoxxAPICompletionBlock) (NSDictionary *_Nullable responseData);

typedef NS_ENUM(NSUInteger, BoxxRecType) {
    BoxxRecTypeBoxx,
    BoxxRecTypeBestSeller,
    BoxxRecTypeTrending,
    BoxxRecTypeRecentlyViewed,
    BoxxRecTypeNewProducts,
};

@interface SMTBoxxRequest : NSObject

@property (nonatomic, assign) BoxxRecType recType;
@property (nonatomic, strong) NSString *locale;
@property (nonatomic, strong) SMTBoxxRequestQuery *requestQuery;

- (NSMutableDictionary *)toNSDictionary;

NS_ASSUME_NONNULL_END

@end
