//
//  VFModifier.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;

#import "VFDelegates.h"
#import "VFEnum.h"
#import "VFSymbol.h"
#import "VFModifierContext.h"
#import "NSObject+NSObjectAdditions.h"

@class VFModifierContext, VFNote, VFTablesGlyphStruct, VFStaffNote;
@class ShiftState, Metrics, VFModifierState, VFFont;

//======================================================================================================================
/** The `VFModifier` class modifies a Staffmodifier. What this means more specifically is that it
 can render items to the staff defined by a code, a position and a scale.

 The following demonstrates some basic usage of this class.

 ExampleCode


 */
@interface VFModifier : VFSymbol <VFTickableDelegate>
{
   @public
    __weak VFStaffNote* _note;
    VFPositionType _positionType;

   @protected
    NSUInteger _intrinsicTicks;
    Rational* _tickMultiplier;
    Rational* _ticks;
    __weak VFVoice* _voice;

    VFTuplet* _tuplet;

    //    float _extraLeftPx;    // Extra room on left for offset note head
    //    float _extraRightPx;   // Extra room on right for offset note head

    NSInteger _index;

    float _absoluteX;
    VFTablesGlyphStruct* _glyphStruct;
    id _glyph;

    VFTickContext* _tickContext;

    float _y_shift;
    float _x_shift;
    BOOL _centerAlign;
    float _center_x_shift;

    __weak VFStaff* _staff;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (weak, nonatomic) VFStaff* staff;
@property (weak, nonatomic) VFStaffNote* note;

@property (assign, nonatomic) NSUInteger intrinsicTicks;
@property (strong, nonatomic) Rational* tickMultiplier;
@property (strong, nonatomic) Rational* ticks;

@property (weak, nonatomic) VFVoice* voice;

@property (strong, nonatomic) NSMutableArray* modifiers;

@property (strong, nonatomic) VFTuplet* tuplet;

// Get and set attached note (`StaveNote`, `TabNote`, etc.)
//@property (weak, nonatomic) VFNote *note;
@property (strong, nonatomic, readonly) NSString* category;

// Every modifier must be part of a `ModifierContext`.
@property (strong, nonatomic) VFModifierContext* modifierContext;

// Set the `text_line` for the modifier.
@property (assign, nonatomic) float text_line;

// Shift modifier down `y` pixels. Negative values shift up.
@property (assign, nonatomic) float y_shift;
@property (assign, nonatomic) float x_shift;

@property (assign, nonatomic) BOOL centerAlign;

@property (assign, nonatomic) float center_x_shift;   // TODO: update this to camelCase

//// Get and set articulation position.
//@property (assign, nonatomic) VFPositionType position;

// Get and set note index, which is a specific note in a chord.
//@property (assign, nonatomic) NSInteger index;

@property (strong, nonatomic) VFModifierState* state;

@property (strong, nonatomic) VFFont* font;

@property (strong, nonatomic) VFTickContext* tickContext;

@property (assign, nonatomic) BOOL ignore_ticks;

@property (assign, nonatomic) float extraLeftPx;
@property (assign, nonatomic) float extraRightPx;

@property (strong, nonatomic) VFTablesGlyphStruct* glyphStruct;
@property (strong, nonatomic) VFGlyph* glyph;

@property (strong, nonatomic) NSString* code;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
+ (NSString*)CATEGORY;
- (NSString*)description;
- (NSString*)prolog;
- (NSString*)epilog:(NSString*)desc;

+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;

- (id)metrics;

- (id)setPosition:(VFPositionType)position;
- (VFPositionType)position;

- (BOOL)preFormat;
- (BOOL)postFormat;
- (BOOL)postFormatWith:(NSArray*)notes;

//- (void)setX_shift:(float)x_shift;

//- (void)draw:(CGContextRef)ctx;

- (void)draw:(CGContextRef)ctx withStaff:(VFStaff*)staff withShiftX:(float)shiftX;

@end
