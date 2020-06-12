//
//  AZBlockHelper.h
//  AZTools
//
//  Created by Alfred on 2020/6/12.
//  Copyright © 2020 AZ. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

extern NSMethodSignature *az_blockSignature(id aBlock);
extern NSUInteger az_numberOfBlockArguments(id aBlock);

@interface AZBlockHelper : NSObject

+ (NSMethodSignature *)blockSignature:(id)aBlock;

+ (NSUInteger)numberOfBlockArguments:(id)aBlock;

@end


NS_ASSUME_NONNULL_END
