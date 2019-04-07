//
//  AZServiceDate.m
//  AZCategory
//
//  Created by Alfred Zhang on 2019/4/7.
//  Copyright © 2019 Alfred. All rights reserved.
//

#import "AZServiceDate.h"
#import "NSDate+AZInternetDateTime.h"
#include <sys/types.h>
#include <sys/sysctl.h>

#define MIB_SIZE 2

@interface AZServiceDate ()

@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSDate *standardNetResponseDate;
@property (nonatomic, strong) NSDate *standardLocalDate;
@property (nonatomic, strong) NSDate *standardBootDate;

@end

@implementation AZServiceDate


static AZServiceDate *_instance;

+ (instancetype)sharedInstance {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[AZServiceDate alloc] init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

#pragma mark- Public

+ (void)updateStandardNetResponseDate:(NSString *)dateStr {
    [[self sharedInstance] updateStandardNetResponseDate:dateStr];
}

+ (void)updateDateWithUrl:(NSString *)url success:(dispatch_block_t)success failure:(dispatch_block_t)failure {
    [[self sharedInstance] updateDateWithUrl:url success:success failure:failure];
}

+ (NSDate *)serviceDate {
    return [[self sharedInstance] currentDate];
}

+ (NSDate *)bootDate {
    int mib[MIB_SIZE];
    size_t size;
    struct timeval  boottime;
    
    mib[0] = CTL_KERN;
    mib[1] = KERN_BOOTTIME;
    size = sizeof(boottime);
    if (sysctl(mib, MIB_SIZE, &boottime, &size, NULL, 0) != -1)
    {
        NSDate* bootDate = [NSDate dateWithTimeIntervalSince1970:boottime.tv_sec];
        return bootDate;
    }
    else {
        return nil;
    }
}
#pragma mark- Private

- (void)updateStandardNetResponseDate:(NSString *)dateStr {
    if (_instance.standardNetResponseDate || !(dateStr.length > 0)) {
        return;
    }
    NSDate *responseDate = [NSDate az_dateFromInternetDateTimeString:dateStr formatHint:AZDateFormatHintNone];
    _instance.standardNetResponseDate = responseDate;
    _instance.standardBootDate = [[self class] bootDate];
    _instance.standardLocalDate = [NSDate date];
}

- (void)updateDateWithUrl:(NSString *)url success:(dispatch_block_t)success failure:(dispatch_block_t)failure {
    _instance.url = url;
    if (!(url.length > 0)) {
        if(failure) {
            failure();
        }
        return;
    }
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse*)response;
        NSDate *responseDate = [NSDate az_dateFromInternetDateTimeString:httpResponse.allHeaderFields[@"Date"] formatHint:AZDateFormatHintNone];
        if (responseDate ) {
            dispatch_async(dispatch_get_main_queue(), ^{
                _instance.standardNetResponseDate = responseDate;
                _instance.standardBootDate = [[self class] bootDate];
                _instance.standardLocalDate = [NSDate date];
                if (success) {
                    success();
                }
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (failure) {
                    failure();
                }
            });
        }
    }];
    [task resume];
}

- (NSDate *)currentDate {
    NSDate *bootDate = [[self class] bootDate];
    NSDate *now = [NSDate date];
    NSDate *date;
    if (bootDate && _instance.standardBootDate && _instance.standardNetResponseDate && _instance.standardLocalDate) {
        long long delta1 = [_instance.standardLocalDate timeIntervalSinceDate:_instance.standardBootDate];
        long long delta2 = [now timeIntervalSinceDate:bootDate];
        date = [_instance.standardNetResponseDate dateByAddingTimeInterval:(delta2 - delta1)];
    }else {
        date = now;
    }
    return date;
}

@end
