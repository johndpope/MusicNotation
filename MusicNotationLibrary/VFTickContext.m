//
//  VFTickContext.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

#import "VFTickContext.h"
#import "VFVex.h"
#import "VFTickable.h"
#import "VFModifier.h"
#import "Rational.h"
#import "VFModifierContext.h"
#import "VFMetrics.h"
#import "VFPadding.h"
#import "ExtraPx.h"
#import "OCTotallyLazy.h"
#import "VFUtils.h"
#import "VFPoint.h"

@interface VFTickContext (private)
@property (assign, nonatomic) BOOL preFormatted;
@property (assign, nonatomic) BOOL postFormatted;
@end

@implementation VFTickContext

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupTickContext];
    }
    return self;
}

- (void)setupTickContext
{
    _currentTick = RationalZero();
    _maxTicks = RationalZero();
    _minTicks = nil;
    _width = 0;
    _padding = [VFPadding paddingWith:3];   // padding on each side (width += padding * 2)
    _pixelsUsed = 0;
    _x = 0;
    _tickables = [NSMutableArray array];   // Notes, tabs, chords, lyrics.
    _notePx = 0;                           // width of widest note in self context
    _extraLeftPx = 0;                      // Extra left pixels for modifers & displace notes
    _extraRightPx = 0;                     // Extra right pixels for modifers & displace notes
    _align_center = NO;

    _tContexts = [NSMutableArray array];   // Parent array of tick contexts

    // Ignore self tick context for formatting and justification
    _shouldIgnoreTicks = YES;
    _preFormatted = NO;
    _postFormatted = NO;
    _graphicsContext = NULL;   // Rendering context
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (NSString*)description
{
    //    //prolog
    //    NSString *ret = [NSString stringWithFormat:@"<%p> : { \n", self];
    //
    //    //guts
    //    ret = [ret concat:[NSString stringWithFormat:@"List: %@\n", [self.list prettyPrint]]];
    //    ret = [ret concat:[NSString stringWithFormat:@"Map: %@\n", [self.map prettyPrint]]];
    //    ret = [ret concat:[NSString stringWithFormat:@"Resolution multiplier: %li\n",
    //    (long)self.resolutionMultiplier]];
    //    //    ret = [ret concat:[NSString stringWithFormat:@"Ticks: %@\n", [self.ticks description]]];
    //    NSString *shouldIgnoreTicksDescription = self.shouldIgnoreTicks ? @"YES" : @"NO";
    //    ret = [ret concat:[NSString stringWithFormat:@"ShouldIgnoreTicks: %@\n", shouldIgnoreTicksDescription]];
    //    NSString *parentDescription = self.parent != Nil ? [self.parent description] : @"";
    //    ret = [ret concat:parentDescription];
    //
    //    //epilog
    //    ret = [ret concat:@"}"];
    //    return [VFLog FormatObject:ret];
    return nil;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (BOOL)shouldIgnoreTicks
{
    return _shouldIgnoreTicks;
}

- (float)getWidth
{
    return _width + (self.padding.width * 2);
}

- (float)width
{
    //    return self.metrics.width;
    return _width;
}

- (void)setWidth:(float)width
{
    //    self.metrics.width = width;
    _width = width;
}

- (float)x
{
    return _x;
}

- (void)setX:(float)x
{
    _x = x;
}

- (float)getPixelsUsed
{
    return _pixelsUsed;
}

- (void)setPixelsUsed:(float)pixelsUsed
{
    _pixelsUsed = pixelsUsed;
}

- (void)setPadding:(VFPadding*)padding
{
    _padding = [padding copy];
}

- (Rational*)getMaxTicks
{
    return _maxTicks;
}

- (Rational*)getMinTicks
{
    return _minTicks;
}

- (NSArray*)getTickables
{
    return [_tickables asArray];
}

- (NSArray*)getCenterAlignedTickables
{
    return [self.tickables filter:^BOOL(VFTickable* tickable) {
      return tickable.centerAlign;
    }];
}

// Get widths context, note and left/right modifiers for formatting
- (id<TickableMetrics>)metrics
{
    id<TickableMetrics> metrics = [[TickableMetrics alloc] initWithDictionary:nil];
    metrics.width = self.width;
    metrics.notePoints = self.notePoints;
    metrics.extraLeftPx = self.extraLeftPx;
    metrics.extraRightPx = self.extraRightPx;
    return metrics;
}

- (Rational*)getCurrentTick
{
    return _currentTick;
}

- (void)setCurrentTick:(Rational*)currentTick
{
    _currentTick = currentTick;
    self.preFormatted = NO;
}

// Get left & right pixels used for modifiers
- (ExtraPx*)getExtraPx
{
    float left_shift = 0;
    float right_shift = 0;
    float extraLeftPx = 0;
    float extraRightPx = 0;

    for(NSUInteger i = 0; i < self.tickables.count; ++i)
    {
        //        VFTickable* tickable = (VFTickable*)self.tickables[i];
        id<VFTickableDelegate> tickable = (id<VFTickableDelegate>)self.tickables[i];
        extraLeftPx = MAX(tickable.extraLeftPx, extraLeftPx);
        extraRightPx = MAX(tickable.extraRightPx, extraRightPx);
        VFModifierContext* mContext = tickable.modifierContext;
        if(mContext != nil)
        {
            left_shift = MAX(left_shift, mContext.state.left_shift);
            right_shift = MAX(right_shift, mContext.state.right_shift);
        }
    }

    return [[ExtraPx alloc] initWithLeft:left_shift right:right_shift extraLeft:extraLeftPx extraRight:extraRightPx];
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

//- (void)addTickable:(VFTickable*)tickable
- (id)addTickable:(id<VFTickableDelegate>)tickable
{
    if(!tickable)
    {
        VFLogError(@"BadArgument, Invalid tickable added.");
    }

    if(!tickable.shouldIgnoreTicks)
    {
        _shouldIgnoreTicks = NO;

        Rational* ticks = tickable.ticks;

        if([ticks gt:self.maxTicks])
        {
            self.maxTicks = [ticks clone];
        }

        if(self.minTicks == nil)
        {
            self.minTicks = [ticks clone];
        }
        else if([ticks lt:self.minTicks])
        {
            self.minTicks = [ticks clone];
        }
    }

    [tickable setTickContext:self];
    [self.tickables push:tickable];
    _preFormatted = NO;
    return self;
}

- (BOOL)preFormat
{
    if(self.preFormatted)
    {
        return YES;
    }

    for(NSUInteger i = 0; i < self.tickables.count; ++i)
    {
        id<VFTickableDelegate> tickable = self.tickables[i];
        [tickable preFormat];
        id<TickableMetrics> metrics = tickable.metrics;

        // Maintain max extra pixels from all tickables in the context
        self.extraLeftPx = MAX(self.extraLeftPx, metrics.extraLeftPx + metrics.modLeftPx);
        self.extraRightPx = MAX(self.extraRightPx, metrics.extraRightPx + metrics.modRightPx);

        // Maintain the widest note for all tickables in the context
        self.notePx = MAX(self.notePx, metrics.noteWidth);

        // Recalculate the tick context total width
        self.width = self.notePx + self.extraLeftPx + self.extraRightPx;
    }

    return YES;
}

- (BOOL)postFormat
{
    if(self.postFormatted)
    {
        return YES;
    }
    _postFormatted = YES;
    return YES;
}

+ (VFTickContext*)getNextContext:(VFTickContext*)tContext
{
    NSArray* contexts = tContext.tContexts;
    NSUInteger index = [contexts indexOfObject:tContext];
    if(contexts.count > index + 1)
    {
        return contexts[index + 1];
    }
    else
    {
        return nil;
    }
}

@end
