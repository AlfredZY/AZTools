//
//  AZBlockDemo.h
//  Demo
//
//  Created by Alfred on 2020/6/12.
//  Copyright © 2020 AZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wstrict-prototypes"
typedef id _Nullable (^AZBlock)();
#pragma clang diagnostic pop

@interface AZBlockDemo : NSObject

- (void)performBlock:(AZBlock)block;

@end

NS_ASSUME_NONNULL_END
