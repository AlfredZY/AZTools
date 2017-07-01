//
//  NSString+Number.h
//  AZCategory
//
//  Created by Alfred Zhang on 2017/6/29.
//  Copyright © 2017年 Alfred Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (Number)

/**
 格式化输出 根据有无小数点转换成对相应string(最多两位小数点)
 @f
 */
+ (NSString *)floatToString:(CGFloat)f;


@end
