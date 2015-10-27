//
//  VFBezierPath.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFBezierPath.h"
#import "VFVex.h"

#if TARGET_OS_IPHONE

@implementation VFBezierPath
- (void)addArcWithCenter:(CGPoint)center
                  radius:(CGFloat)radius
              startAngle:(CGFloat)startAngle
                endAngle:(CGFloat)endAngle
               clockwise:(BOOL)clockwise;
{
}
+ (VFBezierPath*)bezierPathWithArcCenter:(CGPoint)center
                                  radius:(CGFloat)radius
                              startAngle:(CGFloat)startAngle
                                endAngle:(CGFloat)endAngle
                               clockwise:(BOOL)clockwise;
{
    return nil;
}
- (void)addLineToPoint:(CGPoint)point;
{
    [self addLineToPoint:point];
}
+ (VFBezierPath*)bezierPath;
{
    return (VFBezierPath*)[UIBezierPath bezierPath];
}
+ (VFBezierPath*)bezierPathWithRect:(CGRect)rect;
{
    return (VFBezierPath*)[UIBezierPath bezierPathWithRect:rect];
}
- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
{
    [self addQuadCurveToPoint:endPoint controlPoint:controlPoint];
}
- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
{
    [self addCurveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
}
@end

#elif TARGET_OS_MAC

@implementation NSBezierPath (BezierPathQuartzUtilities)
// https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/CocoaDrawingGuide/Paths/Paths.html#//apple_ref/doc/uid/TP40003290-CH206-SW2
- (CGPathRef)CGPath
{
    int i, numElements;

    // Need to begin a path here.
    CGPathRef immutablePath = NULL;

    // Then draw the path elements.
    numElements = [self elementCount];
    if(numElements > 0)
    {
        CGMutablePathRef path = CGPathCreateMutable();
        NSPoint points[3];
        BOOL didClosePath = YES;

        for(i = 0; i < numElements; i++)
        {
            switch([self elementAtIndex:i associatedPoints:points])
            {
                case NSMoveToBezierPathElement:
                    CGPathMoveToPoint(path, NULL, points[0].x, points[0].y);
                    break;

                case NSLineToBezierPathElement:
                    CGPathAddLineToPoint(path, NULL, points[0].x, points[0].y);
                    didClosePath = NO;
                    break;

                case NSCurveToBezierPathElement:
                    CGPathAddCurveToPoint(path, NULL, points[0].x, points[0].y, points[1].x, points[1].y, points[2].x,
                                          points[2].y);
                    didClosePath = NO;
                    break;

                case NSClosePathBezierPathElement:
                    CGPathCloseSubpath(path);
                    didClosePath = YES;
                    break;
            }
        }

        // Be sure the path is closed or Quartz may not do valid hit detection.
        if(!didClosePath)
            CGPathCloseSubpath(path);

        immutablePath = CGPathCreateCopy(path);
        CGPathRelease(path);
    }

    return immutablePath;
}
@end

@implementation VFBezierPath

// https://github.com/iccir/XUIKit/blob/master/Source/XUIBezierPathAdditions.m

- (void)addArcWithCenter:(CGPoint)center
                  radius:(CGFloat)radius
              startAngle:(CGFloat)startAngle
                endAngle:(CGFloat)endAngle
               clockwise:(BOOL)clockwise
{
    [self appendBezierPathWithArcWithCenter:center
                                     radius:radius
                                 startAngle:startAngle
                                   endAngle:endAngle
                                  clockwise:clockwise];
}

+ (VFBezierPath*)bezierPathWithArcCenter:(CGPoint)center
                                  radius:(CGFloat)radius
                              startAngle:(CGFloat)startAngle
                                endAngle:(CGFloat)endAngle
                               clockwise:(BOOL)clockwise
{
    NSBezierPath* path = [NSBezierPath bezierPath];
    [path appendBezierPathWithArcWithCenter:center
                                     radius:radius
                                 startAngle:startAngle
                                   endAngle:endAngle
                                  clockwise:clockwise];
    return (VFBezierPath*)path;
}

- (void)addLineToPoint:(CGPoint)point
{
    [self lineToPoint:point];
}

+ (VFBezierPath*)bezierPath
{
    return [[VFBezierPath alloc] init];
}

+ (VFBezierPath*)bezierPathWithRect:(NSRect)rect;
{
    return (VFBezierPath*)[NSBezierPath bezierPathWithRect:rect];
}

- (void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;
{
    CGPoint QP0 = [self currentPoint];
    CGPoint QP2 = endPoint;
    CGPoint CP3 = QP2;
    CGPoint QP1 = controlPoint;

    CGPoint CP1 = CGPointMake(
        //  QP0   +   2   / 3    * (QP1   - QP0  )
        QP0.x + ((2.0 / 3.0) * (QP1.x - QP0.x)), QP0.y + ((2.0 / 3.0) * (QP1.y - QP0.y)));

    CGPoint CP2 = CGPointMake(
        //  QP2   +  2   / 3    * (QP1   - QP2)
        QP2.x + (2.0 / 3.0) * (QP1.x - QP2.x), QP2.y + (2.0 / 3.0) * (QP1.y - QP2.y));

    [self curveToPoint:CP3 controlPoint1:CP1 controlPoint2:CP2];
}

- (void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGPoint)controlPoint1 controlPoint2:(CGPoint)controlPoint2;
{
    [self curveToPoint:endPoint controlPoint1:controlPoint1 controlPoint2:controlPoint2];
}
@end
#endif