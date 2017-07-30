//
//  UIViewController+PushAndPop.m
//  AZCategoryDemo
//
//  Created by Alfred Zhang on 2017/7/30.
//  Copyright © 2017年 Alfred Zhang. All rights reserved.
//

#import "UIViewController+PushAndPop.h"
#import <objc/runtime.h>

@implementation UIViewController (PushAndPop)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(az_viewDidLoad);
        swizzleMethod([self class], originalSelector, swizzledSelector);
    });
}

static void swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector)
{
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)az_viewDidLoad {
    NSUInteger limitNum = [[self class] cyclePushLimitNumber];
    if (limitNum <= 0) {
        [self az_viewDidLoad];
        return;
    }
    
    NSArray *vcs = self.navigationController.viewControllers;
    NSMutableArray *productDetailVCIndexArrM = [NSMutableArray array];
    for (NSInteger i = vcs.count; i >= 0; i--) {
        if (![vcs[i - 1] isKindOfClass:[self class]]) {
            break;
        }
        [productDetailVCIndexArrM addObject:@(i - 1)];
    }
    
    if (productDetailVCIndexArrM.count > limitNum) {
        NSMutableArray *vcsArrM = [vcs mutableCopy];
        [vcsArrM removeObjectAtIndex:[productDetailVCIndexArrM[1] integerValue]];
        [self.navigationController setViewControllers:vcsArrM animated:YES];
    }
    
    [self az_viewDidLoad];
}

+ (NSUInteger)cyclePushLimitNumber {
    return 0;
}

@end
