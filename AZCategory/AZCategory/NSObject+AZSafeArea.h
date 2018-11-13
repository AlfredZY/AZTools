//
//  NSObject+AZSafeArea.h
//  AZCategoryDemo
//
//  Created by Alfred Zhang on 2018/11/13.
//  Copyright © 2018年 Alfred Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define AZ_HAS_SAFEAREA [self az_hasSafeArea]

@interface NSObject (AZSafeArea)

- (BOOL)az_hasSafeArea;

@end
