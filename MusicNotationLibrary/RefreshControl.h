//
//  RefreshControl.h
//  VexFlow
//
//  Created by Scott on 6/7/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Animation.h"

@class Animator;

/*
typedef NS_ENUM(NSUInteger, RefreshControlState)
{
    Idle = 0,
    Refreshing = 1,
    Disappearing = 2
};

@interface RefreshControl : NSView <Animation>

@property (assign, nonatomic) CGFloat dropHeight;
@property (assign, nonatomic) CGFloat originalTopContentInset;
@property (assign, nonatomic) CGFloat disappearProgress;
@property (assign, nonatomic) CGFloat internalAnimationFactor;
@property (assign, nonatomic) int horizontalRandomness;
@property (assign, nonatomic) BOOL reverseLoadingAnimation;
@property (assign, nonatomic) CGPoint center;
@property (assign, nonatomic) CGAffineTransform transform;

// should be private
@property (assign, nonatomic) RefreshControlState state;
@property (strong, nonatomic) NSArray* barItems;
@property (weak, nonatomic) Animator* animator;
//@property (nonatomic, assign) CVDisplayLinkRef displayLink;
//@property (nonatomic, assign) id target;
//@property (nonatomic) SEL action;

+ (RefreshControl*)refreshControlWithFrame:(CGRect)frame
                                    
                             refreshAction:(SEL)refreshAction
                                     paths:(NSMutableArray*)paths;

- (void)startLoadingAnimation;

- (void)animationTick:(CFTimeInterval)dt finished:(BOOL*)finished;

//- (void)disperse;

@end
*/