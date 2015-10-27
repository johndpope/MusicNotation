//
//  VFModifier.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFModifier.h"
#import "VFNote.h"
#import "VFLog.h"
#import "VFEnum.h"
#import "VFModifierContext.h"
#import "VFMetrics.h"
#import "VFGlyphList.h"
#import "VFGlyph.h"
#import "VFStaff.h"
//#import "VFNote.h"
#import "VFTickContext.h"
#import "VFRenderOptions.h"
#import <objc/runtime.h>
#import "NSString+Ruby.h"
#import "Rational.h"
#import "VFBoundingBox.h"
#import "VFTuplet.h"
#import "VFTables.h"
#import "VFTickable.h"

@interface VFModifier (private)
//@property (assign, nonatomic) float width;
@end

@implementation VFModifier

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setupModifier];
        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setupModifier
{
    self.width = 0;
    //    self.graphicsContext = NULL;

    // Modifiers are attached to a note and an index. An index is a
    // specific head in a chord.
    //    _note = nil;
    _index = -1;

    // The `text_line` is reserved space above or below a stave.
    _text_line = 0;
    _positionType = VFPositionLeft;
    _modifierContext = nil;
    _x_shift = 0;
    _y_shift = 0;
    // NOTE: uncomment the folloing for more debug info
    //    [VFLog logInfo:[NSString stringWithFormat:@"Created new modifier. Class: %@ Category: %@",
    //                                              [object_getClass((id)self) class], [object_getClass((id)self)
    //                                              CATEGORY]]];
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY;
{
    return @"none";
}

// Every modifier has a category. The `ModifierContext` uses this to determine
// the type and order of the modifiers.
- (NSString*)category;
{
    return [VFModifier CATEGORY];
}

- (NSString*)description
{
    NSString* ret = [self prolog];

    ret = [ret concat:[NSString stringWithFormat:@"Category: %@\n", [[self class] CATEGORY]]];   // self.category]];
    ret = [ret concat:[self.metrics description]];                                               // prettyPrint]];

    return [VFLog formatObject:[self epilog:ret]];
}
- (NSString*)prolog
{
    //    static int depth = 0;
    //    int i = depth++;
    //    id a = self;
    //    while (i > 0) {
    //        a = class_getSuperclass([a class]);
    //        --i;
    //    }
    //
    //    const char *str = class_getName([a class]);

    //    NSString *desc = [desc concat:[NSString stringWithFormat:@"%s <%p> : { \n", str, self]];

    NSString* desc = [NSString stringWithFormat:@"%@ { \n", @""];

    //    NSString *desc = [NSString stringWithFormat:@"%@ { \n", @"super : "];

    //    NSString *desc = [NSString stringWithCString:str encoding:NSASCIIStringEncoding];
    //***
    //    desc = [desc concat:[NSString stringWithFormat:@"%s { \n", str]];
    return desc;
}

- (NSString*)epilog:(NSString*)desc
{
    desc = [desc concat:@"}\n"];
    return desc;
}

//- (id)metrics;
//{
//    return _metrics;
//}

+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    return YES;
}

//- (BOOL)preFormat; { return YES; }
//- (BOOL)postFormat; { return YES; }
- (BOOL)postFormatWith:(NSArray*)notes;
{
    return YES;
}

// Shift modifier `x` pixels in the direction of the modifier. Negative values
// shift reverse.
- (void)setX_shift:(float)x_shift;
{
    _x_shift = 0;
    if(self.position == VFPositionLeft)
    {
        _x_shift -= x_shift;
    }
    else
    {
        _x_shift += x_shift;
    }
}

- (id)setPosition:(VFPositionType)position;
{
    _positionType = position;
    return self;
}

- (VFPositionType)position;
{
    return _positionType;
}

- (void)setIndex:(NSUInteger)index;
{
    _index = index;
}

- (NSUInteger)index;
{
    return _index;
}

// Render the modifier onto the canvas.
- (void)draw:(CGContextRef)ctx withStaff:(VFStaff*)staff withShiftX:(float)shiftX;
{
    // abstract ?
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
    _tuplet = nil;

    self.centerAlign = NO;
    _center_x_shift = 0;   // Shift from tick context if center aligned

    // self flag tells the formatter to ignore self tickable during
    // formatting and justification. It is set by tickables such as BarNote.
    _ignore_ticks = NO;
    //    self.graphicsContext = nil;
}

- (VFBoundingBox*)boundingBox;
{
    TickableMetrics* metrics = self->_metrics;
    return [VFBoundingBox boundingBoxAtX:metrics.modLeftPx atY:metrics.modRightPx withWidth:self.width andHeight:0];
}

- (float)getCenterXShift;
{
    if(self.centerAlign)
    {
        return self.center_x_shift;
    }
    return 0;
}

//- (void)setCenterAlignment:(BOOL)align_center;
//{
//    self.align_center = align_center;
//}

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

- (Rational*)tickMultiplier;
{
    if(!_tickMultiplier)
    {
        _tickMultiplier = RationalOne();
    }
    return _tickMultiplier;
}

- (Rational*)ticks;
{
    if(!_ticks)
    {
        _ticks = RationalZero();
    }
    return _ticks;
}

- (void)setIntrinsicTicks:(NSUInteger)intrinsicTicks;
{
    _intrinsicTicks = intrinsicTicks;
    _ticks = [[self.tickMultiplier clone] mult:intrinsicTicks];
}

- (void)applyTickMultiplier:(NSUInteger)numerator denominator:(NSUInteger)denominator;
{
    [self.tickMultiplier multiply:[Rational rationalWithNumerator:numerator andDenominator:denominator]];
    _ticks = [[self.tickMultiplier clone] mult:self.intrinsicTicks];
}

- (void)setDuration:(Rational*)duration;
{
    NSUInteger ticks = duration.numerator * (kRESOLUTION / duration.denominator);
    _ticks = [[self.tickMultiplier clone] mult:ticks];
    _intrinsicTicks = [self.ticks floatValue];
}

@end
