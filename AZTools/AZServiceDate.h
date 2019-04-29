//
//  AZServiceDate.h
//  AZCategory
//
//  Created by Alfred Zhang on 2019/4/7.
//  Copyright © 2019 Alfred. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AZServiceDate : NSObject

/** 校验服务器地址 */
@property (nonatomic, copy, readonly) NSString *url;

+ (instancetype)sharedInstance;

/**
 获取ServiceDate,
 未设置校验服务器或未设置StandardNetResponseDate，则返回当前手机时间
 
 @return ServiceDate
 */
+ (nonnull NSDate *)serviceDate;

/** 以特定URL返回的Date为基准更新ServiceDate */
+ (void)updateDateWithUrl:(nullable NSString *)url success:(dispatch_block_t)success failure:(dispatch_block_t)failure;

/** 通过 RFC3339 或者 RFC822 string 直接更新基准时间 */
+ (void)updateStandardNetResponseDate:(nullable NSString *)dateStr;


/** 获取设备上次重启的时间 */
+ (nullable NSDate *)bootDate;

@end

NS_ASSUME_NONNULL_END
