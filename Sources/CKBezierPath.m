//
//  CKBezierPath.m
//  CrimsonKit
//
//  Created by Waqar Malik on 2/7/10.
//  © Copyright 2008 Crimson Research, Inc. All rights reserved.
//

#import "CKBezierPath.h"

NSString *const CKBezierPathKey = @"CKBezierPath";
NSString *const CKBezierPathFlatnessKey = @"CKBezierPathFlatness";
NSString *const CKBezierPathLineWidthKey = @"CKBezierPathLineWidth";
NSString *const CKBezierPathMiterLimitKey = @"CKBezierPathMiterLimit";
NSString *const CKBezierPathLineCapStyleKey = @"CKBezierPathLineCapStyle";
NSString *const CKBezierPathLineJoinStyleKey = @"CKBezierPathLineJoinStyle";
NSString *const CKBezierPathEvenOddFillRuleKey = @"CKBezierPathUsesEvenOddFillRule";
NSString *const CKBezierPathDashCountKey = @"CKBezierPathDashCount";
NSString *const CKBezierPathDashPhaseKey = @"CKBezierPathDashPhase";
NSString *const CKBezierPathDashPatternKey = @"CKBezierPathDashPattern";
NSString *const CKBezierPathElementTypeKey = @"CKBezierPathElementType";
NSString *const CKBezierPathPoint0Key = @"point0";
NSString *const CKBezierPathPoint1Key = @"point1";
NSString *const CKBezierPathPoint2Key = @"point2";

@interface CKBezierPath (Private)
- (void)_setDefaults CLANG_ANALYZER_NORETURN;
- (void)_appendCGPath:(CGPathRef)cgPath CLANG_ANALYZER_NORETURN __attribute__((nonnull(1)));
@end

typedef struct
{
	CGMutablePathRef path;
	const CGAffineTransform	m;
} CKBezierTransform;

static void CKBezierPathTransformer(void *infoRecord, const CGPathElement *element)
{
	CKBezierTransform *info = infoRecord;
	CGMutablePathRef path = info->path;
    
	switch(element->type)
	{
		case kCGPathElementMoveToPoint:
			CGPathMoveToPoint(path, &info->m, element->points[0].x, element->points[0].y);
			break;
		case kCGPathElementAddLineToPoint:
			CGPathAddLineToPoint(path, &info->m, element->points[0].x, element->points[0].y);
			break;
		case kCGPathElementAddQuadCurveToPoint:
			CGPathAddQuadCurveToPoint(path, &info->m, element->points[0].x, element->points[0].y, element->points[1].x, element->points[1].y);
			break;
		case kCGPathElementAddCurveToPoint:
			CGPathAddCurveToPoint(path, &info->m, element->points[0].x, element->points[0].y, element->points[1].x, element->points[1].y, element->points[2].x, element->points[2].y);			
			break;
		case kCGPathElementCloseSubpath:
			CGPathCloseSubpath(path);
			break;
	}
}

static void CKBezierPathEncoder(void *infoRecord, const CGPathElement *element)
{
	NSMutableArray *elements = (NSMutableArray *)infoRecord;
    NSMutableDictionary *item = [NSMutableDictionary dictionary];
    [item setObject:[NSNumber numberWithInteger:element->type] forKey:CKBezierPathElementTypeKey];
    
    switch(element->type)
	{
        case kCGPathElementAddCurveToPoint:
            [item setObject:NSStringFromCGPoint(element->points[2]) forKey:CKBezierPathPoint2Key];
        case kCGPathElementAddQuadCurveToPoint:
            [item setObject:NSStringFromCGPoint(element->points[1]) forKey:CKBezierPathPoint1Key];            
		case kCGPathElementMoveToPoint:
		case kCGPathElementAddLineToPoint:
            [item setObject:NSStringFromCGPoint(element->points[0]) forKey:CKBezierPathPoint0Key];
			break;
        default:
            break;
	}
    
    [elements addObject:item];
}

@implementation CKBezierPath
@dynamic bounds, currentPoint, empty, CGPath;
@synthesize flatness = mFlatness, lineWidth = mLineWidth, miterLimit = mMiterLimit;
@synthesize lineCapStyle = mLineCapStyle, lineJoinStyle = mLineJoinStyle, usesEvenOddFillRule = mUsesEvenOddFillRule;

#pragma mark -
#pragma mark Object LifeCycle

- (id)init
{
    if(nil != (self = [super init]))
    {
        mCGPath = CGPathCreateMutable();
        [self _setDefaults];
    }
    
    return self;
}

- (void)dealloc
{
    if(NULL != mCGPath)
    {
        CGPathRelease(mCGPath), mCGPath = NULL;
    }
    
    if(NULL != mDashPattern)
    {
        NSZoneFree(NULL, mDashPattern), mDashPattern = NULL;
    }
    
    [super dealloc];
}

#pragma mark -
#pragma mark NSCoding Protocol
- (id)initWithCoder:(NSCoder *)coder
{
    if(nil != (self = [super init]))
    {
        mCGPath = CGPathCreateMutable();
        [self _setDefaults];
        NSArray *elements = [coder decodeObjectForKey:CKBezierPathKey];
        mFlatness = [coder decodeFloatForKey:CKBezierPathFlatnessKey];
        mLineWidth = [coder decodeFloatForKey:CKBezierPathLineWidthKey];
        mMiterLimit = [coder decodeFloatForKey:CKBezierPathMiterLimitKey];
        mLineCapStyle = (CGLineCap)[coder decodeIntForKey:CKBezierPathLineCapStyleKey];
        mLineJoinStyle = (CGLineJoin)[coder decodeIntForKey:CKBezierPathLineJoinStyleKey];
        mUsesEvenOddFillRule = [coder decodeBoolForKey:CKBezierPathEvenOddFillRuleKey];
        
        for(NSDictionary *element in elements)
        {
            CGPathElementType elementType = (CGPathElementType)[[element objectForKey:CKBezierPathElementTypeKey] integerValue];
            CGPoint point = CGPointFromString([element objectForKey:CKBezierPathPoint0Key]), point1 = CGPointZero, point2 = CGPointZero;
            switch(elementType)
            {
                case kCGPathElementMoveToPoint:
                    [self moveToPoint:point];
                    break;
                case kCGPathElementAddLineToPoint:
                    [self addLineToPoint:point];
                    break;
                case kCGPathElementAddQuadCurveToPoint:
                    point1 = CGPointFromString([element objectForKey:CKBezierPathPoint1Key]);
                    [self addQuadCurveToPoint:point1 controlPoint:point];
                    break;
                case kCGPathElementAddCurveToPoint:
                    point1 = CGPointFromString([element objectForKey:CKBezierPathPoint1Key]);
                    point2 = CGPointFromString([element objectForKey:CKBezierPathPoint2Key]);
                    [self addCurveToPoint:point2 controlPoint1:point controlPoint2:point1];
                    break;
                case kCGPathElementCloseSubpath:
                    [self closePath];
                    break;
            }
        }
        
        if(mDashCount > 0)
        {
            NSInteger count = [coder decodeIntForKey:CKBezierPathDashCountKey];
            CGFloat phase = [coder decodeFloatForKey:CKBezierPathDashPhaseKey];

            NSArray *values = [coder decodeObjectForKey:CKBezierPathDashPatternKey];
            CGFloat *pattern = NSZoneMalloc(NULL, (size_t)count * sizeof(CGFloat));
            NSInteger i = 0;
            for(NSNumber *number in values)
            {
                pattern[i++] = [number floatValue];
            }
            [self setLineDash:pattern count:count phase:phase];
            NSZoneFree(NULL, pattern), pattern = NULL;
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    NSMutableArray *array = [[NSMutableArray array] retain];
    CGPathApply(mCGPath, array, CKBezierPathEncoder);
    [coder encodeObject:array forKey:CKBezierPathKey];
    [coder encodeFloat:mFlatness forKey:CKBezierPathFlatnessKey];
    [coder encodeFloat:mLineWidth forKey:CKBezierPathLineWidthKey];
    [coder encodeFloat:mMiterLimit forKey:CKBezierPathMiterLimitKey];
    [coder encodeInt:mLineCapStyle forKey:CKBezierPathLineCapStyleKey];
    [coder encodeInt:mLineJoinStyle forKey:CKBezierPathLineJoinStyleKey];
    [coder encodeBool:mUsesEvenOddFillRule forKey:CKBezierPathEvenOddFillRuleKey];
    [array release], array = nil;
    
    if(mDashCount > 0)
    {
        [coder encodeInt:mDashCount forKey:CKBezierPathDashCountKey];
        [coder encodeFloat:mDashPhase forKey:CKBezierPathDashPhaseKey];
        
        NSMutableArray *values = [NSMutableArray arrayWithCapacity:(NSUInteger)mDashCount];
        for(NSInteger i = 0; i < mDashCount; i++)
        {
            [values addObject:[NSNumber numberWithFloat:mDashPattern[i]]];
        }
        [coder encodeObject:values forKey:CKBezierPathDashPatternKey];
    }
}

#pragma mark -
#pragma mark NSCopying Protocol
- (id)copyWithZone:(NSZone *)zone
{
    CKBezierPath *path = [[CKBezierPath allocWithZone:zone] init];
    path.CGPath = mCGPath;
    path.flatness = mFlatness;
    path.lineCapStyle = mLineCapStyle;
    path.lineJoinStyle = mLineJoinStyle;
    path.lineWidth = mLineWidth;
    path.miterLimit = mMiterLimit;
    path.usesEvenOddFillRule = mUsesEvenOddFillRule;
    if(mDashCount > 0)
    {
        [path setLineDash:mDashPattern count:mDashCount phase:mDashPhase];
    }
    return path;
}

    // Creating a CKBezierPath Object
+ (CKBezierPath *)bezierPath
{
    return [[[self class] new] autorelease];
}

+ (CKBezierPath *)bezierPathWithRect:(CGRect)rect
{
    CKBezierPath *bezierPath = [[self class] new];
    [bezierPath appendBezierPathWithRect:rect];
    
    return [bezierPath autorelease];
}

+ (CKBezierPath *)bezierPathWithOvalInRect:(CGRect)rect
{
    CKBezierPath *bezierPath = [[self class] new];
    [bezierPath appendBezierPathWithOvalInRect:rect];
    
    return [bezierPath autorelease];
}

+ (CKBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius
{
    CKBezierPath *bezierPath = [[self class] new];
    [bezierPath appendBezierPathWithRoundedRect:rect byRoundingCorners:CKRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];

    return [bezierPath autorelease];
}

+ (CKBezierPath *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(CKRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    CKBezierPath *bezierPath = [[self class] new];
    [bezierPath appendBezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
    
    return [bezierPath autorelease];    
}

+ (CKBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
{
    CKBezierPath *bezierPath = [[self class] new];
    [bezierPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
    
    return [bezierPath autorelease];
}

+ (CKBezierPath *)bezierPathWithCGPath:(CGPathRef)cgPath
{
    CKBezierPath *path = [[self class] new];
    [path _appendCGPath:cgPath];
    return [path autorelease];
}

#pragma mark -
#pragma mark Properties
- (CGRect)bounds
{
    return CGPathGetBoundingBox(mCGPath);
}

- (CGPoint)currentPoint
{
    return CGPathGetCurrentPoint(mCGPath);
}

- (BOOL)isEmpty
{
    return CGPathIsEmpty(mCGPath);
}

- (CGPathRef)CGPath
{
    return mCGPath;
}

- (void)setCGPath:(CGPathRef)path
{
    assert(NULL != path && "Null Path");
    CGPathRelease(mCGPath);
    mCGPath = CGPathCreateMutableCopy(path);
}

- (void)appendBezierPathWithRect:(CGRect)rect
{
    CGPathAddRect(mCGPath, &mTransform, rect);
}

- (void)appendBezierPathWithOvalInRect:(CGRect)rect
{
    CGPathAddEllipseInRect(mCGPath, &mTransform, rect);
}

- (void)appendBezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(CKRectCorner)corners cornerRadii:(CGSize)cornerRadii
{
    if(CGRectEqualToRect(rect, CGRectZero))
    {
        return;
    }
    
        // clamp down the x radius to the mid of the rect.
    if(CGRectGetWidth(rect)/2.0f < cornerRadii.width)
    {
        cornerRadii.width = CGRectGetWidth(rect)/2.0f;
    }
    
    if(CGRectGetHeight(rect)/2.0f < cornerRadii.height)
    {
        cornerRadii.height = CGRectGetHeight(rect)/2.0f;
    }
    
        // if either of the radius is no positive we just add a rect.
    if(0 >= cornerRadii.width || 0 >= cornerRadii.height)
    {
        CGPathAddRect(mCGPath, &mTransform, rect);
        return;
    }
        
    CGMutablePathRef path = CGPathCreateMutable();
    
    CGFloat minX = CGRectGetMinX(rect), maxX = CGRectGetMaxX(rect), minY = CGRectGetMinY(rect), maxY = CGRectGetMaxY(rect);
    if(corners & CKRectCornerTopLeft)
    {
        CGPathMoveToPoint(path, &mTransform, minX+cornerRadii.width, minY);
        CGPathAddQuadCurveToPoint(path, &mTransform, minX, minY, minX, minY+cornerRadii.height);
    } else {
        CGPathMoveToPoint(path, &mTransform, minX, minY);
    }
    
    if(corners & CKRectCornerBottomLeft)
    {
        CGPathAddLineToPoint(path, &mTransform, minX, maxY-cornerRadii.height);
        CGPathAddQuadCurveToPoint(path, &mTransform, minX, maxY, minX+cornerRadii.width, maxY);
    } else {
        CGPathAddLineToPoint(path, &mTransform, minX, maxY);
    }
    
    if(corners & CKRectCornerBottomRight)
    {
        CGPathAddLineToPoint(path, &mTransform, maxX-cornerRadii.width, maxY);
        CGPathAddQuadCurveToPoint(path, &mTransform, maxX, maxY, maxX, maxY-cornerRadii.height);
    } else {
        CGPathAddLineToPoint(path, &mTransform, maxX, maxY);
    }
    
    if(corners & CKRectCornerTopRight)
    {
        CGPathAddLineToPoint(path, &mTransform, maxX, minY+cornerRadii.height);
        CGPathAddQuadCurveToPoint(path, &mTransform, maxX, minY, maxX-cornerRadii.width, minY);
    } else {
        CGPathAddLineToPoint(path, &mTransform, maxX, minY);
    }
    
    CGPathCloseSubpath(path);
    
    CGPathAddPath(mCGPath, &mTransform, path);
    CGPathRelease(path), path = NULL;
}

    // Constructing a Path
- (void)moveToPoint:(CGPoint)point
{
    CGPathMoveToPoint(mCGPath, &mTransform, point.x, point.y);
}

- (void)addLineToPoint:(CGPoint)point
{
    CGPathAddLineToPoint(mCGPath, &mTransform, point.x, point.y);
}

- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2
{
    CGPathAddCurveToPoint(mCGPath, &mTransform, controlPoint1.x, controlPoint1.y, controlPoint2.x, controlPoint2.y, endPoint.x, endPoint.y);
}

- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint
{
    CGPathAddQuadCurveToPoint(mCGPath, &mTransform, controlPoint.x, controlPoint.y, endPoint.x, endPoint.y);
}

- (void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise
{
    CGPathAddArc(mCGPath, &mTransform, center.x, center.y, radius, startAngle, endAngle, clockwise);	
}

- (void)closePath
{
    CGPathCloseSubpath(mCGPath);
}

- (void)removeAllPoints
{
    CGPathRelease(mCGPath);
    mCGPath = CGPathCreateMutable();
}

- (void)appendPath:(CKBezierPath *)bezierPath
{
    CGPathAddPath(mCGPath, &mTransform, bezierPath.CGPath);
}

    // Accessing Drawing Properties
- (void)setLineDash:(const CGFloat *)pattern count:(NSInteger)count phase:(CGFloat)phase
{
    if(NULL != mDashPattern)
    {
        free(mDashPattern);
    }
    
    mDashCount = count;
    mDashPhase = phase;
    mDashPattern = NSZoneMalloc(NULL, (size_t)mDashCount * sizeof(CGFloat));
    memcpy(mDashPattern, pattern, sizeof(CGFloat) * (size_t)mDashCount);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineDash(context, mDashPhase, mDashPattern, (size_t)mDashCount);
}

- (void)getLineDash:(CGFloat *)pattern count:(NSInteger *)count phase:(CGFloat *)phase
{
    *count = mDashCount;
    *phase = mDashPhase;
    
    memcpy(pattern, mDashPattern, sizeof(CGFloat) * (size_t)mDashCount);
}

    // Drawing Paths
- (void)fill
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, mCGPath);
    CGContextDrawPath(context, mUsesEvenOddFillRule ? kCGPathEOFill : kCGPathFill);
}

- (void)fillWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetBlendMode(context, blendMode);
    CGContextSetAlpha(context, alpha);
    CGContextAddPath(context, mCGPath);
    CGContextDrawPath(context, mUsesEvenOddFillRule ? kCGPathEOFill : kCGPathFill);
}

- (void)stroke
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetMiterLimit(context, self.miterLimit);
    CGContextSetFlatness(context, self.flatness);
    CGContextSetLineCap(context, self.lineCapStyle);
    CGContextSetLineJoin(context, self.lineJoinStyle);
    CGContextAddPath(context, mCGPath);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);   
}

- (void)strokeWithBlendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetMiterLimit(context, self.miterLimit);
    CGContextSetFlatness(context, self.flatness);
    CGContextSetLineCap(context, self.lineCapStyle);
    CGContextSetLineJoin(context, self.lineJoinStyle);
    CGContextSetBlendMode(context, blendMode);
    CGContextSetAlpha(context, alpha);
    CGContextAddPath(context, mCGPath);
    CGContextDrawPath(context, kCGPathStroke);
    CGContextRestoreGState(context);   
}

    // Clipping Paths
- (void)addClip
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, mCGPath);
    mUsesEvenOddFillRule ? CGContextEOClip(context) : CGContextClip(context);
}

    // Hit Detection
- (BOOL)containsPoint:(CGPoint)point
{
    return CGPathContainsPoint(mCGPath, &mTransform, point, mUsesEvenOddFillRule);
}

    // Applying Tranformations
- (void)applyTransform:(CGAffineTransform)transform
{
	CKBezierTransform rec = {CGPathCreateMutable(), transform};
	CGPathApply(mCGPath, &rec, CKBezierPathTransformer);
    self.CGPath = rec.path;
    CGPathRelease(rec.path);
}
@end

@implementation CKBezierPath (Private)
- (void)_setDefaults
{
    mFlatness = 0.6f;
    mLineWidth = 1.0f;
    mMiterLimit = 10.0f;
    mLineCapStyle = kCGLineCapButt;
    mLineJoinStyle = kCGLineJoinMiter;
    mUsesEvenOddFillRule = NO;
    mTransform = CGAffineTransformIdentity;
    mDashPattern = NULL;
    mDashCount = 0;
    mDashPhase = 0.0f;
}

- (void)_appendCGPath:(CGPathRef)cgPath
{
    assert(NULL != cgPath && "NULL path");
    CGPathAddPath(mCGPath, &mTransform, cgPath);
}
@end
