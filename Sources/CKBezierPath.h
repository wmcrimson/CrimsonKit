//
//  CKBezierPath.h
//  CrimsonKit
//
//  Created by Waqar Malik on 2/7/10.
//  © Copyright 2008 Crimson Research, Inc. All rights reserved.
//
//  $Id: CKBezierPath.h 99 2010-06-25 21:00:49Z malik $
//

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

@property(nonatomic, readonly) CGRect bounds;
@property(nonatomic, readonly) CGPoint currentPoint;
@property(readonly, getter=isEmpty) BOOL empty;
@property(nonatomic) CGPathRef CGPath;

@property(nonatomic) CGFloat flatness; // (0.6)
@property(nonatomic) CGLineCap lineCapStyle; // (kCGLineCapButt)
@property(nonatomic) CGLineJoin lineJoinStyle; // (kCGLineJoinMiter)
@property(nonatomic) CGFloat lineWidth; // (1.0)
@property(nonatomic) CGFloat miterLimit; // (10)
@property(nonatomic) BOOL usesEvenOddFillRule; //(NO)

    // Creating a CKBezierPath Object
+ (CKBezierPath *)bezierPath;
+ (CKBezierPath *)bezierPathWithRect:(CGRect)rect;
+ (CKBezierPath *)bezierPathWithOvalInRect:(CGRect)rect;
+ (CKBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
+ (CKBezierPath *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(CKRectCorner)corners cornerRadii:(CGSize)cornerRadii;
+ (CKBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
+ (CKBezierPath *)bezierPathWithCGPath:(CGPathRef)cgPath;

- (void)appendBezierPathWithRect:(CGRect)rect;
- (void)appendBezierPathWithOvalInRect:(CGRect)rect;
- (void)appendBezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(CKRectCorner)corners cornerRadii:(CGSize)cornerRadii;

    // Constructing a Path
- (void)moveToPoint:(CGPoint)point;
- (void)addLineToPoint:(CGPoint)point;
- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
- (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;
- (void)closePath;
- (void)removeAllPoints;
- (void)appendPath:(CKBezierPath *)bezierPath;

    // Accessing Drawing Properties
- (void)setLineDash:(const CGFloat *)pattern count:(NSInteger)count phase:(CGFloat)phase;
- (void)getLineDash:(CGFloat *)pattern count:(NSInteger *)count phase:(CGFloat *)phase;

    // Drawing Paths
- (void)fill;
- (void)fillWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;
- (void)stroke;
- (void)strokeWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha;

    // Clipping Paths
- (void)addClip;

    // Hit Detection
- (BOOL)containsPoint:(CGPoint)point;

    // Applying Tranformations
- (void)applyTransform:(CGAffineTransform)transform;
@end
