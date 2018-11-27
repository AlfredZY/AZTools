//
//  NSObject+AZSafeArea.m
//  AZCategoryDemo
//
//  Created by Alfred Zhang on 2018/11/13.
//  Copyright © 2018年 Alfred Zhang. All rights reserved.
//

#import "NSObject+AZSafeArea.h"

@implementation NSObject (AZSafeArea)

- (BOOL)az_hasSafeArea {
    static dispatch_once_t onceToken;
    static BOOL hasSafeArea = NO;
    if (![UIApplication sharedApplication].windows){
        // 在+load方法里调用会出现这种情况
        // 我这里直接返回了NO，其实如果需要在+load方法里判断是否是圆角，只能通过机型列表或者分辨率等方式判断，每次发布新机型都需要更新方法。
        // 所以该方法在+load里调用无效
        return NO;
    }else {
        dispatch_once(&onceToken, ^{
            if (@available(iOS 11.0, *)) {
                UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
                hasSafeArea = window.safeAreaInsets.bottom > 0;
            }
        });
        return hasSafeArea;
    }
}

@end
