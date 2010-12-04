//
//  CKGradient.h
//  CrimsonKit
//
//  Created by Waqar Malik on 2/7/10.
//  © Copyright 2008 Crimson Research, Inc. All rights reserved.
//

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

- (id)initWithColorsAndLocations:(UIColor *)firstColor, ...;
- (id)initWithColors:(NSArray *)colorArray atLocations:(const CGFloat *)locations colorSpace:(CGColorSpaceRef)colorSpace;

// Primitive Drawing Methods

- (void)drawFromPoint:(CGPoint)startingPoint toPoint:(CGPoint)endingPoint options:(CGGradientDrawingOptions)options;
- (void)drawFromCenter:(CGPoint)startCenter radius:(CGFloat)startRadius toCenter:(CGPoint)endCenter radius:(CGFloat)endRadius options:(CGGradientDrawingOptions)options;

// Drawing Linear Gradients

- (void)drawInRect:(CGRect)rect angle:(CGFloat)angle;
- (void)drawInBezierPath:(CKBezierPath *)path angle:(CGFloat)angle;

// Drawing Radial Gradients
- (void)drawInRect:(CGRect)rect relativeCenterPosition:(CGPoint)relativeCenterPosition;
- (void)drawInBezierPath:(CKBezierPath *)path relativeCenterPosition:(CGPoint)relativeCenterPosition;

- (void)getColor:(UIColor **)color location:(CGFloat *)location atIndex:(NSInteger)colorIndex;

// Assuming that color and locations are always increasing.
- (UIColor *)interpolatedColorAtLocation:(CGFloat)location;
@end
