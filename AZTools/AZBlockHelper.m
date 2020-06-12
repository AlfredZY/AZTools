//
//  AZBlockHelper.m
//  AZTools
//
//  Created by Alfred on 2020/6/12.
//  Copyright © 2020 AZ. All rights reserved.
//

#import "AZBlockHelper.h"

NSMethodSignature *az_blockSignature(id aBlock) {
    return [AZBlockHelper blockSignature:aBlock];
}

NSUInteger az_numberOfBlockArguments(id aBlock) {
    return [AZBlockHelper numberOfBlockArguments:aBlock];
}

@implementation AZBlockHelper

+ (NSMethodSignature *)blockSignature:(id)aBlock {
    if (!aBlock) {
        return nil;
    }

    if (!([aBlock isKindOfClass:NSClassFromString(@"__NSGlobalBlock__")] ||
          [aBlock isKindOfClass:NSClassFromString(@"__NSMallocBlock__")] ||
          [aBlock isKindOfClass:NSClassFromString(@"__NSStackBlock__")])) {
        NSAssert(NO, @"%@ Not A Block!",aBlock);
        return nil;
    }
    
    uint64_t blockInMemory[4];      //block 在内存中的前4个uint64_t
    uint64_t descriptor[5];         //block的descriptor 在内存中的前5个uint64_t
    char *signatureCStr;
    NSMethodSignature *blockSignature;
    
    void *aBlockPtr = (__bridge void *)(aBlock);
    memcpy(blockInMemory, (void *)aBlockPtr, sizeof(blockInMemory));
    memcpy(descriptor, (void *)blockInMemory[3], sizeof(descriptor));
    
    BOOL hasSignature = ((blockInMemory[1] & 0x00000000FFFFFFFF)  & (1 << 30)) != 0;
    if (!hasSignature) {
        NSAssert(NO, @"%@ Do Not Have Signature!",aBlock);
        return nil;
    }
    
    BOOL hasCopyDisposeHelper = ((blockInMemory[1] & 0x00000000FFFFFFFF)  & (1 << 25)) != 0;
    
    if (hasCopyDisposeHelper) {
        signatureCStr = (char *)descriptor[4];
    }else{
        signatureCStr = (char *)descriptor[2];
    }
    blockSignature = [NSMethodSignature signatureWithObjCTypes:signatureCStr];
    
    return blockSignature;
}

+ (NSUInteger)numberOfBlockArguments:(id)aBlock {
    return [AZBlockHelper blockSignature:aBlock].numberOfArguments;
}

@end
