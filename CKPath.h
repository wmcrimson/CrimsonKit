/*
 *  © Copyright Crimson Research, Inc. 2008. All rights reserved.
 */

#ifndef __CKPATH_H__
#define __CKPATH_H__

#include <CoreGraphics/CoreGraphics.h>
#include <math.h>

#include "CKSourceAnnotations.h"

#if !defined(DegreesToRadians)
#define DegreesToRadians(x) (x * (CGFloat)M_PI / 180.0f)
#endif

#if !defined(RadiansToDegrees)
#define RadiansToDegrees(x) (x * 180.0f / (CGFloat)M_PI)
#endif

#ifdef __cplusplus
extern "C" {
#endif
    
    typedef enum
    {
        kCKPathTopLeftCorner = 1 << 0,
        kCKPathTopRightCorner = 1 << 1,
        kCKPathBottomLeftCorner = 1 << 2,
        kCKPathBottomRightCorner = 1 << 3,
        kCKPathAllCorners = (kCKPathTopLeftCorner | kCKPathTopRightCorner | kCKPathBottomLeftCorner | kCKPathBottomRightCorner)
    } CKPathCornerOptions;
    
    void CKPathAddRoundedRect(CGMutablePathRef path, const CGAffineTransform *m, CGRect rect, CGFloat radius) __attribute__((nonnull(1)));
	void CKPathAddRoundedRectWithCornerOptions(CGMutablePathRef path, const CGAffineTransform *m, CGRect rect, CGFloat radius, CKPathCornerOptions cornerOptions) __attribute__((nonnull(1)));
    CGPathRef CKPathCreateRoundedRect(CGRect rect, const CGAffineTransform *m, CGFloat radius);
    CGPathRef CKPathCreateRountedRectWithCornerOptions(CGRect rect, const CGAffineTransform *m, CGFloat radius, CKPathCornerOptions cornerOptions);
   
#ifdef __cplusplus
}
#endif

#endif /* __CKPATH_H__ */
