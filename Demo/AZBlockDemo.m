//
//  AZBlockDemo.m
//  Demo
//
//  Created by Alfred on 2020/6/12.
//  Copyright © 2020 AZ. All rights reserved.
//

#import "AZBlockDemo.h"
#import "AZBlockHelper.h"

@implementation AZBlockDemo

- (void)performBlock:(AZBlock)block {
    if (block) {
        NSUInteger count = az_numberOfBlockArguments(block);
        if (count == 1) {
            block();
        }else if (count == 2) {
            block(@"argument1");
        }else if (count == 3) {
            block(@"argument1",@"argument2");
        }
    }
}

@end
