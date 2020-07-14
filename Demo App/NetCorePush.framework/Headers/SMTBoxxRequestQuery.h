//
//  SMTBoxxRequestQuery.h
//  NetCorePush
//
//  Created by jainish on 23/06/20.
//  Copyright © 2020 NetCore. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SMTBoxxRequestQuery : NSObject

@property (nonatomic, strong) NSString *relatedActionType;
@property (nonatomic, strong) NSArray *relatedProducts;
@property (nonatomic, strong) NSArray *exclude;
@property (nonatomic, strong) NSArray *dontRepeatTransactionTypes;
@property (nonatomic, strong) NSDictionary *itemFilters;
@property (nonatomic, strong) NSDictionary *context;
@property (nonatomic, strong) NSDictionary *extras;
@property (nonatomic) BOOL getProductProperties;
@property (nonatomic) BOOL getProductLikedDislikedStatus;
@property (nonatomic) BOOL getProductAliases;
@property (nonatomic, assign) NSUInteger num;
@property (nonatomic, assign) NSUInteger offset;

- (NSMutableDictionary *)toNSDictionary;

NS_ASSUME_NONNULL_END

@end
