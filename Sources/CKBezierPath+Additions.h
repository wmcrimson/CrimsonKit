//
//  CKBezierPath+Additions.h
//  CrimsonKit
//
//  Created by Waqar Malik on 3/8/10.
//  © Copyright 2008 Crimson Research, Inc. All rights reserved.
//

#import "CKBezierPath.h"

@interface CKBezierPath (Additions)
+ (CKBezierPath *)bezierPathWithRoundedRect:(CGRect)rect xRadius:(CGFloat)xRadius yRadius:(CGFloat)yRadius;

- (void)lineToPoint:(CGPoint)point;
- (void)relativeMoveToPoint:(CGPoint)point;
- (void)relativeLineToPoint:(CGPoint)point;
- (void)curveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
- (void)addRelativeCurveToPoint:(CGPoint)point controlPoint1:(CGPoint)cp1 controlPoint2:(CGPoint)cp2;
- (void)appendCGPath:(CGPathRef)cgPath;

- (void)appendBezierPath:(CKBezierPath *)path;
- (void)appendBezierPathWithArcFromPoint:(CGPoint)fromPoint toPoint:(CGPoint)toPoint radius:(CGFloat)radius;
- (void)appendBezierPathWithArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle;
- (void)appendBezierPathWithPoints:(CGPoint *)points count:(NSInteger)count;
- (void)appendBezierPathWithRoundedRect:(CGRect)rect xRadius:(CGFloat)xRadius yRadius:(CGFloat)yRadius;

+ (void)fillRect:(CGRect)rect;
+ (void)strokeRect:(CGRect)rect;
+ (void)strokeLineFromPoint:(CGPoint)point1 toPoint:(CGPoint)point2;
+ (void)clipRect:(CGRect)rect;

- (void)appendBezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;
@end
