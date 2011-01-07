/*
 *  ColorConversion.h
 *  CrimsonKit
 *
 *  Created by Waqar Malik on 1/7/11.
 *  Copyright 2011 Crimson Research, Inc. All rights reserved.
 *
 */

#ifndef __COLORCONVERSION_H__
#define __COLORCONVERSION_H__

#include <math.h>
#include "CKSourceAnnotations.h"

#ifdef __cplusplus
extern "C" {
#endif
    
    void RGBtoHSB(float_t red, float_t green, float_t blue, float_t *toHue, float_t *toSaturation, float_t *toBrightness);
    void HSBtoRGB(float_t hue, float_t saturation, float_t brightness, float_t *toRed, float_t *toGreen, float_t *toBlue);

#ifdef __cplusplus
}
#endif

#endif /* __COLORCONVERSION_H__ */
