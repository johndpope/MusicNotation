//
//  Mocks.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
//#import "VFTestView.h"
#import "TestViewController.h"
#import "VFDelegates.h"
#import "VFTickable.h"
#import "VFEnum.h"

//======================================================================================================================
/** The `Mocks` class tests ...

 */
@interface MockTickable : NSObject <VFTickableDelegate>
{
    __weak VFStaff* _staff;
    NSUInteger _intrinsicTicks;
    Rational* _tickMultiplier;
    Rational* _ticks;
    float _width;
    float _x;
    float _xShift;
    __weak VFVoice* _voice;
    VFTickContext* _tickContext;
    VFModifierContext* _modifierContext;
    NSMutableArray* _modifiers;
    BOOL _preFormatted;
    BOOL _postFormatted;
    VFTuplet* _tuplet;
    TickableMetrics* _metrics;
    BOOL _align_center;
    float _center_x_shift;
    BOOL _ignore_ticks;
    CGContextRef _graphicsContext;
    VFBoundingBox* _boundingBox;
    float _getCenterXShift;
    float _extraLeftPx;
    float _extraRightPx;
    BOOL _shouldIgnoreTicks;
}
@property (weak, nonatomic) VFStaff* staff;

@property (assign, nonatomic) NSUInteger intrinsicTicks;
@property (strong, nonatomic) Rational* tickMultiplier;

//@property (strong, nonatomic) Rational* ticks;

//@property (assign, nonatomic) float width;
//@property (assign, nonatomic) float x_shift;
@property (weak, nonatomic) VFVoice* voice;

@property (strong, nonatomic) VFTickContext* tickContext;

@property (strong, nonatomic) VFModifierContext* modifierContext;
@property (strong, nonatomic) NSMutableArray* modifiers;
@property (assign, nonatomic) BOOL preFormatted;
@property (assign, nonatomic) BOOL postFormatted;
@property (strong, nonatomic) VFTuplet* tuplet;
@property (strong, nonatomic) TickableMetrics* metrics;
@property (assign, nonatomic, getter=isCenterAligned, setter=setCenterAlignment:) BOOL align_center;
@property (assign, nonatomic) float center_x_shift;   // Shift from tick context if center aligned

//@property (assign, nonatomic) BOOL ignore_ticks;

@property (assign, nonatomic) CGContextRef graphicsContext;
@property (strong, nonatomic, readonly) VFBoundingBox* boundingBox;
@property (readonly, nonatomic, getter=getCenterXShift) float getCenterXShift;
@property (assign, nonatomic) float extraLeftPx;
@property (assign, nonatomic) float extraRightPx;

@property (assign, nonatomic) BOOL shouldIgnoreTicks;

- (instancetype)initWithTimeType:(VFTimeType)timeType;
+ (MockTickable*)mockTickableWithTimeType:(VFTimeType)timeType;

//- (void)addToModifierContext:(VFModifierContext *)mc;
//- (void)addModifiersObject:(VFModifier *)mod;
- (BOOL)preFormat;
//- (BOOL)postFormat;
//- (void)setIntrinsicTicks:(Rational *)intrinsicTicks;
//- (void)applyTickMultiplier:(NSUInteger)numerator denominator:(NSUInteger)denominator;
//- (void)setDuration:(Rational *)duration;

- (float)getX;
- (Rational*)getIntrinsicTicks;
//- (Rational*)getTicks;
- (MockTickable*)setCustomTicks:(Rational*)t;
- (NSDictionary*)getMetrics;
- (void)getWidth;
- (MockTickable*)setCustomWidth:(float)w;
- (id)setWidth:(float)w;
- (void)setVoice:(VFVoice*)v;
- (void)setstaff:(VFStaff*)staff;
//- (void)setTickContext:(VFTickContext *)tc;
//- (void)setIgnoreTicks:(BOOL)ignore_ticks;
//- (BOOL)shouldIgnoreTicks;

- (Rational*)getTicks;
- (id)setTicks:(Rational*)ticks;

- (BOOL)getIgnoreTicks;
- (id)setIgnoreTicks:(BOOL)ignoreTicks;

@end
