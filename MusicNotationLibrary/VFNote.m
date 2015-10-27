//
//  VFNote.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFNote.h"
#import "VFVex.h"
#import "VFStaff.h"
#import "VFModifier.h"
#import "VFTickable.h"
#import "VFModifierContext.h"
#import "VFShiftState.h"
#import "VFTickContext.h"
#import "VFTables.h"
#import "VFPlayNote.h"
#import "VFClef.h"
#import "VFTickable.h"
#import "VFTables.h"
#import "VFGlyph.h"
#import "VFKeyProperty.h"
#import "NSObject+NSObjectAdditions.h"
#import "VFStrokes.h"
#import "ExtraPx.h"
#import "VFTablesNoteData.h"
#import "Rational.h"
#import "VFPoint.h"
#import "VFTablesGlyphStruct.h"
#import "VFBeam.h"
#import "VFNoteHead.h"

@implementation NoteRenderOptions

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
    }
    return self;
}

@end

@implementation NoteMetrics
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}
@end

@implementation VFNote

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        // TODO: This is a hack. fix so notehead does not derive from note.
        if(![self isKindOfClass:[VFNoteHead class]])
        {
            [self setupNote:optionsDict];
        }
        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)init;
{
    self = [self initWithDictionary:nil];
    if(self)
    {
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    [propertiesEntriesMapping addEntriesFromDictionary:@{
        @"duration" : @"durationString",
        @"ignore_ticks" : @"ignoreTicks",
        @"align_center" : @"centerAlign",
        @"center_x_shift" : @"centerXShift",
        @"keys" : @"keyStrings"
    }];
    return propertiesEntriesMapping;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"note";
}

/*!
 *  sets up the note
 *
 *  @param optionsDict dictionary of default values
 *      duration_override
 *      align_center
 */
- (void)setupNote:(NSDictionary*)optionsDict;
{
    // set up VFTickableDelegate vars
    self.intrinsicTicks = 0;
    self.tickMultiplier = Rational(1, 1);
    self.ticks = Rational(0, 1);
    self.width = 0;
    _x_shift = 0;   // Shift from tick context
    self.voice = nil;
    self.tickContext = nil;
    self.modifierContext = nil;
    self.modifiers = [NSMutableArray array];
    self.preFormatted = NO;
    self.postFormatted = NO;
    self.tuplet = nil;
    self.centerAlign = NO;
    self.centerXShift = 0;   // Shift from tick context if center aligned
    // This flag tells the formatter to ignore this tickable during
    // formatting and justification. It is set by tickables such as BarNote.
    _ignoreTicks = NO;

    if(!optionsDict)
    {
        VFLogError(@"BadArguments, \
                   Note must have valid initialization data to identify \
                   duration and type.");
    }

    VFTablesNoteInputData* inputData = [[VFTablesNoteInputData alloc] initWithDictionary:optionsDict];
    VFTablesNoteStringData* initData = [VFTables parseNoteData:inputData];
    if(!initData)
    {
        VFLogError(@"BadArguments, Invalid note initialization object: %@", initData);
    }

    // Set note properties from parameters.
    self.durationString = initData.durationString;
    self.dots = initData.dots;
    self.noteNHMRSType = initData.noteNHMRSType;
    self.noteNHMRSString = initData.noteNHMRSString;
    self.noteDurationType = initData.noteDurationType;

    if([optionsDict.allKeys containsObject:@"duration_override"])
    {
        // Custom duration
        [self setTickDuration:optionsDict[@"duration_override"]];
    }
    else
    {
        // Default duration
        self.intrinsicTicks = (NSUInteger)ceil(initData.ticks.floatValue);
        self.ticks = [initData.ticks clone];
    }

    _modifiers = [NSMutableArray array];

    // Get the glyph code for self note from the font.
    self.glyphStruct = [VFTables durationToGlyphStruct:self.noteDurationType withNHMRSType:self.noteNHMRSType];
    self.glyphCode = self.glyphStruct.code_head;
    self.code = self.glyphCode;

    // Note to play for audio players.
    self.playNote = nil;

    // Positioning contexts used by the Formatter.
    self.tickContext = nil;   // The current tick context.
    self.modifierContext = nil;
    //    _ignore_ticks = NO;

    // Positioning variables
    self.width = 0;                     // Width in pixels calculated after preFormat
    _extraLeftPx = 0;                   // Extra room on left for offset note head
    _extraRightPx = 0;                  // Extra room on right for offset note head
    _x_shift = 0;                       // X shift from tick context X
    self.left_modPx = 0;                // Max width of left modifiers
    self.right_modPx = 0;               // Max width of right mod ifiers
    self.voice = nil;                   // The voice that self note is in
    self.preFormatted = NO;             // Is self note preFormatted?
    self.ys = [NSMutableArray array];   // list of y coordinates for each note
                                        // we need to hold on to these for ties and beams.

    if([optionsDict.allKeys containsObject:@"align_center"])
    {
        self.centerAlign = [optionsDict[@"align_center"] boolValue];
    }

    _staff = nil;
    self->_renderOptions =
        [[NoteRenderOptions alloc] initWithDictionary:@{@"annotation_spacing" : @5, @"stave_padding" : @12}];
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  Render options
 *  @return render options object
 */
- (NoteRenderOptions*)renderOptions
{
    if(!self->_renderOptions)
    {
        self->_renderOptions = [[NoteRenderOptions alloc] initWithDictionary:@{
            @"annotation_spacing" : @5,
            @"staff_padding" : @12
        }];
    }
    return self->_renderOptions;
}

/*!
 *   `Note` is not really a modifier, but is used in
 *    a `ModifierContext`.
 *  @return the note category
 */
- (NSString*)category
{
    return VFNote.CATEGORY;
}

/*!
 *  hhelps create a debug description from the specified string to properties dictionary
 *  @return a dictionary of property names
 */
- (NSDictionary*)dictionarySerialization;
{
    return [self dictionaryWithValuesForKeyPaths:@[]];
}

/*!
 *   Gets the play note, which is arbitrary data that can be used by an
 *   audio player.
 *  @return play note object
 */
- (VFPlayNote*)getPlayNote
{
    return _playNote;
}

/*!
 *   Sets the play note, which is arbitrary data that can be used by an
 *   audio player.
 *  @param playNote play note object
 */
- (void)setPlayNote:(VFPlayNote*)playNote
{
    _playNote = playNote;
}

/*!
 *   Don't play notes by default, call them rests. This is also used by things like
 *   beams and dots for positioning.
 *  @return if a rest
 */
- (BOOL)isRest
{
    return NO;
}

// TODO(0xfe): Why is this method here?
- (id)addStroke:(VFStroke*)stroke atIndex:(NSUInteger)index
{
    [stroke setNote:self];
    //    stroke->_note = self;
    stroke.index = index;
    [self.modifiers push:stroke];
    [self setPreFormatted:NO];
    return self;
}

/*!
 *  Gets the target staff.
 *  @return the target staff
 */
- (VFStaff*)getStaff
{
    return _staff;
}

/*!
 *  Sets the target staff.
 *  @param staff the target staff
 */
- (void)setStaff:(VFStaff*)staff
{
    _staff = staff;
    // Update Y values if the staff is changed.
    [self setYs:[NSMutableArray arrayWithObject:@([staff getYForLine:0])]];
}

/*!
 *  Get spacing to the left of the notes.
 *  @return px
 */
- (float)extraLeftPx
{
    return _extraLeftPx;
}

/*!
 *  Get spacing to the right of the notes.
 *  @return px
 */
- (float)extraRightPx
{
    return _extraRightPx;
}

/*!
 *  set spacing to the left of the notes.
 *  @param extraLeftPx px
 *  @return this object
 */
- (id)setExtraLeftPx:(float)extraLeftPx
{
    _extraLeftPx = extraLeftPx;
    return self;
}

/*!
 *  set spacing to the right of the notes.
 *  @param extraRightPx px
 *  @return this object
 */
- (id)setExtraRightPx:(float)extraRightPx
{
    _extraRightPx = extraRightPx;
    return self;
}

/*!
 *  Returns YES if self note has no duration (e.g., bar notes, spacers, etc.)
 *  @return YES if no duration
 */
- (BOOL)shouldIgnoreTicks
{
    return _ignoreTicks;
}

/*!
 *  YES if self note has no duration (e.g., bar notes, spacers, etc.)
 *  @param ignoreTicks YES if no duration
 *  @return this object
 */
- (id)setIgnoreTicks:(BOOL)ignoreTicks;
{
    _ignoreTicks = ignoreTicks;
    return self;
}

/*!
 *  Get the staff line number for the note.
 */
- (NSUInteger)lineForNote
{
    return 0;
}

/*!
 *  Get the staff line number for rest.
 *  @return line number
 */
- (NSUInteger)lineForRest
{
    return 0;
}

/*!
 *  Get the glyph struct associated with this note.
 *  @return a glyph struct
 */
- (VFTablesGlyphStruct*)glyphStruct
{
    return _glyphStruct;
}

/*!
 *  get the ticks occupied
 *  @return ticks
 */
- (Rational*)ticks;
{
    return _ticks;
}

/*!
 *  set ticks directly
 *  @param ticks amount of ticks
 *  @return this object
 */
- (id)setTicks:(Rational*)ticks;
{
    _ticks = ticks;
    return self;
}

/*!
 *  multiply ticks by factor
 *  @param numerator   p
 *  @param denominator q
 */
- (void)applyTickMultiplier:(NSUInteger)numerator denominator:(NSUInteger)denominator
{
    [self.tickMultiplier multiply:Rational(numerator, denominator)];
    self.ticks = [[self.tickMultiplier clone] mult:self.intrinsicTicks];
}

/*!
 *  Set the tick duration
 *  @param duration ticks
 */
- (void)setTickDuration:(Rational*)duration;
{
    NSUInteger ticks = duration.numerator * (kRESOLUTION / duration.denominator);
    self.ticks = [[self.tickMultiplier clone] mult:ticks];
    _intrinsicTicks = [_ticks floatValue];
}

/*!
 *  set Y positions for self note. Each Y value is associated with
 *  an individual pitch/key within the note/chord.
 *  @param ys collection of points
 */
- (void)setYs:(NSMutableArray*)ys
{
    _ys = ys;
}

/*!
 *  get Y positions for self note. Each Y value is associated with
 *  an individual pitch/key within the note/chord.
 *  @return collection of points
 */
- (NSMutableArray*)ys
{
    if(!_ys)
    {
        _ys = [NSMutableArray array];
    }

    if(_ys.count == 0)
    {
        VFLogError(@"NoYValues, No Y-values calculated for self note.");
    }
    return _ys;
}

/*!
 *   Get the Y position of the space above the stave onto which text can
 *   be rendered.
 *  @param text_line the staff line
 *  @return the y coordinate on the staff
 */
- (float)yForTopText:(NSUInteger)text_line
{
    if(!self.staff)
    {
        VFLogError(@"Nostaff %@", @"No staff attached to self note.");
    }
    return [self.staff getYForTopTextWithLine:text_line];
}

/*!
 *  Get a `BoundingBox` for self note.
 *  @return a bounding box
 */
- (VFBoundingBox*)getBoundingBox
{
    return nil;
}

/*!
 *  Returns the voice that self note belongs in.
 *  @return the voice
 */
- (VFVoice*)voice
{
    if(!_voice)
    {
        VFLogError(@"NoVoice %@", @"Note has no voice.");
    }
    return _voice;
}

/*!
 *  Attach self note to `voice`.
 *  @param voice the voice to attach note to
 *  @return this object
 */
- (id)setVoice:(VFVoice*)voice
{
    _voice = voice;
    _preFormatted = NO;
    return self;
}

/*!
 *  Set the `TickContext` for self note.
 *  @param tickContext the tick context
 *  @return this object
 */
- (id)setTickContext:(VFTickContext*)tickContext
{
    _tickContext = tickContext;
    //        [super set:tickContext];
    self.preFormatted = NO;
    return self;
}

/*!
 *  Get the `TickContext` for self note.
 *  @return the tick context
 */
- (VFTickContext*)tickContext
{
    return _tickContext;
}

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
- (NSString*)duration
{
    return _duration;
}

/*!
 *  Gets if this note has dots
 *  @return YES if not has dots
 */
- (BOOL)isDotted
{
    return self.dots > 0;
}

/*!
 *  Gets if this note has a stem
 *  @return YES if not has a stem
 */
- (BOOL)hasStem
{
    return NO;
}

/*!
 *  Gets count of dots
 *  @return dots count
 */
- (NSUInteger)getDotsCount
{
    return _dots;
}

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
{
    if(!_noteNHMRSString)
    {
        _noteNHMRSType = VFNoteNote;
        _noteNHMRSString = @"n";
    }
    return _noteNHMRSString;
}

/*!
 *  sets the beam for this note
 *  @param beam beam to set
 *  @return this object
 *  @note ignores parameters
 */
- (id)setBeam:(VFBeam*)beam
{
    return self;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  Attach self note to a modifier context.
 *  @param modifierContext the modifier context
 *  @return this object
 */
- (id)setModifierContext:(VFModifierContext*)modifierContext
{
    _modifierContext = modifierContext;
    return self;
}

/*!
 *  gets the modifier context
 *  @return the modifier context
 */
- (VFModifierContext*)modifierContext
{
    return _modifierContext;
}

/*!
 *  Generic function to add modifiers to a note
 *  @param modifier modifier to add
 *  @param index    index of the key that we're modifying
 *  @return this object
 */
- (id)addModifier:(VFModifier*)modifier atIndex:(NSUInteger)index;
{
    //    [modifier setNote:self];
    modifier->_note = self;
    modifier.parent = self;
    modifier.index = index;
    [self.modifiers push:modifier];
    [self setPreFormatted:NO];
    return self;
}

/*!
 *  optional, if tickable has modifiers
 *  @note taken from tickable.js
 *  @param modifierContext the modifier context
 *  @return this object
 */
- (id)addToModifierContext:(VFModifierContext*)modifierContext
{
    self.modifierContext = modifierContext;
    // Add modifiers to modifier context (if any)
    self.preFormatted = NO;
    return self;
}

// Attach a modifier to self note.
- (void)attachModifier:(VFModifier*)modifier atIndex:(NSUInteger)index
{
    modifier->_note = self;
    modifier.index = index;
    [self.modifiers addObject:modifier];
    self.preFormatted = NO;
}

/*!
 *  Attach a modifier to this note.
 *  @param modifier the modifier to add to this note
 *  @return this object
 */
- (id)addModifier:(VFModifier*)modifier;
{
    [self.modifiers push:modifier];
    self.preFormatted = NO;
    return self;
}

/*!
 *  gets the point to put modifier for this note
 *  @return an xy point
 */
- (VFPoint*)getModifierstartXY
{
    if(!self.preFormatted)
    {
        VFLogError(@"UnformattedNote %@", @"Can't call GetModifierStartXY on an unformatted note");
    }

    return [VFPoint pointWithX:self.absoluteX andY:[self.ys[0] floatValue]];
}

/*!
 *  gets the point to put modifier for this note
 *  @param position the `left`, `right`, `top`, or `bottom` position to put the modifier
 *  @param index    if there's more than one modifier, then which index to occupy
 *  @return an xy point
 */
- (VFPoint*)getModifierstartXYforPosition:(VFPositionType)position andIndex:(NSUInteger)index;
{
    if(!self.preFormatted)
    {
        VFLogError(@"UnformattedNote %@", @"Can't call GetModifierStartXY on an unformatted note");
    }

    VFLogError(@"ModifierstartXYforPositionError, better to call method that takes not args.");

    return [VFPoint pointWithX:self.absoluteX andY:[self.ys[0] floatValue]];
}

/*!
 *  Get the coordinates for where modifiers begin.
 *  @return an (x,y) point
 */
- (VFPoint*)modifiersStartXY
{
    if(!self.preFormatted)
    {
        VFLogError(@"UnformattedNote %@", @"Can't call GetModifierStartXY on an unformatted note");
    }

    return [VFPoint pointWithX:self.absoluteX andY:[self.ys[0] floatValue]];
}

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
- (NoteMetrics*)metrics
{
    if(!self.preFormatted)
    {
        VFLogError(@"UnformattedNote, Can't call getMetrics on an unformatted note.");
    }

    float modLeftPx = 0;
    float modRightPx = 0;
    if(self.modifierContext)
    {
        modLeftPx = self.modifierContext.state.left_shift;
        modRightPx = self.modifierContext.state.right_shift;
    }
    float width = self.width;
    //    NoteMetrics* metrics = [[NoteMetrics alloc] initWithDictionary:@{
    //        @"width" : @(width),
    //        @"noteWidth" : @(width - modLeftPx - modRightPx -   // used by accidentals and modifiers
    //                           self.extraLeftPx -
    //                           self.extraRightPx),
    //        @"left_shift" : @(self.x_shift),
    //        @"modLeftPx" : @(modLeftPx),
    //        @"modRightPx" : @(modRightPx),
    //        @"extraLeftPx" : @(self.extraLeftPx),
    //        @"extraRightPx" : @(self.extraRightPx),
    //    }];
    NoteMetrics* metrics = [[NoteMetrics alloc] initWithDictionary:nil];
    metrics.width = width;
    metrics.noteWidth = width - modLeftPx - modRightPx -   // used by accidentals and modifiers
                        self.extraLeftPx - self.extraRightPx;
    metrics.left_shift = _x_shift;   // TODO(0xfe): Make style consistent
    metrics.modLeftPx = modLeftPx;
    metrics.modRightPx = modRightPx;
    metrics.extraLeftPx = self.extraLeftPx;
    metrics.extraRightPx = self.extraRightPx;
    return metrics;
}

//
/*!
 *  Sets width of note. Used by the formatter for positioning.
 *  @param width note width
 */
- (void)setWidth:(float)width
{
    _width = width;
}

/*!
 *  Gets width of note. Used by the formatter for positioning.
 *  @return width note width
 */
- (float)width
{
    if(!_preFormatted)
    {
        VFLogError(@"UnformattedNote %@", @"Can't call GetWidth on an unformatted note.");
    }

    //    return self.width + (self.modifierContext ? self.modifierContext.width : 0);
    return _width + (self.modifierContext ? self.modifierContext.width : 0);
}

/*!
 *  Displace note by `x` pixels.
 *  @param x_shift amount to shift
 *  @return this object
 */
- (id)setXShift:(float)xShift
{
    _x_shift = xShift;
    return self;
}

- (float)xShift
{
    return _x_shift;
}

- (float)centerXShift
{
    if(self.centerAlign)
    {
        return _centerXShift;
    }
    else
    {
        return 0;
    }
}

//- (BOOL)isCenterAligned
//{
//    return _alignCenter;
//}
//
//- (void)setCenterAlignment:(BOOL)alignCenter
//{
//    _alignCenter = alignCenter;
//    //    return self;
//}

/*!
 *  Get `X` position of self tick context.
 *  @return tick context x position
 */
- (float)x
{
    if(!_tickContext)
    {
        VFLogError(@"NoTickContext %@", @"Note needs a TickContext assigned for an X-Value");
    }

    return _tickContext.x + _x_shift;
}

/*!
 *  Get the absolute `X` position of self note relative to the staff.
 *  @return absolut x position
 */
- (float)absoluteX
{
    if(!_tickContext)
    {
        VFLogError(@"NoTickContext %@", @"Note needs a TickContext assigned for an X-Value");
        return 0;
    }

    // Position note to left edge of tick context.
    float x = _tickContext.x;
    if(_staff)
    {
        x += [_staff getNoteStartX] + ((NoteRenderOptions*)self->_renderOptions).staff_padding;
    }

    if(self.centerAlign)
    {
        x += self.centerXShift;
    }

    return x;
}

- (BOOL)preFormat
{
    return [super preFormat];
}

- (BOOL)postFormat
{
    return [super postFormat];
}

- (void)setPreFormatted:(BOOL)preFormatted
{
    _preFormatted = preFormatted;
    // Maintain the width of left and right modifiers in pixels.
    if(_preFormatted)
    {
        ExtraPx* extra = [_tickContext getExtraPx];
        self.left_modPx = MAX(self.left_modPx, extra.left);
        self.right_modPx = MAX(self.right_modPx, extra.right);
    }
}

- (void)draw:(CGContextRef)ctx
{
//    [super draw:ctx];
}

@end
