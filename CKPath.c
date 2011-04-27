/*
 *  © Copyright Crimson Research, Inc. 2008. All rights reserved.
 */

#include "CKPath.h"

void CKPathAddRoundedRect(CGMutablePathRef path, const CGAffineTransform *m, CGRect rect, CGFloat radius)
{
	CKPathAddRoundedRectWithCornerOptions(path, m, rect, radius, kCKPathAllCorners);
}

void CKPathAddRoundedRectWithCornerOptions(CGMutablePathRef path, const CGAffineTransform *m, CGRect rect, CGFloat radius, CKPathCornerOptions cornerOptions)
{
	if(CGRectEqualToRect(rect, CGRectZero))
    {
        return;
    }

	CGFloat minX = CGRectGetMinX(rect), maxX = CGRectGetMaxX(rect), minY = CGRectGetMinY(rect), maxY = CGRectGetMaxY(rect);
    if(cornerOptions & kCKPathTopLeftCorner)
    {
        CGPathAddArc(path, m, minX+radius, minY+radius, radius, DegreesToRadians(270), DegreesToRadians(180), 1);
    } else {
        CGPathMoveToPoint(path, m, minX, minY);
    }
    
    if(cornerOptions & kCKPathBottomLeftCorner)
    {
        CGPathAddArc(path, m, minX+radius, maxY-radius, radius, DegreesToRadians(180),  DegreesToRadians(90), 1);
    } else {
        CGPathAddLineToPoint(path, m, minX, maxY);
    }
    
    if(cornerOptions & kCKPathBottomRightCorner)
    {
        CGPathAddArc(path, m, maxX-radius, maxY-radius, radius, DegreesToRadians(90),   DegreesToRadians(0), 1);
    } else {
        CGPathAddLineToPoint(path, m, maxX, maxY);
    }
    
    if(cornerOptions & kCKPathTopRightCorner)
    {
        CGPathAddArc(path, m, maxX-radius, minY+radius, radius, DegreesToRadians(0), DegreesToRadians(270), 1);
    } else {
        CGPathAddLineToPoint(path, m, maxX, minY);
    }
        
    CGPathCloseSubpath(path);
}

CGPathRef CKPathCreateRoundedRect(CGRect rect, const CGAffineTransform *m, CGFloat radius)
{
    return CKPathCreateRountedRectWithCornerOptions(rect, m, radius, kCKPathAllCorners);
}

CGPathRef CKPathCreateRountedRectWithCornerOptions(CGRect rect, const CGAffineTransform *m, CGFloat radius, CKPathCornerOptions cornerOptions)
{
    CGMutablePathRef path = CGPathCreateMutable();
	CKPathAddRoundedRectWithCornerOptions(path, m, rect, radius, cornerOptions);
	return path;    
}
