//
//  VFTickable.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFDelegates.h"
#import "VFSymbol.h"
//#import "VFModifier.h"
#import "IAModelBase.h"

@class VFPoint;

@interface TickableMetrics : IAModelBase<TickableMetrics>
@property (assign, nonatomic) float extraLeftPx;    // Extra left pixels for modifers & displace notes
@property (assign, nonatomic) float extraRightPx;   // Extra right pixels for modifers & displace notes
@property (assign, nonatomic) float noteWidth;      // The width of the note head only.
@property (assign, nonatomic) float left_shift;     // The horizontal displacement of the note.
@property (assign, nonatomic) float modLeftPx;      // Start `X` for left modifiers.
@property (assign, nonatomic) float modRightPx;     // Start `X` for right modifiers.
@property (assign, nonatomic) float notePoints;
@property (assign, nonatomic) float width;
@property (assign, nonatomic) VFPoint* point;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

//@class VFStaff, VFVoice, VFModifier, VFModifierContext;
@class VFModifierContext, VFTickContext, VFVoice, VFTuplet, VFBoundingBox, Rational, VFModifier;
//@class , VFStaff, , Tuplet, ;
//@class VFPadding;

///** The `Extra` class performs ...
//
// The following demonstrates some basic usage of this class.
//
// ExampleCode
// */
//@interface Extra : NSObject
//@property (assign, nonatomic) float left;
//@property (assign, nonatomic) float right;
//@end

//======================================================================================================================
/** The `VFTickable`. Tickables are things that sit on a score and
 have a duration, i.e., they occupy space in the musical rendering dimension.

 The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFTickable : VFSymbol <VFTickableDelegate>
{
   @private
    __weak VFStaff* _staff;

    NSUInteger _intrinsicTicks;
    Rational* _tickMultiplier;
    Rational* _ticks;

//    float _width;
    NSUInteger _x;
    float _x_shift;

    __weak VFVoice* _voice;
    VFTickContext* _tickContext;
    VFModifierContext* _modifierContext;
    NSMutableArray* _modifiers;

    VFTuplet* _tuplet;

    BOOL _align_center;
    float _center_x_shift;   // Shift from tick context if center aligned
    BOOL _ignore_ticks;

    float _getCenterXShift;
    float _extraLeftPx;
    float _extraRightPx;
    BOOL _shouldIgnoreTicks;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (weak, nonatomic) VFStaff* staff;
@property (assign, nonatomic) NSUInteger intrinsicTicks;
@property (strong, nonatomic) Rational* tickMultiplier;
//@property (strong, nonatomic) Rational *ticks;
//@property (assign, nonatomic) float width;
//@property (assign, nonatomic) float x;
@property (assign, nonatomic) float x_shift;
@property (weak, nonatomic) VFVoice* voice;
@property (strong, nonatomic) VFTickContext* tickContext;
@property (strong, nonatomic) VFModifierContext* modifierContext;
@property (strong, nonatomic) NSMutableArray* modifiers;
@property (strong, nonatomic) VFTuplet* tuplet;
//@property (strong, nonatomic) TickableMetrics *metrics;

@property (assign, nonatomic, getter=isCenterAligned, setter=setCenterAlignment:) BOOL align_center;
@property (assign, nonatomic) float centerXShift;   // Shift from tick context if center aligned

// This flag tells the formatter to ignore this tickable during
// formatting and justification. It is set by tickables such as BarNote.
//@property (assign, nonatomic) BOOL ignore_ticks;
@property (assign, nonatomic) CGContextRef graphicsContext;
@property (strong, nonatomic, readonly) VFBoundingBox* boundingBox;

@property (readonly, nonatomic, getter=getCenterXShift) float getCenterXShift;

//@property (assign, nonatomic) float extraLeftPx;
//@property (assign, nonatomic) float extraRightPx;
@property (assign, nonatomic, getter=shouldIgnoreTicks) BOOL shouldIgnoreTicks;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (id)metrics;

- (void)addToModifierContext:(VFModifierContext*)modifierContext;
- (void)addModifier:(VFModifier*)modifier;

- (BOOL)preFormat;
- (BOOL)postFormat;

- (void)setIntrinsicTicks:(NSUInteger)intrinsicTicks;
- (void)applyTickMultiplier:(NSUInteger)numerator denominator:(NSUInteger)denominator;
- (void)setTickDuration:(Rational*)duration;

- (float)getExtraLeftPx;
- (float)getExtraRightPx;
- (id)setExtraLeftPx:(float)extraLeftPx;
- (id)setExtraRightPx:(float)extraRightPx;

- (Rational*)getTicks;
- (id)setTicks:(Rational*)ticks;

- (BOOL)getIgnoreTicks;
- (id)setIgnoreTicks:(BOOL)ignoreTicks;

@end
