//
//  VFBeam.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
@import Foundation;
#elif TARGET_OS_MAC
@import AppKit;
#endif
#import "VFColor.h"
#import "VFBezierPath.h"
#import "VFBeam.h"
#import "VFVex.h"
#import "VFEnum.h"
#import "VFMetrics.h"
#import "VFStemmableNote.h"
#import "VFStaffNote.h"
#import "VFNote.h"
#import "VFStem.h"
#import "Rational.h"
#import "VFTables.h"
#import "VFKeyProperty.h"
#import "VFOptions.h"
#import "VFGlyph.h"
#import "VFLine.h"
#import "VFVoice.h"
#import "VFTickable.h"
#import "OCTotallyLazy.h"
//#import <ReactiveCocoa/ReactiveCocoa.h>
#import "VFExtentStruct.h"
#import "NSString+Ruby.h"
#import "NSMutableArray+JSAdditions.h"
#import "VFTuplet.h"

@interface BeamRenderOptions : Options
@property (assign, nonatomic) float beam_width;
@property (assign, nonatomic) float max_slope;
@property (assign, nonatomic) float min_slope;
@property (assign, nonatomic) float slope_iterations;
@property (assign, nonatomic) float slope_cost;
@property (assign, nonatomic) BOOL show_stemlets;
@property (assign, nonatomic) float stemlet_extension;
@property (assign, nonatomic) float partial_beam_length;
@end
@implementation BeamRenderOptions
- (instancetype)init
{
    self = [super init];
    if (self) {
        _beam_width = 0;
        _max_slope = 0;
        _min_slope = 0;
        _slope_iterations = 0;
        _slope_cost = 0;
        _show_stemlets = NO;
        _stemlet_extension = 0;
        _partial_beam_length = 0;
    }
    return self;
}
@end

@interface BeamLine : IAModelBase
// TODO: is this data type a float or nsuiniteger
@property (assign, nonatomic) float start;
@property (assign, nonatomic) float end;
+ (BeamLine*)lineWithStart:(NSUInteger)start end:(NSUInteger)end;
@end
@implementation BeamLine
+ (BeamLine*)lineWithStart:(NSUInteger)start end:(NSUInteger)end;
{
    BeamLine* ret = [[BeamLine alloc] init];
    ret.start = start;
    ret.end = end;
    return ret;
}
@end

@interface Partial : IAModelBase
@property (assign, nonatomic) BOOL left;
@property (assign, nonatomic) BOOL right;
+ (Partial*)partialWithLeft:(BOOL)left right:(BOOL)right;
@end
@implementation Partial
+ (Partial*)partialWithLeft:(BOOL)left right:(BOOL)right;
{
    Partial* ret = [[Partial alloc] init];
    ret.left = left;
    ret.right = right;
    return ret;
}
@end

@implementation BeamConfig

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{
        @"stem_direction" : @"stemDirection",
        @"beam_rests" : @"beamRests",
        @"beam_middle_only" : @"beamMiddleOnly",
        @"show_stemlets" : @"showStemlets",
        @"maintain_stem_directions" : @"maintainStemDirections",
    }];
    return propertiesEntriesMapping;
}

@end

//======================================================================================================================
#pragma mark - VFBeam Implementation
/**---------------------------------------------------------------------------------------------------------------------
 * @name VFBeam Implementation
 * ---------------------------------------------------------------------------------------------------------------------
 */

@interface VFBeam () {
    BOOL _preFormatted;
    BOOL _postFormatted;

    BeamRenderOptions* _renderOptions;
    //    float _slope;
}
@property (assign, nonatomic) float slope;
@property (strong, nonatomic) BeamRenderOptions* renderOptions;
@property (strong, nonatomic) NSArray* break_on_indices; // nsarray<nsnumber> //indices where there are no beams
@end

@implementation VFBeam

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if (self) {
        //        [self setupBeam];
        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}
- (instancetype)initWithNotes:(NSArray*)notes
{
    self = [self initWithNotes:notes autoStem:NO];
    if (self) {
        _notes = notes;
        [self setupBeam];
    }
    return self;
}
- (instancetype)initWithNotes:(NSArray*)notes autoStem:(BOOL)autoStem;
{
    self = [self initWithDictionary:nil];
    if (self) {
        _notes = notes;
        _autoStem = YES;
        [self setupBeam];
    }
    return self;
}

+ (VFBeam*)beamWithNotes:(NSArray*)notes;
{
    return [[VFBeam alloc] initWithNotes:notes autoStem:YES];
}

+ (VFBeam*)beamWithNotes:(NSArray*)notes autoStem:(BOOL)autoStem
{
    return [[VFBeam alloc] initWithNotes:notes autoStem:autoStem];
}

- (void)setupBeam
{
    if (!_notes || _notes.count == 0) {
        VFLogError(@"BadArguments, No notes provided for beam.");
    }
    if (_notes.count == 1) {
        VFLogError(@"BadArguments, Too few notes for beam.");
    }
    // Validate beam line, direction and ticks.
    if (self.intrinsicTicks >= [VFTables durationToTicks:@"4"]) {
        VFLogError(@"BadArguments , Beams can only be applied to notes shorter than a quarter note.");
    }

    _stemDirection = VFStemDirectionUp;

    for (VFStemmableNote* note in _notes) {
        if (note.hasStem) {
            _stemDirection = note.stemDirection;
            break;
        }
    }

    VFStemDirectionType stem_direction = _stemDirection;
    // Figure out optimal stem direction based on given notes
    if (_autoStem && [((VFStemmableNote*)_notes[0]).category isEqualToString:@"staffnotes"]) {
        stem_direction = [VFBeam calculateStemDirection:_notes];
    }
    else if (_autoStem && [((VFStemmableNote*)_notes[0]).category isEqualToString:@"tabnotes"]) {
        // Auto Stem TabNotes
        float stem_weight = [[_notes reduce:^NSNumber*(NSNumber* memo, VFStemmableNote* note) {
            return [NSNumber numberWithFloat:([memo floatValue] + note.stemDirection)];
        }] floatValue];
        stem_direction = stem_weight > -1 ? VFStemDirectionUp : VFStemDirectionDown;
    }

    // Apply stem directions and attach beam to notes
    for (VFStemmableNote* note in _notes) {
        if (_autoStem) {
            [note setStemDirection:_stemDirection];
            _stemDirection = stem_direction;
        }
        note.beam = self;
    }
    _postFormatted = NO;
    //    _notes = notes; //already set in init
    _beamCount = [self getBeamCount];
    _break_on_indices = [NSMutableArray array];
    _renderOptions = [[BeamRenderOptions alloc] init];
    _renderOptions.beam_width = 5.0; // 0.5;
    _renderOptions.max_slope = 0.25;
    _renderOptions.min_slope = -0.25;
    _renderOptions.slope_iterations = 20;
    _renderOptions.slope_cost = 100;
    _renderOptions.show_stemlets = NO;
    _renderOptions.stemlet_extension = 7;
    _renderOptions.partial_beam_length = 10;

    _slope = 0;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{
        @"beam_width" : @"beamWidth",
        @"partial_beam_length" : @"partialBeamLength",

    }];
    return propertiesEntriesMapping;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*
       // The the rendering `context`
   setContext: function(context) { self.context = context; return this; },

       // Get the notes in this beam
   getNotes: function() { return self.notes; },
      */

- (BeamRenderOptions*)renderOptions
{
    if (!_renderOptions) {
        _renderOptions = [[BeamRenderOptions alloc] init];
    }
    return _renderOptions;
}

//
/*!
 *  Get the max number of beams in the set of notes
 *
 *  @return a count of possible beams
 */
- (NSUInteger)getBeamCount;
{
    NSArray* beamCounts = [self.notes oct_map:^NSNumber*(VFStemmableNote* note) {
        return [NSNumber numberWithUnsignedInteger:note.glyph.beamCount];
    }];
    NSNumber* maxBeamCount = [beamCounts reduce:^NSNumber*(NSNumber* max, NSNumber* beamCount) {
        return beamCount > max ? beamCount : max;
    }];
    return [maxBeamCount unsignedIntegerValue];
}

//
/*!
 *  Set which note `indices` to break the secondary beam at
 *
 *  @param indices which beams brean on
 *
 *  @return this object
 */
- (id)breakSecondaryAt:(NSArray*)indices;
{
    self.break_on_indices = indices;
    return self;
}

//
/*!
 *  Return the y coordinate for linear function
 *
 *  @param x          variable x coordinate
 *  @param first_x_px first x coordinade
 *  @param first_y_px first y coordinade
 *  @param slope      rise over run, slope m
 *
 *  @return the y coordinate for the given x and other variables
 */
- (float)getSlopeYForX:(float)x first_x_px:(float)first_x_px first_y_px:(float)first_y_px slope:(float)slope;
{
    return first_y_px + ((x - first_x_px) * slope);
}

/*!
 *  Calculate the best possible slope for the provided notes
 */
- (void)calculateSlope;
{
    VFStemmableNote* first_note = self.notes[0];
    float first_y_px = first_note.stemExtents.topY;
    float first_x_px = first_note.stemX;

    float inc = (self.renderOptions.max_slope - self.renderOptions.min_slope) / self.renderOptions.slope_iterations;
    float min_cost = FLT_MAX;
    float best_slope = 0;
    float y_shift = 0;

    // iterate through slope values to find best weighted fit
    for (float slope = self.renderOptions.min_slope; slope <= self.renderOptions.max_slope; slope += inc) {
        float total_stem_extension = 0;
        float y_shift_tmp = 0;

        // iterate through notes, calculating y shift and stem extension
        for (NSUInteger i = 1; i < self.notes.count; ++i) {
            VFStemmableNote* note = self.notes[i];

            float x_px = note.stemX;
            float y_px = note.stemExtents.topY;
            float slope_y_px =
                [self getSlopeYForX:x_px
                         first_x_px:first_x_px
                         first_y_px:first_y_px
                              slope:slope] + y_shift_tmp;

            // beam needs to be shifted up to accommodate note
            if (y_px * ((float)self.stemDirection) < slope_y_px * ((float)self.stemDirection)) {
                float diff = fabsf(y_px - slope_y_px);
                if (self.stemDirection == VFStemDirectionNone) {
                    VFLogError(@"CalculateSlopeError, cannot calculate slope without stem direction");
                }
                float direction = ((float)self.stemDirection); // == VFStemDirectionUp ? +1.f : -1.f;
                y_shift_tmp += diff * -direction;
                total_stem_extension += (diff * i);
            }
            else { // beam overshoots note, account for the difference
                total_stem_extension += (y_px - slope_y_px) * ((float)self.stemDirection);
            }
        }

        VFStemmableNote* last_note = self.notes[self.notes.count - 1];
        float first_last_slope = ((last_note.stemExtents.topY - first_y_px) / (last_note.stemX - first_x_px));
        // most engraving books suggest aiming for a slope about half the angle of
        // the
        // difference between the first and last notes' stem length;
        float ideal_slope = first_last_slope / 2;
        float distance_from_ideal = fabsf(ideal_slope - slope);

        // This tries to align most beams to something closer to the ideal_slope,
        // but
        // doesn't go crazy. To disable, set self.render_options.slope_cost = 0
        float cost = self.renderOptions.slope_cost * distance_from_ideal + fabsf(total_stem_extension);

        // update state when a more ideal slope is found
        if (cost < min_cost) {
            min_cost = cost;
            best_slope = slope;
            y_shift = y_shift_tmp;
        }
    }
    if (y_shift > FLT_MAX) {
        VFLogError(@"self.y_shift is unreasonable: %f", y_shift);
    }

    self.slope = best_slope;
    self.y_shift = y_shift;
}

/*!
 *   Create new stems for the notes in the beam, so that each stem
 *   extends into the beams.
 */
- (void)applyStemExtensions;
{
    VFStemmableNote* first_note = self.notes[0];
    float first_y_px = first_note.stemExtents.topY;
    float first_x_px = first_note.stemX;

    for (uint i = 0; i < self.notes.count; ++i) {
        VFStemmableNote* note = self.notes[i];

        float x_px = note.stemX;
        VFExtentStruct* y_extents = note.stemExtents;
        float base_y_px = y_extents.baseY;
        float top_y_px = y_extents.topY;

        // For harmonic note heads, shorten stem length by 3 pixels
        base_y_px += ((float)self.stemDirection) * note.glyphStruct.stem_offset;

        // Don't go all the way to the top (for thicker stems)
        float y_displacement = kSTEM_WIDTH;

        if (!note.hasStem) {
            if (note.isRest && self.renderOptions.show_stemlets) {
                float centerGlyphX = note.centerGlyphX;

                float width = self.renderOptions.beam_width;
                float total_width = ((((float)self.beamCount) - 1) * width * 1.5) + width;

                float stemlet_height = (total_width - y_displacement + self.renderOptions.stemlet_extension);

                float beam_y =
                    [self getSlopeYForX:centerGlyphX
                             first_x_px:first_x_px
                             first_y_px:first_y_px
                                  slope:self.slope];
                // (centerGlyphX, first_x_px, first_y_px, self.slope) + self.y_shift;
                float start_y = beam_y + (kSTEM_HEIGHT * ((float)self.stemDirection));
                float end_y = beam_y + (stemlet_height * ((float)self.stemDirection));

                // Draw Stemlet
                VFStem* stem = [[VFStem alloc] init];
                stem.x_begin = centerGlyphX;
                stem.x_end = centerGlyphX;
                stem.y_bottom = self.stemDirection == VFStemDirectionUp ? end_y : start_y;
                stem.y_top = self.stemDirection == VFStemDirectionUp ? start_y : end_y;
                stem.y_extend = y_displacement;
                stem.stem_extension = -1; // To avoid protruding through the beam
                stem.stemDirection = self.stemDirection;
                note.stem = stem;
                //                VFStem* stem = [[VFStem alloc] initWithDictionary:@{
                //                    @"x_begin" : @(centerGlyphX),
                //                    @"x_end" : @(centerGlyphX),
                //                    @"y_bottom" : @(self.stemDirection == 1 ? end_y : start_y),
                //                    @"y_top" : @(self.stemDirection == 1 ? start_y : end_y),
                //                    @"y_extend" : @(y_displacement),
                //                    @"stem_extension" : @(-1),   // To avoid protruding through the beam
                //                    @"stem_direction" : @(self.stemDirection),
                //                }];
                note.stem = stem;
            }

            continue;
        }

        float slope_y =
            [self getSlopeYForX:x_px
                     first_x_px:first_x_px
                     first_y_px:first_y_px
                          slope:self.slope] + self.y_shift;

        VFStem* stem = [[VFStem alloc] init];
        stem.x_begin = x_px - (kSTEM_WIDTH / 2), stem.x_end = x_px, stem.x_end = x_px;
        stem.y_top = self.stemDirection == VFStemDirectionUp ? top_y_px : base_y_px,
        stem.y_bottom = self.stemDirection == VFStemDirectionUp ? base_y_px : top_y_px, stem.y_extend = y_displacement,
        stem.y_extend = y_displacement;
        stem.stem_extension = ABS(top_y_px - slope_y) - kSTEM_HEIGHT - 1;
        stem.stemDirection = self.stemDirection;
        //        VFStem* stem = [[VFStem alloc] initWithDictionary:@{
        //            @"x_begin" : @(x_px - (kSTEM_WIDTH / 2)),
        //            @"x_end" : @(x_px),
        //            @"y_top" : @(self.stemDirection == 1 ? top_y_px : base_y_px),
        //            @"y_bottom" : @(self.stemDirection == 1 ? base_y_px : top_y_px),
        //            @"y_extend" : @(y_displacement),
        //            @"stem_extension" : @(ABS(top_y_px - slope_y) - kSTEM_HEIGHT - 1),
        //            @"stem_direction" : @(self.stemDirection),
        //        }];
        note.stem = stem;
    }
}

/*!
 *  Get the x coordinates for the beam lines of specific `duration`
 *  @param duration <#duration description#>
 *  @return an array of BeamLine objects
 */
- (NSArray*)getBeamLines:(NSString*)duration;
{
    NSMutableArray* beam_lines = [NSMutableArray array];
    BOOL beam_started = NO;
    BeamLine* current_beam;
    float partial_beam_length = self.renderOptions.partial_beam_length;

    Partial* (^determinePartialSide)(VFStemmableNote*, VFStemmableNote*);

    determinePartialSide = ^Partial*(VFStemmableNote* prev_note, VFStemmableNote* next_note)
    {
        // Compare beam counts and store differences
        NSInteger unshared_beams = 0;
        if (next_note && prev_note) {
            unshared_beams = prev_note.beamCount - next_note.beamCount;
        }

        BOOL left_partial = [duration isNotEqualToString:@"8"] && unshared_beams > 0;
        BOOL right_partial = [duration isNotEqualToString:@"8"] && unshared_beams < 0;

        return [Partial partialWithLeft:left_partial right:right_partial];
    };

    for (NSUInteger i = 0; i < self.notes.count; ++i) {
        // TODO: should these be VFStaffNote instead?
        VFStemmableNote* note = self.notes[i];
        VFStemmableNote* prev_note = i == 0 ? nil : self.notes[i - 1];
        VFStemmableNote* next_note = i == self.notes.count - 1 ? nil : self.notes[i + 1];
        NSUInteger ticks = note.intrinsicTicks;
        Partial* partial = determinePartialSide(prev_note, next_note);
        float stem_x = note.isRest ? note.centerGlyphX : note.stemX;

        // Check whether to apply beam(s)
        if (ticks < [VFTables durationToTicks:duration]) {
            if (!beam_started) {
                BeamLine* new_line = [BeamLine lineWithStart:stem_x end:0];
                if (partial.left) {
                    new_line.end = stem_x - partial_beam_length;
                }

                [beam_lines push:new_line];
                beam_started = YES;
            }
            else {
                current_beam = beam_lines.lastObject;
                current_beam.end = stem_x;

                // Should break secondary beams on note
                BOOL should_break = [self.break_on_indices containsObject:@(1)];
                // Shorter than or eq an 8th note duration
                BOOL can_break = duration.integerValue >= 8;
                if (should_break && can_break) {
                    beam_started = NO;
                }
            }
        }
        else {
            if (!beam_started) {
                // we don't care
            }
            else {
                current_beam = beam_lines.lastObject;
                if (current_beam.end == 0) {
                    // single note
                    current_beam.end = current_beam.start + partial_beam_length;
                }
                else {
                    // we don't care
                }
            }

            beam_started = NO;
        }
    }

    if (beam_started) {
        current_beam = beam_lines.lastObject;
        if (current_beam.end == 0) {
            // single note
            current_beam.end = current_beam.start - partial_beam_length;
        }
    }

    return beam_lines;
}

#pragma mark - Rendering Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Rendering Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  Render the stems for each notes
 *
 *  @param ctx the graphics context
 */
- (void)drawStems:(CGContextRef)ctx;
{
    [self.notes foreach:^(VFStemmableNote* note, NSUInteger index, BOOL* stop) {
        if (note.stem) {
            [note.stem draw:ctx];
        }
    }];
}

//
/*!
 *  Render the beam lines
 *
 *  @param ctx the graphics context
 */
- (void)drawBeamLines:(CGContextRef)ctx;
{
    NSArray* valid_beam_durations = @[ @"4", @"8", @"16", @"32", @"64" ];

    NSString* first_note = self.notes[0];
    NSString* last_note = self.notes.lastObject; //[self.notes.count - 1];

    float first_y_px = ([((VFStaffNote*)first_note)stemExtents]).topY;
    float last_y_px = ([((VFStaffNote*)last_note)stemExtents]).topY;

    float first_x_px = ((VFStaffNote*)first_note).stemX;

    float beam_width = self.renderOptions.beam_width * ((float)self.stemDirection);

    // Draw the beams.
    for (NSUInteger i = 0; i < valid_beam_durations.count; ++i) {
        NSString* duration = valid_beam_durations[i];
        NSArray* beam_lines = [self getBeamLines:duration];

        for (uint j = 0; j < beam_lines.count; ++j) {
            BeamLine* beam_line = beam_lines[j];
            float first_x = beam_line.start - (((float)self.stemDirection) == VFStemDirectionDown ? kSTEM_WIDTH / 2 : 0);
            float first_y = [self getSlopeYForX:first_x first_x_px:first_x_px first_y_px:first_y_px slope:self.slope];

            float last_x = beam_line.end + (self.stemDirection == VFStemDirectionUp ? (kSTEM_WIDTH / 3) : (-kSTEM_WIDTH / 3));
            float last_y = [self getSlopeYForX:last_x first_x_px:first_x_px first_y_px:first_y_px slope:self.slope];

            VFLogInfo(@"first:(%f, %f), last(%f, %f)", first_x, first_y, last_x, last_y);

            if (first_x > last_x) {
                NSLog(@"hi");
            }

            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, first_x, first_y + self.y_shift);
            CGContextAddLineToPoint(ctx, first_x, first_y + beam_width + self.y_shift);
            CGContextAddLineToPoint(ctx, last_x + 1, last_y + beam_width + self.y_shift);
            CGContextAddLineToPoint(ctx, last_x + 1, last_y + self.y_shift);
            CGContextClosePath(ctx);
            CGContextFillPath(ctx);
        }

        first_y_px += beam_width * 1.5;
        last_y_px += beam_width * 1.5;
    }
}

/*!
 *  Pre-format the beam
 *
 *  @return YES if preFormatting was successful, NO otherwise
 */
- (BOOL)preFormat;
{
    // do nothing

    return YES;
}

/*!
 *   Post-format the beam. This can only be called after
 *   the notes in the beam have both `x` and `y` values. ie: they've
 *   been formatted and have staves
 *
 *  @return YES if preFormatting was successful, NO otherwise
 */
- (BOOL)postFormat;
{
    if (_postFormatted) {
        VFLogInfo(@"postFormat: Already called");
        return YES;
    }
    [self calculateSlope];
    [self applyStemExtensions];
    _postFormatted = YES;

    return YES;
}

//
/*!
 *  Render the beam to the canvas context
 *
 *  @param ctx the graphics context
 */
- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    if (self.unbeamable) {
        return;
    }
    if (!_postFormatted) {
        [self postFormat];
    }
    [self drawStems:ctx];
    [self drawBeamLines:ctx];
}

/*!
 *  calculates the direction of the stems
 *
 *  @param notes the notes used to determine the stem direction
 *
 *  @return up or down
 */
+ (VFStemDirectionType)calculateStemDirection:(NSArray*)notes;
{
    __block NSInteger lineSum = 0;
    [notes foreach:^(VFStaffNote* note, NSUInteger index, BOOL* stop) {
        if (note.keyProps) {
            [note.keyProps foreach:^(KeyProperty* keyProp, NSUInteger index, BOOL* stop) {
                lineSum += (keyProp.line - 3);
            }];
        }
    }];
    if (lineSum >= 0) {
        return VFStemDirectionDown;
    }
    else {
        return VFStemDirectionUp;
    }
}

// ## Static Methods
//
// Gets the default beam groups for a provided time signature.
// Attempts to guess if the time signature is not found in table.
// Currently this is fairly naive.
+ (NSArray*)getDefaultBeamGroupsForTimeSignatureType:(VFTimeType)timeType;
{
    NSString* ret = [VFEnum simplNameForTimeType:timeType];
    return [self getDefaultBeamGroupsForTimeSignatureName:ret];
}

+ (NSArray*)getDefaultBeamGroupsForTimeSignatureName:(NSString*)timeType;
{
    // TODO: does this belong in VFTables?
    NSDictionary* defaults = @{
        @"1/2" : @[ @"1/2" ],
        @"2/2" : @[ @"1/2" ],
        @"3/2" : @[ @"1/2" ],
        @"4/2" : @[ @"1/2" ],

        @"1/4" : @[ @"1/4" ],
        @"2/4" : @[ @"1/4" ],
        @"3/4" : @[ @"1/4" ],
        @"4/4" : @[ @"1/4" ],

        @"1/8" : @[ @"1/8" ],
        @"2/8" : @[ @"2/8" ],
        @"3/8" : @[ @"3/8" ],
        @"4/8" : @[ @"2/8" ],

        @"1/16" : @[ @"1/16" ],
        @"2/16" : @[ @"2/16" ],
        @"3/16" : @[ @"3/16" ],
        @"4/16" : @[ @"2/16" ],
    };

    NSArray* groups = defaults[timeType];

    if (!groups) {
        // If no beam groups found, naively determine
        // the beam groupings from the time signature
        NSArray* timeSplit = [timeType split:@"/"];

        NSString* beatTotalString = timeSplit[0];
        NSNumber* number = [NSNumber numberWithLongLong:beatTotalString.longLongValue];
        NSUInteger beatTotal = number.unsignedIntegerValue;
        NSString* beatValueString = timeSplit[1];
        number = [NSNumber numberWithLongLong:beatValueString.longLongValue];
        NSUInteger beatValue = number.unsignedIntegerValue;

        NSUInteger tripleMeter = beatTotal % 3 == 0;

        if (tripleMeter) {
            return @[ Rational(3, beatValue) ];
        }
        else if (beatValue > 4) {
            return @[ Rational(2, beatValue) ];
        }
        else if (beatValue <= 4) {
            return @[ Rational(1, beatValue) ];
        }
    }
    else {
        return [groups oct_map:^Rational*(NSString* group) {
            return [Rational parse:group];
        }];
    }
    return nil;
}

// A helper function to automatically build basic beams for a voice. For more
// complex auto-beaming use `Beam.generateBeams()`.
//
// Parameters:
// * `voice` - The voice to generate the beams for
// * `stem_direction` - A stem direction to apply to the entire voice
// * `groups` - An array of `Fraction` representing beat groupings for the beam
+ (NSArray*)applyAndGetBeams:(VFVoice*)voice direction:(VFStemDirectionType)stem_direction groups:(NSArray*)groups;
{
    return [self generateBeams:voice.tickables
                        config:[[BeamConfig alloc]
                                   initWithDictionary:@{ @"groups" : groups, @"stem_direction" : @(stem_direction) }]];
}

+ (NSArray*)applyAndGetBeams:(VFVoice*)voice groups:(NSArray*)groups;
{
    return [self generateBeams:voice.tickables config:[[BeamConfig alloc] initWithDictionary:@{ @"groups" : groups }]];
}

+ (NSArray*)applyAndGetBeams:(VFVoice*)voice
{
    return [self generateBeams:voice.tickables config:nil];
}

/**!
 *   A helper function to autimatically build beams for a voice with
 *    configuration options.
 *
 *    Example configuration object:
 *
 *    ```
 *    config = {
 *      groups: [new Vex.Flow.Fraction(2, 8)],
 *      stem_direction: -1,
 *      beam_rests: YES,
 *      beam_middle_only: YES,
 *      show_stemlets: NO
 *    };
 *    ```
 *    * `config` - The configuration object
 *       * `groups` - Array of `Rationals` that represent the beat structure to beam the notes
 *       * `stem_direction` - Set to apply the same direction to all notes
 *       * `beam_rests` - Set to `YES` to include rests in the beams
 *       * `beam_middle_only` - Set to `YES` to only beam rests in the middle of the beat
 *       * `show_stemlets` - Set to `YES` to draw stemlets for rests
 *       * `maintain_stem_directions` - Set to `YES` to not apply new stem directions
 *
 *  @param notes  An array of notes to create the beams for
 *  @param config The configuration object
 *
 *  @return generated beams
 */
+ (NSArray*)generateBeams:(NSArray*)notes withDictionary:(NSDictionary*)config;
{
    return [[self class] generateBeams:notes config:[[BeamConfig alloc] initWithDictionary:config]];
}

+ (NSArray*)generateBeams:(NSArray*)notes config:(BeamConfig*)config;
{
    if (!config) {
        config = [[BeamConfig alloc] initWithDictionary:nil];
    }

    if (!config.groups || config.groups.count == 0) {
        config.groups = [NSMutableArray arrayWithArray:@[ Rational(2, 8) ]];
    }

    // Convert beam groups to tick amounts
    NSMutableArray* tickGroups = [config.groups oct_map:^Rational*(Rational* group) {
        if (![group isKindOfClass:[Rational class]]) {
            VFLogError(@"InvalidBeamGroups, The beam groups must be an array of Rationals");
        }
        return [[group clone] multiply:Rational(kRESOLUTION, 1)];
    }];

    NSArray* unprocessedNotes = notes;
    __block NSUInteger currentTickGroup = 0;
    __block NSMutableArray* noteGroups = [NSMutableArray array];
    __block NSMutableArray* currentGroup = [NSMutableArray array];

    // forward declarations of all blocks used in this method
    Rational* (^getTotalTicks)(NSArray*);
    void (^nextTickGroup)();
    void (^createGroups)();
    NSArray* (^getBeamGroups)(); // get groups able to have beams added
    void (^sanitizeGroups)(); // Splits up groups by Rest
    void (^formatStems)();
    __block VFStemmableNote* (^findFirstNote)(NSArray*);
    __block void (^applyStemDirection)(NSArray*, VFStemDirectionType);
    NSArray* (^getTupletGroups)();

    getTotalTicks = ^Rational*(NSArray* notes)
    {
        //        return [vf_notes reduce:^Rational*(Rational* memo, VFStemmableNote* note) {
        //          return [[note.ticks clone] add:memo];
        //        }];
        Rational* ret = RationalZero();
        for (VFStemmableNote* note in notes) {
            [ret add:note.ticks];
        }
        return ret;
    };

    nextTickGroup = ^() {
        if (tickGroups.count - 1 > currentTickGroup) {
            currentTickGroup += 1;
        }
        else {
            currentTickGroup = 0;
        }
    };

    createGroups = ^() {
        //      NSMutableArray* nextGroup = [NSMutableArray array];
        [unprocessedNotes foreach:^(VFStemmableNote* unprocessedNote, NSUInteger index, BOOL* stop) {
            NSMutableArray* nextGroup = [NSMutableArray array];
            if (unprocessedNote.shouldIgnoreTicks) {
                [noteGroups push:currentGroup];
                currentGroup = nextGroup;
                return; // Ignore untickables (like bar notes)
            }

            [currentGroup push:unprocessedNote];
            Rational* ticksPerGroup = [tickGroups[currentTickGroup] clone];
            Rational* totalTicks = getTotalTicks(currentGroup);

            // Double the amount of ticks in a group, if it's an unbeamable tuplet
            BOOL unbeamable = [VFTables durationToNumber:unprocessedNote.durationString].unsignedIntegerValue < 8;
            if (unbeamable && unprocessedNote.tuplet) {
                [ticksPerGroup mult:2];
            }

            // If the note that was just added overflows the group tick total
            if ([totalTicks gt:ticksPerGroup]) {
                // If the overflow note can be beamed, start the next group
                // with it. Unbeamable notes leave the group overflowed.
                if (!unbeamable) {
                    [nextGroup push:[currentGroup pop]];
                }
                [noteGroups push:currentGroup];
                currentGroup = nextGroup;
                nextTickGroup();
            }
            else if ([totalTicks equalsRational:ticksPerGroup]) {
                [noteGroups push:currentGroup];
                currentGroup = nextGroup;
                nextTickGroup();
            }
        }];

        // Adds any remainder notes
        if (currentGroup.count > 0) {
            [noteGroups push:currentGroup];
        }
    };

    getBeamGroups = ^NSArray*()
    {
        return [noteGroups filter:^BOOL(NSArray* group) {
            if (group.count > 1) {
                __block BOOL beamable = YES;
                [group foreach:^(VFTickable* note, NSUInteger index, BOOL* stop) {
                    if (note.intrinsicTicks >= [VFTables durationToTicks:@"4"]) {
                        beamable = NO;
                    }
                }];
                return beamable;
            }
            return NO;
        }];
    };

    // Splits up groups by Rest
    sanitizeGroups = ^() {
        NSMutableArray* sanitizedGroups = [NSMutableArray array];
        [noteGroups foreach:^(NSArray* group, NSUInteger index, BOOL* stop) {
            __block NSMutableArray* tempGroup = [NSMutableArray array];
            [group foreach:^(VFStemmableNote* note, NSUInteger index, BOOL* stop) {
                BOOL isFirstOrLast = index == 0 || index == group.count - 1;
                VFStemmableNote* prevNote = index > 0 ? group[index - 1] : nil;

                BOOL breaksOnEachRest = !config.beamRests && note.isRest;
                BOOL breaksOnFirstOrLastRest = (config.beamRests && config.beamMiddleOnly && note.isRest && isFirstOrLast);

                BOOL breakOnStemChange = NO;
                if (config.maintainStemDirections && prevNote && !note.isRest && !prevNote.isRest) {
                    VFStemDirectionType prevDirection = prevNote.stemDirection;
                    VFStemDirectionType currentDirection = note.stemDirection;
                    breakOnStemChange = currentDirection != prevDirection;
                }

                BOOL isUnbeamableDuration = [note.durationString integerValue] < 8;

                // Determine if the group should be broken at this note
                BOOL shouldBreak = breaksOnEachRest || breaksOnFirstOrLastRest || breakOnStemChange || isUnbeamableDuration;

                if (shouldBreak) {
                    // Add current group
                    if (tempGroup.count > 0) {
                        [sanitizedGroups push:tempGroup];
                    }

                    // Start a new group. Include the current note if the group
                    // was broken up by stem direction, as that note needs to start
                    // the next group of notes
                    tempGroup = [(breakOnStemChange ? @[ note ] : @[])mutableCopy];
                }
                else {
                    // Add note to group
                    [tempGroup push:note];
                }
            }];
            // If there is a remaining group, add it as well
            if (tempGroup.count > 0) {
                [sanitizedGroups push:tempGroup];
            }
        }];
        noteGroups = sanitizedGroups;
    };

    formatStems = ^() {
        [noteGroups foreach:^(NSArray* group, NSUInteger index, BOOL* stop) {
            //      for(NSArray* group in noteGroups)
            //      {
            VFStemDirectionType stemDirection;
            if (config.maintainStemDirections) {
                VFStemmableNote* note = findFirstNote(group);
                stemDirection = note ? note.stemDirection : VFStemDirectionUp;
            }
            else {
                if (config.stemDirection) {
                    stemDirection = config.stemDirection;
                }
                else {
                    stemDirection = [VFBeam calculateStemDirection:group];
                }
            }
            applyStemDirection(group, stemDirection);
            //      }
        }];
    };

    findFirstNote = ^VFStemmableNote*(NSArray* group)
    { // group of notes
        for (VFStemmableNote* note in group) {
            if (!note.isRest) {
                return note;
            }
        }
        return nil;
    };

    applyStemDirection = ^(NSArray* group, VFStemDirectionType direction) {
        [group foreach:^(VFStemmableNote* note, NSUInteger index, BOOL* stop) {
            note.stemDirection = direction;
        }];
    };

    getTupletGroups = ^NSArray*()
    {
        return [noteGroups filter:^BOOL(NSArray* group) { // group of notes
            if (group.firstObject) {
                if (((VFStemmableNote*)group.firstObject)
                        .tuplet) // TODO: this might break if tuplet is dynamicall allocated
                {
                    return YES;
                }
            }
            return NO;
        }];
    };

    // Using closures to store the variables throughout the various functions
    // IMO Keeps it this process lot cleaner - but not super consistent with
    // the rest of the API's style - Silverwolf90 (Cyril)
    createGroups();
    sanitizeGroups();
    formatStems();

    // Get the notes to be beamed
    NSArray* beamedNoteGroups = getBeamGroups();

    // Get the tuplets in order to format them accurately
    NSArray* tupletGroups = getTupletGroups();

    __block NSMutableArray* beams = [NSMutableArray array];
    [beamedNoteGroups foreach:^(NSArray* group, NSUInteger index, BOOL* stop) { // group of notes
        VFBeam* beam = [[VFBeam alloc] initWithNotes:group];
        BOOL show_stemlets = config.showStemlets;
        if (show_stemlets) {
            beam.renderOptions.show_stemlets = YES;
        }
        [beams push:beam];
    }];

    // Reformat tuplets
    [tupletGroups foreach:^(NSArray* group, NSUInteger index, BOOL* stop) {
        __block VFStemmableNote* firstNote = group.firstObject;
        [group foreach:^(VFStemmableNote* note, NSUInteger index, BOOL* stop) {
            if (note.hasStem) {
                firstNote = note;
                *stop = YES;
            }
        }];

        VFTuplet* tuplet = firstNote.tuplet;

        if (firstNote.beam) {
            tuplet.bracketed = NO;
        }
        if (firstNote.stemDirection == VFStemDirectionDown) {
            tuplet.tupletLocation = VFTupletLocationBottom;
        }
    }];

    return beams;
}

@end
