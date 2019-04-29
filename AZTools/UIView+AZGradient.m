//
//  UIView+AZGradient.m
//  AZCategory
//
//  Created by Alfred Zhang on 2017/6/29.
//  Copyright © 2017年 Alfred Zhang. All rights reserved.
//

#import "UIView+AZGradient.h"
#import <objc/runtime.h>

@implementation UIView (AZGradient)


+ (Class)layerClass {
    return [CAGradientLayer class];
}

+ (UIView *)az_gradientViewWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    UIView *view = [[self alloc] init];
    [view az_setGradientBackgroundWithColors:colors locations:locations startPoint:startPoint endPoint:endPoint];
    return view;
}

- (void)az_setGradientBackgroundWithColors:(NSArray<UIColor *> *)colors locations:(NSArray<NSNumber *> *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint {
    NSMutableArray *colorsM = [NSMutableArray array];
    for (UIColor *color in colors) {
        [colorsM addObject:(__bridge id)color.CGColor];
    }
    self.az_colors = [colorsM copy];
    self.az_locations = locations;
    self.az_startPoint = startPoint;
    self.az_endPoint = endPoint;
}

#pragma mark- Getter&Setter

- (NSArray *)az_colors {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAz_colors:(NSArray *)colors {
    objc_setAssociatedObject(self, @selector(az_colors), colors, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setColors:self.az_colors];
    }
}

- (NSArray<NSNumber *> *)az_locations {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setAz_locations:(NSArray<NSNumber *> *)locations {
    objc_setAssociatedObject(self, @selector(az_locations), locations, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setLocations:self.az_locations];
    }
}

- (CGPoint)az_startPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setAz_startPoint:(CGPoint)startPoint {
    objc_setAssociatedObject(self, @selector(az_startPoint), [NSValue valueWithCGPoint:startPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setStartPoint:self.az_startPoint];
    }
}

- (CGPoint)az_endPoint {
    return [objc_getAssociatedObject(self, _cmd) CGPointValue];
}

- (void)setAz_endPoint:(CGPoint)endPoint {
    objc_setAssociatedObject(self, @selector(az_endPoint), [NSValue valueWithCGPoint:endPoint], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if ([self.layer isKindOfClass:[CAGradientLayer class]]) {
        [((CAGradientLayer *)self.layer) setEndPoint:self.az_endPoint];
    }
}


@end

@implementation UILabel (AZGradient)

+ (Class)layerClass {
    return [CAGradientLayer class];
}

@end


