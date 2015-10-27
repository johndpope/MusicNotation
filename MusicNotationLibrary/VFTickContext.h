//
//  VFTickContext.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

@import Foundation;

#import "VFContextDelegate.h"
#import "VFDelegates.h"
#import "IAModelBase.h"
#import "ExtraPx.h"

@class Rational, VFTickable, VFPoint, VFPadding, VFStaff, VFModifier;

//======================================================================================================================
/** The `VFTickContext` class  is a A formatter for abstract
 tickable objects, such as notes, chords,
 tabs, etc.

 The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFTickContext : IAModelBase
{   //<VFContextDelegate>
   @protected
    BOOL _preFormatted;
    BOOL _postFormatted;
    float _width;
    float _x;
    float _pixelsUsed;

    //    TickableMetrics* _metrics;
    id<TickableMetrics> _metrics;
    BOOL _shouldIgnoreTicks;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (strong, nonatomic) VFPoint* position;

@property (assign, nonatomic) float x;

/** Notes, tabs, chords, lyrics.
 */
@property (strong, nonatomic) NSMutableArray* tickables;

@property (strong, nonatomic) NSArray* tContexts;   // Parent array of tick contexts

@property (strong, nonatomic) Rational* tick;
@property (strong, nonatomic) Rational* ticks;

@property (strong, nonatomic) Rational* currentTick;

@property (strong, nonatomic) Rational* maxTicks;

@property (strong, nonatomic) Rational* minTicks;

//@property (strong, nonatomic) Metrics *metrics;

/** width of this overall
 */
@property (assign, nonatomic) float width;

//@property (assign, nonatomic) BOOL shouldIgnoreTicks;
@property (weak, nonatomic) id parent;
@property (weak, nonatomic) VFStaff* staff;

@property (strong, nonatomic, readonly) id<TickableMetrics> metrics;

@property (strong, nonatomic) VFPadding* padding;

/** width of widest note in this context
 */
@property (assign, nonatomic) float notePoints;

@property (assign, nonatomic) CGContextRef graphicsContext;

@property (assign, nonatomic) float notePx;         // width of widest note in self context
@property (assign, nonatomic) float extraLeftPx;    // Extra left pixels for modifers & displace notes
@property (assign, nonatomic) float extraRightPx;   // Extra right pixels for modifers & displace notes
@property (assign, nonatomic) BOOL align_center;

@property (assign, nonatomic, readonly) BOOL preFormatted;
@property (assign, nonatomic, readonly) BOOL postFormatted;
@property (assign, nonatomic) BOOL shouldIgnoreTicks;
@property (assign, nonatomic) float pixelsUsed;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)init;

- (BOOL)shouldIgnoreTicks;
- (float)getWidth;
- (float)x;
- (void)setX:(float)x;
- (float)getPixelsUsed;
- (void)setPixelsUsed:(float)pixelsUsed;
- (void)setPadding:(VFPadding*)padding;
- (Rational*)getMaxTicks;
- (Rational*)getMinTicks;
- (NSArray*)getTickables;
- (ExtraPx*)getExtraPx;
- (NSArray*)getCenterAlignedTickables;

//- (void)addTickable:(VFTickable *)tickable;
- (id)addTickable:(id<VFTickableDelegate>)tickable;
- (BOOL)preFormat;
- (BOOL)postFormat;
+ (VFTickContext*)getNextContext:(VFTickContext*)tContext;

@end
