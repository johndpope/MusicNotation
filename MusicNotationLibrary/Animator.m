//
//  Animator.m
//  VexFlow
//
//  Created by Scott on 6/7/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "Animator.h"

#import <objc/runtime.h>
/*

static int ScreenAnimationDriverKey;
static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink,
                                      const CVTimeStamp* now,
                                      const CVTimeStamp* outputTime,
                                      CVOptionFlags flagsIn,
                                      CVOptionFlags* flagsOut,
                                      void* displayLinkContext);

@interface Animator ()

@property (nonatomic) CVDisplayLinkRef displayLink;
@property (nonatomic, strong) NSMutableSet* animations;
@property (nonatomic) BOOL paused;
@end

@implementation Animator

+ (instancetype)animatorWithScreen:(NSScreen*)screen
{
    if(!screen)
    {
        screen = [NSScreen mainScreen];
    }
    Animator* driver = objc_getAssociatedObject(screen, &ScreenAnimationDriverKey);
    if(!driver)
    {
        driver = [[self alloc] initWithScreen:screen];
        objc_setAssociatedObject(screen, &ScreenAnimationDriverKey, driver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return driver;
}

- (instancetype)initWithScreen:(NSScreen*)screen
{
    self = [super init];
    if(self)
    {
        [self setupDisplayLinkForScreen:screen];
        self.animations = [NSMutableSet new];
    }
    return self;
}

- (void)setupDisplayLinkForScreen:(NSScreen*)screen
{
    CVDisplayLinkRef displayLink = NULL;
    CVDisplayLinkCreateWithActiveCGDisplays(&displayLink);
    CVDisplayLinkSetCurrentCGDisplay(
        displayLink, ((CGDirectDisplayID)[[screen.deviceDescription objectForKey:@"NSScreenNumber"] intValue]));
    CVDisplayLinkSetOutputCallback(displayLink, &MyDisplayLinkCallback, (__bridge void*)self);
    CVDisplayLinkStart(displayLink);

    self.displayLink = displayLink;
}

- (void)addAnimation:(id<Animation>)animation
{
    [self.animations addObject:animation];
    if(self.animations.count == 1)
    {
        self.paused = NO;
    }
}

- (void)setPaused:(BOOL)paused
{
    _paused = paused;
    if(paused)
    {
        CVDisplayLinkStop(self.displayLink);
    }
    else
    {
        CVDisplayLinkStart(self.displayLink);
    }
}

- (void)removeAnimation:(id<Animation>)animatable
{
    if(animatable == nil)
        return;

    [self.animations removeObject:animatable];
    if(self.animations.count == 0)
    {
        self.paused = YES;
    }
}

- (void)animationTick:(double)dt
{
    for(id<Animation> a in [self.animations copy])
    {
        BOOL finished = NO;
        [a animationTick:dt finished:&finished];
        if(finished)
        {
            [self.animations removeObject:a];
        }
    }
    if(self.animations.count == 0)
    {
        self.paused = YES;
    }
}

@end

@implementation NSView (Animator)

- (Animator*)objc_animator
{
    return [Animator animatorWithScreen:self.window.screen];
}

@end

static CVReturn MyDisplayLinkCallback(CVDisplayLinkRef displayLink,
                                      const CVTimeStamp* now,
                                      const CVTimeStamp* outputTime,
                                      CVOptionFlags flagsIn,
                                      CVOptionFlags* flagsOut,
                                      void* displayLinkContext)
{
    Animator* animator = (__bridge Animator*)displayLinkContext;
    @autoreleasepool
    {
        double deltaSeconds = (outputTime->videoTime - now->videoTime) / (double)outputTime->videoTimeScale;

        [animator animationTick:deltaSeconds];
    }

    return kCVReturnSuccess;
}
*/