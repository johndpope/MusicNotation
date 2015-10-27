//
//  RefreshControl.m
//  VexFlow
//
//  Created by Scott on 6/7/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "RefreshControl.h"
#import "VFColor.h"
#import "BarItem.h"
#import "Animator.h"
#import <QuartzCore/QuartzCore.h>

static const CGFloat kloadingIndividualAnimationTiming = 0.8;
static const CGFloat kbarDarkAlpha = 0.4;
static const CGFloat kloadingTimingOffset = 0.01;
static const CGFloat kdisappearDuration = 1.2;

NSString* const startPointKey = @"startPoints";
NSString* const endPointKey = @"endPoints";
NSString* const xKey = @"x";
NSString* const yKey = @"y";
/*
@implementation RefreshControl

- (instancetype)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.wantsLayer = YES;
        //        self.layer =  [self makeBackingLayer];
        CALayer* viewLayer = [CALayer layer];
        [viewLayer setBackgroundColor:[NSColor blueColor].CGColor];   // CGColorCreateGenericRGB(0.0, 0.0, 1.0, 1.0)];
                                                                      // // RGB plus Alpha Channel
        [self setLayer:viewLayer];
        [self setLayerContentsRedrawPolicy:NSViewLayerContentsRedrawOnSetNeedsDisplay];
        [viewLayer setNeedsDisplay];
        [self.layer setDelegate:self];
    }
    return self;
}

+ (RefreshControl*)refreshControlWithFrame:(CGRect)frame
                                    
                             refreshAction:(SEL)refreshAction
                                     paths:(NSMutableArray*)paths
{
    return [RefreshControl refreshControlWithFrame:(CGRect)frame
                                            target:target
                                     refreshAction:refreshAction
                                             paths:paths
                                             color:(VFColor*)[VFColor whiteColor]
                                         lineWidth:2
                                        dropHeight:80
                                             scale:1
                              horizontalRandomness:150
                           reverseLoadingAnimation:NO
                           internalAnimationFactor:0.7];
}

+ (RefreshControl*)refreshControlWithFrame:(CGRect)frame
                                    
                             refreshAction:(SEL)refreshAction
                                     paths:(NSMutableArray*)paths
                                     color:(VFColor*)color
                                 lineWidth:(CGFloat)lineWidth
                                dropHeight:(CGFloat)dropHeight
                                     scale:(CGFloat)scale
                      horizontalRandomness:(CGFloat)horizontalRandomness
                   reverseLoadingAnimation:(BOOL)reverseLoadingAnimation
                   internalAnimationFactor:(CGFloat)internalAnimationFactor
{
    RefreshControl* refreshControl = [[RefreshControl alloc] initWithFrame:frame];
    //    refreshControl.layer.backgroundColor = NSColor.blueColor.CGColor;
    //    refreshControl.wantsLayer = YES;

    //    viewLayer.frame = refreshControl.bounds;
    //    viewLayer.position = CGPointMake(CGRectGetMidX(refreshControl.frame), CGRectGetMidY(refreshControl.frame));

    refreshControl.dropHeight = dropHeight;
    refreshControl.horizontalRandomness = horizontalRandomness;
    refreshControl.reverseLoadingAnimation = reverseLoadingAnimation;
    refreshControl.internalAnimationFactor = internalAnimationFactor;

    // Calculate frame according to points max width and height
    CGFloat width = refreshControl.layer.bounds.size.width;
    CGFloat height = refreshControl.layer.bounds.size.height;
    //    NSDictionary* rootDictionary =
    //        [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:plist ofType:@"plist"]];
    //    NSArray* startPoints = barList.firstObject;
    //    NSArray* endPoints = barList.lastObject;

    //    CGPoint position = CGPointMake(200, 200);
    //
    //    CGPoint startPoint = CGPointZero;
    //    CGPoint endPoint = CGPointZero;
    //    for(int i = 0; i < startPoints.count; i++)
    //    {
    //        startPoint = CGPointMake([startPoints[0] floatValue],
    //                                 [startPoints[1] floatValue]);   // NSPointFromString(startPoints[i]);
    //        endPoint =
    //            CGPointMake([endPoints[0] floatValue], [endPoints[1] floatValue]);   //
    //            NSPointFromString(endPoints[i]);
    //
    //        //        if(startPoint.x > width)
    //        //            width = startPoint.x;
    //        //        if(endPoint.x > width)
    //        //            width = endPoint.x;
    //        //        if(startPoint.y > height)
    //        //            height = startPoint.y;
    //        //        if(endPoint.y > height)
    //        //            height = endPoint.y;
    //    }
    //    //    refreshControl.frame = CGRectMake(0, 0, width, height);

    // Create bar items
    NSMutableArray* mutableBarItems = [[NSMutableArray alloc] init];
    CGPoint prevPoint = CGPointZero;   // CGPointMake(200, 200);
    CGPoint barStartPoint = CGPointZero;
    CGPoint barEndPoint = CGPointZero;
    for(int i = 0; i < paths.count; i++)
    {
        //        barStartPoint = prevPoint;
        //
        //        barEndPoint =
        //            CGPointMake([barList[i][0] floatValue], [paths[i][1] floatValue]);   //
        //            NSPointFromString(startPoints[i]);
        //        barEndPoint =
        //            CGPointMake([barList[i+1][0] floatValue] + position.x, [barList[i+1][1] floatValue] + position.y);
        //            // NSPointFromString(endPoints[i]);

        NSLog(@"(%.01f, %.01f)-> (%.01f, %.01f)", barStartPoint.x, barStartPoint.y, barEndPoint.x, barEndPoint.y);

        BarItem* barItem =
            [[BarItem alloc] initWithTrans:CGPointMake(200, 200)
                                      //                                               startPoint:barStartPoint
                                      //                                                 endPoint:barEndPoint
                                      path:CFBridgingRetain(paths[i])
                                     color:color
                                 lineWidth:lineWidth];
        //        prevPoint = barEndPoint;

        //        barItem.tag = i;
        //        barItem.backgroundColor = [NSColor whiteColor].CGColor;
        //        barItem.backgroundColor = [NSColor blackColor].CGColor;
        //        barItem.alpha = 1;

        if(i % 2 == 0)
        {
            barItem.fillColor = NSColor.whiteColor.CGColor;
        }
        else
        {
            //            barItem.fillColor = NSColor.darkGrayColor.CGColor;
            barItem.fillColor = NSColor.whiteColor.CGColor;
        }

        barItem.opacity = 1;
        [mutableBarItems addObject:barItem];
        //        [refreshControl addSubview:barItem];
        [refreshControl.layer addSublayer:barItem];

        [barItem setNeedsDisplay];

        //        [barItem setHorizontalRandomness:refreshControl.horizontalRandomness
        //                dropHeight:refreshControl.dropHeight];
    }

    refreshControl.barItems = [NSArray arrayWithArray:mutableBarItems];
    //    //    refreshControl.frame = CGRectMake(0, 0, width, height);
    //    //    refreshControl.center =
    //    //        CGPointMake(parent.bounds.size.width / 2, 0);   // CGPointMake([NSScreen
    //    mainScreen].bounds.size.width /
    //    //        2, 0);
    //    for(BarItem* barItem in refreshControl.barItems)
    //    {
    //        [barItem setupWithFrame:refreshControl.frame];
    //    }

    //    refreshControl.transform = CGAffineTransformMakeScale(scale, scale);
    return refreshControl;
}

- (void)drawLayer:(CALayer*)layer inContext:(CGContextRef)ctx
{
    [super drawLayer:layer inContext:ctx];
    //    NSRect rect = self.bounds;
    //    rect.origin.x = 0;
    //    rect.origin.y = 0;
    //    [self drawRect:rect];
    //    [[NSColor blueColor] setFill];
    //    self clea
    //    layer.backgroundColor
}

- (void)updateBarItemsWithProgress:(CFTimeInterval)dt
{
    for(BarItem* barItem in self.barItems)
    {
        NSInteger index = [self.barItems indexOfObject:barItem];
        CGFloat startPadding = (1 - self.internalAnimationFactor) / self.barItems.count * index;
        CGFloat endPadding = 1 - self.internalAnimationFactor - startPadding;

        if(self.disappearProgress == 1 || self.disappearProgress >= 1 - endPadding)
        {
            barItem.transform = CATransform3DIdentity;   // [NSAffineTransform transform]; //CGAffineTransformIdentity;
            barItem.alpha = kbarDarkAlpha;
        }
        else if(self.disappearProgress == 0)
        {
            [barItem setHorizontalRandomness:self.horizontalRandomness dropHeight:self.dropHeight];
        }
        else
        {
            CGFloat realProgress;
            if(self.disappearProgress <= startPadding)
            {
                realProgress = 0;
            }
            else
            {
                realProgress = MIN(1, (self.disappearProgress - startPadding) / self.internalAnimationFactor);
            }
            barItem.transform = CATransform3DMakeTranslation(barItem.translationX * (1 - realProgress),
                                                             -self.dropHeight * (1 - realProgress), 0);
            barItem.transform = CATransform3DMakeRotation(
                M_PI * (realProgress), 0, 0, 0);   // CGAffineTransformRotate(barItem.transform, M_PI * (realProgress));
            barItem.transform =
                CATransform3DMakeScale(realProgress, realProgress,
                                       0);   // CGAffineTransformScale(barItem.transform, realProgress, realProgress);
            barItem.alpha = realProgress * kbarDarkAlpha;
        }
    }
}

- (void)startLoadingAnimation
{
    if(self.reverseLoadingAnimation)
    {
        int count = (int)self.barItems.count;
        for(int i = count - 1; i >= 0; i--)
        {
            BarItem* barItem = [self.barItems objectAtIndex:i];
            [self performSelector:@selector(barItemAnimation:)
                       withObject:barItem
                       afterDelay:(self.barItems.count - i - 1) * kloadingTimingOffset
                          inModes:@[ NSRunLoopCommonModes ]];
        }
    }
    else
    {
        for(int i = 0; i < self.barItems.count; i++)
        {
            BarItem* barItem = [self.barItems objectAtIndex:i];
            [self performSelector:@selector(barItemAnimation:)
                       withObject:barItem
                       afterDelay:i * kloadingTimingOffset
                          inModes:@[ NSRunLoopCommonModes ]];
        }
    }
}

- (void)barItemAnimation:(BarItem*)barItem
{
    //    if(self.state == Refreshing)
    //    {
    barItem.alpha = 1;
    [barItem removeAllAnimations];
    //        [UIView animateWithDuration:kloadingIndividualAnimationTiming
    //            animations:^{
    //              barItem.alpha = kbarDarkAlpha;
    //            }
    //            completion:^(BOOL finished){
    //
    //            }];
    //
    [NSAnimationContext beginGrouping];
    // Animate enclosed operations with a duration of 1 second
    [[NSAnimationContext currentContext] setDuration:kloadingIndividualAnimationTiming];
    barItem.opacity = kbarDarkAlpha;
    [NSAnimationContext endGrouping];

    BOOL isLastOne;
    if(self.reverseLoadingAnimation)
    {
        isLastOne = barItem.tag == 0;
    }
    else
    {
        isLastOne = barItem.tag == self.barItems.count - 1;
    }
    if(isLastOne && self.state == Refreshing)
    {
        [self startLoadingAnimation];
    }
    //    }
}

- (void)updateDisappearAnimation:(CFTimeInterval)dt
{
    if(self.disappearProgress >= 0 && self.disappearProgress <= 1)
    {
        self.disappearProgress -= 1 / 60.f / kdisappearDuration;
        // 60.f means this method get called 60 times per second
        [self updateBarItemsWithProgress:self.disappearProgress];
    }
}

#pragma mark Public Methods

- (void)disperse
{
    self.state = Disappearing;

    //    [NSAnimationContext beginGrouping];
    //    [[NSAnimationContext currentContext] setDuration:kdisappearDuration];
    //    [NSAnimationContext endGrouping];

    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"position"];
    //        animation.fromValue = [NSValue valueWithCGPoint:startPoint];
    //        animation.toValue = [NSValue valueWithCGPoint:endPoint];

    [CATransaction setAnimationDuration:kdisappearDuration];
    @weakify(self);
    [CATransaction setCompletionBlock:^{
      @strongify(self);
      Animator* animator = self.animator;
      [animator removeAnimation:self];   // remove stopDisplayLink];
    }];

    [CATransaction begin];
    [self.layer addAnimation:animation forKey:nil];
    [CATransaction commit];

    self.state = Idle;
    //    [self.displayLink invalidate];
    self.disappearProgress = 1;
    [NSAnimationContext endGrouping];

    for(BarItem* barItem in self.barItems)
    {
        [barItem removeAllAnimations];
        barItem.alpha = kbarDarkAlpha;
    }

    self.disappearProgress = 1;
}

- (void)animationTick:(CFTimeInterval)dt finished:(BOOL*)finished;
{
    [self updateBarItemsWithProgress:dt];
    [self updateDisappearAnimation:dt];
}

@end
 */
