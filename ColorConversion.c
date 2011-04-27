/*
 *  ColorConversion.c
 *  CrimsonKit
 *
 *  Created by Waqar Malik on 1/7/11.
 *  Copyright 2011 Crimson Research, Inc. All rights reserved.
 *
 */

#include <stdint.h>
#include "ColorConversion.h"

void RGBtoHSB(float_t red, float_t green, float_t blue, float_t *toHue, float_t *toSaturation, float_t *toBrightness)
{
	float_t h = 0.0f, s = 0.0f, b = 0.0f;
    
	float_t max = MAX(red, MAX(green, blue));
	float_t min = MIN(red, MIN(green, blue));
	
	b = max;
	
	s = (max != 0.0f) ? ((max - min) / max) : 0.0f;
	
	if(0.0f == s)
    {
		h = 0.0f;
	} else {
		float_t rc = (max - red) / (max - min);
		float_t gc = (max - green) / (max - min);
		float_t bc = (max - blue) / (max - min);
		
		if(red == max)
        {
            h = bc - gc;
        } else if (green == max) {
            h = 2 + rc - bc;
        } else {
            h = 4 + gc - rc;
        }
		
		h *= 60.0f;
		if(h < 0.0f)
        {
            h += 360.0f;
        }
	}
	
	if(toHue)
    {
        *toHue = h;
    }
    
	if(toSaturation)
    {
        *toSaturation = s;
    }
    
	if(toBrightness)
    {
        *toBrightness = b;
    }
}

void HSBtoRGB(float_t hue, float_t saturation, float_t brightness, float_t *toRed, float_t *toGreen, float_t *toBlue)
{
	float_t r = 0.0f, g = 0.0f, b = 0.0f;
    
	if(saturation == 0.0f)
    {
		r = g = b = brightness;
	} else {
		if(hue == 360.0f)
        {
            hue = 0.0f;
        }
        
		hue /= 60.0f;
		
		uint32_t i = (uint32_t)floorf(hue);
		float_t  f = hue - i;
		float_t  p = brightness * (1.0f - saturation);
		float_t  q = brightness * (1.0f - (saturation * f));
		float_t  t = brightness * (1.0f - (saturation * (1.0f - f)));
		
		switch(i)
        {
			case 0:	r = brightness; g = t; b = p; break;
			case 1:	r = q; g = brightness; b = p; break;
			case 2:	r = p; g = brightness; b = t; break;
			case 3:	r = p; g = q; b = brightness; break;
			case 4:	r = t; g = p; b = brightness; break;
			case 5:	r = brightness; g = p; b = q; break;
            default: break;
		}
	}
	
	if(toRed)
    {
        *toRed = r;
    }
    
	if(toGreen)
    {
        *toGreen = g;
    }
    
	if(toBlue)
    {
        *toBlue = b;
    }
}
