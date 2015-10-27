//
//  Mocks.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "Mocks.h"
#import "VexFlowTestHelpers.h"

@implementation MockTickable
/**
 * VexFlow - TickContext Tests
 *

Vex.Flow.Test.TIME4_4 = {
num_beats: 4,
beat_value: 4,
resolution: kRESOLUTION
};

// Mock Tickable

 Vex.Flow.Test.MockTickable = function() { this.ignore_ticks = NO; }
*/

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _ignore_ticks = NO;
    }
    return self;
}

- (instancetype)initWithTimeType:(VFTimeType)timeType
{
    self = [super init];
    if(self)
    {
        [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    }
    return self;
}

+ (MockTickable*)mockTickableWithTimeType:(VFTimeType)timeType;
{
    return [[MockTickable alloc] initWithTimeType:timeType];
}

/*
Vex.Flow.Test.MockTickable.prototype.getX = function() {
    return this.tickContext.getX();}
Vex.Flow.Test.MockTickable.prototype.getIntrinsicTicks = function() {return this.ticks;}
Vex.Flow.Test.MockTickable.prototype.getTicks = function() {return this.ticks;}
Vex.Flow.Test.MockTickable.prototype.setTicks = function(t) {
    this.ticks = new Vex.Flow.Fraction(t, 1); return this; };
Vex.Flow.Test.MockTickable.prototype.getMetrics = function() {
    return { noteWidth: this.width,
    left_shift: 0,
    modLeftPx: 0, modRightPx: 0,
        extraLeftPx: 0, extraRightPx: 0 };
}
Vex.Flow.Test.MockTickable.prototype.getWidth = function() {return this.width;}
Vex.Flow.Test.MockTickable.prototype.setWidth = function(w) {
    this.width = w; return this; }
Vex.Flow.Test.MockTickable.prototype.setVoice = function(v) {
    this.voice = v; return this; }
Vex.Flow.Test.MockTickable.prototype.setstaff = function(staff) {
    this.staff = staff; return this; }
Vex.Flow.Test.MockTickable.prototype.setTickContext = function(tc) {
    this.tickContext = tc; return this; }
Vex.Flow.Test.MockTickable.prototype.setIgnoreTicks = function(ignore_ticks) {
    this.ignore_ticks = ignore_ticks; return this; }
Vex.Flow.Test.MockTickable.prototype.shouldIgnoreTicks = function() {
    return this.ignore_ticks; }
Vex.Flow.Test.MockTickable.prototype.preFormat = function() {}
*/

- (float)getX;
{
    return self.tickContext.x;
}
- (Rational*)getIntrinsicTicks;
{
    return _ticks;
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

- (NSDictionary*)getMetrics;
{
    return @{
        @"noteWidth" : @(self.width),
        @"left_shift" : @0,
        @"modLeftPx" : @0,
        @"modRightPx" : @0,
        @"extraLeftPx" : @0,
        @"extraRightPx" : @0
    };
    //    Metrics *ret = [Metrics metricsZero];
    //    ret.noteWidth = self.width;
    //    ret.modLeftPx = 0;
    //    ret.modRightPx = 0;
    //    ret.extraLeftPx = 0;
    //    ret.extraRightPx = 0;
}
//- (float)getWidth; {
//    return self.width;
//}
- (id)setWidth:(float)w;
{
    _width = w;
    return self;
}
- (void)setVoice:(VFVoice*)v;
{
    self.voice = v;
}
- (void)setstaff:(VFStaff*)staff;
{
    self.staff = staff;
}
- (void)setTickContext:(VFTickContext*)tc;
{
    self.tickContext = tc;
}

- (BOOL)shouldIgnoreTicks;
{
    return _ignore_ticks;
}

- (BOOL)preFormat;
{
    return YES;
}

@end
