//
//  CKBezierPath.h
//  CrimsonKit
//
//  Created by Waqar Malik on 2/7/10.
//  © Copyright 2008 Crimson Research, Inc. All rights reserved.
//

#import "CKSourceAnnotations.h"

#if !defined(DegreesToRadians)
#define DegreesToRadians(x) (x * (CGFloat)M_PI / 180.0f)
#endif

#if !defined(RadiansToDegrees)
#define RadiansToDegrees(x) (x * 180.0f / (CGFloat)M_PI)
#endif

typedef enum {
    CKRectCornerTopLeft     = 1 << 0,
    CKRectCornerTopRight    = 1 << 1,
    CKRectCornerBottomLeft  = 1 << 2,
    CKRectCornerBottomRight = 1 << 3,
    CKRectCornerAllCorners  = (CKRectCornerTopLeft | CKRectCornerTopRight | CKRectCornerBottomLeft | CKRectCornerBottomRight)
} CKRectCorner;

@interface CKBezierPath : NSObject <NSCoding, NSCopying>
{
@private
    CGMutablePathRef mCGPath;
    CGFloat mFlatness, mLineWidth, mMiterLimit;
    CGLineCap mLineCapStyle;
    CGLineJoin mLineJoinStyle;
    BOOL mUsesEvenOddFillRule;
    CGAffineTransform mTransform;
    CGFloat *mDashPattern;
    NSInteger mDashCount;
    CGFloat mDashPhase;
}

@property(nonatomic, readonly, assign) CGRect bounds;
@property(nonatomic, readonly, assign) CGPoint currentPoint;
@property(readonly, getter=isEmpty, assign) BOOL empty;
@property(nonatomic, assign) CGPathRef CGPath;

@property(nonatomic, assign) CGFloat flatness; // (0.6)
@property(nonatomic, assign) CGLineCap lineCapStyle; // (kCGLineCapButt)
@property(nonatomic, assign) CGLineJoin lineJoinStyle; // (kCGLineJoinMiter)
@property(nonatomic, assign) CGFloat lineWidth; // (1.0)
@property(nonatomic, assign) CGFloat miterLimit; // (10)
@property(nonatomic, assign) BOOL usesEvenOddFillRule; //(NO)

    // Creating a CKBezierPath Object
+ (CKBezierPath *)bezierPath NS_RETURNS_NOT_RETAINED;
+ (CKBezierPath *)bezierPathWithRect:(CGRect)rect NS_RETURNS_NOT_RETAINED;
+ (CKBezierPath *)bezierPathWithOvalInRect:(CGRect)rect NS_RETURNS_NOT_RETAINED;
+ (CKBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius NS_RETURNS_NOT_RETAINED;
+ (CKBezierPath *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(CKRectCorner)corners cornerRadii:(CGSize)cornerRadii NS_RETURNS_NOT_RETAINED;
+ (CKBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise NS_RETURNS_NOT_RETAINED;
+ (CKBezierPath *)bezierPathWithCGPath:(CGPathRef)cgPath NS_RETURNS_NOT_RETAINED;

- (void)appendBezierPathWithRect:(CGRect)rect CLANG_ANALYZER_NORETURN;
- (void)appendBezierPathWithOvalInRect:(CGRect)rect CLANG_ANALYZER_NORETURN;
- (void)appendBezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(CKRectCorner)corners cornerRadii:(CGSize)cornerRadii CLANG_ANALYZER_NORETURN;

    // Constructing a Path
- (void)moveToPoint:(CGPoint)point CLANG_ANALYZER_NORETURN;
- (void)addLineToPoint:(CGPoint)point CLANG_ANALYZER_NORETURN;
- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2 CLANG_ANALYZER_NORETURN;
- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint CLANG_ANALYZER_NORETURN;
- (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise CLANG_ANALYZER_NORETURN;
- (void)closePath CLANG_ANALYZER_NORETURN;
- (void)removeAllPoints CLANG_ANALYZER_NORETURN;
- (void)appendPath:(CKBezierPath *)bezierPath CLANG_ANALYZER_NORETURN;

    // Accessing Drawing Properties
- (void)setLineDash:(const CGFloat *)pattern count:(NSInteger)count phase:(CGFloat)phase CLANG_ANALYZER_NORETURN;
- (void)getLineDash:(CGFloat *)pattern count:(NSInteger *)count phase:(CGFloat *)phase CLANG_ANALYZER_NORETURN;

    // Drawing Paths
- (void)fill CLANG_ANALYZER_NORETURN;
- (void)fillWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha CLANG_ANALYZER_NORETURN;
- (void)stroke CLANG_ANALYZER_NORETURN;
- (void)strokeWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha CLANG_ANALYZER_NORETURN;

    // Clipping Paths
- (void)addClip CLANG_ANALYZER_NORETURN;

    // Hit Detection
- (BOOL)containsPoint:(CGPoint)point;

    // Applying Tranformations
- (void)applyTransform:(CGAffineTransform)transform CLANG_ANALYZER_NORETURN;
@end
