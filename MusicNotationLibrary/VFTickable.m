//
//  VFTickable.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

#import "VFVex.h"
#import "VFTickable.h"
#import "Rational.h"
#import "VFModifierContext.h"
#import "VFBoundingBox.h"
#import "VFTuplet.h"
#import "VFTables.h"
#import "VFPoint.h"

@implementation TickableMetrics
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}
@end

@implementation VFTickable

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupTickable];
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setupTickable;
{
    _intrinsicTicks = 0;
    _tickMultiplier = [Rational rationalWithNumerator:1 andDenominator:1];
    _ticks = [Rational rationalWithNumerator:0 andDenominator:1];
    self.width = 0;
    _x_shift = 0;   // Shift from tick context
    _voice = nil;
    _tickContext = nil;
    _modifierContext = nil;
    _modifiers = [@[] mutableCopy];
    self.preFormatted = NO;
    self.postFormatted = NO;
    _tuplet = nil;

    self.align_center = NO;
    _center_x_shift = 0;   // Shift from tick context if center aligned

    // self flag tells the formatter to ignore self tickable during
    // formatting and justification. It is set by tickables such as BarNote.
    _ignore_ticks = NO;
    self.graphicsContext = NULL;
    _metrics = [[TickableMetrics alloc] initWithDictionary:nil];
}

- (id)metrics
{
    if(!_metrics)
    {
        _metrics = [Metrics metricsZero];
    }
    return _metrics;
}

- (VFBoundingBox*)boundingBox;
{
    TickableMetrics* metrics = _metrics;
    return [VFBoundingBox boundingBoxAtX:metrics.modLeftPx atY:metrics.modRightPx withWidth:self.width andHeight:0];
}

- (float)getCenterXShift;
{
    if([self isCenterAligned])
    {
        return self.center_x_shift;
    }
    return 0;
}

- (BOOL)isCenterAligned;
{
    return self.align_center;
}

- (void)setCenterAlignment:(BOOL)align_center;
{
    self.align_center = align_center;
}

// Every tickable must be associated with a voice. self allows formatters
// and preFormatter to associate them with the right modifierContexts
- (VFVoice*)voice
{
    if(!_voice)
    {
        VFLogError(@"NoVoice, Tickable has no voice.");
    }
    return _voice;
}

- (void)setTuplet:(VFTuplet*)tuplet;
{
    // Detach from previous tuplet
    NSUInteger noteCount, beatsOccupied;

    if(self.tuplet)
    {
        noteCount = self.tuplet.noteCount;
        beatsOccupied = self.tuplet.beatsOccupied;

        // Revert old multiplier
        [self applyTickMultiplier:noteCount denominator:beatsOccupied];
    }

    // Attach to [tuplet
    if(tuplet)
    {
        noteCount = tuplet.noteCount;
        beatsOccupied = tuplet.beatsOccupied;

        [self applyTickMultiplier:beatsOccupied denominator:noteCount];
    }

    self.tuplet = tuplet;
}

// optional, if tickable has modifiers
- (void)addToModifierContext:(VFModifierContext*)mc;
{
    self.modifierContext = mc;
    // Add modifiers to modifier context (if any)
    self.preFormatted = NO;
}

// optional, if tickable has modifiers
- (void)addModifiersObject:(VFModifier*)mod;
{
    [self.modifiers addObject:mod];
    self.preFormatted = NO;
}

- (void)setTickContext:(VFTickContext*)tickContext;
{
    _tickContext = tickContext;
    self.preFormatted = NO;
}

- (BOOL)preFormat;
{
    if(self.preFormatted)
    {
        return YES;
    }
    self.width = 0;
    if(self.modifierContext)
    {
        [self.modifierContext preFormat];
    }
    return YES;
}

- (BOOL)postFormat;
{
    if(self.postFormatted)
    {
        return YES;
    }
    self.postFormatted = YES;
    return YES;
}

- (void)setIntrinsicTicks:(NSUInteger)intrinsicTicks;
{
    _intrinsicTicks = intrinsicTicks;
    self.ticks = [[self.tickMultiplier clone] mult:intrinsicTicks];
}

- (void)applyTickMultiplier:(NSUInteger)numerator denominator:(NSUInteger)denominator;
{
    [self.tickMultiplier multiply:[Rational rationalWithNumerator:numerator andDenominator:denominator]];
    self.ticks = [[self.tickMultiplier clone] mult:self.intrinsicTicks];
}

- (void)setTickDuration:(Rational*)duration;
{
    NSUInteger ticks = duration.numerator * (kRESOLUTION / duration.denominator);
    self.ticks = [[self.tickMultiplier clone] mult:ticks];
    _intrinsicTicks = [_ticks floatValue];
}

- (Rational*)getTicks;
{
    return _ticks;
}

- (id)setTicks:(Rational*)ticks;
{
    _ticks = ticks;
    return self;
}

- (BOOL)getIgnoreTicks;
{
    return _ignore_ticks;
}

- (id)setIgnoreTicks:(BOOL)ignoreTicks;
{
    _ignore_ticks = ignoreTicks;
    return self;
}

@end
