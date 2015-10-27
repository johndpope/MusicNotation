//
//  VFDelegates.h
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
@import UIKit;
//#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
@import AppKit;
#endif

@class VFModifierContext, VFTickContext, VFVoice, VFTuplet, VFBoundingBox, Rational, VFModifier, VFStaff, Rational;
@class Metrics;
@protocol TickableMetrics;

//======================================================================================================================
/** The `VFTickableDelegate` protocol...
 */
@protocol VFTickableDelegate <NSObject>
@required
@property (weak, nonatomic) VFStaff* staff;
@property (assign, nonatomic) NSUInteger intrinsicTicks;
@property (strong, nonatomic) Rational* tickMultiplier;
//@property (strong, nonatomic) Rational* ticks;
- (Rational*)ticks;
- (id)setTicks:(Rational*)ticks;
@property (assign, nonatomic) float width;
@property (assign, nonatomic) float x;
//@property (assign, nonatomic) float x_shift;
- (id)setXShift:(float)xShift;
- (float)xShift;
//@property (weak, nonatomic) VFVoice* voice;
- (id)setVoice:(VFVoice*)voice;
- (VFVoice*)voice;
//@property (strong, nonatomic) VFTickContext* tickContext;
- (id)setTickContext:(VFTickContext*)tickContext;
- (VFTickContext*)tickContext;
//@property (strong, nonatomic) VFModifierContext* modifierContext;
- (id)setModifierContext:(VFModifierContext*)modifierContext;
- (VFModifierContext*)modifierContext;
@property (strong, nonatomic) NSMutableArray* modifiers;
@property (assign, nonatomic) BOOL preFormatted;
@property (assign, nonatomic) BOOL postFormatted;
@property (strong, nonatomic) VFTuplet* tuplet;

@property (assign, nonatomic) BOOL centerAlign;
@property (assign, nonatomic) float center_x_shift;   // Shift from tick context if center aligned
//@property (assign, nonatomic) BOOL ignore_ticks;
@property (strong, nonatomic, readonly) VFBoundingBox* boundingBox;
//@property (readonly, nonatomic, getter=getCenterXShift) float getCenterXShift;
@property (assign, nonatomic) float extraLeftPx;
@property (assign, nonatomic) float extraRightPx;
@property (assign, nonatomic) BOOL shouldIgnoreTicks;

@required
//- (id)metrics;

@required
- (void)addToModifierContext:(VFModifierContext*)mc;
//- (void)addModifiersObject:(VFModifier*)mod;
- (id)addModifier:(VFModifier*)modifier;

- (BOOL)preFormat;
- (BOOL)postFormat;

- (id<TickableMetrics>)metrics;

//- (BOOL)getIgnoreTicks;
//- (id)setIgnoreTicks:(BOOL)ignoreTicks;

- (void)setIntrinsicTicks:(NSUInteger)intrinsicTicks;
- (void)applyTickMultiplier:(NSUInteger)numerator denominator:(NSUInteger)denominator;
- (void)setTickDuration:(Rational*)duration;

@optional
- (void)draw:(CGContextRef)ctx;
@end

@protocol TickableMetrics <NSObject>
@required
@property (assign, nonatomic) float width;          // The total width of the note (including modifiers.)
@property (assign, nonatomic) float noteWidth;      // The width of the note head only.
@property (assign, nonatomic) float left_shift;     // The horizontal displacement of the note.
@property (assign, nonatomic) float modLeftPx;      // Start `X` for left modifiers.
@property (assign, nonatomic) float modRightPx;     // Start `X` for right modifiers.
@property (assign, nonatomic) float extraLeftPx;    // Extra left pixels for modifers & displace notes
@property (assign, nonatomic) float extraRightPx;   // Extra right pixels for modifers & displace notes
@property (assign, nonatomic) float notePoints;
@end
