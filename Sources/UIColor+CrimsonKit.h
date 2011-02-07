//
//  UIColor+Crimson.h
//  CrimsonKit
//
//  Created by Waqar Malik on 12/31/10.
//  Copyright 2010 Crimson Research, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CKSourceAnnotations.h"

#ifndef MIN
#define MIN(x,y) ((x)<(y)?(x):(y))
#endif

#ifndef MAX
#define MAX(x,y) ((x)>(y)?(x):(y))
#endif

@interface UIColor (CrimsonKit)
@property (nonatomic, readonly, assign) BOOL canProvideRGBAComponents;
@property (nonatomic, readonly, assign) CGColorSpaceRef colorSpace;
@property (nonatomic, readonly, assign) NSString *colorSpaceName;
@property (nonatomic, readonly, assign) CGColorSpaceModel colorSpaceModel;
@property (nonatomic, readonly, assign) NSUInteger numberOfComponents;
@property (nonatomic, readonly, assign) uint32_t RGBAHex;
@property (nonatomic, readonly, assign) NSString *RGBAString;

@property (nonatomic, readonly, assign) CGFloat alpha;
@property (nonatomic, readonly, assign) CGFloat black;
@property (nonatomic, readonly, assign) CGFloat blue;
@property (nonatomic, readonly, assign) CGFloat brightness;
@property (nonatomic, readonly, assign) CGFloat cyan;
@property (nonatomic, readonly, assign) CGFloat green;
@property (nonatomic, readonly, assign) CGFloat hue;
@property (nonatomic, readonly, assign) CGFloat magenta;
@property (nonatomic, readonly, assign) CGFloat red;
@property (nonatomic, readonly, assign) CGFloat saturation;
@property (nonatomic, readonly, assign) CGFloat white;
@property (nonatomic, readonly, assign) CGFloat yellow;

+ (UIColor *)colorWithRGBAString:(NSString *)colorString NS_RETURNS_NOT_RETAINED;
+ (UIColor *)colorWithRGBAHex:(uint32_t)colorValue NS_RETURNS_NOT_RETAINED;
+ (void)red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue toHue:(CGFloat *)toHue saturation:(CGFloat *)toSaturation brightness:(CGFloat *)toBrightness CLANG_ANALYZER_NORETURN;
+ (void)hue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness toRed:(CGFloat *)toRed green:(CGFloat *)toGreen blue:(CGFloat *)toBlue CLANG_ANALYZER_NORETURN;

- (void)components:(CGFloat *)components CLANG_ANALYZER_NORETURN;
- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha;
- (BOOL)white:(CGFloat *)white alpha:(CGFloat *)alpha;
- (BOOL)cyan:(CGFloat *)cyan magenta:(CGFloat *)magenta yellow:(CGFloat *)yellow black:(CGFloat *)black alpha:(CGFloat *)alpha;
- (BOOL)hue:(CGFloat *)hue saturation:(CGFloat *)saturation brightness:(CGFloat *)brightness alpha:(CGFloat *)alpha;
@end
