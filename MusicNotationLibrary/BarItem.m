//
//  BarItem.m
//  VexFlow
//
//  Created by Scott on 6/7/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "BarItem.h"

#import "VFColor.h"
#import "VFBezierPath.h"

@implementation BarItem

- (instancetype)initWithTrans:(CGPoint)translation
                         //                   startPoint:(CGPoint)startPoint
                         //                     endPoint:(CGPoint)endPoint
                         path:(CGMutablePathRef)path
                        color:(VFColor*)color
                    lineWidth:(CGFloat)lineWidth;
{
    self = [super init];   //[super initWithFrame:frame];
    if(self)
    {
        //        _startPoint = startPoint;
        //        _endPoint = endPoint;
        //        _lineWidth = lineWidth;
        _color = color;

        CGPoint (^middlePoint)(CGPoint, CGPoint) = ^CGPoint(CGPoint a, CGPoint b) {
          CGFloat x = (a.x + b.x) / 2.f;
          CGFloat y = (a.y + b.y) / 2.f;
          return CGPointMake(x, y);
        };
        //        _middlePoint = middlePoint(startPoint, endPoint);
        //        [self setupWithFrame:frame];

        //        self.anchorPoint = CGPointMake(self.middlePoint.x, self.middlePoint.y);
        //        self.anchorPoint = CGPointZero;

        //        NSLog(@"%.01f, %.01f", self.anchorPoint.x, self.anchorPoint.y);
        //
        //        CGMutablePathRef path = CGPathCreateMutable();
        //        CGFloat theta = atan2f(endPoint.y - startPoint.y, endPoint.x - startPoint.x);   // theta = atan(y/x)
        //        NSLog(@"%.01f", theta);
        //
        //        CGAffineTransform trans = CGAffineTransformMakeTranslation(translation.x, translation.y);
        //        CGAffineTransform rot = CGAffineTransformMakeRotation(M_PI);
        //        CGAffineTransform transform =
        //            CGAffineTransformConcat(CGAffineTransformConcat(rot, CGAffineTransformMakeRotation(0 /*theta*/)),
        //            trans);
        //
        //        CGPathAddRect(path, &transform, CGRectMake(startPoint.x, startPoint.y, endPoint.x - startPoint.x,
        //        lineWidth));
        //        CGPathAdd self.path = path;
        
        
        self.path = CGPathCreateCopyByStrokingPath(path, &CGAffineTransformIdentity, 2, kCGLineCapRound, kCGLineJoinRound, 0);
    }
    return self;
}

//- (void)setupWithFrame:(CGRect)rect
//{
//    self.anchorPoint =
//        CGPointMake(self.middlePoint.x / self.frame.size.width, self.middlePoint.y / self.frame.size.height);
//    self.frame = CGRectMake(self.frame.origin.x + self.middlePoint.x - self.frame.size.width / 2,
//                            self.frame.origin.y + self.middlePoint.y - self.frame.size.height / 2,
//                            self.frame.size.width, self.frame.size.height);
//}

- (void)setHorizontalRandomness:(int)horizontalRandomness dropHeight:(CGFloat)dropHeight
{
    int randomNumber = -horizontalRandomness + arc4random() % horizontalRandomness * 2;
    self.translationX = randomNumber;
    self.transform = CATransform3DMakeTranslation(
        self.translationX, -dropHeight, 0);   // CGAffineTransformMakeTranslation(self.translationX, -dropHeight);
}

//- (void)drawRect:(CGRect)rect
//{
//    VFBezierPath* bezierPath = VFBezierPath.bezierPath;
//    [bezierPath moveToPoint:self.startPoint];
//    [bezierPath addLineToPoint:self.endPoint];
//    [self.color setStroke];
//    bezierPath.lineWidth = self.lineWidth;
//    [bezierPath stroke];
//}

@end
