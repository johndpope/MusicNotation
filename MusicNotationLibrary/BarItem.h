//
//  BarItem.h
//  VexFlow
//
//  Created by Scott on 6/7/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <QuartzCore/QuartzCore.h>

@class VFColor;

@interface BarItem : CAShapeLayer

@property (assign, nonatomic) NSUInteger tag;
@property (assign, nonatomic) CGFloat translationX;
@property (assign, nonatomic) CGPoint middlePoint;
//@property (assign, nonatomic) CGFloat lineWidth;
//@property (assign, nonatomic) CGPoint startPoint;
//@property (assign, nonatomic) CGPoint endPoint;
@property (strong, nonatomic) VFColor* color;
//@property (nonatomic) VFColor* backgroundColor;
@property (assign, nonatomic) CGFloat alpha;
//@property (nonatomic) CGAffineTransform transform;

- (instancetype)initWithTrans:(CGPoint)translation
                         //                   startPoint:(CGPoint)startPoint
                         //                     endPoint:(CGPoint)endPoint
                         path:(CGMutablePathRef)path
                        color:(VFColor*)color
                    lineWidth:(CGFloat)lineWidth;

- (void)setHorizontalRandomness:(int)horizontalRandomness dropHeight:(CGFloat)dropHeight;

@end