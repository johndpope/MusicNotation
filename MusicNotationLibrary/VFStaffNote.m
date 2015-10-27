//
//  VFStaffNote.m
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

#import "VFStaffNote.h"
#import "VFVex.h"
#import "VFUtils.h"

#import "VFGlyph.h"
#import "VFBeam.h"
#import "VFClef.h"
#import "VFNote.h"
#import "VFMetrics.h"
#import "VFPadding.h"

#import "VFStaff.h"
#import "VFNote.h"
#import "VFAccidental.h"
#import "VFArticulation.h"
#import "VFAnnotation.h"
#import "VFModifier.h"
#import "VFOptions.h"
#import "VFTables.h"
#import "VFKeyProperty.h"
#import "VFStaff.h"
#import "VFEnum.h"
#import "VFModifierContext.h"
#import "VFBoundingBox.h"
#import "VFModifier.h"
#import "VFNote.h"
#import "VFBoundingBox.h"
#import "VFKeyProperty.h"
#import "VFDot.h"
#import "VFSymbol.h"
#import "VFNote.h"
#import "VFTickable.h"
#import "VFDelegates.h"
#import "NSString+Ruby.h"
#import "OCTotallyLazy.h"
#import "VFExtentStruct.h"
#import "VFStem.h"
#import "VFTuplet.h"
#import "NSMutableArray+JSAdditions.h"
#import "VFNoteHead.h"
#import "IAModelBase.h"
#import "VFTablesNoteData.h"
#import "VFTickContext.h"
#import "VFShapeLayer.h"

@interface FormatNote : IAModelBase
@property (assign, nonatomic) float line;       // note/rest base line
@property (assign, nonatomic) float max_line;   // note/rest upper bounds line
@property (assign, nonatomic) float min_line;   // note/rest lower bounds line
@property (assign, nonatomic) BOOL isRest;
@property (assign, nonatomic) VFStemDirectionType stem_dir;
@property (assign, nonatomic) float stem_max;   // Maximum (default) note stem length;
@property (assign, nonatomic) float stem_min;   // minimum note stem length
@property (assign, nonatomic) float voice_shift;
@property (assign, nonatomic) BOOL displaced;   // note manually displaced
@property (strong, nonatomic) VFStaffNote* note;
@end

@implementation FormatNote
@end

@implementation StaffNoteRenderOptions
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

@implementation NoteHeadBounds
@end

//======================================================================================================================
#pragma mark - VFStaffNote Implementation
/**---------------------------------------------------------------------------------------------------------------------
 * @name VFStaffNote Implementation
 * ---------------------------------------------------------------------------------------------------------------------
 */

@interface VFStaffNote ()
{
    CGRect _layerBounds;
}

@property (assign, nonatomic) CGRect layerBounds;

@end

@implementation VFStaffNote

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setupStaffNoteWithOptions:optionsDict];

        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration;
{
    NSDictionary* options = @{@"keys" : keys, @"duration" : duration};
    return [[VFStaffNote alloc] initWithDictionary:options];
}

+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration autoStem:(BOOL)autoStem;
{
    NSDictionary* options = @{@"keys" : keys, @"duration" : duration, @"autoStem" : @(autoStem)};
    return [[VFStaffNote alloc] initWithDictionary:options];
}

+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration andClef:(NSString*)clef;
{
    NSDictionary* options = @{
        @"keys" : keys,
        @"duration" : duration,
        @"clefName" : clef,
    };
    return [[VFStaffNote alloc] initWithDictionary:options];
}

+ (VFStaffNote*)noteWithKeys:(NSArray*)keys
                 andDuration:(NSString*)duration
                     andClef:(NSString*)clef
                 octaveShift:(float)octaveShift;
{
    NSDictionary* options =
        @{@"keys" : keys, @"duration" : duration, @"clefName" : clef, @"octave_shift" : @(octaveShift)};
    return [[VFStaffNote alloc] initWithDictionary:options];
}

+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration dots:(NSUInteger)dots;
{
    NSDictionary* options = @{@"keys" : keys, @"duration" : duration, @"dots" : @(dots)};
    VFStaffNote* ret = [[VFStaffNote alloc] initWithDictionary:options];
    //    VFTablesNoteStringData* data = [VFTables parseNoteData:@{}];  // [VFTables
    //    parseNoteDurationString:duration];
    //    if(data.dots == 0)
    //    {
    //        ret.dots = dots;
    //        ret.ticks = [[[[ret.ticks clone] divn:2] add:ret.ticks] clone];   // TODO: this is inefficient
    //    }
    //    else
    //    {
    //        if(data.dots != dots)
    //        {
    //            VFLogError(@"NoteWithDotsMismatchError, if dots are specified in duration then dots argument must
    //            match.");
    //        }
    //    }

    return ret;
}
+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration type:(NSString*)type;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return nil;
}
+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration dots:(NSUInteger)dots type:(NSString*)type;
{
    //    VFStaffNote* ret = [[self class] noteWithKeys:keys andDuration:duration dots:dots];
    //    VFTablesNoteStringData* data = [VFTables parseNoteDurationString:duration];
    //    ret.noteNHMRSType = VFNoteRest;
    //    if (ret.noteTypeString != type)
    //    {
    //        VFLogError(@"");
    //    }

    NSDictionary* options = @{@"keys" : keys, @"duration" : duration, @"dots" : @(dots), @"noteNHMRSString" : type};
    VFStaffNote* ret = [[VFStaffNote alloc] initWithDictionary:options];
    return ret;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"octave_shift" : @"octaveShift"}];
    return propertiesEntriesMapping;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

//- (VFStemDirectionType)stemDirection
//{
//    return _stemDirection;
//}

//- (void)setStemDirection:(VFStemDirectionType)stemDirection {
//    _stemDirection = stemDirection;
//}

/*!
 *  helps create a debug description from the specified string to properties dictionary
 *  @return a dictionary of property names
 */
- (NSDictionary*)dictionarySerialization;
{
    return [self dictionaryWithValuesForKeyPaths:@[
        @"position",
    ]];
}

#pragma mark - Setup/Configuration
/**---------------------------------------------------------------------------------------------------------------------
 * @name Setup/Configuration
 * ---------------------------------------------------------------------------------------------------------------------
 */

/** defaults setup
 */
- (void)setupStaffNote
{
    //    _staff = [VFStaff currentStaff];

    self.rest = NO;
    self.hasStem = YES;
    self.renderStem = YES;
    //    self.numDots = 0;
    self.dots = 0;
    _beam = nil;
    self.stemHeight = 5;
    //    self.octaveShift = 0;

    self.preFormatted = NO;
    self->_renderOptions = [[StaffNoteRenderOptions alloc] init];
}

- (void)setupStaffNoteWithOptions:(NSDictionary*)options
{
    [self setupStaffNote];

    // TODO: fix
    //    self.noteType = [VFTables noteDurationTypeForDurationString:<#(NSString *)#>]

    self.glyphStruct = [VFTables durationToGlyphStruct:self.noteDurationType withNHMRSType:self.noteNHMRSType];
    if(!self.glyphStruct)
    {
        VFLogError(@"BadArguments, Invalid note initialization data (No glyph found): %@", options);
    }

    // if YES, displace note to right
    self.displaced = NO;
    self.dotShiftY = 0;
    // per-pitch properties
    self.keyProps = [NSMutableArray array];
    // for displaced ledger lines
    self.use_default_head_x = NO;

    // Drawing
    self.note_heads = [NSMutableArray array];
    self.modifiers = [NSMutableArray array];

    if(self.clefName.length > 0)
    {
        self.clef = [VFClef clefWithName:self.clefName];
    }

    self->_renderOptions =
        [[StaffNoteRenderOptions alloc] initWithDictionary:[self->_renderOptions propertiesToDictionaryEntriesMapping]];
    // font size for note heads and rests
    [self->_renderOptions setGlyphFontScale:35];
    // number of stroke px to the left and right of head
    [self->_renderOptions setStrokePx:3];

    [self calculateKeyProps];
    self.note_heads = [NSMutableArray arrayWithCapacity:self.keyProps.count];
    for(NSUInteger i = 0; i < self.keyProps.count; ++i)
    {
        [self.note_heads addObject:[NSNull null]];
    }

    [self buildStem];

    // Set the stem direction
    if(self.autoStem)
    {
        [self autoStemPrivate];
    }
    else
    {
        [self setStemDirection:[options[@"stem_direction"] integerValue]];
    }

    [self buildNoteHeads];

    // Calculate left/right padding
    [self calcExtraPx];
}

// Builds a `Stem` for the note
- (void)buildStem
{
    VFTablesGlyphStruct* glyphStruct = self.glyphStruct;
    float y_extend = 0;
    if([glyphStruct.code_head isEqualToString:@"v95"] || [glyphStruct.code_head isEqualToString:@"v3e"])
    {
        y_extend = -4;
    }
    if(self.isRest)
    {
        self.stem.hide = YES;
    }

    if(!self.beam)
    {
        self.stem.y_extend = y_extend;
    }

    self.stem.y_extend = y_extend;
}

// Builds a `NoteHead` for each key in the note
- (void)buildNoteHeads
{
    VFStemDirectionType stem_direction = self.stemDirection;

    //    if(stem_direction == VFStemDirectionDown)
    //    {
    //        NSLog(@"hi");
    //    }

    NSMutableArray* keys = self.keyStrings;

    float last_line = -999;
    float line_diff = 0;
    BOOL displaced = NO;

    // Draw notes from bottom to top.
    NSInteger start_i = 0;
    NSInteger end_i = keys.count;
    NSInteger step_i = 1;

    // For down-stem notes, we draw from top to bottom.
    if(stem_direction == VFStemDirectionDown)
    {
        start_i = keys.count - 1;
        end_i = -1;
        step_i = -1;
    }

    for(NSInteger i = start_i; i != end_i; i += step_i)
    {
        KeyProperty* note_props = self.keyProps[i];

        float line = note_props.line;

        // Keep track of last line with a note head, so that consecutive heads
        // are correctly displaced.
        if(last_line == -999)
        {
            last_line = line;
        }
        else
        {
            line_diff = ABS(last_line - line);
            if(line_diff == 0 || line_diff == 0.5)
            {
                displaced = !displaced;
            }
            else
            {
                displaced = NO;
                self.use_default_head_x = YES;
            }
        }
        last_line = line;

        //        [self->renderOptions setGlyphFontScale:10];
        //        NSLog(@"%f", [self->renderOptions glyphFontScale]);

        //        NSDictionary* options =
        //            [self dictionaryWithValuesForKeyPaths:@[ @"duration", @"noteType", @"renderOptions.glyphFontScale"
        //            ]];

        //        [self->renderOptions setGlyphFontScale:10];
        //        NSLog(@"%f", [self->renderOptions glyphFontScale]);

        // TODO: fix the following
        //        VFNoteHead* noteHead = [[VFNoteHead alloc] initWithDictionary:nil];
        //        noteHead.duration = self.durationString;
        //        noteHead.noteNHMRSType = self.noteNHMRSType;
        //        noteHead.isDisplaced = displaced;
        //        noteHead.stemDirection = stem_direction;
        //        noteHead.customGlyphCode = note_props.glyphCode;
        //        [noteHead->_renderOptions setGlyphFontScale:[self->_renderOptions glyphFontScale]];
        //        noteHead.x_shift = note_props.shiftRight;
        //        noteHead.line = note_props.line;
        //        noteHead.noteName = self.durationString;

        VFNoteHead* noteHead = [[VFNoteHead alloc] initWithDictionary:@{
            //            @"rest" : @(self.isRest),
            @"keys" : self.keyStrings,
            @"note_type" : self.noteNHMRSString,
            @"duration" : self.durationString,
            @"noteDurationType" : @(self.noteDurationType),
            @"noteNHMRSType" : @(self.noteNHMRSType),
            @"displaced" : @(displaced),
            @"stemDirection" : @(stem_direction),
            @"customGlyphCode" : note_props.glyphCode,
            @"x_shift" : @(note_props.shiftRight),
            @"line" : @(note_props.line),
            @"noteName" : self.durationString,
        }];
        [noteHead->_renderOptions setGlyphFontScale:[self->_renderOptions glyphFontScale]];
        self.note_heads[i] = noteHead;   //[self.note_heads insertObject:noteHead atIndex:i];
    }
}

// Automatically sets the stem direction based on the keys in the note
- (void)autoStemPrivate
{
    BOOL auto_stem_direction;

    // Figure out optimal stem direction based on given notes
    self.minLine = ((KeyProperty*)self.keyProps[0]).line;
    self.maxLine = ((KeyProperty*)self.keyProps.lastObject).line;
    float decider = (self.minLine + self.maxLine) / 2;

    if(decider < 3.0f)
    {
        auto_stem_direction = VFStemDirectionUp;
    }
    else
    {
        auto_stem_direction = VFStemDirectionDown;
    }

    self.stemDirection = auto_stem_direction;
}

/*!
 *  Calculates and stores the properties for each key in the note
 */
- (void)calculateKeyProps
{
    __block NSInteger last_line = -999;
    [self.keyStrings foreach:^(NSString* key, NSUInteger index, BOOL* stop) {
      // All rests use the same position on the line.
      // if (self.glyph.rest) key = self.glyph.position;
      if(self.glyphStruct.rest)
      {
          self.glyphStruct.position = key;
      }
      NSDictionary* options = @{ @"octave_shift" : @(self.octaveShift) };
      KeyProperty* props = [VFTables keyPropertiesForKey:key andClef:self.clef.type andOptions:options];
      if(!props)
      {
          VFLogError(@"BadArguments %@%@", @"Invalid key for note properties: ", key);
      }

      // Override line placement for default rests
      if([props.key isEqualToString:@"R"])
      {
          if([self.durationString isEqualToString:@"1"] || [self.durationString isEqualToString:@"w"])
          {
              props.line = 4;
          }
          else
          {
              props.line = 3;
          }
      }

      // Calculate displacement of this note
      float line = props.line;
      if(last_line == -999)
      {
          last_line = line;
      }
      else
      {
          if(ABS(last_line - line) == 0.5)
          {
              self.displaced = YES;
              props.displaced = YES;

              // Have to mark the previous note as
              // displaced as well, for modifier placement
              if(self.keyProps.count > 0)
              {
                  ((KeyProperty*)self.keyProps[index - 1]).displaced = YES;
              }
          }
      }

      last_line = line;
      [self.keyProps push:(props)];
    }];

    [self.keyProps sortUsingComparator:^NSComparisonResult(KeyProperty* obj1, KeyProperty* obj2) {
      if(obj1.line < obj2.line)
      {
          return NSOrderedAscending;
      }
      else if(obj1.line > obj2.line)
      {
          return NSOrderedDescending;
      }
      else
      {
          return NSOrderedSame;
      }
    }];
}

#pragma mark - Static Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Static Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

// Helper methods for rest positioning in ModifierContext.
+ (void)shiftRestVertical:(FormatNote*)rest note:(FormatNote*)note direction:(VFShiftDirectionType)direction
{
    float delta = (note.isRest ? 0.0 : 1.0) * direction;
    rest.line += delta;
    rest.max_line += delta;
    rest.min_line += delta;
    VFStaffNote* restNote = rest.note;
    [rest.note setKeyLine:0 withLine:([restNote getKeyLine:0] + delta)];
}

// Called from formatNotes :: center a rest between two notes
+ (void)centerRest:(FormatNote*)rest noteU:(FormatNote*)noteU noteL:(FormatNote*)noteL
{
    float delta = rest.line - vfmidline(noteU.min_line, noteL.max_line);
    [rest.note setKeyLine:0 withLine:[rest.note getKeyLine:(0 - delta)]];
    rest.line -= delta;
    rest.max_line -= delta;
    rest.min_line -= delta;
}

// Format notes inside a ModifierContext.
+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* notes = modifiers;
    if(!notes || notes.count < 2)
    {
        return NO;
    }

    if(((VFStaffNote*)notes[0]).staff)
    {
        return [VFStaffNote formatByY:notes state:state];
    }

    NSMutableArray* notes_list = [NSMutableArray array];
    for(NSUInteger i = 0; i < notes.count; ++i)
    {
        VFStaffNote* note = notes[i];
        NSMutableArray* props = note.keyProps;
        KeyProperty* firstKeyProp = props.firstObject;
        float line = firstKeyProp.line;
        KeyProperty* lastKeyProp = props.lastObject;
        NSUInteger minL = lastKeyProp.line;
        VFStemDirectionType stem_dir = note.stemDirection;
        float stem_max = note.stemLength / 10;
        float stem_min = note.stemMinLength / 10;

        NSUInteger maxL;
        if(note.isRest)
        {
            maxL = line + note.glyphStruct.line_above;
            minL = line - note.glyphStruct.line_below;
        }
        else
        {
            maxL = stem_dir == 1 ? ((KeyProperty*)props[props.count - 1]).line + stem_max
                                 : ((KeyProperty*)props[props.count - 1]).line;
            minL = stem_dir == 1 ? ((KeyProperty*)props[0]).line : ((KeyProperty*)props[0]).line - stem_max;
        }
        [notes_list push:[[FormatNote alloc] initWithDictionary:@{
                        @"line" : @(firstKeyProp.line),   // note/rest base line
                        @"max_line" : @(maxL),            // note/rest upper bounds line
                        @"min_line" : @(minL),            // note/rest lower bounds line
                        @"isRest" : @(note.isRest),
                        @"stem_dir" : @(stem_dir),
                        @"stem_max" : @(stem_max),   // Maximum (default) note stem length;
                        @"stem_min" : @(stem_min),   // minimum note stem length
                        @"voice_shift" : @(note.voiceShiftWidth),
                        @"displaced" : @(note.displaced),   // note manually displaced
                        @"note" : note,
                    }]];
    }

    NSUInteger voices = notes_list.count;

    FormatNote* noteU = notes_list[0];
    FormatNote* noteM = voices > 2 ? notes_list[1] : nil;
    FormatNote* noteL = voices > 2 ? notes_list[2] : notes_list[1];
    // for two voice backward compatibility, ensure upper voice is stems up
    // for three voices, the voices must be in order (upper, middle, lower)
    if(voices == 2 && noteU.stem_dir == -1 && noteL.stem_dir == 1)
    {
        noteU = notes_list[1];
        noteL = notes_list[0];
    }

    float voice_x_shift = MAX(noteU.voice_shift, noteL.voice_shift);
    float x_shift = 0;
    float stem_delta;

    // Test for two voice note intersection
    // Test for two voice note intersection
    if(voices == 2)
    {
        float line_spacing = noteU.stem_dir == noteL.stem_dir ? 0.0 : 0.5;
        // if top voice is a middle voice, check stem intersection with lower voice
        if(noteU.stem_dir == noteL.stem_dir && noteU.min_line <= noteL.max_line)
        {
            if(!noteU.isRest)
            {
                stem_delta = ABS(noteU.line - (noteL.max_line + 0.5));
                stem_delta = MAX(stem_delta, noteU.stem_min);
                noteU.min_line = noteU.line - stem_delta;
                [noteU.note setStemLength:(stem_delta * 10)];
            }
        }
        if(noteU.min_line <= noteL.max_line + line_spacing)
        {
            if(noteU.isRest)
            {
                // shift rest up
                [[self class] shiftRestVertical:noteU note:noteL direction:1];
            }
            else if(noteL.isRest)
            {
                // shift rest down
                [[self class] shiftRestVertical:noteL note:noteU direction:-1];
            }
            else
            {
                x_shift = voice_x_shift;
                if(noteU.stem_dir == noteL.stem_dir)
                {
                    // upper voice is middle voice, so shift it right
                    [noteU.note setXShift:x_shift + 3];
                }
                else
                {
                    // shift lower voice right
                    [noteL.note setXShift:x_shift];
                }
            }
        }

        // format complete
        return YES;
    }

    // Check middle voice stem intersection with lower voice
    if(noteM && noteM.min_line < noteL.max_line + 0.5)
    {
        if(!noteM.isRest)
        {
            stem_delta = ABS(noteM.line - (noteL.max_line + 0.5));
            stem_delta = MAX(stem_delta, noteM.stem_min);
            noteM.min_line = noteM.line - stem_delta;
            [noteM.note setStemLength:(stem_delta * 10)];
        }
    }

    // For three voices, test if rests can be repositioned
    //
    // Special case 1 :: middle voice rest between two notes
    //
    if(noteM.isRest && !noteU.isRest && !noteL.isRest)
    {
        if(noteU.min_line <= noteM.max_line || noteM.min_line <= noteL.max_line)
        {
            float rest_height = noteM.max_line - noteM.min_line;
            float space = noteU.min_line - noteL.max_line;
            if(rest_height < space)
            {
                // center middle voice rest between the upper and lower voices
                [[self class] centerRest:noteM noteU:noteU noteL:noteL];   // centerRest(noteM, noteU, noteL);
            }
            else
            {
                x_shift = voice_x_shift + 3;   // shift middle rest right
                [noteM.note setXShift:x_shift];
            }
            // format complete
            return YES;
        }
    }

    // Special case 2 :: all voices are rests
    if(noteU.isRest && noteM.isRest && noteL.isRest)
    {
        // Shift upper voice rest up
        [[self class] shiftRestVertical:noteU note:noteM direction:1];
        // Shift lower voice rest down
        [[self class] shiftRestVertical:noteL note:noteM direction:-1];
        // format complete
        return YES;
    }

    // Test if any other rests can be repositioned
    if(noteM.isRest && noteU.isRest && noteM.min_line <= noteL.max_line)
    {
        // Shift middle voice rest up
        [[self class] shiftRestVertical:noteM note:noteL direction:1];
    }
    if(noteM.isRest && noteL.isRest && noteU.min_line <= noteM.max_line)
    {
        // Shift middle voice rest down
        [[self class] shiftRestVertical:noteM note:noteU direction:-1];
    }
    if(noteU.isRest && noteU.min_line <= noteM.max_line)
    {
        // shift upper voice rest up;
        [[self class] shiftRestVertical:noteU note:noteM direction:1];
    }
    if(noteL.isRest && noteM.min_line <= noteL.max_line)
    {
        // shift lower voice rest down
        [[self class] shiftRestVertical:noteL note:noteM direction:-1];
    }

    // If middle voice intersects upper or lower voice
    if((!noteU.isRest && !noteM.isRest && noteU.min_line <= noteM.max_line + 0.5) ||
       (!noteM.isRest && !noteL.isRest && noteM.min_line <= noteL.max_line))
    {
        x_shift = voice_x_shift + 3;   // shift middle note right
        [noteM.note setXShift:x_shift];
    }

    return YES;
}

+ (BOOL)formatByY:(NSMutableArray*)notes state:(VFModifierState*)state
{
    // NOTE: this function does not support more than two voices per staff
    //       use with care.
    BOOL hasStaff = YES;
    for(VFStaffNote* note in notes)
    {
        hasStaff = hasStaff && note.staff != nil;
    }

    if(!hasStaff)
    {
        VFLogError(@"Staff Missing %@", @"All notes must have a Staff - Vex.Flow.ModifierContext.formatMultiVoice!");
    }
    float x_shift = 0;

    for(uint i = 0; i < notes.count - 1; i++)
    {
        VFStaffNote* top_note = notes[i];
        VFStaffNote* bottom_note = notes[i + 1];

        if(top_note.stemDirection == VFStemDirectionDown)
        {
            top_note = notes[i + 1];
            bottom_note = notes[i];
        }

        NSArray* top_keys = top_note.keyProps;         //.getKeyProps(); // array of KeyProperty
        NSArray* bottom_keys = bottom_note.keyProps;   // getKeyProps();

        float topY = [top_note.staff getYForLine:(((KeyProperty*)top_keys[0]).line)];
        float bottomY = [bottom_note.staff getYForLine:(((KeyProperty*)bottom_keys[bottom_keys.count - 1]).line)];

        float line_space = top_note.staff.options.spacing_between_lines_px;
        if(ABS(topY - bottomY) == line_space / 2)
        {
            x_shift = [top_note voiceShiftWidth];   //.getVoiceShiftWidth();
            [bottom_note setXShift:x_shift];
        }
    }

    state.right_shift += x_shift;
    return YES;
}

+ (BOOL)postFormat:(NSMutableArray*)modifiers;
{
    NSArray* notes = modifiers;
    if(!notes)
    {
        return NO;
    }

    __block BOOL success = YES;
    [notes foreach:^(VFNote* note, NSUInteger index, BOOL* stop) {
      if(![note postFormat])
      {
          success = NO;
      }
    }];

    return success;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

// Calculates and sets the extra pixels to the left or right
// if the note is displaced
- (void)calcExtraPx
{
    //    NoteMetrics* metrics = self.metrics;
    //    metrics.extraLeftPx = (self.displaced && self.stemDirection == -1) ? self.glyphStruct.head_width : 0;
    //    metrics.extraRightPx = (self.displaced && self.stemDirection == 1) ? self.glyphStruct.head_width : 0;

    self.extraLeftPx = (self.displaced && self.stemDirection == -1) ? self.glyphStruct.head_width : 0;
    self.extraRightPx = (self.displaced && self.stemDirection == 1) ? self.glyphStruct.head_width : 0;
}

//- (NSString*)description
//{
//    NSString* ret = [self prolog];
//    ret = [ret concat:[super description]];
//
//    ret = [ret concat:[NSString stringWithFormat:@"Category: %@\n", self.category]];
//    //    ret = [ret concat:[NSString stringWithFormat:@"Position: %@\n", self.position]];
//    if(_beam)
//        ret = [ret concat:[NSString stringWithFormat:@"Beam: %@\n", [self.beam prettyPrint]]];
//    if(_tuplet)
//        ret = [ret concat:[NSString stringWithFormat:@"Tuplet: %@\n", [self.tuplet prettyPrint]]];
//
//    return [self epilog:ret];
//}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"staffnote";
}

- (NSString*)codeHead
{
    return [(Metrics*)self->_metrics code];
}

//- (VFTablesGlyphStruct*)glyphStruct
//{
//    if(!_glyphStruct)
//    {
//        _glyphStruct = [[VFTablesGlyphStruct alloc] init];
//    }
//    return _glyphStruct;
//}

//- (VFBeam *)beam {
//    if (!_beam) {
//        _beam = [[VFBeam alloc]init];
//    }
//    return _beam;
//}
//
//- (VFTuplet *)tuplet {
//    if (!_tuplet) {
//        _tuplet = [[VFTuplet alloc]init];
//    }
//    return _tuplet;
//}
//
//- (StaffNoteOptions *)renderOptions {
//    if (!_renderOptions) {
////        [VFLog LogWarn:@"RenderOptionsWarning, renderOptions was not initialized."];
//        _renderOptions = [[StaffNoteOptions alloc]init];
//    }
//    return _renderOptions;
//}

//
/*!
 *  Get the `BoundingBox` for the entire note
 *  @return a bounding box around the note
 */
- (VFBoundingBox*)boundingBox
{
    if(!self.preFormatted)
    {
        [VFLog logError:@"UnformattedNote, Can't call getBoundingBox on an unformatted note."];
    }

    //    TickableMetrics *metrics = self.metrics;

    NoteMetrics* metrics = self.metrics;

    float w = metrics.width;
    float x = self.absoluteX - metrics.modLeftPx - metrics.extraLeftPx;

    __block float minY = 0;
    __block float maxY = 0;
    float halfLineSpacing = self.staff.spacingBetweenLines / 2.0;
    float line_spacing = halfLineSpacing * 2.0;

    if(self.rest)
    {
        float y = [self.ys[0] floatValue];
        if([self.durationString isEqualToString:@"w"] || [self.durationString isEqualToString:@"h"])
        {
            minY = y - halfLineSpacing;
            maxY = y + halfLineSpacing;
        }
        else
        {
            minY = y - (self.glyphStruct.metrics.lineAbove * line_spacing);
            maxY = y + (self.glyphStruct.metrics.lineBelow * line_spacing);
        }
    }
    else if(self.hasStem)
    {
        VFExtentStruct* extents = self.stem.extents;
        extents.baseY += halfLineSpacing * self.stemDirection;
        minY = MIN(extents.topY, extents.baseY);
        maxY = MAX(extents.topY, extents.baseY);
    }
    else
    {
        minY = 0;
        maxY = 0;

        [self.ys enumerateObjectsUsingBlock:^(NSNumber* floatNumber, NSUInteger idx, BOOL* stop) {
          float yy = [floatNumber floatValue];
          if(idx == 0)
          {
              minY = yy;
              maxY = yy;
          }
          else
          {
              minY = MIN(yy, minY);
              maxY = MAX(yy, maxY);
          }
          minY -= halfLineSpacing;
          maxY += halfLineSpacing;
        }];
    }

    return [VFBoundingBox boundingBoxAtX:x atY:minY withWidth:w andHeight:(maxY - minY)];
}

// Gets the line number of the top or bottom note in the chord.
// If `is_top_note` is `YES` then get the top note
- (NSUInteger)getLineNumber:(BOOL)is_top_note
{
    if(!self.keyProps.count)
    {
        [VFLog logError:[NSString
                            stringWithFormat:@"NoKeyProps %@",
                                             @"Can't get bottom note line, because note is not initialized properly."]];
    }

    NSUInteger result_line = ((KeyProperty*)self.keyProps[0]).line;

    // No precondition assumed for sortedness of keyProps array
    for(KeyProperty* kp in self.keyProps)
    {
        NSUInteger this_line = kp.line;
        if(is_top_note)
        {
            if(this_line > result_line)
            {
                result_line = this_line;
            }
        }
        else
        {
            if(this_line < result_line)
            {
                result_line = this_line;
            }
        }
    }

    return result_line;
}

// Determine if current note is a rest
- (BOOL)isRest
{
    return self.glyphStruct.rest;
}

// Determine if the current note is a chord
- (BOOL)isChord
{
    return !self.isRest && self.keyStrings.count > 1;
}

- (BOOL)hasStem
{
    return self.glyphStruct.stem && !self.isRest;
}

- (void)setStem:(VFStem*)stem
{
    //    self.glyphStruct.stem = stem;
    _stem = stem;
}

// TODO: superclass should create the stem
- (VFStem*)stem
{
    if(self.isRest)
    {
        //        VFLogInfo(@"setting stem on a rest. why? possibly an error");
    }
    if(!_stem)
    {
        _stem = [[VFStem alloc] initWithDictionary:nil];
        _stem.stemDirection = VFStemDirectionNone;
    }
    _stem.stemDirection = self.stemDirection;   // HACK
    return _stem;
}

//- (VFStaff *)staff {
//    if (!_staff) {
//        _staff = [VFStaff currentStaff];
//        [VFLog LogError:@"Getting current staff for staffnote."];
//    }
//    return  _staff;
//}

// Sets the current note to the provided `Staff`. This applies
// `y` values to the `NoteHeads`.
- (id)setStaff:(VFStaff*)staff;
{
    // TODO: fix these redundant lines, this function is messy
    super.staff = staff;
    _staff = staff;

    NSMutableArray* ys = [[self.note_heads oct_map:^NSNumber*(VFNoteHead* note_head) {
      note_head.staff = staff;
      return [NSNumber numberWithFloat:note_head.y];
    }] mutableCopy];

    self.ys = ys;

    NoteHeadBounds* bounds = [self getNoteHeadBounds];   // .noteHeadBounds;

    if(!self.beam)
    {
        [self.stem setYBoundsTop:bounds.y_top andBottom:bounds.y_bottom];
    }
    return self;
}

- (VFStaff*)staff;
{
    return _staff;
}

//- (BOOL)isDisplaced
//{
//    //return _notesDisplaced;
////    return _displ
//}

/*!
 *  Get the starting `x` coordinate for a `StaffTie`
 *  @return <#return value description#>
 */
- (float)tieRightX
{
    float tieStartX = self.absoluteX;
    tieStartX += self.glyphStruct.head_width + self.xShift + self.extraRightPx;
    if(self.modifierContext)
    {
        tieStartX += [self.modifierContext getExtraRightPx];
    }
    return tieStartX;
}

/*!
 *  Get the ending `x` coordinate for a `StaffTie`
 *  @return <#return value description#>
 */
- (float)tieLeftX
{
    float tieEndX = self.absoluteX;
    tieEndX += self.xShift - self.extraLeftPx;
    return tieEndX;
}

/*!
 *  Get the Staff line on which to place a rest
 *  @return <#return value description#>
 */
- (NSUInteger)lineForRest
{
    float restLine = [((KeyProperty*)[self.keyProps objectAtIndex:0])line];
    if(self.keyProps.count > 1)
    {
        float lastLine = [((KeyProperty*)[self.keyProps lastObject])line];
        float top = MAX(restLine, lastLine);
        float bottom = MIN(restLine, lastLine);
        restLine = [VFMath midLineOf:top and:bottom];
    }
    return restLine;
}

/*!
 *  gets the point to put modifier for this note
 *  @param position the `left`, `right`, `top`, or `bottom` position to put the modifier
 *  @param index    if there's more than one modifier, then which index to occupy
 *  @return an xy point
 */
- (VFPoint*)getModifierstartXYforPosition:(VFPositionType)position andIndex:(NSUInteger)index;
{
    if(self.preFormatted == NO)
    {
        VFLogError(@"UnformattedNote, Can't call GetModifierStartXY on an unformatted note");
    }

    if(self.ys.count == 0)
    {
        VFLogError(@"NoYValues, No Y-Values calculated for this note.");
    }

    float x = 0;
    if(position == VFPositionLeft)
    {
        // extra_left_px
        x = -1 * 2;
    }
    else if(position == VFPositionRight)
    {
        // extra_right_px
        x = self.glyphStruct.head_width + self.shift_x + 2;
    }
    else if(position == VFPositionAbove || position == VFPositionBelow)
    {
        x = self.glyphStruct.head_width / 2;
    }

    else if(position == VFPositionCenter)
    {
        // TODO: is center okay
    }

    return VFPointMake(self.absoluteX + x, [self.ys[index] floatValue]);
}

/*!
 *  Get all accidentals in the `ModifierContext`
 *  @return an array of VFAccidenal
 */
- (NSMutableArray*)getAccidentals
{
    return [self.modifierContext getModifiersForType:@"accidentals"];
}

/*!
 *  Get all dots in the `ModifierContext`
 *  @return an array of VFDot
 */
- (NSArray*)getDots
{
    return [self.modifierContext getModifiersForType:@"dots"];
}

- (float)voiceShiftWidth
{
    // TODO: may need to accomodate for dot here.
    return self.glyphStruct.head_width * (self.displaced ? 2 : 1);
}

//- (void)setStemDirection:(VFStemDirectionType)stemDirection
//{
//    if(stemDirection == VFStemDirectionNone)
//    {
//        stemDirection = VFStemDirectionUp;
//    }
//    if(stemDirection != VFStemDirectionUp && stemDirection != VFStemDirectionDown)
//    {
//        VFLogError(@"BadArgument %@%lu", @"Invalid stem direction: ", stemDirection);
//    }
//
//    _stemDirection = stemDirection;
//    _beam = nil;
//    if(self.preFormatted)
//    {
//        [self preFormat];
//    }
//}

#pragma mark - get positions for modifiers
/**---------------------------------------------------------------------------------------------------------------------
 * @name getters for modifiers positioning
 * ---------------------------------------------------------------------------------------------------------------------
 */

// TODO: change this to getYForBottomTextWithLine
- (float)getYForTopText:(float)textLine
{
    VFExtentStruct* extents = self.stemExtents;
    return MIN([self.staff getYForTopTextWithLine:textLine],
               extents.topY - ([self->_renderOptions annotation_spacing] * (textLine + 1)));
}

- (float)getYForBottomText:(float)textLine
{
    VFExtentStruct* extents = self.stemExtents;
    return MAX([self.staff getYForTopTextWithLine:textLine],
               extents.baseY - ([self->_renderOptions annotation_spacing] * (textLine + 1)));
}

// Sets the style of the complete StaffNote, including all keys
// and the stem.
- (void)setStyleBlock:(void (^)(CGContextRef))styleBlock
{
    _styleBlock = styleBlock;
    [self.note_heads foreach:^(VFNoteHead* notehead, NSUInteger index, BOOL* stop) {
      notehead.styleBlock = styleBlock;
    }];
    self.stem.styleBlock = styleBlock;
}

// Sets the notehead at `index` to the provided coloring `style`.
//
// `style` is an `object` with the following properties: `shadowColor`,
// `shadowBlur`, `fillStyle`, `strokeStyle`
- (void)setKeyStyle:(NSUInteger)index withBlock:(void (^)(CGContextRef))styleBlock
{
    ((VFNoteHead*)self.note_heads[index]).styleBlock = styleBlock;
}

- (void)setKeyLine:(NSUInteger)index withLine:(NSUInteger)line;
{
    ((KeyProperty*)self.keyProps[index]).line = line;
    ((VFNoteHead*)self.note_heads[index]).line = line;
}

- (NSUInteger)getKeyLine:(NSUInteger)index
{
    return ((KeyProperty*)self.keyProps[index]).line;
}

#pragma mark - add modifiers
/**---------------------------------------------------------------------------------------------------------------------
 * @name add modifiers
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 * Add self to modifier context. `mContext` is the `ModifierContext`
 * to be added to.

 *  @param mContext <#mContext description#>
 */
- (id)addToModifierContext:(VFModifierContext*)mContext
{
    [self setModifierContext:mContext];
    for(uint i = 0; i < self.modifiers.count; ++i)
    {
        [self.modifierContext addModifier:self.modifiers[i]];
    }
    [self.modifierContext addModifier:self];
    [self setPreFormatted:NO];
    return self;
}

/*
addModifier: function(index, modifier) {
    modifier.setNote(this);
    modifier.setIndex(index);
    this.modifiers.push(modifier);
    this.setPreFormatted(false);
    return this;
},
 */

///*!
// *  Generic function to add modifiers to a note
// *  @param modifier modifier to add
// *  @param index    index of the key that we're modifying
// *  @return this object
// */
//- (id)addModifier:(VFModifier*)modifier atIndex:(NSUInteger)index;
//{
//    //    [modifier setNote:self];
//    modifier->_note = self;
//    modifier.parent = self;
//    modifier.index = index;
//    [self.modifiers push:modifier];
//    [self setPreFormatted:NO];
//    return self;
//}

// Helper function to add an accidental to a key
- (VFStaffNote*)addAccidental:(VFAccidental*)accidental atIndex:(NSUInteger)index
{
    [self addModifier:accidental atIndex:index];
    accidental.note = self;
    return self;
}

- (id)addArticulation:(VFArticulation*)articulation;
{
    return [self addModifier:articulation atIndex:0];
}

// Helper function to add an articulation to a key
- (id)addArticulation:(VFArticulation*)articulation atIndex:(NSUInteger)index
{
    return [self addModifier:articulation atIndex:index];
}

// Helper function to add an annotation to a key
- (id)addAnnotation:(VFAnnotation*)annotation atIndex:(NSUInteger)index
{
    return [self addModifier:annotation atIndex:index];
}

- (id)addDotAtIndex:(NSUInteger)index
{
    VFDot* dot = [[VFDot alloc] init];
    dot.dotShiftY = self.glyphStruct.dot_shiftY;
    [dot setDotShiftY:self.glyphStruct.dot_shiftY];
    self.dots++;
    [self addModifier:dot atIndex:index];
    return self;
}

- (VFStaffNote*)addDotToAll;
{
    for(NSUInteger i = 0; i < self.keyProps.count; ++i)
    {
        [self addDotAtIndex:i];
    }
    return self;
}

+ (VFStaffNote*)showNoteWithDictionary:(NSDictionary*)noteStruct
                           withContext:(CGContextRef)ctx
                               onStaff:(VFStaff*)staff
                                   atX:(float)x;
{
    VFStaffNote* ret = [[VFStaffNote alloc] initWithDictionary:noteStruct];
    return [[self class] showNoteWithNote:ret withContext:ctx onStaff:staff atX:x];
}

+ (VFStaffNote*)showNoteWithNote:(VFStaffNote*)note withContext:(CGContextRef)ctx onStaff:(VFStaff*)staff atX:(float)x;
{
    //    VFStaffNote* ret = [[VFStaffNote alloc] initWithDictionary:noteStruct];
    VFTickContext* tickContext = [[VFTickContext alloc] init];
    [[tickContext addTickable:note] preFormat];
    tickContext.x = x;
    tickContext.pixelsUsed = 20;
    note.staff = staff;
    [note draw:ctx];
    //    if (drawBoundingBox) {
    //        [ret.boundingBox draw:ctx];
    //    }
    //    return ret;
    return note;
}

#if TARGET_OS_IPHONE
+ (UIImage*)imageForNoteWithDictionary:(NSDictionary*)noteStruct rect:(CGRect)rect;
{
    VFStaffNote* note = [[VFStaffNote alloc] initWithDictionary:noteStruct];
    return [[self class] imageForNote:note rect:rect];
}

+ (UIImage*)imageForNote:(VFStaffNote*)note rect:(CGRect)rect;
{
    //    CGRect rect = CGRectZero;
    CGFloat scale = 0.0;   // main screen scale

    UIGraphicsBeginImageContextWithOptions(rect.size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);

    // Scale the context so that the image is rendered at the
    //    CGContextScaleCTM(context, scale, scale);

    VFStaff* staff = [VFStaff staffWithRect:rect];
    [[self class] showNoteWithNote:note withContext:context onStaff:staff atX:CGRectGetMidX(rect) / 2];

    CGContextRestoreGState(context);
    UIImage* ret = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return ret;
}

#endif

#pragma mark - Rendering Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Rendering Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (BOOL)preFormat
{
    if(self.preFormatted)
    {
        return YES;
    }

    if(![super preFormat])
    {
        return YES;
    }
    if(self.modifierContext)
    {
        [self.modifierContext preFormat];
    }

    float width = self.glyphStruct.head_width + self.extraLeftPx + self.extraRightPx;

    // For upward flagged notes, the width of the flag needs to be added
    if(self.glyphStruct.flag && self.beam == nil && self.stemDirection == 1)
    {
        width += self.glyphStruct.head_width;
    }

    self.width = width;
    self.preFormatted = YES;

    return YES;
}

// Gets the staff line and y value for the highest and lowest notehead
- (NoteHeadBounds*)getNoteHeadBounds
{
    if(self.note_heads.count == 0)
    {
        VFLogError(@"cannot get NoteHeadBounds w/o note_heads");
    }

    // Top and bottom Y values for stem.
    __block float y_top = 0;
    __block float y_bottom = 0;

    __block float highest_line = self.staff.numberOfLines;
    __block float lowest_line = 1;

    [self.note_heads foreach:^(VFNoteHead* note_head, NSUInteger index, BOOL* stop) {
      float line = note_head.line;
      float y = note_head.y;

      if(y_top == 0 || y < y_top)
      {
          y_top = y;
      }

      if(y_bottom == 0 || y > y_bottom)
      {
          y_bottom = y;
      }

      highest_line = line > highest_line ? line : highest_line;
      lowest_line = line < lowest_line ? line : lowest_line;

    }];

    NoteHeadBounds* ret = [[NoteHeadBounds alloc] init];
    ret.y_top = y_top;
    ret.y_bottom = y_bottom;
    ret.highest_line = highest_line;
    ret.lowest_line = lowest_line;
    return ret;
}

/*!
 *  Get the starting `x` coordinate for the noteheads
 *  @return an x value
 */
- (float)getNoteHeadBeginX
{
    return self.absoluteX + self.xShift;
}

/*!
 *  Get the ending `x` coordinate for the noteheads
 *  @return an x value
 */
- (float)getNoteHeadEndX
{
    float x_begin = [self getNoteHeadBeginX];
    return x_begin + self.glyphStruct.head_width;   // - (kSTEM_WIDTH / 2);
}

/*!
 *  Draw the ledger lines between the Staff and the highest/lowest keys
 *  @param ctx the graphics context
 */
- (void)drawLedgerLines:(CGContextRef)ctx
{
    if(self.isRest)
    {
        return;
    }

    NoteHeadBounds* bounds = [self getNoteHeadBounds];
    float highest_line = bounds.highest_line;
    float lowest_line = bounds.lowest_line;
    // TODO: absoluteX broken
    //       var head_x = this.note_heads[0].getAbsoluteX();
    __block float head_x = ((VFNoteHead*)self.note_heads[0]).x;   //.absoluteX;

    VFStaffNote* that = self;
    void (^stroke)(float) = ^void(float y) {
      if(that.use_default_head_x == YES)
      {
          // TODO: absoluteX broken
          // head_x = that.getAbsoluteX() + that.x_shift;
          head_x = ((VFNoteHead*)self.note_heads[0]).x /* .absoluteX*/ + that.xShift;
      }
      float x = head_x - [that->_renderOptions strokePx];
      float length = ((head_x + that.glyphStruct.head_width) - head_x) + ([that->_renderOptions strokePx] * 2);

      CGContextFillRect(ctx, CGRectMake(x, y, length, 1));
    };

    NSInteger line;   // iterator
    for(line = 6; line <= highest_line; ++line)
    {
        stroke([self.staff getYForNoteWithLine:line]);
    }

    for(line = 0; line >= lowest_line; --line)
    {
        stroke([self.staff getYForNoteWithLine:line]);
    }
}

/*!
 *  Draw all key modifiers
 *  @param ctx the graphics context
 */
- (void)drawModifiers:(CGContextRef)ctx
{
    //    CGContextRef ctx = context;
    for(VFModifier* mod in self.modifiers)
    {
        VFNoteHead* note_head = self.note_heads[mod.index];   //.getIndex()];
        StyleBlock key_style = note_head.styleBlock;          // .getStyle();
        if(key_style)
        {
            CGContextSaveGState(ctx);
            key_style(ctx);   // note_head.applyStyle(ctx);
        }
        //        mod.graphicsContext = ctx;
        [mod draw:ctx];
        if(key_style)
        {
            CGContextRestoreGState(ctx);
        }
    }
}

/*!
 *  Draw the flag for the note
 *  @param ctx the graphics context
 */
- (void)drawFlag:(CGContextRef)ctx
{
    VFTablesGlyphStruct* glyph = self.glyphStruct;   // self.glyphStruct;
    BOOL render_flag = self.beam == nil;
    NoteHeadBounds* bounds = [self getNoteHeadBounds];   //.noteHeadBounds;

    float x_begin = [self getNoteHeadBeginX];
    float x_end = [self getNoteHeadEndX];

    if(glyph.flag && render_flag)
    {
        float note_stem_height = self.stem.height;
        float flag_x, flag_y;
        NSString* flag_code;

        if(self.stemDirection == VFStemDirectionDown)
        {
            // Down stems have flags on the left.
            flag_x = x_begin + 1;
            flag_y = bounds.y_top - note_stem_height + 2;   // CHANGE
            flag_code = glyph.code_flag_downstem;
        }
        else
        {
            // Up stems have flags on the left.
            flag_x = x_end + 1;
            flag_y = bounds.y_bottom - note_stem_height - 2;   // CHANGE
            flag_code = glyph.code_flag_upstem;
        }

        // Draw the Flag
        [VFGlyph renderGlyph:ctx
                         atX:flag_x
                         atY:flag_y
                   withScale:1   //[self->_renderOptions glyphFontScale] // CHANGE
                forGlyphCode:flag_code];
    }
}

/*!
 *  Draw the NoteHeads
 *  @param ctx the graphics context
 */
- (void)drawNoteHeads:(CGContextRef)ctx
{
    [self.note_heads foreach:^(VFNoteHead* note_head, NSUInteger index, BOOL* stop) {
      //      note_head.graphicsContext = context
      StyleBlock key_style = note_head.styleBlock;   // .getStyle();
      if(key_style)
      {
          CGContextSaveGState(ctx);
          key_style(ctx);   // note_head.applyStyle(ctx);
      }
      //        mod.graphicsContext = ctx;
      [note_head draw:ctx];
      if(key_style)
      {
          CGContextRestoreGState(ctx);
      }
    }];
}

/*!
 *  Render the stem onto the canvas
 *  @param ctx the graphics context
 */
- (void)drawStem:(CGContextRef)ctx
{
    [self.stem setStyleBlock:self.styleBlock];
    [self.stem draw:ctx];
}

/*!
 *  Draws all the `StaffNote` parts. This is the main drawing method.
 *  @param ctx the graphics context
 */
- (void)draw:(CGContextRef)ctx
{
    if(!self.staff)
    {
        VFLogError(@"NoStaff, Can't draw without a Staff.");
    }

    if(self.ys.count == 0)
    {
        VFLogError(@"NoYValues, Can't draw note without Y values.");
    }

    // TODO: the following lines should belong in format function (e.g. postFormat)
    float x_begin = [self getNoteHeadBeginX];
    float x_end = [self getNoteHeadEndX];

    // Format note head x positions
    [self.note_heads foreach:^(VFNoteHead* note_head, NSUInteger index, BOOL* stop) {
      note_head.x = x_begin;
      note_head.y += self.staff.y;
    }];

    // Format stem x positions
    [self.stem setNoteHeadXBoundsBegin:x_begin andEnd:x_end];

    VFLogDebug(@"%@",
               [NSString stringWithFormat:@"Rendering %@ %@", self.isChord ? @"chord :" : @"note :", self.keyStrings]);
    VFLogDebug(@"%@", [NSString stringWithFormat:@"Rendering staffnote at. Beg X: %f,    End X: %f", x_begin, x_end]);

    // Draw each part of the note
    [self drawLedgerLines:ctx];
    BOOL render_stem = self.hasStem && !self.beam;   // TODO: perhaps this should be a readonly property
    if(render_stem)
    {
        [self drawStem:ctx];
    }
    if(self.isRest)
    {
        [VFGlyph renderGlyph:ctx atX:x_begin atY:[self.ys[0] floatValue] withScale:1 forGlyphCode:self.glyphCode];
    }
    else
    {
        [self drawNoteHeads:ctx];
        [self drawFlag:ctx];
    }
    [self drawModifiers:ctx];
}

#pragma mark - CALayer methods

- (CGMutablePathRef)pathConvertPoint:(CGPoint)convertPoint
{
//    convertPoint = CGCombinePoints(self.point.CGPoint, convertPoint);
    CGMutablePathRef path = [super pathConvertPoint:convertPoint];

    for(VFNoteHead* noteHead in self.note_heads)
    {
        CGPathRef subPath = [noteHead pathConvertPoint:convertPoint];
        CGPathAddPath(path, NULL, subPath);
    }
    
    if(self.hasStem && !self.beam)
    {
        self.stem.staff = self.staff;
        self.stem.parent = self;
        self.stem.stemDirection = self.stemDirection;
        CGPathRef subPath = [self.stem pathConvertPoint:convertPoint];
        CGPathAddPath(path, NULL, subPath);
    }
    
    for(VFModifier* mod in self.modifiers)
    {
        CGPathRef subPath = [mod pathConvertPoint:convertPoint];
        CGPathAddPath(path, NULL, subPath);
    }

    return path;
}

- (CGRect)layerFrame
{
    CGRect superFrame = [super layerFrame];
//    superBounds.origin.y  += self.staff.y;
        float x_begin = [self getNoteHeadBeginX];
    //    CGRect myRect = CGRectMake(x_begin, self.staff.y, 30, 30);
    //    return CGRectUnion(superBounds, myRect);
    
    
    CGRect ret = CGRectMake(x_begin, self.staff.y, superFrame.size.width, superFrame.size.height);
    return ret;
}

- (VFShapeLayer*)shapeLayer
{
    VFShapeLayer* ret = [super shapeLayer]; //[CAShapeLayer layer];
    
    ret.path = [self pathConvertPoint:self.staff.point.CGPoint];

    CGRect frame = [self layerFrame];
//    ret.bounds = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
//    ret.position = bounds.origin;
    ret.frame = frame;

    // TODO: apply style

    return ret;
}

@end
