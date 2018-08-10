//
//  NetCoreConstant.h
//  NetCorePush
//
//  Created by NetCore on 11/14/16.
//  Copyright © 2016 NetCore. All rights reserved.
//

#ifndef NetCoreConstant_h
#define NetCoreConstant_h

typedef void (^NetCoreStatusBlock)(NSInteger statusCode);
typedef void (^NetCoreResultBlock)(NSInteger statusCode,id result);

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#pragma mark - NSLog Swithcer

#define DEBUG_MODE_OFF

#ifdef DEBUG_MODE
#define NCLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#define NCLog(...)
#endif


#endif /* NetCoreConstant_h */
