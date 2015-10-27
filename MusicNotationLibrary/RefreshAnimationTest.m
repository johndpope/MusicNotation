//
//  RefreshAnimationTest.m
//  VexFlow
//
//  Created by Scott on 6/3/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "RefreshAnimationTest.h"
#import "RefreshControl.h"
#import "Animator.h"

@implementation RefreshAnimationTest

/*
//- (void)drawRect:(NSRect)dirtyRect
//{
//    [super drawRect:dirtyRect];
//
//    // Drawing code here.
//}

- (void)start:(VFTestView*)parent
{
    //    CGAffineTransform transform = CGAffineTransformIdentity;

    CGPoint translation = CGPointMake(200, 200);
    CGAffineTransform trans = CGAffineTransformMakeTranslation(translation.x, translation.y);
    CGAffineTransform rot = CGAffineTransformMakeRotation(M_PI);
    CGAffineTransform transform =
        CGAffineTransformConcat(CGAffineTransformConcat(rot, CGAffineTransformMakeRotation(0 / *theta* /)), trans);

    NSMutableArray* paths = [NSMutableArray array];

    [VFGlyph renderIntoArray:paths
                   transform:&transform
                    withCode:@"v83"
                   withScale:2];   // renderIntoArray:barList withCode:@"v83" atStartPoint:VFPointMake(200, 200)
                                   // withScale:2];

    RefreshControl* control = [RefreshControl refreshControlWithFrame:CGRectMake(0, 0, 400, 400)
                                                               target:[self class]
                                                        refreshAction:@selector(hello)
                                                                paths:paths];
    control.animator = [Animator animatorWithScreen:nil];
    [control setNeedsDisplay:YES];

    [parent addSubview:control];
    [control startLoadingAnimation];
}

- (void)hello
{
    NSLog(@"Hello");
}
*/

@end
