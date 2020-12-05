//
//  UIButton+AZCountDown.h
//  AZTools
//
//  Created by Alfred on 2020/12/5.
//  Copyright © 2020 AZ. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (AZCountDown)

/// 当前是否正在倒计时
@property (nonatomic, assign) BOOL az_cd_isCountdowning;

/// 唯一标志位，唯一标识一个倒计时
@property (nonatomic, copy) NSString *az_cd_identify;

/// 倒计时总数（s）
@property (nonatomic, assign) NSInteger az_cd_count;

/// 倒计时回调 countDown剩余秒数
@property (nonatomic, copy) void((^az_cd_countdownBlock)(NSInteger countDown,UIButton *button));

/// 倒计时结束block回调
@property (nonatomic, copy) dispatch_block_t az_cd_endBlock;

/// 开始/恢复倒计时【会新建倒计时】
- (void)az_cd_start;

/// 恢复倒计时【不会新建倒计时】
- (void)az_cd_recover;

/// 停止倒计时
- (void)az_cd_stop;

@end

NS_ASSUME_NONNULL_END
