//
//  UIButton+AZCountDown.m
//  AZTools
//
//  Created by Alfred on 2020/12/5.
//  Copyright © 2020 AZ. All rights reserved.
//

#import "UIButton+AZCountDown.h"
#import <objc/runtime.h>
#import "AZServiceDate.h"
#import "AZWeakProxy.h"

@interface UIButton ()

@property (nonatomic, strong) NSTimer *az_cd_timer;

// 倒计时结束的时间
@property (nonatomic, assign) NSTimeInterval az_cd_targetTime;

@end

@implementation UIButton (AZCountDown)

- (void)dealloc {
    [self.az_cd_timer invalidate];
    self.az_cd_timer = nil;
}

- (void)az_cd_start {
    NSParameterAssert(self.az_cd_identify);
    NSNumber *targetTimeNum = [self az_cd_read_targetTime];
    // nil表示没有倒计时 重新计算新的倒计时
    if (targetTimeNum == nil) {
        self.az_cd_targetTime = [self az_cd_restTargetTime];
    }else { // 有未完成的倒计时
        self.az_cd_targetTime = [targetTimeNum doubleValue];
    }
    if (!self.az_cd_timer) {
        AZWeakProxy *proxy = [AZWeakProxy proxyWithTarget:self];
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:proxy selector:@selector(sxj_cd_count_down) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        [timer fire];
    }
}

- (void)az_cd_recover {
    NSNumber *targetTimeNum = [self az_cd_read_targetTime];
    // 有未完成的倒计时
    if (targetTimeNum) {
        [self az_cd_start];
    }
}

- (void)az_cd_stop {
    NSParameterAssert(self.az_cd_identify);
    [self.az_cd_timer invalidate];
    self.az_cd_timer = nil;
    [self sxj_cd_remove_targetTime];
    self.az_cd_isCountdowning = NO;
}

- (void)sxj_cd_count_down {
    NSInteger delta = self.az_cd_targetTime - [[AZServiceDate serviceDate] timeIntervalSince1970];
    if (delta <= 0) {
        self.enabled = YES;
        [self az_cd_stop];
        if (self.az_cd_countdownBlock) {
            self.az_cd_countdownBlock(0,self);
        }
        if (self.az_cd_endBlock) {
            self.az_cd_endBlock();
        }
    }else {
        self.az_cd_isCountdowning = YES;
        self.enabled = NO;
        if (self.az_cd_countdownBlock) {
            self.az_cd_countdownBlock(delta,self);
        }
    }
}

- (NSString *)sxj_cd_key {
    return [NSString stringWithFormat:@"sxj_cd_%@",self.az_cd_identify];
}

- (NSNumber *)az_cd_read_targetTime {
    return [[NSUserDefaults standardUserDefaults] objectForKey:[self sxj_cd_key]];
}

- (void)sxj_cd_remove_targetTime {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:[self sxj_cd_key]];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSTimeInterval)az_cd_restTargetTime {
    NSTimeInterval targetTime = [[AZServiceDate serviceDate] timeIntervalSince1970] + self.az_cd_count;
    [[NSUserDefaults standardUserDefaults] setObject:@(targetTime) forKey:[self sxj_cd_key]];
    [[NSUserDefaults standardUserDefaults] synchronize];
    return targetTime;
}


#pragma mark- Getter&Setter

- (NSTimer *)az_cd_timer {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAz_cd_timer:(NSTimer *)sxj_cd_timer {
    objc_setAssociatedObject(self, @selector(az_cd_timer), sxj_cd_timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimeInterval)az_cd_targetTime {
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}
- (void)setAz_cd_targetTime:(NSTimeInterval)sxj_cd_targetTime {
    objc_setAssociatedObject(self, @selector(az_cd_targetTime), @(sxj_cd_targetTime), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)az_cd_isCountdowning {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setAz_cd_isCountdowning:(BOOL)sxj_cd_isCountdowning {
    objc_setAssociatedObject(self, @selector(az_cd_isCountdowning), @(sxj_cd_isCountdowning), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)az_cd_identify {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAz_cd_identify:(NSString *)sxj_cd_identify {
    objc_setAssociatedObject(self, @selector(az_cd_identify), sxj_cd_identify, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSInteger)az_cd_count {
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

- (void)setAz_cd_count:(NSInteger)sxj_cd_count {
    objc_setAssociatedObject(self, @selector(az_cd_count), @(sxj_cd_count), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void ((^)(NSInteger, UIButton * _Nonnull)))az_cd_countdownBlock {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAz_cd_countdownBlock:(void ((^)(NSInteger, UIButton * _Nonnull)))sxj_cd_countdownBlock {
    objc_setAssociatedObject(self, @selector(az_cd_countdownBlock), sxj_cd_countdownBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (dispatch_block_t)az_cd_endBlock {
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setAz_cd_endBlock:(dispatch_block_t)sxj_cd_endBlock {
    objc_setAssociatedObject(self, @selector(az_cd_endBlock), sxj_cd_endBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
