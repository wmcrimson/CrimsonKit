//
//  CKGradient.h
//  CrimsonKit
//
//  Created by Waqar Malik on 2/7/10.
//  © Copyright 2008 Crimson Research, Inc. All rights reserved.
//

#import "CKSourceAnnotations.h"

#if MAC_OS_X
#define UIColor NSColor
#endif

@class CKBezierPath;

@interface CKGradient : NSObject
{
@protected
    CFMutableArrayRef   mCGColors;
	CGGradientRef		mCGGradient;
	CGColorSpaceRef		mColorSpace;
	NSUInteger			mNumberOfColorStops;
	CGFloat				*mLocations;
}

@property (nonatomic, readonly, assign) CGColorSpaceRef colorSpace;
@property (nonatomic, readonly, assign) NSUInteger numberOfColorStops;
@property (nonatomic, readonly, assign) CGGradientRef CGGradient;

// Initialization

- (id)initWithStartingColor:(UIColor *)startingColor endingColor:(UIColor *)endingColor;
- (id)initWithColors:(NSArray *)colorArray;

// Color Location Color Location (MUST be nil terminated)

- (id)initWithColorsAndLocations:(UIColor *)firstColor, ... NS_REQUIRES_NIL_TERMINATION;
- (id)initWithColors:(NSArray *)colorArray atLocations:(const CGFloat *)locations colorSpace:(CGColorSpaceRef)colorSpace;

// Primitive Drawing Methods

- (void)drawFromPoint:(CGPoint)startingPoint toPoint:(CGPoint)endingPoint options:(CGGradientDrawingOptions)options CLANG_ANALYZER_NORETURN;
- (void)drawFromCenter:(CGPoint)startCenter radius:(CGFloat)startRadius toCenter:(CGPoint)endCenter radius:(CGFloat)endRadius options:(CGGradientDrawingOptions)options CLANG_ANALYZER_NORETURN;

// Drawing Linear Gradients

- (void)drawInRect:(CGRect)rect angle:(CGFloat)angle CLANG_ANALYZER_NORETURN;
- (void)drawInBezierPath:(CKBezierPath *)path angle:(CGFloat)angle CLANG_ANALYZER_NORETURN;

// Drawing Radial Gradients
- (void)drawInRect:(CGRect)rect relativeCenterPosition:(CGPoint)relativeCenterPosition CLANG_ANALYZER_NORETURN;
- (void)drawInBezierPath:(CKBezierPath *)path relativeCenterPosition:(CGPoint)relativeCenterPosition CLANG_ANALYZER_NORETURN;

- (void)getColor:(UIColor **)color location:(CGFloat *)location atIndex:(NSInteger)colorIndex CLANG_ANALYZER_NORETURN;

// Assuming that color and locations are always increasing.
- (UIColor *)interpolatedColorAtLocation:(CGFloat)location NS_RETURNS_NOT_RETAINED;
@end
