//
//  VFNote.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFMetrics.h"
#import "VFDelegates.h"
#import "VFSymbol.h"
#import "VFRenderOptions.h"
#import "VFEnum.h"

@interface NoteRenderOptions : RenderOptions
@property (assign, nonatomic) float annotation_spacing;
@property (assign, nonatomic) float staff_padding;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

@interface NoteMetrics : Metrics <TickableMetrics>
//@property (assign, nonatomic) float width;      // The total width of the note (including modifiers.)
@property (assign, nonatomic) float noteWidth;      // The width of the note head only.
@property (assign, nonatomic) float left_shift;     // The horizontal displacement of the note.
@property (assign, nonatomic) float modLeftPx;      // Start `X` for left modifiers.
@property (assign, nonatomic) float modRightPx;     // Start `X` for right modifiers.
@property (assign, nonatomic) float extraLeftPx;    // Extra left pixels for modifers & displace notes
@property (assign, nonatomic) float extraRightPx;   // Extra right pixels for modifers & displace notes
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

@class VFVoice, VFStaff, VFNote, VFClef, VFTablesGlyphStruct;   //, VFBoundingBox;
@class VFPlayNote, VFModifier, Rational, VFTickContext, VFStroke, VFBeam;

//======================================================================================================================
/** The `VFNote` class  implements an abstract interface for notes and chords that
      are rendered on a stave. Notes have some common properties: All of them
      have a value (e.g., pitch, fret, etc.) and a duration (quarter, half, etc.)

 // To create a new note you need to provide a `note_struct`, which consists
 // of the following fields:
 //
 // `type`: The note type (e.g., `r` for rest, `s` for slash notes, etc.)
 // `dots`: The number of dots, which affects the duration.
 // `duration`: The time length (e.g., `q` for quarter, `h` for half, `8` for eighth etc.)
 //
 // The range of values for these parameters are available in `src/tables.js`.

 // Every note is a tickable, i.e., it can be mutated by the `Formatter` class for
 // positioning and layout.

      Some notes have stems, heads, dots, etc. Most notational elements that
      surround a note are called *modifiers*, and every note has an associated
      array of them. All notes also have a rendering context and belong to a stave.

     The following demonstrates some basic usage of this class.

         ExampleCode
 */
@interface VFNote : VFSymbol <VFTickableDelegate>
{
   @protected
    __weak VFVoice* _voice;
    NSMutableArray* _modifiers;
    VFPadding* _modifierPoints;
    NSString* _duration;
    NSString* _durationString;
    NSString* _noteNHMRSString;
    NSString* _key;
    VFClef* _clef;
    NSUInteger _dots;
    NSMutableArray* _ys;
    NSMutableArray* _keyStrings;
    NSMutableArray* _keyProperties;
    VFPlayNote* _playNote;
    float _x_shift;
    VFTuplet* _tuplet;
    float _left_modPx;
    float _right_modPx;
    VFTickContext* _tickContext;
    VFModifierContext* _modifierContext;
    VFNoteNHMRSType _noteNHMRSType;
    BOOL _ignoreTicks;
    //    float _width;
    Rational* _ticks;
    float _extraLeftPx;
    float _extraRightPx;
    BOOL _centerAlign;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

// the key for this note
@property (strong, nonatomic) NSString* key;
@property (strong, nonatomic) NSMutableArray* keyStrings;   // pitches in the note

// the clef type for this note
@property (strong, nonatomic) VFClef* clef;
@property (strong, nonatomic) VFPoint* modifiersStartXY;
@property (assign, nonatomic) NSUInteger dots;

/** holds an array of NSNumber filled with positive absolet
 *  float values of screen coordinates
 *  used to help position note and modifiers
 */
@property (strong, nonatomic) NSMutableArray* ys;

// Collection of KeyProperty objects
@property (strong, nonatomic) NSMutableArray* keyProps;

//@property (strong, nonatomic) NoteMetrics* metrics;

@property (strong, nonatomic, readonly) NSString* category;

// for audio players later
@property (strong, nonatomic) VFPlayNote* playNote;

@property (assign, nonatomic) VFNoteDurationType noteDurationType;

// note types: n h r m s ?
@property (assign, nonatomic) VFNoteNHMRSType noteNHMRSType;

@property (assign, nonatomic) float width;

// durations: "q", "h", "8", "16", "32"
@property (strong, nonatomic) NSString* durationString;
@property (strong, nonatomic) NSString* noteNHMRSString;
@property (assign, nonatomic) BOOL autoStem;
@property (assign, nonatomic, getter=isRest) BOOL rest;
@property (assign, nonatomic, getter=isDotted) BOOL dotted;
@property (assign, nonatomic) BOOL displaced;
@property (assign, nonatomic) float voiceShiftWidth;
@property (assign, nonatomic) float left_modPx;
@property (assign, nonatomic) float right_modPx;
@property (readonly, nonatomic) float leftModifierPoints;
@property (readonly, nonatomic) float rightModifierPoints;
@property (readonly, nonatomic) float lowerModifierPoints;
@property (readonly, nonatomic) float upperModifierPoints;
@property (assign, nonatomic) float minLine;
@property (assign, nonatomic) float maxLine;
@property (assign, nonatomic) float line;
@property (strong, nonatomic) VFTablesGlyphStruct* glyphStruct;
@property (strong, nonatomic) NSString* glyphCode;   // code head
@property (strong, nonatomic) NSString* code;
@property (weak, nonatomic) VFStaff* staff;
@property (assign, nonatomic) NSUInteger intrinsicTicks;
@property (strong, nonatomic) Rational* tickMultiplier;
- (Rational*)ticks;
- (id)setTicks:(Rational*)ticks;
@property (assign, nonatomic) float x;
- (id)setTickContext:(VFTickContext*)tickContext;
- (VFTickContext*)tickContext;
- (id)setModifierContext:(VFModifierContext*)modifierContext;
- (VFModifierContext*)modifierContext;
@property (strong, nonatomic) NSMutableArray* modifiers;
@property (strong, nonatomic) VFTuplet* tuplet;
//@property (assign, nonatomic, getter=isCenterAligned, setter=setCenterAlignment:) BOOL align_center;
//@property (assign, nonatomic) float center_x_shift;   // Shift from tick context if center aligned
@property (assign, nonatomic) float centerXShift;
- (float)extraLeftPx;
- (float)extraRightPx;
- (id)setExtraLeftPx:(float)extraLeftPx;
- (id)setExtraRightPx:(float)extraRightPx;
@property (assign, nonatomic) BOOL centerAlign;
@property (assign, nonatomic, readonly) float absoluteX;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

/*!
 *  Render options
 *  @return render options object
 */
- (NoteRenderOptions*)renderOptions;

/*!
 *   Gets the play note, which is arbitrary data that can be used by an
 *   audio player.
 *  @return play note object
 */
- (VFPlayNote*)getPlayNote;

/*!
 *   Sets the play note, which is arbitrary data that can be used by an
 *   audio player.
 *  @param playNote play note object
 */
- (void)setPlayNote:(VFPlayNote*)playNote;

/*!
 *   Don't play notes by default, call them rests. This is also used by things like
 *   beams and dots for positioning.
 *  @return if a rest
 */
- (BOOL)isRest;

- (id)addStroke:(VFStroke*)stroke atIndex:(NSUInteger)index;

/*!
 *  Gets the target staff.
 *  @return the target staff
 */
- (VFStaff*)getStaff;

/*!
 *  Sets the target staff.
 *  @param staff the target staff
 */
- (void)setStaff:(VFStaff*)staff;

///*!
// *  Get spacing to the left of the notes.
// *  @return px
// */
//- (float)extraLeftPx;
//
///*!
// *  Get spacing to the right of the notes.
// *  @return px
// */
//- (float)extraRightPx;
//
///*!
// *  set spacing to the left of the notes.
// *  @param extraLeftPx px
// *  @return this object
// */
//- (id)setExtraLeftPx:(float)extraLeftPx;
//
///*!
// *  set spacing to the right of the notes.
// *  @param extraRightPx px
// *  @return this object
// */
//- (id)setExtraRightPx:(float)extraRightPx;

/*!
 *  Returns YES if self note has no duration (e.g., bar notes, spacers, etc.)
 *  @return YES if no duration
 */
- (BOOL)shouldIgnoreTicks;

/*!
 *  YES if self note has no duration (e.g., bar notes, spacers, etc.)
 *  @param ignoreTicks YES if no duration
 *  @return this object
 */
- (id)setIgnoreTicks:(BOOL)ignoreTicks;

/*!
 *  Get the staff line number for the note.
 */
- (NSUInteger)lineForNote;

/*!
 *  Get the staff line number for rest.
 *  @return line number
 */
- (NSUInteger)lineForRest;

/*!
 *  Get the glyph struct associated with this note.
 *  @return a glyph struct
 */
- (VFTablesGlyphStruct*)glyphStruct;

///*!
// *  get the ticks occupied
// *  @return ticks
// */
//- (Rational*)ticks;
//
///*!
// *  set ticks directly
// *  @param ticks amount of ticks
// *  @return this object
// */
//- (id)setTicks:(Rational*)ticks;

/*!
 *  multiply ticks by factor
 *  @param numerator   p
 *  @param denominator q
 */
- (void)applyTickMultiplier:(NSUInteger)numerator denominator:(NSUInteger)denominator;

/*!
 *  Set the tick duration
 *  @param duration ticks
 */
- (void)setTickDuration:(Rational*)duration;

/*!
 *  set Y positions for self note. Each Y value is associated with
 *  an individual pitch/key within the note/chord.
 *  @param ys collection of points
 */
- (void)setYs:(NSMutableArray*)ys;

/*!
 *  get Y positions for self note. Each Y value is associated with
 *  an individual pitch/key within the note/chord.
 *  @return collection of points
 */
- (NSMutableArray*)ys;

/*!
 *   Get the Y position of the space above the stave onto which text can
 *   be rendered.
 *  @param text_line the staff line
 *  @return the y coordinate on the staff
 */
- (float)yForTopText:(NSUInteger)text_line;

/*!
 *  Get a `BoundingBox` for self note.
 *  @return a bounding box
 */
- (VFBoundingBox*)getBoundingBox;

/*!
 *  Returns the voice that self note belongs in.
 *  @return the voice
 */
- (VFVoice*)voice;

/*!
 *  Attach self note to `voice`.
 *  @param voice the voice to attach note to
 *  @return this object
 */
- (id)setVoice:(VFVoice*)voice;

///*!
// *  Set the `TickContext` for self note.
// *  @param tickContext the tick context
// *  @return this object
// */
//- (id)setTickContext:(VFTickContext*)tickContext;
//
///*!
// *  Get the `TickContext` for self note.
// *  @return the tick context
// */
//- (VFTickContext*)tickContext;

/*!
 *  gets the duration of the note as a string
 *  @return note duration. one of the following
 *   @"-1"
 *   @"0"
 *   @"1"
 *   @"2"
 *   @"4"
 *   @"8"
 *   @"16"
 *   @"32"
 *   @"64"
 *   @"128"
 *   @"256"
 *   @"w"
 *   @"h"
 *   @"q"
 */
- (NSString*)duration;

/*!
 *  Gets if this note has dots
 *  @return YES if not has dots
 */
- (BOOL)isDotted;

/*!
 *  Gets if this note has a stem
 *  @return YES if not has a stem
 */
- (BOOL)hasStem;

/*!
 *  Gets count of dots
 *  @return dots count
 */
- (NSUInteger)getDotsCount;

/*!
 *  Gets the type of note as a string
 *  @return note type. one of the following
 *   @"x"
 *   @"s"
 *   @"h"
 *   @"r"
 *   @"n"
 *   @"m"
 */
- (NSString*)noteTypeString;

/*!
 *  sets the beam for this note
 *  @param beam beam to set
 *  @return this object
 *  @note ignores parameters
 */
- (id)setBeam:(VFBeam*)beam;

///*!
// *  Attach self note to a modifier context.
// *  @param modifierContext the modifier context
// *  @return this object
// */
//- (id)setModifierContext:(VFModifierContext*)modifierContext;
//
///*!
// *  gets the modifier context
// *  @return the modifier context
// */
//- (VFModifierContext*)modifierContext;

/*!
 *  Generic function to add modifiers to a note
 *  @param modifier modifier to add
 *  @param index    index of the key that we're modifying
 *  @return this object
 */
- (id)addModifier:(VFModifier*)modifier atIndex:(NSUInteger)index;

/*!
 *  optional, if tickable has modifiers
 *  @note taken from tickable.js
 *  @param modifierContext the modifier context
 *  @return this object
 */
- (id)addToModifierContext:(VFModifierContext*)modifierContext;

// Attach a modifier to self note.
- (void)attachModifier:(VFModifier*)modifier atIndex:(NSUInteger)index;

/*!
 *  Attach a modifier to this note.
 *  @param modifier the modifier to add to this note
 *  @return this object
 */
- (id)addModifier:(VFModifier*)modifier;

/*!
 *  gets the point to put modifier for this note
 *  @return an xy point
 */
- (VFPoint*)getModifierstartXY;

/*!
 *  gets the point to put modifier for this note
 *  @param position the `left`, `right`, `top`, or `bottom` position to put the modifier
 *  @param index    if there's more than one modifier, then which index to occupy
 *  @return an xy point
 */
- (VFPoint*)getModifierstartXYforPosition:(VFPositionType)position andIndex:(NSUInteger)index;

/*!
 *   Get bounds and metrics for self note.
 *   @return a struct with fields:
 *    `width`: The total width of the note (including modifiers.)
 *    `noteWidth`: The width of the note head only.
 *    `left_shift`: The horizontal displacement of the note.
 *    `modLeftPx`: Start `X` for left modifiers.
 *    `modRightPx`: Start `X` for right modifiers.
 *    `extraLeftPx`: Extra space on left of note.
 *    `extraRightPx`: Extra space on right of note.
 */
- (NoteMetrics*)metrics;

/*!
 *  Sets width of note. Used by the formatter for positioning.
 *  @param width note width
 */
- (void)setWidth:(float)width;
/*!
 *  Gets width of note. Used by the formatter for positioning.
 *  @return width note width
 */
- (float)getWidth;
/*!
 *  Displace note by `x` pixels.
 *  @param x_shift amount to shift
 *  @return this object
 */
- (id)setXShift:(float)xShift;

- (float)xShift;
- (float)centerXShift;
- (BOOL)isCenterAligned;
- (void)setCenterAlignment:(BOOL)alignCenter;
/*!
 *  Get `X` position of self tick context.
 *  @return tick context x position
 */
- (float)x;
/*!
 *  Get the absolute `X` position of self note relative to the staff.
 *  @return absolut x position
 */
- (float)absoluteX;
- (BOOL)preFormat;
- (BOOL)postFormat;
- (void)setPreFormatted:(BOOL)preFormatted;

@end
