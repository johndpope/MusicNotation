//
//  vfMacros.h
//  VexFlow
//
//  Created by Scott on 3/26/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#ifndef VexFlow_vfMacros_h
#define VexFlow_vfMacros_h

#define VFBoundingBoxMake(x, y, w, h) [VFBoundingBox boundingBoxWithRect:CGRectMake(x, y, w, h)]

#define VFRectMake(x, y, w, h) [VFRect boundingBoxAtX:x atY:y withWidth:w andHeight:h]

#define VFPointMake(x, y) [VFPoint pointWithX:x andY:y]

// pad all 4 directions with same padding
#define VFPaddingMake(padding) [VFPadding paddingWith:padding]

#define VFFloatSizeMake(x, y) [VFFloatSize sizeWithWidth:x andHeight:y]

#define VFUIntSizeMake(x, y) [VFUIntSize sizeWithWidth:x andHeight:y]
#define VFUIntSizeZero() [VFUIntSize sizeWithWidth:0 andHeight:0]

#define RationalParse(s) [Rational parse:s]

#define Rational(p, q) [Rational rationalWithNumerator:p andDenominator:q]

#define Rational1(p) Rational(p, 1)

#define RationalZero() Rational(0, 1)

#define RationalOne() Rational(1, 1)

#define kDrawUsingVFKit YES

#define expect(fmt, ...) DDLogVerbose((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define VFLogInfo(fmt, ...) DDLogInfo((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define VFLogDebug(fmt, ...) DDLogDebug((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define VFLogWarn(fmt, ...) DDLogWarn((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define VFLogError(fmt, ...) DDLogError((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#define VFLogVerbose(fmt, ...) DDLogVerbose((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

//
//#if !defined(MAX_CGFLOAT)
//#define MAX(A,B)	({ __typeof__(A) __a = (A); __typeof__(B) __b = (B); __a < __b ? __b : __a; })
//#endif
//
//

#define STAFF_LINE_GAP 10.0f
#define STAFF_STANDARD_WIDTH 569.0f

#define SHEET_MUSIC_COLOR [NSColor colorWithRed:0.93f green:0.93f blue:0.87f alpha:1.0f]

#define TF(BOOL_VAL) (BOOL_VAL ? @"YES" : @"NO")

//#define ok(msg) \
//    assertThatBool(YES, describedAs(msg, isTrue(), nil));

#define vfstring(s, ...) [NSString stringWithFormat:(s), ##__VA_ARGS__ ?: @""]

#define ok(bResult, string) assertThatBool(bResult, describedAs(string, isTrue(), nil));

#if TARGET_OS_IPHONE
#define SHEET_MUSIC_COLOR [UIColor colorWithRed:0.93f green:0.93f blue:0.87f alpha:1.0f]
#elif TARGET_OS_MAC
#define SHEET_MUSIC_COLOR [NSColor colorWithRed:0.93f green:0.93f blue:0.87f alpha:1.0f]
#endif

#if TARGET_OS_IPHONE
#define VFGraphicsContext() UIGraphicsGetCurrentContext()
#elif TARGET_OS_MAC
#define VFGraphicsContext() [[NSGraphicsContext currentContext] graphicsPort]
#endif

#if TARGET_OS_IPHONE
#define VFView UIView
#elif TARGET_OS_MAC
#define VFView NSView
#endif

#define VariableName(arg) (@"" #arg)

#define CGRectShiftOrigin(rect, newOrigin) CGRectMake(newOrigin.x, newOrigin.y +, rect.size.width, rect.size.height)

#define CGRectShiftOriginByAmount(rect, shiftSize) \
    CGRectMake(rect.origin.x + shiftSize.width, rect.origin.y + shiftSize.height, rect.size.width, rect.size.height)

#define CGScaleRect(rect, scale) \
    CGRectMake(rect.origin.x, rect.origin.y, rect.size.width* scale, rect.size.height* scale)

#define CGScaleSize(size, scale) CGSizeMake(size.width* scale, size.height* scale)

#define CGScalePoint(point, scale) CGPointMake(point.x* scale, point.y* scale)

#define CGInvertPoint(point) CGPointMake(-point.x, -point.y)

#define CGInvertYForPoint(point) CGPointMake(point.x, -point.y)

#define CGInvertXForPoint(point) CGPointMake(-point.x, point.y)

#define CGCombinePoints(point1, point2) CGPointMake(point1.x + point2.x, point1.y + point2.y)

#define CGPositivePoint(point) CGPointMake(ABS(point.x), ABS(point.y))

#define CGOneMinusPoint(point) CGPointMake(1. - point.x, 1. - point.y)

//#define CGClampPoint(point) \
    CGPointMake(ABS(point.x / MAX(ABS(point.x), ABS(point.y))), ABS(point.y / MAX(ABS(point.x), ABS(point.y))))

#define CGClampPoint(point, size) CGPointMake(ABS(point.x / size.width), ABS(point.y / size.height))

#define CGPointSizeCombine(point, size) CGRectMake(point.x, point.y, size.width, size.height)

#define CGRectExpandBySize(rect, size)                                                                        \
    CGRectMake(rect.origin.x + size.width / 2, rect.origin.y + size.height / 2, rect.size.width + size.width, \
               rect.size.height + size.height)

#define CGRectToString(rect)                                                                               \
    [NSString stringWithFormat:@"(%@ x:%.02f y:%.02f w:%.02f h:%.02f)", VariableName(rect), rect.origin.x, \
                               rect.origin.y, rect.size.width, rect.size.height]

// // CGRectUnion
//#define CGMergeRects(rect1, rect2)                                                   \
//    CGRectMake(MIN(CGRectGetMinX(rect1, rect2)), MIN(CGRectGetMinY(rect1, rect2)),   \
//               -MIN(CGRectGetMinX(rect1, rect2)) + MAX(CGRectGetMaxX(rect1, rect2)), \
//               -MIN(CGRectGetMinY(rect1, rect2)) + MAX(CGRectGetMaxY(rect1, rect2)))

#endif
