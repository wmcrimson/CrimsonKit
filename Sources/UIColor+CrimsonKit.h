//
//  UIColor+Crimson.h
//  CrimsonKit
//
//  Created by Waqar Malik on 12/31/10.
//  Copyright 2010 Crimson Research, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKSourceAnnotations.h"

@interface UIColor (CrimsonKit)
@property (nonatomic, readonly, assign) BOOL canProvideRGBAComponents;
@property (nonatomic, readonly, assign) CGColorSpaceRef colorSpace;
@property (nonatomic, readonly, assign) NSString *colorSpaceName;
@property (nonatomic, readonly, assign) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly, assign) NSUInteger numberOfComponents;
@property (nonatomic, readonly, assign) uint32_t RGBAHex;
@property (nonatomic, readonly, assign) NSString *RGBAString;

+ (UIColor *)colorWithRGBAString:(NSString *)colorString NS_RETURNS_NOT_RETAINED;
+ (UIColor *)colorWithRGBAHex:(uint32_t)colorValue NS_RETURNS_NOT_RETAINED;

- (void)components:(CGFloat *)components;
- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
@end
