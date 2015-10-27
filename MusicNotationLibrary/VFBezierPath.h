//
//  VFBezierPath.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
//@import Foundation;
@import UIKit;
//======================================================================================================================
/** The `VFBezierPath` class performs ...

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface VFBezierPath : UIBezierPath
#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (void)addArcWithCenter:(CGPoint)center
                  radius:(CGFloat)radius
              startAngle:(CGFloat)startAngle
                endAngle:(CGFloat)endAngle
               clockwise:(BOOL)clockwise;
+ (VFBezierPath*)bezierPathWithArcCenter:(CGPoint)center
                                  radius:(CGFloat)radius
                              startAngle:(CGFloat)startAngle
                                endAngle:(CGFloat)endAngle
                               clockwise:(BOOL)clockwise;
- (void)addLineToPoint:(CGPoint)point;
+ (VFBezierPath*)bezierPath;
+ (VFBezierPath*)bezierPathWithRect:(CGRect)rect;
- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
@end
#elif TARGET_OS_MAC
@import AppKit;
//======================================================================================================================
/** The `VFBezierPath` class performs ...

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface VFBezierPath : NSBezierPath

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (void)addArcWithCenter:(CGPoint)center
                  radius:(CGFloat)radius
              startAngle:(CGFloat)startAngle
                endAngle:(CGFloat)endAngle
               clockwise:(BOOL)clockwise;
+ (VFBezierPath*)bezierPathWithArcCenter:(CGPoint)center
                                  radius:(CGFloat)radius
                              startAngle:(CGFloat)startAngle
                                endAngle:(CGFloat)endAngle
                               clockwise:(BOOL)clockwise;
- (void)addLineToPoint:(CGPoint)point;
+ (VFBezierPath*)bezierPath;
+ (VFBezierPath*)bezierPathWithRect:(NSRect)rect;
- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;

@end

@interface NSBezierPath (BezierPathQuartzUtilities)

- (CGPathRef)CGPath;

@end
#endif
