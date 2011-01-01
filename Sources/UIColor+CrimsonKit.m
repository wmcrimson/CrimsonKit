//
//  UIColor+Crimson.m
//  CrimsonKit
//
//  Created by Waqar Malik on 12/31/10.
//  Copyright 2010 Crimson Research, Inc. All rights reserved.
//

#import "UIColor+CrimsonKit.h"

@implementation UIColor (CrimsonKit)
@dynamic canProvideRGBAComponents;
@dynamic colorSpace;
@dynamic colorSpaceName;
@dynamic colorSpaceModel;
@dynamic numberOfComponents;
@dynamic RGBAHex;
@dynamic RGBAString;

+ (UIColor *)colorWithRGBAString:(NSString *)colorString
{
    NSString *tmp = [colorString stringByTrimmingCharactersInSet:[NSCharacterSet punctuationCharacterSet]];
    NSScanner *scanner = [NSScanner scannerWithString:tmp];
    uint32_t colorValue = 0;
    [scanner scanHexInt:&colorValue];
    return [UIColor colorWithRGBAHex:colorValue];
}

+ (UIColor *)colorWithRGBAHex:(uint32_t)colorValue
{
    uint32_t r = (colorValue >> 24) & 0xFF;
    uint32_t g = (colorValue >> 16) & 0xFF;
    uint32_t b = (colorValue >> 8)  & 0xFF;
    uint32_t a = (colorValue >> 0)  & 0xFF;
        
    return [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a/255.0f];
}

#pragma mark -
#pragma mark Properties
- (BOOL)canProvideRGBAComponents
{
    BOOL canProvide = NO;
    
    switch (self.colorSpaceModel)
    {
		case kCGColorSpaceModelRGB:
		case kCGColorSpaceModelMonochrome:
			canProvide = YES;
            break;
		default:
            break;
	}
    
    return canProvide;
}

- (CGColorSpaceRef)colorSpace
{
    return CGColorGetColorSpace(self.CGColor);
}

- (NSString *)colorSpaceName
{
    NSString *name = @"Unsuported Colorspace";
    
	switch (self.colorSpaceModel)
    {
		case kCGColorSpaceModelUnknown:
			name = @"kCGColorSpaceModelUnknown";
            break;
		case kCGColorSpaceModelMonochrome:
			name = @"kCGColorSpaceModelMonochrome";
            break;
		case kCGColorSpaceModelRGB:
			name = @"kCGColorSpaceModelRGB";
            break;
		case kCGColorSpaceModelCMYK:
			name = @"kCGColorSpaceModelCMYK";
            break;
		case kCGColorSpaceModelLab:
			name = @"kCGColorSpaceModelLab";
            break;
		case kCGColorSpaceModelDeviceN:
			name = @"kCGColorSpaceModelDeviceN";
            break;
		case kCGColorSpaceModelIndexed:
			name = @"kCGColorSpaceModelIndexed";
            break;
		case kCGColorSpaceModelPattern:
			name = @"kCGColorSpaceModelPattern";
            break;
		default:
			break;
	}
    return name;
}

- (CGColorSpaceModel)colorSpaceModel
{
    return CGColorSpaceGetModel(self.colorSpace);
}

- (uint32_t)RGBAHex
{
    assert(self.canProvideRGBAComponents && "Color space model not supported");
    CGFloat r = 0.0f, g = 0.0f, b = 0.0f, a = 0.0f;
    [self red:&r green:&g blue:&b alpha:&a];
    
	r = MIN(MAX(r, 0.0f), 1.0f);
	g = MIN(MAX(g, 0.0f), 1.0f);
	b = MIN(MAX(b, 0.0f), 1.0f);
	a = MIN(MAX(a, 0.0f), 1.0f);
    
	return (((uint32_t)roundf(r * 255)) << 24) | (((uint32_t)roundf(g * 255)) << 16)
         | (((uint32_t)roundf(b * 255)) << 8)  | (((uint32_t)roundf(a * 255)) << 0);
}

- (NSString *)RGBAString
{
    return [NSString stringWithFormat:@"%08x", self.RGBAHex];
}

- (NSUInteger)numberOfComponents
{
    return CGColorGetNumberOfComponents(self.CGColor);
}

- (void)components:(CGFloat *)components
{
    const CGFloat *result = CGColorGetComponents(self.CGColor);
    *components = *result;
}

- (BOOL)red:(CGFloat *)red green:(CGFloat *)green blue:(CGFloat *)blue alpha:(CGFloat *)alpha
{
    BOOL haveValues = NO;
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	
	CGFloat r = 0.0f, g = 0.0f, b = 0.0f, a = 0.0f;
	
	switch(self.colorSpaceModel)
    {
		case kCGColorSpaceModelMonochrome:
			r = g = b = components[0];
			a = components[1];
            haveValues = YES;
			break;
		case kCGColorSpaceModelRGB:
			r = components[0];
			g = components[1];
			b = components[2];
			a = components[3];
            haveValues = YES;
			break;
		default:
            break;
	}
	
    if(haveValues && red)
    {
        *red = r;
    }
    if(haveValues && green)
    {
        *green = g;
    }
        
    if(haveValues && blue)
    {
        *blue = b;
    }
        
    if(haveValues && alpha)
    {
        *alpha = a;
    }
    
    return haveValues;
}
@end
