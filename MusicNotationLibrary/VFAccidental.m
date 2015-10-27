//
//  VFAccidental.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFAccidental.h"
#import "VFVex.h"
#import "VFNote.h"
#import "VFStaffNote.h"
#import "VFStaff.h"
#import "VFTables.h"
#import "NSMutableArray+JSAdditions.h"
#import "VFKeyProperty.h"
#import "OCTotallyLazy.h"
#import "VFGlyph.h"
#import "VFVoice.h"
#import "VFMusic.h"
#import "NSString+Ruby.h"

@implementation AccidentalRenderOptions
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        //        [self setupRenderOptions];
        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}
- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    [propertiesEntriesMapping
        addEntriesFromDictionaryWithoutReplacing:@{@"font_scale" : @"fontScale", @"stroke_px" : @"strokePoints"}];
    return propertiesEntriesMapping;
}

@end

//======================================================================================================================

@interface AccListStruct : IAModelBase
@property (assign, nonatomic) float y;
@property (assign, nonatomic) NSInteger line;      // line: acc_line,
@property (assign, nonatomic) float shift;         // shift: shiftL,
@property (strong, nonatomic) VFAccidental* acc;   // acc: acc,
@property (assign, nonatomic) float lineSpace;     // lineSpace: line_space
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

@implementation AccListStruct
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
    }
    return self;
}
@end

//======================================================================================================================

@interface LineListStruct : IAModelBase
@property (assign, nonatomic) NSInteger line;             //@"line" : acc[@"line"],
@property (assign, nonatomic) NSInteger flat_line;        //@"flat_line" : @YES,
@property (assign, nonatomic) NSInteger dbl_sharp_line;   //@"dbl_sharp_line" : @YES,
@property (assign, nonatomic) NSInteger num_acc;          //@"num_acc" : @0,
@property (assign, nonatomic) float width;                //@"width" : @0
@property (assign, nonatomic) NSInteger column;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

@implementation LineListStruct
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
    }
    return self;
}
@end

//======================================================================================================================

@implementation VFAccidental

/*!
 *  <#Description#>
 *  @param optionsDict dictionary of options
 *  @return an accidental object
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        //        if (!_type) {
        //            _type = nil;
        //        }

        // The `index` points to a specific note in a chord.
        self.index = -999;
        //        self.type = type;
        self.position = VFPositionLeft;

        self->_renderOptions = [[AccidentalRenderOptions alloc] initWithDictionary:@{
            // Font size for glyphs
            @"font_scale" : @38,
            // Length of stroke across heads above or below the staff.
            @"stroke_px" : @3
        }];

        self.accidental = VFTables.accidentalCodes[self.type];
        if(!self.accidental)
        {
            VFLogError(@"ArgumentError, Unknown accidental type: %@", self.type);
        }

        // Cautionary accidentals have parentheses around them
        [self setAsCautionary:NO];
        self.paren_left = nil;
        self.paren_right = nil;

        // Initial width is set from table.
        [self setWidth:[self.accidental[@"width"] floatValue]];

        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
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

/*!
 *  gets an accidental for attaching to a note
 *  @param type the type of accidental specified by one of the following:
 *              # ## b n { } db d bb ++ +
 *  @return an accidental object
 */
+ (VFAccidental*)accidentalWithType:(NSString*)type
{
    return [[VFAccidental alloc] initWithStringType:type];
}

- (instancetype)initWithStringType:(NSString*)type
{
    self = [self initWithDictionary:@{ @"type" : type }];
    if(self)
    {
        NSDictionary* codes = VFTables.accidentalCodes[self.type];
        self.accidental = codes;   // <-- TODO: this is kindof a mess
        [self setValuesForKeyPathsWithDictionary:codes];
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    [propertiesEntriesMapping
        addEntriesFromDictionaryWithoutReplacing:
            @{@"shift_right" : @"shiftRight", @"shift_down" : @"shiftDown", @"gracenote_width" : @"gracenoteWidth"}];
    return propertiesEntriesMapping;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

//- (AccidentalOptions *)renderOptions {
//    if (!renderOptions) {
//        renderOptions = [[AccidentalOptions alloc]init];
//    }
//    return renderOptions;
//}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"accidentals";
}

/*!
 *  sets the note for this accidental
 *  @param note parent note of accidental
 */
- (void)setNote:(VFStaffNote*)note;
{
    if(!note)
    {
        VFLogError(@"ArgumentError, Bad note value: %@", note.description);
    }
    _note = note;
    // Accidentals attached to grace notes are rendered smaller.
    if([((VFNote*)self.note).category isEqualToString:@"gracenotes"])
    {
        ((AccidentalRenderOptions*)self->_renderOptions).fontScale = 25;
        [self setWidth:[self.accidental[@"gracenote_width"] unsignedIntegerValue]];
    }
}

/*!
 *  If called, draws parenthesis around accidental.
 *  @return this object
 */
- (id)setAsCautionary
{
    return [self setAsCautionary:YES];
}
- (id)setAsCautionary:(BOOL)cautionary
{
    _cautionary = cautionary;
    ((AccidentalRenderOptions*)self->_renderOptions).fontScale = 28;
    self.paren_left = (NSDictionary*)VFTables.accidentalCodes[@"{"];
    self.paren_right = (NSDictionary*)VFTables.accidentalCodes[@"}"];

    float width_adjust = ([self.type isEqualToString:@"##"] || [self.type isEqualToString:@"bb"]) ? 6 : 4;

    // Make sure `width` accomodates for parentheses.
    [self
        setWidth:([self.paren_left[@"width"] unsignedIntegerValue] + [self.accidental[@"width"] unsignedIntegerValue] +
                  [self.paren_right[@"width"] integerValue] - width_adjust)];

    return self;
}

#pragma mark - Static Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Static Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  Arrange accidentals inside a ModifierContext.
 *  @param modifiers collection of accidentals
 *  @param state     state of the accidentals
 *  @param context   the modifier context container
 *  @return YES if succussful
 */
+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* accidentals = modifiers;
    float left_shift = state.left_shift;
    NSUInteger accidental_spacing = 2;

    // If there are no accidentals, we needn't format their positions
    if(!accidentals || accidentals.count == 0)
    {
        return NO;
    }

    NSMutableArray* acc_list = [NSMutableArray array];   // array of AccListStruct
    BOOL hasStaff = NO;
    VFStaffNote* prev_note = nil;
    float shiftL = 0;

    // First determine the accidentals' Y positions from the note.keys
    VFAccidental* acc;
    KeyProperty* props_tmp;
    for(NSUInteger i = 0; i < accidentals.count; ++i)
    {
        acc = accidentals[i];
        VFStaffNote* note = acc.note;
        VFStaff* staff = note.staff;
        KeyProperty* props = note.keyProps[acc.index];
        if(note != prev_note)
        {
            // Iterate through all notes to get the displaced pixels
            for(NSUInteger n = 0; n < note.keyStrings.count; ++n)
            {
                props_tmp = note.keyProps[n];
                shiftL = (props_tmp.displaced ? note.extraLeftPx : shiftL);
            }
            prev_note = note;
        }
        if(staff)
        {
            hasStaff = YES;
            float line_space = staff.spacingBetweenLines;   //.options.spacing_between_lines_px; // TODO: fix this
            NSUInteger y = [staff getYForLine:props.line];
            float acc_line = roundf(((float)y) / line_space * 2) / 2;
            [acc_list push:[[AccListStruct alloc] initWithDictionary:@{
                          @"y" : @(y),
                          @"line" : @(acc_line),
                          @"shift" : @(shiftL),
                          @"acc" : acc,
                          @"lineSpace" : @(line_space)
                      }]];
        }
        else
        {
            [acc_list push:[[AccListStruct alloc]
                               initWithDictionary:@{@"line" : @(props.line), @"shift" : @(shiftL), @"acc" : acc}]];
        }
    }

    // Sort accidentals by line number.
    [acc_list sortUsingComparator:^NSComparisonResult(AccListStruct* obj1, AccListStruct* obj2) {
      NSUInteger a = obj1.line;
      NSUInteger b = obj2.line;
      if(a < b)
      {
          return NSOrderedAscending;
      }
      else if(a > b)
      {
          return NSOrderedDescending;
      }
      else
      {
          return NSOrderedSame;
      }
    }];

    // Create an array of unique line numbers (line_list) from acc_list
    NSMutableArray* line_list = [NSMutableArray array];   // an array of LineListStruct
    float acc_shift = 0;   // amount by which all accidentals must be shifted right or left for stem flipping, notehead
    // shifting concerns.
    NSInteger previous_line = -999;

    for(NSUInteger i = 0; i < acc_list.count; i++)
    {
        AccListStruct* acc = acc_list[i];

        // if this is the first line, or a new line, add a line_list
        if((previous_line == -999) || (previous_line != acc.line))
        {
            [line_list push:[[LineListStruct alloc] initWithDictionary:@{
                           @"line" : @(acc.line),
                           @"flat_line" : @YES,
                           @"dbl_sharp_line" : @YES,
                           @"num_acc" : @0,
                           @"width" : @0
                       }]];
        }
        // if this accidental is not a flat, the accidental needs 3.0 lines lower
        // clearance instead of 2.5 lines for b or bb.
        if(([acc.acc.type isNotEqualToString:@"b"]) && ([acc.acc.type isNotEqualToString:@"bb"]))
        {
            ((VFAccidental*)line_list[line_list.count - 1]).flat_line = NO;
        }
        // if this accidental is not a double sharp, the accidental needs 3.0 lines above
        if([acc.acc.type isNotEqualToString:@"##"])
        {
            ((VFAccidental*)line_list[line_list.count - 1]).dbl_sharp_line = NO;
        }

        // Track how many accidentals are on this line:
        ((LineListStruct*)line_list[line_list.count - 1]).num_acc++;

        // Track the total x_offset needed for this line which will be needed
        // for formatting lines w/ multiple accidentals:

        // width = accidental width + universal spacing between accidentals
        ((LineListStruct*)line_list[line_list.count - 1]).width += acc.acc.width + accidental_spacing;

        // if this acc_shift is larger, use it to keep first column accidentals in the same line
        acc_shift = ((acc.shift > acc_shift) ? acc.shift : acc_shift);

        previous_line = acc.line;
    }

    // Helper function to determine whether two lines of accidentals collide vertically
    BOOL (^checkCollision)(LineListStruct*, LineListStruct*) = ^(LineListStruct* line_1, LineListStruct* line_2) {
      float clearance = line_2.line - line_1.line;
      float clearance_required = 3;
      // But less clearance is required for certain accidentals: b, bb and ##.
      if(clearance > 0)
      {   // then line 2 is on top
          clearance_required = (line_2.flat_line || line_2.dbl_sharp_line) ? 2.5 : 3.0;
          if(line_1.dbl_sharp_line)
              clearance -= 0.5;
      }
      else
      {   // line 1 is on top
          clearance_required = (line_1.flat_line || line_1.dbl_sharp_line) ? 2.5 : 3.0;
          if(line_2.dbl_sharp_line)
              clearance -= 0.5;
      }
      BOOL colission = (ABS(clearance) < clearance_required);
      VFLogDebug(@"Line_1: %tu Line_2: %tu Collision: %@", line_1.line, line_2.line, TF(colission));
      return (colission);
    };

    // ### Place Accidentals in Columns
    //
    // Default to a classic triangular layout (middle accidental farthest left),
    // but follow exceptions as outlined in G. Read's _Music Notation_ and
    // Elaine Gould's _Behind Bars_.
    //
    // Additionally, this implements different vertical collision rules for
    // flats (only need 2.5 lines clearance below) and double sharps (only
    // need 2.5 lines of clearance above or below).
    //
    // Classic layouts and exception patterns are found in the 'VFTables.m'
    // in 'VFTables.accidentalColumnsTable'
    //
    // Beyond 6 vertical accidentals, default to the parallel ascending lines approach,
    // using as few columns as possible for the verticle structure.
    //
    // TODO (?): Allow column to be specified for an accidental at run-time?

    NSUInteger total_columns = 0;

    // establish the boundaries for a group of notes with clashing accidentals:
    for(NSUInteger i = 0; i < line_list.count; i++)
    {
        BOOL no_further_conflicts = NO;
        NSUInteger group_start = i;
        NSUInteger group_end = i;

    group_check_while:
        while((group_end + 1 < line_list.count) && (!no_further_conflicts))
        {
            // if this note conflicts with the next:
            if(checkCollision(line_list[group_end], line_list[group_end + 1]))
            {
                // include the next note in the group:
                group_end++;
            }
            else
                no_further_conflicts = YES;
        }

        // Set columns for the lines in this group:
        NSUInteger group_length = group_end - group_start + 1;

        // Set the accidental column for each line of the group
        NSString* end_case = checkCollision(line_list[group_start], line_list[group_end]) ? @"a" : @"b";

        //        var checkCollision = self.checkCollision;
        switch(group_length)
        {
            case 3:
                if(([end_case isEqualToString:@"a"]) && (((LineListStruct*)line_list[group_start + 1]).line -
                                                             ((LineListStruct*)line_list[group_start + 2]).line ==
                                                         0.5) &&
                   (((LineListStruct*)line_list[group_start]).line -
                        ((LineListStruct*)line_list[group_start + 1]).line !=
                    0.5))
                    end_case = @"second_on_bottom";
                break;
            case 4:
                if((!checkCollision(((LineListStruct*)line_list[group_start]),
                                    ((LineListStruct*)line_list[group_start + 2]))) &&
                   (!checkCollision(((LineListStruct*)line_list[group_start + 1]),
                                    ((LineListStruct*)line_list[group_start + 3]))))
                    end_case = @"spaced_out_tetrachord";
                break;
            case 5:
                if(([end_case isEqualToString:@"b"]) &&
                   (!checkCollision(((LineListStruct*)line_list[group_start + 1]),
                                    ((LineListStruct*)line_list[group_start + 3]))))
                    end_case = @"spaced_out_pentachord";
                if(([end_case isEqualToString:@"spaced_out_pentachord"]) &&
                   (!checkCollision(((LineListStruct*)line_list[group_start]),
                                    ((LineListStruct*)line_list[group_start + 2]))) &&
                   (!checkCollision(((LineListStruct*)line_list[group_start + 2]),
                                    ((LineListStruct*)line_list[group_start + 4]))))
                    end_case = @"very_spaced_out_pentachord";
                break;
            case 6:
                if((!checkCollision(((LineListStruct*)line_list[group_start]),
                                    ((LineListStruct*)line_list[group_start + 3]))) &&
                   (!checkCollision(((LineListStruct*)line_list[group_start + 1]),
                                    ((LineListStruct*)line_list[group_start + 4]))) &&
                   (!checkCollision(((LineListStruct*)line_list[group_start + 2]),
                                    ((LineListStruct*)line_list[group_start + 5]))))
                    end_case = @"spaced_out_hexachord";
                if((!checkCollision(((LineListStruct*)line_list[group_start]),
                                    ((LineListStruct*)line_list[group_start + 2]))) &&
                   (!checkCollision(((LineListStruct*)line_list[group_start + 2]),
                                    ((LineListStruct*)line_list[group_start + 4]))) &&
                   (!checkCollision(((LineListStruct*)line_list[group_start + 1]),
                                    ((LineListStruct*)line_list[group_start + 3]))) &&
                   (!checkCollision(((LineListStruct*)line_list[group_start + 3]),
                                    ((LineListStruct*)line_list[group_start + 5]))))
                    end_case = @"very_spaced_out_hexachord";
                break;
        }

        NSUInteger group_member;
        NSUInteger column;
        // If the group contains more than seven members, use ascending parallel lines
        // of accidentals, using as few columns as possible while avoiding collisions.
        if(group_length >= 7)
        {
            // First, determine how many columns to use:
            NSUInteger pattern_length = 2;
            BOOL colission_detected = YES;
            /*while(colission_detected === true) {
                colission_detected = false;
                colission_detecter : for(var line = 0; line + pattern_length < line_list.length; line++) {
                    if(this.checkCollision(line_list[line], line_list[line+pattern_length])) {
                        colission_detected = true;
                        pattern_length++;
                        break colission_detecter;
                    }
                }
            }*/

            while(colission_detected == YES)
            {
                colission_detected = NO;
                // TODO: check/test the following 6 lines
                //                    colission_detecter :
                for(NSUInteger line = 0; line + pattern_length < line_list.count; ++line)
                {
                    if(checkCollision(((LineListStruct*)line_list[line]),
                                      ((LineListStruct*)line_list[line + pattern_length])))
                    {
                        colission_detected = YES;
                        pattern_length++;
                        //                            break colission_detecter;
                        break;
                    }
                }
            }
            // Then, assign a column to each line of accidentals
            for(NSUInteger group_member = i; group_member <= group_end; group_member++)
            {
                column = ((group_member - i) % pattern_length) + 1;
                ((LineListStruct*)line_list[group_member]).column = column;
                total_columns = (total_columns > column) ? total_columns : column;
            }

            // Otherwise, if the group contains fewer than seven members, use the layouts from
            // the accidentalsColumnsTable housed in tables.js.
        }
        else
        {
            for(group_member = i; group_member <= group_end; ++group_member)
            {
                NSDictionary* table = VFTables.accidentalColumnsTable;
                NSString* gl = [NSString stringWithFormat:@"%tu", group_length];
                column = [((((NSDictionary*)table[gl])[end_case])[group_member - i])unsignedIntegerValue];
                ((LineListStruct*)line_list[group_member]).column = column;
                total_columns = (total_columns > column) ? total_columns : column;
            }
        }

        // Increment i to the last note that was set, so that if a lower set of notes
        // does not conflict at all with this group, it can have its own classic shape.
        i = group_end;
    }

    // ### Convert Columns to x_offsets
    //
    // This keeps columns aligned, even if they have different accidentals within them
    // which sometimes results in a larger x_offset than is an accidental might need
    // to preserve the symmetry of the accidental shape.
    //
    // Neither A.C. Vinci nor G. Read address this, and it typically only happens in
    // music with complex chord clusters.
    //
    // TODO (?): Optionally allow closer compression of accidentals, instead of forcing
    // parallel columns.

    // track each column's max width, which will be used as initial shift of later columns:
    NSMutableArray* column_widths = [NSMutableArray arrayWithCapacity:total_columns];
    NSMutableArray* column_x_offsets = [NSMutableArray arrayWithCapacity:total_columns];
    for(NSUInteger i = 0; i <= total_columns; ++i)
    {
        column_widths[i] = @(0);
        column_x_offsets[i] = @(0);
    }

    column_widths[0] = @(acc_shift + left_shift);
    column_x_offsets[0] = @(acc_shift + left_shift);

    // Fill column_widths with widest needed x-space;
    // this is what keeps the columns parallel.
    [line_list foreach:^(LineListStruct* line, NSUInteger index, BOOL* stop) {
      if(((LineListStruct*)line).width > [column_widths[((LineListStruct*)line).column] unsignedIntegerValue])
      {
          column_widths[((LineListStruct*)line).column] = @(((LineListStruct*)line).width);
      };
    }];

    for(NSUInteger i = 1; i < column_widths.count; i++)
    {
        // this column's offset = this column's width + previous column's offset
        column_x_offsets[i] =
            @([column_widths[i] unsignedIntegerValue] + [column_x_offsets[i - 1] unsignedIntegerValue]);
    }

    // Set the x_shift for each accidental according to column offsets:
    __block NSUInteger acc_count = 0;
    [line_list foreach:^(LineListStruct* line, NSUInteger index, BOOL* stop) {
      float line_width = 0;
      float last_acc_on_line = acc_count + line.num_acc;
      // handle all of the accidentals on a given line:
      for(acc_count; acc_count < last_acc_on_line; ++acc_count)
      {
          float x_shift = ([column_x_offsets[line.column - 1] floatValue] + line_width);
          [((AccListStruct*)acc_list[acc_count]).acc setX_shift:x_shift];
          // keep track of the width of accidentals we've added so far, so that when
          // we loop, we add space for them.
          line_width += ((AccListStruct*)acc_list[acc_count]).acc.width + accidental_spacing;
          VFLogDebug(@"Line: %tu, acc_count: %tu, shift: %f", line.line, acc_count, x_shift);
      }
    }];

    // update the overall layout with the full width of the accidental shapes:
    state.left_shift += [column_x_offsets[column_x_offsets.count - 1] floatValue];

    return YES;
}

/*!
 *  Use this method to automatically apply accidentals to a set of `voices`.
 *  The accidentals will be remembered between all the voices provided.
 *  Optionally, you can also provide an initial `keySignature`.
 *  @param voices       a collection of voices
 *  @param keySignature the key signature
 */
+ (void)applyAccidentals:(NSArray*)voices withKeySignature:(NSString*)keySignature;
{
    NSMutableArray* tickPositions = [NSMutableArray array];
    NSMutableDictionary* tickNoteMap = [NSMutableDictionary dictionary];

    // Sort the tickables in each voice by their tick position in the voice
    [voices foreach:^(VFVoice* voice, NSUInteger index, BOOL* stop) {
      Rational* tickPosition = Rational(0, 1);
      NSArray* notes = voice.tickables;
      [notes foreach:^(VFStaffNote* note, NSUInteger index2, BOOL* stop2) {
        NSMutableArray* notesAtPosition = tickNoteMap[tickPosition.numberValue];

        if(!notesAtPosition)
        {
            [tickPositions push:tickPosition.numberValue];
//            tickNoteMap[tickPosition.numberValue] = [NSMutableArray arrayWithObject:note];
            [tickNoteMap setObject:[NSMutableArray arrayWithObject:note] forKey:tickPosition.numberValue];
        }
        else
        {
            [notesAtPosition push:note];
        }

        [tickPosition add:note.ticks];
      }];
    }];

    // Default key signature is C major
    if(!keySignature)
    {
        keySignature = @"C";
    }

    // Get the scale map, which represents the current state of each pitch
    NSMutableDictionary* scaleMap = [VFMusic createScaleMap:keySignature];

    [tickPositions foreach:^(Rational* tick, NSUInteger index, BOOL* stop) {
      NSMutableArray* notes = tickNoteMap[tick];
      // Array to store all pitches that modified accidental states
      // at this tick position
      NSMutableArray* modifiedPitches = [NSMutableArray array];

      [notes foreach:^(VFStaffNote* note, NSUInteger index, BOOL* stop) {
        if(note.isRest)
        {
            return;
        }

        // Go through each key and determine if an accidental should be
        // applied
        __block NSInteger i = -1;
        [note.keyStrings foreach:^(NSString* keyString, NSUInteger keyIndex, BOOL* stop) {
          ++i;
          RootAccidentalTypeStruct* key = [VFMusic getNoteParts:([keyString split:@"/"])[0]];

          // Force a natural for every key without an accidental
          NSString* accidentalString = key.accidental != nil ? key.accidental : @"n";
//            NSString* accidentalString = @"";
//            if (!key.accidental) {
//                accidentalString = @"n";
//            }
          NSString* pitch = [NSString stringWithFormat:@"%@%@", key.root, accidentalString];

          // Determine if the current pitch has the same accidental
          // as the scale state
          BOOL sameAccidental = [scaleMap[key.root] isEqualToString:pitch];

          // Determine if an identical pitch in the chord already
          // modified the accidental state
          BOOL previouslyModified = [modifiedPitches containsObject:pitch];

          // Add the accidental to the staffNote
          if(!sameAccidental || (sameAccidental && previouslyModified))
          {
              // Modify the scale map so that the root pitch has an
              // updated state
              scaleMap[key.root] = pitch;

              // Create the accidental
              VFAccidental* accidental = [[VFAccidental alloc] initWithStringType:accidentalString];

              // Attach the accidental to the staffNote
              [note addAccidental:accidental atIndex:keyIndex];

              // Add the pitch to list of pitches that modified accidentals
              [modifiedPitches push:pitch];
          }
        }];
      }];
    }];
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  Render accidental onto canvas.
 *  @param ctx graphics context
 */
- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    if(!(self.note && (self.index >= 0)))
    {
        VFLogError(@"NoAttachedNote, Can't draw accidental without a note and index.");
    }

    // Figure out the start `x` and `y` coordinates for this note and index.
    VFPoint* start = [self.note getModifierstartXYforPosition:self.position andIndex:self.index];
    float acc_x = (start.x + self.x_shift) - self.width;
    float acc_y = start.y + self.y_shift;
    VFLogDebug(@"%@", [NSString stringWithFormat:@"Rendering: %@, %f, %f", self.type, acc_x, acc_y]);

    AccidentalRenderOptions* renderOptions = ((AccidentalRenderOptions*)self->_renderOptions);

    if(!_cautionary)
    {
        // Render the accidental alone.
        [VFGlyph renderGlyph:ctx
                         atX:acc_x
                         atY:acc_y
                   withScale:1   // renderOptions.fontScale
                forGlyphCode:self.accidental[@"code"]];
    }
    else
    {
        // Render the accidental in parentheses.
        acc_x += 3;
        [VFGlyph renderGlyph:ctx
                         atX:acc_x
                         atY:acc_y
                   withScale:1   // renderOptions.fontScale
                forGlyphCode:self.paren_left[@"code"]];
        acc_x += 2;
        [VFGlyph renderGlyph:ctx
                         atX:acc_x
                         atY:acc_y
                   withScale:1   // renderOptions.fontScale
                forGlyphCode:self.accidental[@"code"]];
        acc_x += [self.accidental[@"width"] unsignedIntegerValue] - 2;
        if([self.type isEqualToString:@"##"] || [self.type isEqualToString:@"bb"])
        {
            acc_x -= 2;
        }
        [VFGlyph renderGlyph:ctx
                         atX:acc_x
                         atY:acc_y
                   withScale:1   // renderOptions.fontScale
                forGlyphCode:self.paren_right[@"code"]];
    }
}

- (CGMutablePathRef)pathConvertPoint:(CGPoint)convertPoint
{
//    convertPoint = CGCombinePoints(self.point.CGPoint, convertPoint);
    CGMutablePathRef path = [super pathConvertPoint:convertPoint];

    VFPoint* start = [self.note getModifierstartXYforPosition:self.position andIndex:self.index];
    float acc_x = (start.x + self.x_shift) - self.width;
    float acc_y = start.y + self.y_shift;
    
    acc_x -= convertPoint.x;
    acc_y -= convertPoint.y;
    
    acc_x = -self.width;
    
    CGPathRef subPath = [VFGlyph createPathwithCode:self.accidental[@"code"] withScale:1 atPoint:CGPointMake(acc_x, acc_y)];
//    CGAffineTransform t = CGAffineTransformMakeTranslation(-convertPoint.x, 0);
//    subPath = CGPathCreateCopyByTransformingPath(subPath, &t);
    
    CGPathAddPath(path, NULL, subPath);
 
    return path;
}

@end
