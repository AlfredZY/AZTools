//
//  AZBlockHelper.m
//  AZTools
//
//  Created by Alfred on 2020/6/12.
//  Copyright © 2020 AZ. All rights reserved.
//

#import "AZBlockHelper.h"

struct AZBlockLiteral {
    void *isa; // initialized to &_NSConcreteStackBlock or &_NSConcreteGlobalBlock
    int flags;
    int reserved;
    void (*invoke)(void *, ...);
    struct block_descriptor {
        unsigned long int reserved;    // NULL
        unsigned long int size;         // sizeof(struct Block_literal_1)
        // optional helper functions
         void (*copy_helper)(void *dst, void *src);     // IFF (1<<25)
         void (*dispose_helper)(void *src);             // IFF (1<<25)
         // required ABI.2010.3.16
         const char *signature;                         // IFF (1<<30)
     } *descriptor;
     // imported variables
 };

 // flags enum
 enum {
     AZBlockDescriptionFlagsHasCopyDispose = (1 << 25),
     AZBlockDescriptionFlagsHasCtor = (1 << 26), // helpers have C++ code
     AZBlockDescriptionFlagsIsGlobal = (1 << 28),
     AZBlockDescriptionFlagsHasStret = (1 << 29), // IFF BLOCK_HAS_SIGNATURE
     AZBlockDescriptionFlagsHasSignature = (1 << 30)
 };

NSMethodSignature *az_blockSignature(id aBlock) {
    return [AZBlockHelper blockSignature:aBlock];
}

NSUInteger az_numberOfBlockArguments(id aBlock) {
    return [AZBlockHelper numberOfBlockArguments:aBlock];
}

@implementation AZBlockHelper

 typedef int AZBlockDescriptionFlags;

+ (NSMethodSignature *)blockSignature:(id)block{
    struct AZBlockLiteral *blockRef = (__bridge struct AZBlockLiteral *)block;
    AZBlockDescriptionFlags _flags = blockRef->flags;
    if (_flags & AZBlockDescriptionFlagsHasSignature) {
        void *signatureLocation = blockRef->descriptor;
        signatureLocation += sizeof(unsigned long int);
        signatureLocation += sizeof(unsigned long int);

        if (_flags & AZBlockDescriptionFlagsHasCopyDispose) {
             signatureLocation += sizeof(void(*)(void *dst, void *src));
             signatureLocation += sizeof(void (*)(void *src));
         }

         const char *signature = (*(const char **)signatureLocation);
         return [NSMethodSignature signatureWithObjCTypes:signature];
     }
     return nil;
 }

+ (NSUInteger)numberOfBlockArguments:(id)aBlock {
    return [AZBlockHelper blockSignature:aBlock].numberOfArguments;
}

@end
