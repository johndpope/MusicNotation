//
//  VFMath.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFMath.h"

float vfmax(float a, float b) {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}

float vfmin(float a, float b) {
    if (a < b) {
        return a;
    } else {
        return b;
    }
}

float vfroundN(NSInteger x, NSInteger n) {
    //    return (x % n) >= (n/2) ? parseInt(x / n) * n + n : parseInt(x / n) * n;
    return x % n >= roundf(n / 2.) ?
    roundf(x / ((float)n) * n + n) :
    roundf(x / ((float)n)) * ((float)n);
}

NSUInteger vfmidline(NSUInteger a, NSUInteger b) {
    float mid_line = b + (a - b) / 2;
    if (((int)floor(mid_line)) % 2 > 0) {
        mid_line = vfroundN((mid_line * 10), 5) / 10;
    }
    return (int)mid_line;
}


@implementation VFMath

+ (float)Max:(float)a :(float)b; {
    if (a > b) {
        return a;
    } else {
        return b;
    }
}




/*
 **
 * Min / Max: If you don't know what this does, you should be ashamed of yourself.
 *
 Vex.Min = function(a, b) {
 return (a > b) ? b : a;
 };
 */


/*
 Vex.Max = function(a, b) {
 return (a > b) ? a : b;
 };
 */


/*
 // Round number to nearest fractional value (.5, .25, etc.)
 Vex.RoundN = function(x, n) {
 return (x % n) >= (n/2) ? parseInt(x / n) * n + n : parseInt(x / n) * n;
 };
 */

+ (float) roundN:(NSInteger)n withX:(NSInteger)x {
    //    return (x % n) >= (n/2) ? parseInt(x / n) * n + n : parseInt(x / n) * n;
    return x % n >= roundf(n / 2.) ?
    roundf(x / ((float)n) * n + n) :
    roundf(x / ((float)n)) * ((float)n);
}

//static int parseInt(float f) {
//    return 0;
//}

+ (float)midLineOf:(float)a and:(float)b {
    /*
     
     // Locate the mid point between Staff lines. Returns a fractional line if a space
     Vex.MidLine = function(a, b) {
     var mid_line = b + (a - b) / 2;
     if (mid_line % 2 > 0) {
     mid_line = Vex.RoundN(mid_line * 10, 5) / 10;
     }
     return mid_line;
     };
     
     */
    
    float mid_line = b + (a - b) / 2;
    if (((int)floor(mid_line)) % 2 > 0) {
        mid_line = [self roundN:(mid_line * 10) withX:5] / 10;
    }
    return mid_line;
}





/*
 **
 * Check if array "a" contains "obj"
 *
 Vex.Contains = function(a, obj) {
 var i = a.count;
 while (i--) {
 if (a[i] === obj) {
 return YES;
 }
 }
 return NO;
 }
 
 */


/*
 **
 * @param {string} canvas_sel The selector id for the canvas.
 * @return {!Object} A 2D canvas context.
 *
 Vex.getCanvasContext = function(canvas_sel) {
 if (!canvas_sel)
 throw new Vex.RERR("BadArgument", "Invalid canvas selector: " + canvas_sel);
 
 var canvas = document.getElementById(canvas_sel);
 if (!(canvas && canvas.getContext)) {
 throw new Vex.RERR("UnsupportedBrowserError",
 "This browser does not support HTML5 Canvas");
 }
*/
@end
