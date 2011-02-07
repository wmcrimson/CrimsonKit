//
//  UIColor+Crimson.m
//  CrimsonKit
//
//  Created by Waqar Malik on 12/31/10.
//  Copyright 2010 Crimson Research, Inc. All rights reserved.
//

#import "ColorConversion.h"
#import "UIColor+CrimsonKit.h"

@implementation UIColor (CrimsonKit)
@dynamic canProvideRGBAComponents;
@dynamic colorSpace;
@dynamic colorSpaceName;
@dynamic colorSpaceModel;
@dynamic numberOfComponents;
@dynamic RGBAHex;
@dynamic RGBAString;

@dynamic alpha;
@dynamic black;
@dynamic blue;
@dynamic brightness;
@dynamic cyan;
@dynamic green;
@dynamic hue;
@dynamic magenta;
@dynamic red;
@dynamic saturation;
@dynamic white;
@dynamic yellow;

+ (UIColor *)colorWithRGBAString:(NSString *)colorString
{
    assert(nil != colorString && "cannot create colors for null string");
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

+ (void)red:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue toHue:(CGFloat *)toHue saturation:(CGFloat *)toSaturation brightness:(CGFloat *)toBrightness
{
        // if all the return pointers are NULL we don't need to do any math just return
    if(!(NULL == toHue && NULL == toSaturation && NULL == toBrightness))
    {
        RGBtoHSB(red, green, blue, toHue, toSaturation, toBrightness);
    }
}

+ (void)hue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness toRed:(CGFloat *)toRed green:(CGFloat *)toGreen blue:(CGFloat *)toBlue
{
        // if all the return pointers are NULL we don't need to do any math just return
    if(!(NULL == toRed && NULL == toGreen && NULL == toBlue))
    {
        HSBtoRGB(hue, saturation, brightness, toRed, toGreen, toBlue);
    }
}

#pragma mark -
#pragma mark Properties
- (CGFloat)alpha
{
    return CGColorGetAlpha(self.CGColor);
}

- (CGFloat)black
{
    CGFloat black = 0.0f;
    [self cyan:NULL magenta:NULL yellow:NULL black:&black alpha:NULL];
    return  black;    
}

- (CGFloat)blue
{
    CGFloat blue = 0.0f;
    [self red:NULL green:NULL blue:&blue alpha:NULL];
    return blue;
}

- (CGFloat)brightness
{
    CGFloat brightness = 0.0f;
    [self hue:NULL saturation:NULL brightness:&brightness alpha:NULL];
    return brightness;
}

- (CGFloat)cyan
{
    CGFloat cyan = 0.0f;
    [self cyan:&cyan magenta:NULL yellow:NULL black:NULL alpha:NULL];
    return cyan;    
}

- (CGFloat)green
{
    CGFloat green = 0.0f;
    [self red:NULL green:&green blue:NULL alpha:NULL];
    return green;
}

- (CGFloat)hue
{
    CGFloat hue = 0.0f;
    [self hue:&hue saturation:NULL brightness:NULL alpha:NULL];
    return hue;
}

- (CGFloat)magenta
{
    CGFloat magenta = 0.0f;
    [self cyan:NULL magenta:&magenta yellow:NULL black:NULL alpha:NULL];
    return magenta;    
}

- (CGFloat)red
{
    CGFloat red = 0.0f;
    [self red:&red green:NULL blue:NULL alpha:NULL];
    return red; 
}

- (CGFloat)saturation
{
    CGFloat saturation = 0.0f;
    [self hue:NULL saturation:&saturation brightness:NULL alpha:NULL];
    return saturation;
}

- (CGFloat)white
{
    CGFloat white = 0.0f;
    [self white:&white alpha:NULL];
    return white;
}

- (CGFloat)yellow
{
    CGFloat yellow = 0.0f;
    [self cyan:NULL magenta:NULL yellow:&yellow black:NULL alpha:NULL];
    return  yellow;
}

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
    NSString *name = @"Unsupported Colorspace";
    
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
    assert(self.canProvideRGBAComponents && "Color space not supported.");
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

- (BOOL)white:(CGFloat *)white alpha:(CGFloat *)alpha
{
    BOOL haveValues = NO;
    assert(kCGColorSpaceModelMonochrome == self.colorSpaceModel && "Invalid Color");
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    haveValues = NULL != components;
    if(haveValues && white)
    {
        *white = components[0];
    }
    
    if(haveValues && alpha)
    {
        *alpha = components[1];
    }
    
    return haveValues;
}

- (BOOL)cyan:(CGFloat *)cyan magenta:(CGFloat *)magenta yellow:(CGFloat *)yellow black:(CGFloat *)black alpha:(CGFloat *)alpha
{
    assert(self.canProvideRGBAComponents && "Invalid Color");
    CGFloat r = 0.0f, g = 0.0f, b = 0.0f, a = 0.0f;
    BOOL haveValues = [self red:&r green:&g blue:&b alpha:&a];
    CGFloat c = 0.0f, m = 0.0f, y = 0.0f, k = 0.0f;
    if(0.0f == r && 0.0f == g && 0.0f == b)
    {
        k = 1;
    } else {
        c = 1.0f - r;
        m = 1.0f - g;
        y = 1.0f - b;
        k = MIN(c, MIN(m, y));
        
        c = (c - k) / (1.0f - k);
        m = (m - k) / (1.0f - k);
        y = (y - k) / (1.0f - k);
    }
    
    if(haveValues && cyan)
    {
        *cyan = c;
    }
    
    if(haveValues && magenta)
    {
        *magenta = m;
    }
    
    if(haveValues && yellow)
    {
        *yellow = y;
    }
    
    if(haveValues && black)
    {
        *black = k;
    }
    
    if(haveValues && alpha)
    {
        *alpha = a;
    }
    
    return haveValues;
}

- (BOOL)hue:(CGFloat *)hue saturation:(CGFloat *)saturation brightness:(CGFloat *)brightness alpha:(CGFloat *)alpha
{
#pragma unused (alpha)
    assert(self.canProvideRGBAComponents && "Invalid Color");
    CGFloat r = 0.0f, g = 0.0f, b = 0.0f, a = 0.0f;
    BOOL haveValues = [self red:&r green:&g blue:&b alpha:&a];
    [UIColor red:r green:g blue:b toHue:hue saturation:saturation brightness:brightness];
    
    return haveValues;
}
@end
