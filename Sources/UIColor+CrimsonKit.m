//
//  UIColor+Crimson.m
//  CrimsonKit
//
//  Created by Waqar Malik on 12/31/10.
//  Copyright 2010 Crimson Research, Inc. All rights reserved.
//

#import "UIColor+CrimsonKit.h"

@implementation UIColor (CrimsonKit)
+ (UIColor *)colorWithRGBAString:(NSString *)colorString
{
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    uint32_t colorValue = 0;
    [scanner scanHexInt:&colorValue];
    return [UIColor colorWithRGBAHex:colorValue];
}

+ (UIColor *)colorWithRGBAHex:(uint32_t)colorValue
{
    uint32_t r = (colorValue >> 24) & 0x0FF;
    uint32_t g = (colorValue >> 16) & 0x0FF;
    uint32_t b = (colorValue >> 8) & 0x0FF;
    uint32_t a = (colorValue >> 0) & 0x0FF;
        
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}
@end
