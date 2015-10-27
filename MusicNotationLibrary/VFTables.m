//
//  VFTables.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFTables.h"
#import "VFVex.h"

#import "VFClef.h"
#import "VFMetrics.h"
#import "VFEnum.h"
#import "VFKeyProperty.h"

#import "VFGlyph.h"
#import "VFArticulation.h"
#import "VFAccidental.h"
#import "VFKeySignature.h"
#import "VFNote.h"
#import "VFStaffNote.h"

#import "RegexKitLite.h"
#import "NSString+Ruby.h"
//#import "Foundation+sdfsubscripts.h" // not necessary with xcode > 4.5

#import "VFTablesOrnamentCodes.h"
#import "VFTablesAccidentalCodes.h"
#import "VFTablesNoteData.h"
#import "VFTableTypes.h"
#import "VFTablesAccListStruct.h"
#import "VFGlyphTabStruct.h"

#import "vfMacros.h"

@implementation NSArray (Reverse)

- (NSArray*)reversedArray
{
    NSMutableArray* array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator* enumerator = [self reverseObjectEnumerator];
    for(id element in enumerator)
    {
        [array addObject:element];
    }
    return array;
}

@end

@implementation NSMutableArray (Reverse)

- (void)reverse
{
    if([self count] == 0)
        return;
    NSUInteger i = 0;
    NSUInteger j = [self count] - 1;
    while(i < j)
    {
        [self exchangeObjectAtIndex:i withObjectAtIndex:j];

        i++;
        j--;
    }
}

@end

//======================================================================================================================
#pragma mark - NoteGlyph Implementation
/**---------------------------------------------------------------------------------------------------------------------
 * @name NoteGlyph Implementation
 * ---------------------------------------------------------------------------------------------------------------------
 */
@implementation NoteGlyph

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupNoteGlyph];
    }
    return self;
}

- (void)setupNoteGlyph
{
    self.code = @"";
    self.shiftRight = 0;
}

+ (NoteGlyph*)noteGlyphWithCode:(NSString*)code andShiftRight:(float)shiftRight
{
    NoteGlyph* ret = [[NoteGlyph alloc] init];
    ret.code = code;
    ret.shiftRight = shiftRight;
    return ret;
}

@end

//======================================================================================================================
#pragma mark - NoteValue Implementation
/**---------------------------------------------------------------------------------------------------------------------
 * @name NoteValue Implementation
 * ---------------------------------------------------------------------------------------------------------------------
 */
@implementation NoteValue

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setup];
    }
    return self;
}

- (instancetype)initWithIndex:(NSUInteger)index andIntVal:(NSInteger)intVal andAccidental:(NSString*)accidental
{
    self = [super init];
    if(self)
    {
        self.index = index;
        self.intVal = intVal;
        self.accidental = accidental;
        self.octave = 0;
        self.code = nil;
        self.shiftRight = 0;
    }
    return self;
}

//- (id)copy {
//    NoteValue *ret = [NoteValue alloc]initWithIndex:self.index
//    andIntVal:self.intVal andAccidental:self.accidental
//}

- (id)copyWithZone:(NSZone*)zone
{
    NoteValue* ret =
        [[NoteValue alloc] initWithIndex:self.index andIntVal:self.intVal andAccidental:[self.accidental copy]];
    return ret;
}

- (void)setup
{
    self.intVal = NSIntegerMax;
}

@end

////======================================================================================================================
//#pragma mark - ClefProperty Implementation
///**---------------------------------------------------------------------------------------------------------------------
// * @name ClefProperty Implementation
// *
// ---------------------------------------------------------------------------------------------------------------------
// */
//@implementation ClefProperty
//
//- (instancetype)initWithLineShift:(NSUInteger)lineShift {
//    self = [super init];
//    if (self) {
//        self.lineShift = lineShift;
//    }
//    return self;
//}
//
//+ (ClefProperty *)propWithLineShift:(NSUInteger)lineShift {
//    return [[ClefProperty alloc] initWithLineShift:lineShift];
//}
//
//@end

//======================================================================================================================
#pragma mark - VFTables Implementation
/**---------------------------------------------------------------------------------------------------------------------
 * @name VFTables Implementation
 * ---------------------------------------------------------------------------------------------------------------------
 */

// create at most one of this Class type
static BOOL _singletonCreated;
static VFTables* _singletonObject;

//`````````````````````
// Class Properties
/**
 */
static NSDictionary* _accidentalsDictionary;
/**
 */
static NSDictionary* _articulationsDictionary;
///**
// */
// static NSDictionary *_clefPropertiesDictionary;
/**
 */
static NSDictionary* _durationAliasesDictionary;
/**
 */
static NSDictionary* _durationCodesDictionary;
/**
 */
static NSDictionary* _durationsDictionary;
/**
 */
static NSArray* _durationsArray;
/** the frequencies for the piano keys
 */
static float* _frequenciesArray;
/** the labels for the piano keys
 */
static NSArray* _pianoLabels;
/**
 */
static NSArray* _integerToNoteArray;
/**
 */
static NSDictionary* _integerToNoteDictionary;
/**
 */
static NSDictionary* _keyNoteValuesDictionary;
/**
 */
static NSArray* _keyPropertiesArray;
/**
 */
static NSDictionary* _keySpecsDictionary;
/**
 */
static NSDictionary* _noteGlyphsDictionary;
/**
 */
static NSDictionary* _noteTypesDictionary;

/**
 */
static NSDictionary* _pitchForClefDictionary;

@implementation VFTables
{
}

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

/** create singleton
 */
- (instancetype)init
{
    if(_singletonCreated)
    {
        return _singletonObject;
    }
    else
    {
        self = [super init];
        if(self)
        {
            _singletonObject = self;
        }
    }
    return _singletonObject;
}

/** free C resources
 */
- (void)dealloc
{
    free(_frequenciesArray);
}

#pragma mark - Class Collections
/**---------------------------------------------------------------------------------------------------------------------
 * @name Class Collections
 * ---------------------------------------------------------------------------------------------------------------------
 */

// creates a dictionary of VFTablesAccidentalCodes objs
+ (NSDictionary*)accidentalsDictionary
{
    if(!_accidentalsDictionary)
    {
        NSDictionary* tmp_accidentalsDictionary = @{
            @"#" : @{
                @"code" : @"v18",
                @"width" : @10,
                @"gracenote_width" : @4.5,
                @"shift_right" : @0,
                @"shift_down" : @0
            },
            @"##" : @{
                @"code" : @"v7f",
                @"width" : @13,
                @"gracenote_width" : @6,
                @"shift_right" : @(-1),
                @"shift_down" : @0
            },
            @"b" :
                @{@"code" : @"v44", @"width" : @8, @"gracenote_width" : @4.5, @"shift_right" : @0, @"shift_down" : @0},
            @"bb" : @{
                @"code" : @"v26",
                @"width" : @14,
                @"gracenote_width" : @8,
                @"shift_right" : @(-3),
                @"shift_down" : @0
            },
            @"n" :
                @{@"code" : @"v4e", @"width" : @8, @"gracenote_width" : @4.5, @"shift_right" : @0, @"shift_down" : @0},
            @"{" : @{
                // Left paren for cautionary accidentals
                @"code" : @"v9c",
                @"width" : @5,
                @"shift_right" : @2,
                @"shift_down" : @0
            },
            @"}" : @{
                // Right paren for cautionary accidentals
                @"code" : @"v84",
                @"width" : @5,
                @"shift_right" : @0,
                @"shift_down" : @0
            },
            @"db" : @{@"code" : @"v9e", @"width" : @16, @"shift_right" : @0, @"shift_down" : @0},
            @"d" : @{@"code" : @"vab", @"width" : @10, @"shift_right" : @0, @"shift_down" : @0},
            @"bbs" : @{@"code" : @"v90", @"width" : @13, @"shift_right" : @0, @"shift_down" : @0},
            @"++" : @{@"code" : @"v51", @"width" : @13, @"shift_right" : @0, @"shift_down" : @0},
            @"+" : @{@"code" : @"v78", @"width" : @8, @"shift_right" : @0, @"shift_down" : @0}
        };
        NSMutableDictionary* tmp_accidentalsReturnDictionary = [NSMutableDictionary dictionary];
        for(NSString* key in tmp_accidentalsDictionary)
        {
            NSDictionary* accidental_dict = [tmp_accidentalsDictionary objectForKey:key];
            VFTablesAccidentalCodes* obj = [[VFTablesAccidentalCodes alloc] initWithDictionary:accidental_dict];
            [tmp_accidentalsReturnDictionary setObject:obj forKey:key];
        }
        _accidentalsDictionary = [NSDictionary dictionaryWithDictionary:tmp_accidentalsReturnDictionary];
    }
    return _accidentalsDictionary;
}

+ (VFArticulation*)articulationForType
{
    return nil;
}

+ (NSString*)articulationCodeForType:(VFArticulationType)type;
{
    switch(type)
    {
        case VFArticulationStacato:
            return @"a.";
            break;
        case VFArticulationStaccatissimo:
            return @"av";
            break;
        case VFArticulationAccent:
            return @"a>";
            break;
        case VFArticulationTenuto:
            return @"a-";
            break;
        case VFArticulationMarcato:
            return @"a^";
            break;
        case VFArticulationLeftHandPizzicato:
            return @"a+";
            break;
        case VFArticulationSnapPizzicato:
            return @"ao";
            break;
        case VFArticulationNaturalHarmonicOrOpenNote:
            return @"ah";
            break;
        case VFArticulationFermataAboveStaff:
            return @"a@a";
            break;
        case VFArticulationFermataBelowStaff:
            return @"a@u";
            break;
        case VFArticulationBowUpDashUpStroke:
            return @"a|";
            break;
        case VFArticulationBowDownDashDownStroke:
            return @"am";
            break;
        case VFArticulationChoked:
            return @"a,";
            break;
        default:
            [VFLog logError:@"unexpected articulation type"];
            break;
    }
}

+ (NSDictionary*)articulationsDictionary;
{
    if(!_articulationsDictionary)
    {
        _articulationsDictionary = @{
            @"a." : @{
                // Staccato
                @"code" : @"v23",
                @"width" : @4,
                @"shift_right" : @-2,
                @"shift_up" : @8,
                @"shift_down" : @0,
                @"between_lines" : @YES
            },
            @"av" : @{
                // Staccatissimo
                @"code" : @"v28",
                @"width" : @4,
                @"shift_right" : @0,
                @"shift_up" : @11,
                @"shift_down" : @5,
                @"between_lines" : @YES
            },
            @"a>" : @{
                // Accent
                @"code" : @"v42",
                @"width" : @10,
                @"shift_right" : @5,
                @"shift_up" : @8,
                @"shift_down" : @1,
                @"between_lines" : @YES
            },
            @"a-" : @{
                // Tenuto
                @"code" : @"v25",
                @"width" : @9,
                @"shift_right" : @-4,
                @"shift_up" : @17,
                @"shift_down" : @10,
                @"between_lines" : @YES
            },
            @"a^" : @{
                // Marcato
                @"code" : @"va",
                @"width" : @8,
                @"shift_right" : @0,
                @"shift_up" : @-4,
                @"shift_down" : @-2,
                @"between_lines" : @NO
            },
            @"a+" : @{
                // Left hand pizzicato
                @"code" : @"v8b",
                @"width" : @9,
                @"shift_right" : @-4,
                @"shift_up" : @12,
                @"shift_down" : @12,
                @"between_lines" : @NO
            },
            @"ao" : @{
                // Snap pizzicato
                @"code" : @"v94",
                @"width" : @8,
                @"shift_right" : @0,
                @"shift_up" : @-4,
                @"shift_down" : @6,
                @"between_lines" : @NO
            },
            @"ah" : @{
                // Natural harmonic or open note
                @"code" : @"vb9",
                @"width" : @7,
                @"shift_right" : @0,
                @"shift_up" : @-4,
                @"shift_down" : @4,
                @"between_lines" : @NO
            },
            @"a@a" : @{
                // Fermata above staff
                @"code" : @"v43",
                @"width" : @25,
                @"shift_right" : @0,
                @"shift_up" : @8,
                @"shift_down" : @10,
                @"between_lines" : @NO
            },
            @"a@u" : @{
                // Fermata below staff
                @"code" : @"v5b",
                @"width" : @25,
                @"shift_right" : @0,
                @"shift_up" : @0,
                @"shift_down" : @-4,
                @"between_lines" : @NO
            },
            @"a|" : @{
                // Bow up - up stroke
                @"code" : @"v75",
                @"width" : @8,
                @"shift_right" : @0,
                @"shift_up" : @8,
                @"shift_down" : @10,
                @"between_lines" : @NO
            },
            @"am" : @{
                // Bow down - down stroke
                @"code" : @"v97",
                @"width" : @13,
                @"shift_right" : @0,
                @"shift_up" : @10,
                @"shift_down" : @12,
                @"between_lines" : @NO
            },
            @"a," : @{
                // Choked
                @"code" : @"vb3",
                @"width" : @6,
                @"shift_right" : @8,
                @"shift_up" : @-4,
                @"shift_down" : @4,
                @"between_lines" : @NO
            }
        };
    }
    return _articulationsDictionary;
}

/*
+ (NSDictionary *)clefPropertiesDictionary {
    if (!_clefPropertiesDictionary) {
        NSMutableDictionary *dict = [[NSMutableDictionary
alloc]initWithCapacity:5];
        [dict setObject:[ClefProperty propWithLineShift:0] forKey:@"treble"];
        [dict setObject:[ClefProperty propWithLineShift:6] forKey:@"bass"];
        [dict setObject:[ClefProperty propWithLineShift:4] forKey:@"tenor"];
        [dict setObject:[ClefProperty propWithLineShift:3] forKey:@"alto"];
        [dict setObject:[ClefProperty propWithLineShift:0]
forKey:@"percussion"];
         _clefPropertiesDictionary = [NSDictionary
dictionaryWithDictionary:dict];
    }
    return _clefPropertiesDictionary;
}
*/

static NSDictionary* _clefProperties;
+ (NSDictionary*)clefProperties
{
    if(!_clefProperties)
    {
        _clefProperties = @{
            @"treble" : @{@"line_shift" : @0},
            @"bass" : @{@"line_shift" : @6},
            @"tenor" : @{@"line_shift" : @4},
            @"alto" : @{@"line_shift" : @3},
            @"soprano" : @{@"line_shift" : @1},
            @"percussion" : @{@"line_shift" : @0},
            @"mezzo-soprano" : @{@"line_shift" : @2},
            @"baritone-c" : @{@"line_shift" : @5},
            @"baritone-f" : @{@"line_shift" : @5},
            @"subbass" : @{@"line_shift" : @7},
            @"french" : @{@"line_shift" : @(-1)}
        };
    }
    return _clefProperties;
}

+ (float)lineShiftForClefType:(VFClefType)clefType
{
    switch(clefType)
    {
        case VFClefAlto:
            return 3;
            break;
        case VFClefBass:
            return 6;
            break;
        case VFClefMovableC:
            return -1;
            break;
        case VFClefPercussion:
            return 0;
            break;
        case VFClefTenor:
            return 4;
            break;
        case VFClefTreble:
            return 0;
            break;
        default:
            [VFLog logError:@"UnknownClefTypeException, unknown clef type."];
            return -1;
            break;
    }
}

+ (NSDictionary*)durationAliasesDictionary
{
    return @{
        @"w" : @"1",
        @"h" : @"2",
        @"q" : @"4",
        // This is the default duration used to render bars (BarNote). Bars no
        // longer
        // consume ticks, so this should be a no-op.
        //
        // TODO(0xfe): This needs to be cleaned up.
        @"b" : @"256"
    };
}

+ (void)configureStaffNoteForNote:(VFStaffNote*)note
{
    switch(note.noteDurationType)
    {
        case(VFDurationWholeNote):
            note.headWidth = 16.5;
            note.hasStem = NO;
            note.stemOffset = 0;
            note.flag = NO;
            note.dotShiftY = 0;
            [note->_metrics setLineAbove:0];
            [note->_metrics setLineBelow:0];
            break;
        case VFDurationHalfNote:
            note.headWidth = 10.5;
            note.hasStem = YES;
            note.stemOffset = 0;
            note.flag = NO;
            note.dotShiftY = 0;
            [note->_metrics setLineAbove:0];
            [note->_metrics setLineBelow:0];
            break;
        case VFDurationQuarterNote:
            note.headWidth = 10.5;
            note.hasStem = YES;
            note.stemOffset = 0;
            note.flag = NO;
            note.dotShiftY = 0;
            [note->_metrics setLineAbove:0];
            [note->_metrics setLineBelow:0];
            break;
        case VFDurationEighthNote:
            note.headWidth = 10.5;
            note.hasStem = YES;
            note.stemOffset = 0;
            note.flag = YES;
            note.beamCount = 1;
            note.codeFlagUpstem = @"v54";
            note.codeFlagDownstem = @"v9a";
            note.dotShiftY = 0;
            [note->_metrics setLineAbove:0];
            [note->_metrics setLineBelow:0];
            break;
        case VFDurationSixteenthNote:
            note.headWidth = 10.5;
            note.hasStem = YES;
            note.stemOffset = 0;
            note.flag = YES;
            note.beamCount = 2;
            note.codeFlagUpstem = @"v3f";
            note.codeFlagDownstem = @"v8f";
            note.dotShiftY = 0;
            [note->_metrics setLineAbove:0];
            [note->_metrics setLineBelow:0];
            break;
        case VFDurationThirtyTwoNote:
            note.headWidth = 10.5;
            note.hasStem = YES;
            note.stemOffset = 0;
            note.flag = YES;
            note.beamCount = 3;
            note.codeFlagUpstem = @"v47";
            note.codeFlagDownstem = @"v2a";
            note.dotShiftY = 0;
            [note->_metrics setLineAbove:0];
            [note->_metrics setLineBelow:0];
            break;
        case VFDurationSixtyFourNote:
            note.headWidth = 10.5;
            note.hasStem = YES;
            note.stemOffset = 0;
            note.flag = YES;
            note.beamCount = 3;
            note.codeFlagUpstem = @"va9";
            note.codeFlagDownstem = @"v58";
            note.dotShiftY = 0;
            [note->_metrics setLineAbove:0];
            [note->_metrics setLineBelow:0];
            break;
        case VFDurationNone:
        default:
            [VFLog logError:@"no duration."];
            break;
    }

// http://stackoverflow.com/a/6366364/629014

#define N 8

    switch(note.noteDurationType * N + note.noteNHMRSType)
    {
        case(VFDurationWholeNote * N + VFNoteNote):   // Whole note
            [note->_metrics setCode:@"v1d"];
            break;
        case(VFDurationWholeNote * N + VFNoteHarmonic):   // Whole note harmonic
            [note->_metrics setCode:@"v46"];
            break;
        case(VFDurationWholeNote * N + VFNoteMuted):   // Whole note muted
            [note->_metrics setCode:@"v92"];
            note.stemOffset = -3;
            break;
        case(VFDurationWholeNote * N + VFNoteRest):   // Whole rest
            [note->_metrics setCode:@"v5c"];
            note.headWidth = 12.5;
            note.rest = YES;
            note.position = @"D/5";
            note.dotShiftY = 0.5;
            break;
        case(VFDurationWholeNote * N + VFNoteSlash):   // Whole note slash
                                                       // Drawn with canvas primitives
            // note.metrics.code = @"";
            note.headWidth = 15;
            note.position = @"B/4";
            break;

        case(VFDurationHalfNote * N + VFNoteNote):   // Half note
            [note->_metrics setCode:@"v81"];
            break;
        case(VFDurationHalfNote * N + VFNoteHarmonic):   // Half note harmonic
            [note->_metrics setCode:@"v2d"];
            break;
        case(VFDurationHalfNote * N + VFNoteMuted):   // Half note muted
            [note->_metrics setCode:@"v95"];
            note.stemOffset = -3;
            break;
        case(VFDurationHalfNote * N + VFNoteRest):   // Half rest
            [note->_metrics setCode:@"vc"];
            note.headWidth = 12.5;
            note.hasStem = NO;
            note.rest = YES;
            note.position = @"B/4";
            note.dotShiftY = -0.5;
            break;
        case(VFDurationHalfNote * N + VFNoteSlash):   // Half note slash
            // Drawn with canvas primitives
            note.headWidth = 15;
            note.position = @"B/4";
            break;

        case(VFDurationQuarterNote * N + VFNoteNote):   // Quarter note
            [note->_metrics setCode:@"vb"];
            break;
        case(VFDurationQuarterNote * N + VFNoteHarmonic):   // Quarter harmonic
            [note->_metrics setCode:@"v22"];
            break;
        case(VFDurationQuarterNote * N + VFNoteMuted):   // Quarter muted
            [note->_metrics setCode:@"v3e"];
            note.stemOffset = -3;
            break;
        case(VFDurationQuarterNote * N + VFNoteRest):   // Quarter rest
            [note->_metrics setCode:@"v7c"];
            note.headWidth = 8;
            note.hasStem = NO;
            note.rest = YES;
            note.position = @"B/4";
            note.dotShiftY = -0.5;
            [note->_metrics setLineAbove:1.5];
            [note->_metrics setLineBelow:1.5];
            break;
        case(VFDurationQuarterNote * N + VFNoteSlash):   // Quarter slash
            // Drawn with canvas primitives
            note.headWidth = 15;
            note.position = @"B/4";
            break;

        case(VFDurationEighthNote * N + VFNoteNote):   // Eighth note
            [note->_metrics setCode:@"vb"];
            break;
        case(VFDurationEighthNote * N + VFNoteHarmonic):   // Eighth note harmonic
            [note->_metrics setCode:@"v22"];
            break;
        case(VFDurationEighthNote * N + VFNoteMuted):   // Eighth note muted
            [note->_metrics setCode:@"v3e"];
            break;
        case(VFDurationEighthNote * N + VFNoteRest):   // Eighth rest
            [note->_metrics setCode:@"va5"];
            note.hasStem = NO;
            note.flag = NO;
            note.rest = YES;
            note.position = @"B/4";
            note.dotShiftY = -0.5;
            [note->_metrics setLineAbove:1.0];
            [note->_metrics setLineBelow:1.0];
            break;
        case(VFDurationEighthNote * N + VFNoteSlash):   // Eighth slash
            // Drawn with canvas primitives
            note.headWidth = 15;
            note.position = @"B/4";
            break;

        case(VFDurationSixteenthNote * N + VFNoteNote):   // Sixteenth note
            [note->_metrics setCode:@"vb"];
            break;
        case(VFDurationSixteenthNote * N + VFNoteHarmonic):   // Sixteenth note harmonic
            [note->_metrics setCode:@"v22"];
            break;
        case(VFDurationSixteenthNote * N + VFNoteMuted):   // Sixteenth note muted
            [note->_metrics setCode:@"v3e"];
            break;
        case(VFDurationSixteenthNote * N + VFNoteRest):   // Sixteenth rest
            [note->_metrics setCode:@"v3c"];
            note.headWidth = 13;
            note.hasStem = NO;
            note.flag = NO;
            note.rest = YES;
            note.position = @"B/4";
            note.dotShiftY = -0.5;
            [note->_metrics setLineAbove:1.0];
            [note->_metrics setLineBelow:2.0];
            break;
        case(VFDurationSixteenthNote * N + VFNoteSlash):   // Sixteenth slash
            // Drawn with canvas primitives
            note.headWidth = 15;
            note.position = @"B/4";
            break;

        case(VFDurationThirtyTwoNote * N + VFNoteNote):   // Thirty-second note
            [note->_metrics setCode:@"vb"];
            break;
        case(VFDurationThirtyTwoNote * N + VFNoteHarmonic):   // Thirty-second note harmonic
            [note->_metrics setCode:@"v22"];
            break;
        case(VFDurationThirtyTwoNote * N + VFNoteMuted):   // Thirty-second note muted
            [note->_metrics setCode:@"v3e"];
            break;
        case(VFDurationThirtyTwoNote * N + VFNoteRest):   // Thirty-second rest
            [note->_metrics setCode:@"v55"];
            note.headWidth = 16;
            note.hasStem = NO;
            note.flag = NO;
            note.rest = YES;
            note.position = @"B/4";
            note.dotShiftY = -1.5;
            [note->_metrics setLineAbove:2.0];
            [note->_metrics setLineBelow:2.0];
            break;
        case(VFDurationThirtyTwoNote * N + VFNoteSlash):   // Thirty-second slash
            // Drawn with canvas primitives
            note.headWidth = 15;
            note.position = @"B/4";
            break;

        case(VFDurationSixtyFourNote * N + VFNoteNote):   // Sixty-fourth note
            [note->_metrics setCode:@"vb"];
            break;
        case(VFDurationSixtyFourNote * N + VFNoteHarmonic):   // Sixty-fourth harmonic
            [note->_metrics setCode:@"v22"];
            break;
        case(VFDurationSixtyFourNote * N + VFNoteMuted):   // Sixty-fourth muted
            [note->_metrics setCode:@"v3e"];
            break;
        case(VFDurationSixtyFourNote * N + VFNoteRest):   // Sixty-fourth rest
            [note->_metrics setCode:@"v38"];
            note.headWidth = 18;
            note.hasStem = NO;
            note.flag = NO;
            note.rest = YES;
            note.position = @"B/4";
            note.dotShiftY = -1.5;
            [note->_metrics setLineAbove:2.0];
            [note->_metrics setLineBelow:3.0];
            break;
        case(VFDurationSixtyFourNote * N + VFNoteSlash):   // Sixty-fourth  slash
            // Drawn with canvas primitives
            note.headWidth = 15;
            note.position = @"B/4";
            break;

        // case (VFDurationNone * N + VFNoteNone):
        default:
            [VFLog logError:@"no duration."];
            break;
    }
}

+ (NSDictionary*)durationToTicksDictionary
{
    if(!_durationsDictionary)
    {
        _durationsDictionary = @{
            @"1" : @(kRESOLUTION / 1.0),
            @"2" : @(kRESOLUTION / 2.0),
            @"4" : @(kRESOLUTION / 4.0),
            @"8" : @(kRESOLUTION / 8.0),
            @"16" : @(kRESOLUTION / 16.0),
            @"32" : @(kRESOLUTION / 32.0),
            @"64" : @(kRESOLUTION / 64.0),
            @"256" : @(kRESOLUTION / 256.0),
        };
    }
    return _durationsDictionary;
}

+ (float)staffLineForKey:(NSString*)key andClef:(VFClef*)clef
{
    return 0.0;
}

/*
- (NSDictionary *)noteTypesMap {
    if (!_noteTypsMap) {
        _noteTypsMap = @{ @"w": @(VFDurationWholeNote),
                          @"h" : @(VFDurationHalfNote),
                          @"q" : @(VFDurationQuarterNote),
                          @"8" : @(VFDurationEighthNote),
                          @"16" : @(VFDurationSixteenthNote),
                          @"32" : @(VFDurationThirtyTwoNote),
                          @"64" : @(VFDurationSixtyFourNote),
                          };
    }
    return _noteTypsMap;
}
*/

+ (float)frequencyForClef:(VFKeySignature*)keySignature andClef:(VFClef*)clef
{
    switch(clef.type)
    {
        case VFClefAlto:

            break;
        case VFClefBass:

            break;
        case VFClefMovableC:

            break;
        case VFClefPercussion:

            break;

        case VFClefTenor:

            break;
        case VFClefTreble:

            break;
        default:
            break;
    }

    //    float *frequencies = [VFTables frequenciesArray];
    //    return frequencies[];
    return 0;
}

+ (float*)frequenciesArray
{
    if(!_frequenciesArray)
    {
        _frequenciesArray = (float*)malloc(88 * sizeof(float));
        _frequenciesArray[0] = 27.5000;
        _frequenciesArray[1] = 29.1352;
        _frequenciesArray[2] = 30.8677;
        _frequenciesArray[3] = 32.7032;
        _frequenciesArray[4] = 34.6478;
        _frequenciesArray[5] = 36.7081;
        _frequenciesArray[6] = 38.8909;
        _frequenciesArray[7] = 41.2034;
        _frequenciesArray[8] = 43.6535;
        _frequenciesArray[9] = 46.2493;
        _frequenciesArray[10] = 48.9994;
        _frequenciesArray[11] = 51.9131;
        _frequenciesArray[12] = 55.0000;
        _frequenciesArray[13] = 58.2705;
        _frequenciesArray[14] = 61.7354;
        _frequenciesArray[15] = 65.4064;
        _frequenciesArray[16] = 69.2957;
        _frequenciesArray[17] = 73.4162;
        _frequenciesArray[18] = 77.7817;
        _frequenciesArray[19] = 82.4069;
        _frequenciesArray[20] = 87.3071;
        _frequenciesArray[21] = 92.4986;
        _frequenciesArray[22] = 97.9989;
        _frequenciesArray[23] = 103.826;
        _frequenciesArray[24] = 110.000;
        _frequenciesArray[25] = 116.541;
        _frequenciesArray[26] = 123.471;
        _frequenciesArray[27] = 130.813;
        _frequenciesArray[28] = 138.591;
        _frequenciesArray[29] = 146.832;
        _frequenciesArray[30] = 155.563;
        _frequenciesArray[31] = 164.814;
        _frequenciesArray[32] = 174.614;   // F Clef
        _frequenciesArray[33] = 184.997;
        _frequenciesArray[34] = 195.998;
        _frequenciesArray[35] = 207.652;
        _frequenciesArray[36] = 220.000;
        _frequenciesArray[37] = 233.082;
        _frequenciesArray[38] = 246.942;
        _frequenciesArray[39] = 261.626;   // C Clef , Movable Clef (Middle C)
        _frequenciesArray[40] = 277.183;
        _frequenciesArray[41] = 293.665;
        _frequenciesArray[42] = 311.127;
        _frequenciesArray[43] = 329.628;   // E (treble line 1)
        _frequenciesArray[44] = 349.228;   // F (treble space 1 (1.5)
        _frequenciesArray[45] = 369.994;
        _frequenciesArray[46] = 391.995;   // G Clef
        _frequenciesArray[47] = 415.305;
        _frequenciesArray[48] = 440.000;   // A
        _frequenciesArray[49] = 466.164;
        _frequenciesArray[50] = 493.883;   // B
        _frequenciesArray[51] = 523.251;   // space 4 treble c
        _frequenciesArray[52] = 554.365;
        _frequenciesArray[53] = 587.330;   // D treble line 4
        _frequenciesArray[54] = 622.254;
        _frequenciesArray[55] = 659.255;   // E trebble space 4
        _frequenciesArray[56] = 698.456;   // F Treble line 5
        _frequenciesArray[57] = 739.989;
        _frequenciesArray[58] = 783.991;   // G Treble top space
        _frequenciesArray[59] = 830.609;
        _frequenciesArray[60] = 880.000;
        _frequenciesArray[61] = 932.328;
        _frequenciesArray[62] = 987.767;
        _frequenciesArray[63] = 1046.50;
        _frequenciesArray[64] = 1108.73;
        _frequenciesArray[65] = 1174.66;
        _frequenciesArray[66] = 1244.51;
        _frequenciesArray[67] = 1318.51;
        _frequenciesArray[68] = 1396.91;
        _frequenciesArray[69] = 1479.98;
        _frequenciesArray[70] = 1567.98;
        _frequenciesArray[71] = 1661.22;
        _frequenciesArray[72] = 1760.00;
        _frequenciesArray[73] = 1864.66;
        _frequenciesArray[74] = 1975.53;
        _frequenciesArray[75] = 2093.00;
        _frequenciesArray[76] = 2217.46;
        _frequenciesArray[77] = 2349.32;
        _frequenciesArray[78] = 2349.32;
        _frequenciesArray[79] = 2489.02;
        _frequenciesArray[80] = 2793.83;
        _frequenciesArray[81] = 2959.96;
        _frequenciesArray[82] = 3135.96;
        _frequenciesArray[83] = 3322.44;
        _frequenciesArray[84] = 3520.00;
        _frequenciesArray[85] = 3729.31;
        _frequenciesArray[86] = 3951.07;
        _frequenciesArray[87] = 4186.01;
    }
    return _frequenciesArray;
}

+ (NSArray*)pianoLabels
{
    if(!_pianoLabels)
    {
        // http://en.wikipedia.org/wiki/Piano_key_frequencies
        _pianoLabels = @[
            /*88	c′′′′′ 5-line octave	C8 Eighth octave	4186.01
             */
            @"C8",
            /*87	b′′′′	B7	3951.07
             */
            @"B7",
            /*86	a♯′′′′/b♭′′′′	A♯7/B♭7	3729.31
             */
            @"A♯7",
            /*85	a′′′′	A7	3520.00
             */
            @"A7",
            /*84	g♯′′′′/a♭′′′′	G♯7/A♭7	3322.44
             */
            @"G♯7",
            /*83	g′′′′	G7	3135.96
             */
            @"G7",
            /*82	f♯′′′′/g♭′′′′	F♯7/G♭7	2959.96
             */
            @"F♯7",
            /*81	f′′′′	F7	2793.83
             */
            @"F7",
            /*80	e′′′′	E7	2637.02
             */
            @"E7",
            /*79	d♯′′′′/e♭′′′′	D♯7/E♭7	2489.02
             */
            @"D♯7",
            /*78	d′′′′	D7	2349.32
             */
            @"D7",
            /*77	c♯′′′′/d♭′′′′	C♯7/D♭7	2217.46
             */
            @"C♯7",
            /*76	c′′′′ 4-line octave	C7 Double high C	2093.00
             */
            @"C7",
            /*75	b′′′	B6	1975.53
             */
            @"B6",
            /*74	a♯′′′/b♭′′′	A♯6/B♭6	1864.66
             */
            @"A♯6",
            /*73	a′′′	A6	1760.00
             */
            @"A6",
            /*72	g♯′′′/a♭′′′	G♯6/A♭6	1661.22
             */
            @"G♯6",
            /*71	g′′′	G6	1567.98
             */
            @"G6",
            /*70	f♯′′′/g♭′′′	F♯6/G♭6	1479.98
             */
            @"F♯6",
            /*69	f′′′	F6	1396.91
             */
            @"F6",
            /*68	e′′′	E6	1318.51
             */
            @"E6",
            /*67	d♯′′′/e♭′′′	D♯6/E♭6	1244.51
             */
            @"D♯6",
            /*66	d′′′	D6	1174.66
             */
            @"D6",
            /*65	c♯′′′/d♭′′′	C♯6/D♭6	1108.73
             */
            @"C♯6",
            /*64	c′′′ 3-line octave	C6 Soprano C (High C)	1046.50
             */
            @"C6",
            /*63	b′′	B5	987.767
             */
            @"B5",
            /*62	a♯′′/b♭′′	A♯5/B♭5	932.328
             */
            @"A♯5",
            /*61	a′′	A5	880.000
             */
            @"A5",
            /*60	g♯′′/a♭′′	G♯5/A♭5	830.609
             */
            @"G♯5",
            /*59	g′′	G5	783.991
             */
            @"G5",
            /*58	f♯′′/g♭′′	F♯5/G♭5	739.989
             */
            @"F♯5",
            /*57	f′′	F5	698.456
             */
            @"F5",
            /*56	e′′	E5	659.255	E
             */
            @"E5",
            /*55	d♯′′/e♭′′	D♯5/E♭5	622.254
             */
            @"D♯5",
            /*54	d′′	D5	587.330
             */
            @"D5",
            /*53	c♯′′/d♭′′	C♯5/D♭5	554.365
             */
            @"C♯5",
            /*52	c′′ 2-line octave	C5 Tenor C	523.251
             */
            @"C5",
            /*51	b′	B4	493.883
             */
            @"B4",
            /*50	a♯′/b♭′	A♯4/B♭4	466.164
             */
            @"A♯4",
            /*49	a′	A4 A440	440.000	A	A
             * High A (Optional)
             */
            @"A4",
            /*48	g♯′/a♭′	G♯4/A♭4	415.305
             */
            @"G♯4",
            /*47	g′	G4	391.995
             */
            @"G4",
            /*46	f♯′/g♭′	F♯4/G♭4	369.994
             */
            @"F♯4",
            /*45	f′	F4	349.228
             */
            @"F4",
            /*44	e′	E4	329.628					High E
             */
            @"E4",
            /*43	d♯′/e♭′	D♯4/E♭4	311.127
             */
            @"D♯4",
            /*42	d′	D4	293.665	D	D
             */
            @"D4",
            /*41	c♯′/d♭′	C♯4/D♭4	277.183
             */
            @"C♯4",
            /*40	c′ 1-line octave	C4 Middle C	261.626
             */
            @"C4",
            /*39	b	B3	246.942					B
             */
            @"B3",
            /*38	a♯/b♭	A♯3/B♭3	233.082
             */
            @"A♯3",
            /*37	a	A3	220.000			A
             */
            @"A3",
            /*36	g♯/a♭	G♯3/A♭3	207.652
             */
            @"G♯3",
            /*35	g	G3	195.998	G	G			G
             */
            @"G3",
            /*34	f♯/g♭	F♯3/G♭3	184.997
             */
            @"F♯3",
            /*33	f	F3	174.614				F (7 string)
             */
            @"F3",
            /*32	e	E3	164.814
             */
            @"E3",
            /*31	d♯/e♭	D♯3/E♭3	155.563
             */
            @"D♯3",
            /*30	d	D3	146.832			D		D
             */
            @"D3",
            /*29	c♯/d♭	C♯3/D♭3	138.591
             */
            @"C♯3",
            /*28	c small octave	C3 Low C	130.813	C (5
             * string)	C		C (6 string)
             */
            @"C3",
            /*27	B	B2	123.471
             */
            @"B2",
            /*26	A♯/B♭	A♯2/B♭2	116.541
             */
            @"A♯2",
            /*25	A	A2	110.000					A
             */
            @"A2",
            /*24	G♯/A♭	G♯2/A♭2	103.826
             */
            @"G♯2",
            /*23	G	G2	97.9989			G	G
             */
            @"G2",
            /*22	F♯/G♭	F♯2/G♭2	92.4986
             */
            @"F♯2",
            /*21	F	F2	87.3071	F (6 string)
             */
            @"F2",
            /*20	E	E2	82.4069					Low E
             */
            @"E2",
            /*19	D♯/E♭	D♯2/E♭2	77.7817
             */
            @"D♯2",
            /*18	D	D2	73.4162				D
             */
            @"D2",
            /*17	C♯/D♭	C♯2/D♭2	69.2957
             */
            @"C♯2",
            /*16	C great octave	C2 Deep C	65.4064			C
             */
            @"C2",
            /*15	B͵	B1	61.7354 B (7 string)
             */
            @"B1",
            /*14	A♯͵/B♭͵	A♯1/B♭1	58.2705	B♭ (7 string)
             */
            @"A♯1",
            /*13	A͵	A1	55.0000				A
             */
            @"A1",
            /*12	G♯͵/A♭͵	G♯1/A♭1	51.9131
             */
            @"G♯1",
            /*11	G͵	G1	48.9994
             */
            @"G1",
            /*10	F♯͵/G♭͵	F♯1/G♭1	46.2493
             * F♯ (8 string)
             */
            @"F♯1",
            /*9	F͵	F1	43.6535
             */
            @"F1",
            /*8	E͵	E1	41.2034				E
             */
            @"E1",
            /*7	D♯͵/E♭͵	D♯1/E♭1	38.8909
             */
            @"D♯1",
            /*6	D͵	D1	36.7081
             */
            @"D1",
            /*5	C♯͵/D♭͵	C♯1/D♭1	34.6478 C♯ (9 string)
             */
            @"C♯1",
            /*4	C͵ contra-octave	C1 Pedal C	32.7032
             */
            @"C1",
            /*3	B͵͵	B0	30.8677				B (5 string)
             */
            @"B",
            /*2	A♯͵͵/B♭͵͵	A♯0/B♭0	29.1352
             */
            @"A♯0",
            /*1	A͵͵ sub-contra-octave	A0 Double Pedal A	27.5000
             */
            @"A0",
        ];
        _pianoLabels = [_pianoLabels reversedArray];
    }
    return _pianoLabels;
}

+ (NSDictionary*)pitchForClefDictionary
{
    if(!_pitchForClefDictionary)
    {
        _pitchForClefDictionary = @{
            @"g4" : @(46),   // g clef
            @"f3" : @(32),   // f clef
            @"c4" : @(39),
            /* c flef    */
        };
    }
    return _pitchForClefDictionary;
}

+ (NSArray*)integerToNoteArray
{
    if(!_integerToNoteArray)
    {
        _integerToNoteArray = @[ @"C", @"C#", @"D", @"D#", @"E", @"F", @"F#", @"G", @"G#", @"A", @"A#", @"B" ];
    }
    return _integerToNoteArray;
}

+ (NSDictionary*)integerToNoteDictionary
{
    if(!_integerToNoteDictionary)
    {
        _integerToNoteDictionary = @{
            @(0) : @"C",
            @(1) : @"C#",
            @(2) : @"D",
            @(3) : @"D#",
            @(4) : @"E",
            @(5) : @"F",
            @(6) : @"F#",
            @(7) : @"G",
            @(8) : @"G#",
            @(9) : @"A",
            @(10) : @"A#",
            @(11) : @"B",
        };
    }
    return _integerToNoteDictionary;
}

//+ (NSDictionary *)keyNoteValuesDictionary {
//    if (!_keyNoteValuesDictionary) {
//
//
//        NSMutableDictionary *dict = [@{ @"C"   : [[NoteValue
//        alloc]initWithIndex:0 andIntVal:0 andAccidental:nil],
//                                        @"CN"  : [[NoteValue
//                                        alloc]initWithIndex:0 andIntVal:0
//                                        andAccidental:@"n"],
//                                        @"C#"  : [[NoteValue
//                                        alloc]initWithIndex:0 andIntVal:1
//                                        andAccidental:@"#"],
//                                        @"C##" : [[NoteValue
//                                        alloc]initWithIndex:0 andIntVal:2
//                                        andAccidental:@"##"],
//                                        @"CB"  : [[NoteValue
//                                        alloc]initWithIndex:0 andIntVal:-1
//                                        andAccidental:@"b"],
//                                        @"CBB" : [[NoteValue
//                                        alloc]initWithIndex:0 andIntVal:-2
//                                        andAccidental:@"bb"],
//                                        @"D"   : [[NoteValue
//                                        alloc]initWithIndex:1 andIntVal:2
//                                        andAccidental:nil],
//                                        @"DN"  : [[NoteValue
//                                        alloc]initWithIndex:1 andIntVal:2
//                                        andAccidental:@"n"],
//                                        @"D#"  : [[NoteValue
//                                        alloc]initWithIndex:1 andIntVal:3
//                                        andAccidental:@"#"],
//                                        @"D##" : [[NoteValue
//                                        alloc]initWithIndex:1 andIntVal:4
//                                        andAccidental:@"##"],
//                                        @"DB"  : [[NoteValue
//                                        alloc]initWithIndex:1 andIntVal:1
//                                        andAccidental:@"b"],
//                                        @"DBB" : [[NoteValue
//                                        alloc]initWithIndex:1 andIntVal:0
//                                        andAccidental:@"bb"],
//                                        @"E"   : [[NoteValue
//                                        alloc]initWithIndex:2 andIntVal:4
//                                        andAccidental:nil],
//                                        @"EN"  : [[NoteValue
//                                        alloc]initWithIndex:2 andIntVal:4
//                                        andAccidental:@"n"],
//                                        @"E#"  : [[NoteValue
//                                        alloc]initWithIndex:2 andIntVal:5
//                                        andAccidental:@"#"],
//                                        @"E##" : [[NoteValue
//                                        alloc]initWithIndex:2 andIntVal:6
//                                        andAccidental:@"##"],
//                                        @"EB"  : [[NoteValue
//                                        alloc]initWithIndex:2 andIntVal:3
//                                        andAccidental:@"b"],
//                                        @"EBB" : [[NoteValue
//                                        alloc]initWithIndex:2 andIntVal:2
//                                        andAccidental:@"bb"],
//                                        @"F"   : [[NoteValue
//                                        alloc]initWithIndex:3 andIntVal:5
//                                        andAccidental:nil],
//                                        @"FN"  : [[NoteValue
//                                        alloc]initWithIndex:3 andIntVal:5
//                                        andAccidental:@"n"],
//                                        @"F#"  : [[NoteValue
//                                        alloc]initWithIndex:3 andIntVal:6
//                                        andAccidental:@"#"],
//                                        @"F##" : [[NoteValue
//                                        alloc]initWithIndex:3 andIntVal:7
//                                        andAccidental:@"##"],
//                                        @"FB"  : [[NoteValue
//                                        alloc]initWithIndex:3 andIntVal:4
//                                        andAccidental:@"b"],
//                                        @"FBB" : [[NoteValue
//                                        alloc]initWithIndex:3 andIntVal:3
//                                        andAccidental:@"bb"],
//                                        @"G"   : [[NoteValue
//                                        alloc]initWithIndex:4 andIntVal:7
//                                        andAccidental:nil],
//                                        @"GN"  : [[NoteValue
//                                        alloc]initWithIndex:4 andIntVal:7
//                                        andAccidental:@"n"],
//                                        @"G#"  : [[NoteValue
//                                        alloc]initWithIndex:4 andIntVal:8
//                                        andAccidental:@"#"],
//                                        @"G##" : [[NoteValue
//                                        alloc]initWithIndex:4 andIntVal:9
//                                        andAccidental:@"##"],
//                                        @"GB"  : [[NoteValue
//                                        alloc]initWithIndex:4 andIntVal:6
//                                        andAccidental:@"b"],
//                                        @"GBB" : [[NoteValue
//                                        alloc]initWithIndex:4 andIntVal:5
//                                        andAccidental:@"bb"],
//                                        @"A"   : [[NoteValue
//                                        alloc]initWithIndex:5 andIntVal:9
//                                        andAccidental:nil],
//                                        @"AN"  : [[NoteValue
//                                        alloc]initWithIndex:5 andIntVal:9
//                                        andAccidental:@"n"],
//                                        @"A#"  : [[NoteValue
//                                        alloc]initWithIndex:5 andIntVal:10
//                                        andAccidental:@"#"],
//                                        @"A##" : [[NoteValue
//                                        alloc]initWithIndex:5 andIntVal:11
//                                        andAccidental:@"##"],
//                                        @"AB"  : [[NoteValue
//                                        alloc]initWithIndex:5 andIntVal:8
//                                        andAccidental:@"b"],
//                                        @"ABB" : [[NoteValue
//                                        alloc]initWithIndex:5 andIntVal:7
//                                        andAccidental:@"bb"],
//                                        @"B"   : [[NoteValue
//                                        alloc]initWithIndex:6 andIntVal:11
//                                        andAccidental:nil],
//                                        @"BN"  : [[NoteValue
//                                        alloc]initWithIndex:6 andIntVal:11
//                                        andAccidental:@"n"],
//                                        @"B#"  : [[NoteValue
//                                        alloc]initWithIndex:6 andIntVal:12
//                                        andAccidental:@"#"],
//                                        @"B##" : [[NoteValue
//                                        alloc]initWithIndex:6 andIntVal:13
//                                        andAccidental:@"##"],
//                                        @"BB"  : [[NoteValue
//                                        alloc]initWithIndex:6 andIntVal:10
//                                        andAccidental:@"b"],
//                                        @"BBB" : [[NoteValue
//                                        alloc]initWithIndex:6 andIntVal:9
//                                        andAccidental:@"bb"],
//                                      } mutableCopy];
//
//        NoteValue *rv = [[NoteValue alloc]initWithIndex:6 andIntVal:9
//        andAccidental:nil];
//        rv.isRest = YES;
//        [dict setObject:rv forKey:@"R"];
//        NoteValue *nv = [[NoteValue alloc]initWithIndex:6 andIntVal:0
//        andAccidental:nil];
//        nv.octave = 4;
//        nv.code = @"v3e";
//        nv.shiftRight = 5.5;
//        nv.isRest = YES;
//        [dict setObject:nv forKey:@"X"];
//
//        _keyNoteValuesDictionary = [NSDictionary
//        dictionaryWithDictionary:dict];
//    }
//    return _keyNoteValuesDictionary;
//}

+ (NSArray*)keyPropertiesArray;
{
    _keyPropertiesArray = @[];
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return _keyPropertiesArray;
}

+ (NSDictionary*)keySpecsDictionary
{
    if(!_keySpecsDictionary)
    {
        _keySpecsDictionary = @{
            @"C" : @{@"acc" : [NSNull null], @"num" : @(0)},
            @"Am" : @{@"acc" : [NSNull null], @"num" : @(0)},
            @"F" : @{@"acc" : @"b", @"num" : @(1)},
            @"Dm" : @{@"acc" : @"b", @"num" : @(1)},
            @"Bb" : @{@"acc" : @"b", @"num" : @(2)},
            @"Gm" : @{@"acc" : @"b", @"num" : @(2)},
            @"Eb" : @{@"acc" : @"b", @"num" : @(3)},
            @"Cm" : @{@"acc" : @"b", @"num" : @(3)},
            @"Ab" : @{@"acc" : @"b", @"num" : @(4)},
            @"Fm" : @{@"acc" : @"b", @"num" : @(4)},
            @"Db" : @{@"acc" : @"b", @"num" : @(5)},
            @"Bbm" : @{@"acc" : @"b", @"num" : @(5)},
            @"Gb" : @{@"acc" : @"b", @"num" : @(6)},
            @"Ebm" : @{@"acc" : @"b", @"num" : @(6)},
            @"Cb" : @{@"acc" : @"b", @"num" : @(7)},
            @"Abm" : @{@"acc" : @"b", @"num" : @(7)},
            @"G" : @{@"acc" : @"#", @"num" : @(1)},
            @"Em" : @{@"acc" : @"#", @"num" : @(1)},
            @"D" : @{@"acc" : @"#", @"num" : @(2)},
            @"Bm" : @{@"acc" : @"#", @"num" : @(2)},
            @"A" : @{@"acc" : @"#", @"num" : @(3)},
            @"F#m" : @{@"acc" : @"#", @"num" : @(3)},
            @"E" : @{@"acc" : @"#", @"num" : @(4)},
            @"C#m" : @{@"acc" : @"#", @"num" : @(4)},
            @"B" : @{@"acc" : @"#", @"num" : @(5)},
            @"G#m" : @{@"acc" : @"#", @"num" : @(5)},
            @"F#" : @{@"acc" : @"#", @"num" : @(6)},
            @"D#m" : @{@"acc" : @"#", @"num" : @(6)},
            @"C#" : @{@"acc" : @"#", @"num" : @(7)},
            @"A#m" : @{@"acc" : @"#", @"num" : @(7)}
            //            @"C" : [[VFKeySignature alloc] initWithAcc:nil andNumber:0],
            //            @"Am" : [[VFKeySignature alloc] initWithAcc:nil
            //            andNumber:0],
            //            @"F" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:1],
            //            @"Dm" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:1],
            //            @"Bb" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:2],
            //            @"Gm" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:2],
            //            @"Eb" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:3],
            //            @"Cm" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:3],
            //            @"Ab" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:4],
            //            @"Fm" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:4],
            //            @"Db" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:5],
            //            @"Bbm" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:5],
            //            @"Gb" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:6],
            //            @"Ebm" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:6],
            //            @"Cb" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:7],
            //            @"Abm" : [[VFKeySignature alloc] initWithAcc:@"b"
            //            andNumber:7],
            //            @"G" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:1],
            //            @"Em" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:1],
            //            @"D" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:2],
            //            @"Bm" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:2],
            //            @"A" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:3],
            //            @"F#m" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:3],
            //            @"E" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:4],
            //            @"C#m" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:4],
            //            @"B" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:5],
            //            @"G#m" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:5],
            //            @"F#" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:6],
            //            @"D#m" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:6],
            //            @"C#" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:7],
            //            @"A#m" : [[VFKeySignature alloc] initWithAcc:@"#"
            //            andNumber:7],
        };
    }
    return _keySpecsDictionary;
}

/*!
 *  <#Description#>
 *  @param spec <#spec description#>
 *  @return an array of VFTablesAccListStruct
 */
+ (NSMutableArray*)keySignatureForSpec:(NSString*)spec
{
    VFTablesKeySpecStruct* keySpec =
        [[VFTablesKeySpecStruct alloc] initWithDictionary:VFTables.keySpecsDictionary[spec]];
    keySpec.acc = [keySpec.acc isEqualToString:@""] ? nil : keySpec.acc;

    if(!keySpec)
    {
        VFLogError("BadKeySignature, Bad key signature spec: '%@'", spec);
    }

    if(!keySpec.acc)
    {
        return [NSMutableArray array];
    }

    NSArray* notes = [VFTables accidentalListForAcc:keySpec.acc];

    NSMutableArray* acc_list = [NSMutableArray array];
    for(NSUInteger i = 0; i < keySpec.num; ++i)
    {
        float line = [notes[i] floatValue];
        [acc_list push:[[VFTablesAccListStruct alloc] initWithDictionary:@{
                      @"type" : keySpec.acc,
                      @"line" : @(line)
                  }]];
    }
    return acc_list;
}

+ (VFKeySignature*)keySignatureWithString:(NSString*)key
{
    if([key isEqualToString:@"C"])
    {
        return [[VFKeySignature alloc] initWithAcc:nil andNumber:0];
    }
    else if([key isEqualToString:@"Am"])
    {
        return [[VFKeySignature alloc] initWithAcc:nil andNumber:0];
    }
    else if([key isEqualToString:@"F"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:1];
    }
    else if([key isEqualToString:@"Dm"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:1];
    }
    else if([key isEqualToString:@"Bb"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:2];
    }
    else if([key isEqualToString:@"Gm"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:2];
    }
    else if([key isEqualToString:@"Eb"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:3];
    }
    else if([key isEqualToString:@"Cm"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:3];
    }
    else if([key isEqualToString:@"Ab"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:4];
    }
    else if([key isEqualToString:@"Fm"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:4];
    }
    else if([key isEqualToString:@"Db"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:5];
    }
    else if([key isEqualToString:@"Bbm"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:5];
    }
    else if([key isEqualToString:@"Gb"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:6];
    }
    else if([key isEqualToString:@"Ebm"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:6];
    }
    else if([key isEqualToString:@"Cb"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:7];
    }
    else if([key isEqualToString:@"Abm"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"b" andNumber:7];
    }
    else if([key isEqualToString:@"G"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:1];
    }
    else if([key isEqualToString:@"Em"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:1];
    }
    else if([key isEqualToString:@"D"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:2];
    }
    else if([key isEqualToString:@"Bm"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:2];
    }
    else if([key isEqualToString:@"A"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:3];
    }
    else if([key isEqualToString:@"F#m"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:3];
    }
    else if([key isEqualToString:@"E"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:4];
    }
    else if([key isEqualToString:@"C#m"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:4];
    }
    else if([key isEqualToString:@"B"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:5];
    }
    else if([key isEqualToString:@"G#m"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:5];
    }
    else if([key isEqualToString:@"F#"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:6];
    }
    else if([key isEqualToString:@"D#m"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:6];
    }
    else if([key isEqualToString:@"C#"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:7];
    }
    else if([key isEqualToString:@"A#m"])
    {
        return [[VFKeySignature alloc] initWithAcc:@"#" andNumber:7];
    }
    else
    {
        [VFLog logError:@"UnknownKeySignatureSpecifier, unrecognized key signature " @"specifier."];
    }
    [VFLog logError:@"UnknownKeySignatureSpecifier, returning nil."];
    return nil;
}

+ (NSDictionary*)noteGlyphsDictionary
{
    if(!_noteGlyphsDictionary)
    {
        _noteGlyphsDictionary = @{
            //    * Diamond *
            @"D0" : [NoteGlyph noteGlyphWithCode:@"v27" andShiftRight:-0.5],
            @"D1" : [NoteGlyph noteGlyphWithCode:@"v2d" andShiftRight:-0.5],
            @"D2" : [NoteGlyph noteGlyphWithCode:@"v22" andShiftRight:-0.5],
            @"D3" : [NoteGlyph noteGlyphWithCode:@"v70" andShiftRight:-0.5],
            //     Triangle *
            @"T0" : [NoteGlyph noteGlyphWithCode:@"v49" andShiftRight:-2],
            @"T1" : [NoteGlyph noteGlyphWithCode:@"v93" andShiftRight:0.5],
            @"T2" : [NoteGlyph noteGlyphWithCode:@"v40" andShiftRight:0.5],
            @"T3" : [NoteGlyph noteGlyphWithCode:@"v7d" andShiftRight:0.5],
            //    * Cross *
            @"X0" : [NoteGlyph noteGlyphWithCode:@"v92" andShiftRight:-2],
            @"X1" : [NoteGlyph noteGlyphWithCode:@"v95" andShiftRight:-0.5],
            @"X2" : [NoteGlyph noteGlyphWithCode:@"v7f" andShiftRight:0.5],
            @"X3" : [NoteGlyph noteGlyphWithCode:@"v3b" andShiftRight:-2],
        };
    }
    return _noteGlyphsDictionary;
}

+ (NSDictionary*)noteTypesDictionary
{
    if(!_noteTypesDictionary)
    {
        _noteTypesDictionary = @{
            @"w" : @(VFDurationWholeNote),
            @"h" : @(VFDurationHalfNote),
            @"q" : @(VFDurationQuarterNote),
            @"8" : @(VFDurationEighthNote),
            @"16" : @(VFDurationSixteenthNote),
            @"32" : @(VFDurationThirtyTwoNote),
            @"64" : @(VFDurationSixtyFourNote),
        };
    }
    return _noteTypesDictionary;
}

#pragma mark - Class Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Class Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (NSArray*)accidentalListForAcc:(NSString*)accidental
{
    if([accidental isEqualToString:@"b"])
    {
        return @[
            @(2),
            @(0.5),
            @(2.5),
            @(1),
            @(3),
            @(1.5),
            @(3.5),
        ];
    }
    else if([accidental isEqualToString:@"#"])
    {
        return @[
            @(0),
            @(1.5),
            @(-0.5),
            @(1),
            @(2.5),
            @(0.5),
            @(2),
        ];
    }
    else
    {
        [VFLog logError:@"Unrecognized acc sent to accidental list for acc."];
        return nil;
    }
}

static NSDictionary* _durationCodesDictionary;

+ (NSDictionary*)durationCodesDictionary
{
    if(!_durationCodesDictionary)
    {
        _durationCodesDictionary = @{
            @(VFDurationBreveNote) : @{
                @"common" : @{
                    @"head_width" : @(22),
                    @"stem" : @(NO),
                    @"stem_offset" : @(0),
                    @"flag" : @(NO),
                    @"stem_up_extension" : @(-kSTEM_HEIGHT),
                    @"stem_down_extension" : @(-kSTEM_HEIGHT),
                    @"gracenote_stem_up_extension" : @(-kSTEM_HEIGHT),
                    @"gracenote_stem_down_extension" : @(-kSTEM_HEIGHT),
                    @"tabnote_stem_up_extension" : @(-kSTEM_HEIGHT),
                    @"tabnote_stem_down_extension" : @(-kSTEM_HEIGHT),
                    @"dot_shiftY" : @(0),
                    @"line_above" : @(0),
                    @"line_below" : @(0)
                },
                @"type" : @{
                    @(VFNoteNote) : @{
                        // Breve note
                        @"code_head" : @"v53"
                    },
                    @(VFNoteHarmonic) : @{
                        // Breve note harmonic
                        @"code_head" : @"v59"
                    },
                    @(VFNoteMuted) : @{
                        // Breve note muted -
                        @"code_head" : @"vf",
                        @"stem_offset" : @(0)
                    },
                    @(VFNoteRest) : @{
                        // Breve rest
                        @"code_head" : @"v31",
                        @"head_width" : @(24),
                        @"rest" : @(YES),
                        @"position" : @"B/5",
                        @"dot_shiftY" : @(0.5)
                    },
                    @(VFNoteSlash) : @{
                        // Breve note slash -
                        // Drawn with canvas primitives
                        @"head_width" : @(15),
                        @"position" : @"B/4"
                    }
                }
            },
            @(VFDurationWholeNote) : @{
                @"common" : @{
                    @"head_width" : @(16),
                    @"stem" : @(NO),
                    @"stem_offset" : @(0),
                    @"flag" : @(NO),
                    @"stem_up_extension" : @(-kSTEM_HEIGHT),
                    @"stem_down_extension" : @(-kSTEM_HEIGHT),
                    @"gracenote_stem_up_extension" : @(-kSTEM_HEIGHT),
                    @"gracenote_stem_down_extension" : @(-kSTEM_HEIGHT),
                    @"tabnote_stem_up_extension" : @(-kSTEM_HEIGHT),
                    @"tabnote_stem_down_extension" : @(-kSTEM_HEIGHT),
                    @"dot_shiftY" : @(0),
                    @"dot_shiftY" : @(0),
                    @"line_below" : @(0)
                },
                @"type" : @{
                    @(VFNoteNote) : @{
                        // Whole note
                        @"code_head" : @"v1d"
                    },
                    @(VFNoteHarmonic) : @{
                        // Whole note harmonic
                        @"code_head" : @"v46"
                    },
                    @(VFNoteMuted) : @{
                        // Whole note muted
                        @"code_head" : @"v92",
                        @"stem_offset" : @(-3)
                    },
                    @(VFNoteRest) : @{
                        // Whole rest
                        @"code_head" : @"v5c",
                        @"head_width" : @(12),
                        @"rest" : @(YES),
                        @"position" : @"D/5",
                        @"dot_shiftY" : @(0.5)
                    },
                    @(VFNoteSlash) : @{
                        // Whole note slash
                        // Drawn with canvas primitives
                        @"head_width" : @(15),
                        @"position" : @"B/4"
                    }
                }
            },
            @(VFDurationHalfNote) : @{
                @"common" : @{
                    @"head_width" : @(10),
                    @"stem" : @(YES),
                    @"stem_offset" : @(0),
                    @"flag" : @(NO),
                    @"stem_up_extension" : @(0),
                    @"stem_down_extension" : @(0),
                    @"gracenote_stem_up_extension" : @(-14),
                    @"gracenote_stem_down_extension" : @(-14),
                    @"tabnote_stem_up_extension" : @(0),
                    @"tabnote_stem_down_extension" : @(0),
                    @"dot_shiftY" : @(0),
                    @"line_above" : @(0),
                    @"line_below" : @(0)
                },
                @"type" : @{
                    @(VFNoteNote) : @{
                        // Half note
                        @"code_head" : @"v81"
                    },
                    @(VFNoteHarmonic) : @{
                        // Half note harmonic
                        @"code_head" : @"v2d"
                    },
                    @(VFNoteMuted) : @{
                        // Half note muted
                        @"code_head" : @"v95",
                        @"stem_offset" : @(-3)
                    },
                    @(VFNoteRest) : @{
                        // Half rest
                        @"code_head" : @"vc",
                        @"head_width" : @(12),
                        @"stem" : @(NO),
                        @"rest" : @(YES),
                        @"position" : @"B/4",
                        @"dot_shiftY" : @(-0.5)
                    },
                    @(VFNoteSlash) : @{
                        // Half note slash
                        // Drawn with canvas primitives
                        @"head_width" : @(15),
                        @"position" : @"B/4"
                    }
                }
            },
            @(VFDurationQuarterNote) : @{
                @"common" : @{
                    @"head_width" : @(10),
                    @"stem" : @(YES),
                    @"stem_offset" : @(0),
                    @"flag" : @(NO),
                    @"stem_up_extension" : @(0),
                    @"stem_down_extension" : @(0),
                    @"gracenote_stem_up_extension" : @(-14),
                    @"gracenote_stem_down_extension" : @(-14),
                    @"tabnote_stem_up_extension" : @(0),
                    @"tabnote_stem_down_extension" : @(0),
                    @"dot_shiftY" : @(0),
                    @"dot_shiftY" : @(0),
                    @"line_below" : @(0)
                },
                @"type" : @{
                    @(VFNoteNote) : @{
                        // Quarter note
                        @"code_head" : @"vb"
                    },
                    @(VFNoteHarmonic) : @{
                        // Quarter harmonic
                        @"code_head" : @"v22"
                    },
                    @(VFNoteMuted) : @{
                        // Quarter muted
                        @"code_head" : @"v3e",
                        @"stem_offset" : @(-3)
                    },
                    @(VFNoteRest) : @{
                        // Quarter rest
                        @"code_head" : @"v7c",
                        @"head_width" : @(8),
                        @"stem" : @(NO),
                        @"rest" : @(YES),
                        @"position" : @"B/4",
                        @"dot_shiftY" : @(-0.5),
                        @"line_above" : @(1.5),
                        @"line_below" : @(1.5)
                    },
                    @(VFNoteSlash) : @{
                        // Quarter slash
                        // Drawn with canvas primitives
                        @"head_width" : @(15),
                        @"position" : @"B/4"
                    }
                }
            },
            @(VFDurationEighthNote) : @{
                @"common" : @{
                    @"head_width" : @(10),
                    @"stem" : @(YES),
                    @"stem_offset" : @(0),
                    @"flag" : @(YES),
                    @"beam_count" : @(1),
                    @"code_flag_upstem" : @"v54",
                    @"code_flag_downstem" : @"v9a",
                    @"stem_up_extension" : @(0),
                    @"stem_down_extension" : @(0),
                    @"gracenote_stem_up_extension" : @(-14),
                    @"gracenote_stem_down_extension" : @(-14),
                    @"tabnote_stem_up_extension" : @(0),
                    @"tabnote_stem_down_extension" : @(0),
                    @"dot_shiftY" : @(0),
                    @"dot_shiftY" : @(0),
                    @"line_below" : @(0)
                },
                @"type" : @{
                    @(VFNoteNote) : @{
                        // Eighth note
                        @"code_head" : @"vb"
                    },
                    @(VFNoteHarmonic) : @{
                        // Eighth note harmonic
                        @"code_head" : @"v22"
                    },
                    @(VFNoteMuted) : @{
                        // Eighth note muted
                        @"code_head" : @"v3e"
                    },
                    @(VFNoteRest) : @{
                        // Eighth rest
                        @"code_head" : @"va5",
                        @"stem" : @(NO),
                        @"flag" : @(NO),
                        @"rest" : @(YES),
                        @"position" : @"B/4",
                        @"dot_shiftY" : @-0.5,
                        @"line_above" : @1.0,
                        @"line_below" : @1.0
                    },
                    @(VFNoteSlash) : @{
                        // Eight slash
                        // Drawn with canvas primitives
                        @"head_width" : @15,
                        @"position" : @"B/4"
                    }
                }
            },
            @(VFDurationSixteenthNote) : @{
                @"common" : @{
                    @"beam_count" : @(2),
                    @"head_width" : @(10),
                    @"stem" : @(YES),
                    @"stem_offset" : @(0),
                    @"flag" : @(YES),
                    @"code_flag_upstem" : @"v3f",
                    @"code_flag_downstem" : @"v8f",
                    @"stem_up_extension" : @(4),
                    @"stem_down_extension" : @(0),
                    @"gracenote_stem_up_extension" : @(-14),
                    @"gracenote_stem_down_extension" : @(-14),
                    @"tabnote_stem_up_extension" : @(0),
                    @"tabnote_stem_down_extension" : @(0),
                    @"dot_shiftY" : @(0),
                    @"dot_shiftY" : @(0),
                    @"line_below" : @(0)
                },
                @"type" : @{
                    @(VFNoteNote) : @{
                        // Sixteenth note
                        @"code_head" : @"vb"
                    },
                    @(VFNoteHarmonic) : @{
                        // Sixteenth note harmonic
                        @"code_head" : @"v22"
                    },
                    @(VFNoteMuted) : @{
                        // Sixteenth note muted
                        @"code_head" : @"v3e"
                    },
                    @(VFNoteRest) : @{
                        // Sixteenth rest
                        @"code_head" : @"v3c",
                        @"head_width" : @13,
                        @"stem" : @(NO),
                        @"flag" : @(NO),
                        @"rest" : @(YES),
                        @"position" : @"B/4",
                        @"dot_shiftY" : @(-0.5),
                        @"line_above" : @(1.0),
                        @"line_below" : @(2.0)
                    },
                    @(VFNoteSlash) : @{
                        // Sixteenth slash
                        // Drawn with canvas primitives
                        @"head_width" : @(15),
                        @"position" : @"B/4"
                    }
                }
            },
            @(VFDurationThirtyTwoNote) : @{
                @"common" : @{
                    @"beam_count" : @(3),
                    @"head_width" : @(10),
                    @"stem" : @(YES),
                    @"stem_offset" : @(0),
                    @"flag" : @(YES),
                    @"code_flag_upstem" : @"v47",
                    @"code_flag_downstem" : @"v2a",
                    @"stem_up_extension" : @(13),
                    @"stem_down_extension" : @(9),
                    @"gracenote_stem_up_extension" : @(-12),
                    @"gracenote_stem_down_extension" : @(-12),
                    @"tabnote_stem_up_extension" : @(9),
                    @"tabnote_stem_down_extension" : @(5),
                    @"dot_shiftY" : @(0),
                    @"dot_shiftY" : @(0),
                    @"line_below" : @(0)
                },
                @"type" : @{
                    @(VFNoteNote) : @{
                        // Thirty-second note
                        @"code_head" : @"vb"
                    },
                    @(VFNoteHarmonic) : @{
                        // Thirty-second harmonic
                        @"code_head" : @"v22"
                    },
                    @(VFNoteMuted) : @{
                        // Thirty-second muted
                        @"code_head" : @"v3e"
                    },
                    @(VFNoteRest) : @{
                        // Thirty-second rest
                        @"code_head" : @"v55",
                        @"head_width" : @16,
                        @"stem" : @(NO),
                        @"flag" : @(NO),
                        @"rest" : @(YES),
                        @"position" : @"B/4",
                        @"dot_shiftY" : @(-1.5),
                        @"line_above" : @(2.0),
                        @"line_below" : @(2.0)
                    },
                    @(VFNoteSlash) : @{
                        // Thirty-second slash
                        // Drawn with canvas primitives
                        @"head_width" : @(15),
                        @"position" : @"B/4"
                    }
                }
            },
            @(VFDurationSixtyFourNote) : @{
                @"common" : @{
                    @"beam_count" : @(4),
                    @"head_width" : @(10),
                    @"stem" : @(YES),
                    @"stem_offset" : @(0),
                    @"flag" : @(YES),
                    @"code_flag_upstem" : @"va9",
                    @"code_flag_downstem" : @"v58",
                    @"stem_up_extension" : @(17),
                    @"stem_down_extension" : @(13),
                    @"gracenote_stem_up_extension" : @(-10),
                    @"gracenote_stem_down_extension" : @(-10),
                    @"tabnote_stem_up_extension" : @(13),
                    @"tabnote_stem_down_extension" : @(9),
                    @"dot_shiftY" : @(0),
                    @"line_above" : @(0),
                    @"line_below" : @(0)
                },
                @"type" : @{
                    @(VFNoteNote) : @{
                        // Sixty-fourth note
                        @"code_head" : @"vb"
                    },
                    @(VFNoteHarmonic) : @{
                        // Sixty-fourth harmonic
                        @"code_head" : @"v22"
                    },
                    @(VFNoteMuted) : @{
                        // Sixty-fourth muted
                        @"code_head" : @"v3e"
                    },
                    @(VFNoteRest) : @{
                        // Sixty-fourth rest
                        @"code_head" : @"v38",
                        @"head_width" : @(18),
                        @"stem" : @(NO),
                        @"flag" : @(NO),
                        @"rest" : @(YES),
                        @"position" : @"B/4",
                        @"dot_shiftY" : @(-1.5),
                        @"line_above" : @(2.0),
                        @"line_below" : @(3.0)
                    },
                    @(VFNoteSlash) : @{
                        // Sixty-fourth slash
                        // Drawn with canvas primitives
                        @"head_width" : @(15),
                        @"position" : @"B/4"
                    }
                }
            },
            @(VFDurationOneTwentyEightNote) : @{
                @"common" : @{
                    @"beam_count" : @(5),
                    @"head_width" : @(10),
                    @"stem" : @(YES),
                    @"stem_offset" : @(0),
                    @"flag" : @(YES),
                    @"code_flag_upstem" : @"v9b",
                    @"code_flag_downstem" : @"v30",
                    @"stem_up_extension" : @(26),
                    @"stem_down_extension" : @(22),
                    @"gracenote_stem_up_extension" : @(-8),
                    @"gracenote_stem_down_extension" : @(-8),
                    @"tabnote_stem_up_extension" : @(22),
                    @"tabnote_stem_down_extension" : @(18),
                    @"dot_shiftY" : @(0),
                    @"line_above" : @(0),
                    @"line_below" : @(0)
                },
                @"type" : @{
                    @(VFNoteNote) : @{
                        // Hundred-twenty-eight note
                        @"code_head" : @"vb"
                    },
                    @(VFNoteHarmonic) : @{
                        // Hundred-twenty-eight harmonic
                        @"code_head" : @"v22"
                    },
                    @(VFNoteMuted) : @{
                        // Hundred-twenty-eight muted
                        @"code_head" : @"v3e"
                    },
                    @(VFNoteRest) : @{
                        // Hundred-twenty-eight rest
                        @"code_head" : @"vaa",
                        @"head_width" : @(20),
                        @"stem" : @(NO),
                        @"flag" : @(NO),
                        @"rest" : @(YES),
                        @"position" : @"B/4",
                        @"dot_shiftY" : @(1.5),
                        @"line_above" : @(3.0),
                        @"line_below" : @(3.0)
                    },
                    @(VFNoteSlash) : @{
                        // Hundred-twenty-eight rest
                        // Drawn with canvas primitives
                        @"head_width" : @(15),
                        @"position" : @"B/4"
                    }
                }
            }
        };
    }
    return _durationCodesDictionary;
}

// duration is note length: quarter, half, whole, etc. notetype is n h r m s
//+ (VFGlyph*)durationToGlyph:(NSString*)noteDurationString
// withNHMRSNoteType:(NSString*)noteTypeString;
//{
//    VFNoteDurationType noteDurationType = [VFEnum
//    typeNoteDurationTypeForString:noteDurationString];
//    VFNoteNHMRSType noteNHMRSType = [VFEnum
//    typeNoteNHMRSTypeForString:noteTypeString];
//    return [VFTables durationToGlyph:noteDurationType
//    withNHMRSType:noteNHMRSType];
//}
//
//+ (VFGlyph*)durationToGlyph:(VFNoteDurationType)noteDurationType
// withNHMRSType:(VFNoteNHMRSType)noteNHMRSType;
//{
//    VFGlyph* glyph = [[VFGlyph alloc] init];
//    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
//    return glyph;
//}

+ (VFTablesGlyphStruct*)durationToGlyphStruct:(NSString*)noteDurationString;
{
    // assume that using normal note if noteNHSMSString is not specified
    return [VFTables durationToGlyphStruct:noteDurationString withNHMRSNoteString:@"n"];
}

+ (VFTablesGlyphStruct*)durationToGlyphStruct:(NSString*)noteDurationString
                          withNHMRSNoteString:(NSString*)noteNHSMSString;
{
    VFNoteDurationType noteDurationType = [VFEnum typeNoteDurationTypeForString:noteDurationString];
    VFNoteNHMRSType noteNHMRSType = [VFEnum typeNoteNHMRSTypeForString:noteNHSMSString];
    return [VFTables durationToGlyphStruct:noteDurationType withNHMRSType:noteNHMRSType];
}

+ (VFTablesGlyphStruct*)durationToGlyphStruct:(VFNoteDurationType)noteDurationType
                                withNHMRSType:(VFNoteNHMRSType)noteNHMRSType;
{
    NSDictionary* code = VFTables.durationCodesDictionary[@(noteDurationType)];
    if(!code)
    {
        VFLogError(@"empty code for VFTables.durationCodesDictionary");
        return nil;
    }
    noteNHMRSType = (noteNHMRSType == VFNoteNone) ? VFNoteNote : noteNHMRSType;
    NSDictionary* mergedDict = [NSMutableDictionary merge:code[@"common"] with:code[@"type"][@(noteNHMRSType)]];
    VFTablesGlyphStruct* ret = [[VFTablesGlyphStruct alloc] initWithDictionary:mergedDict];
    ret.noteNHMRSType = noteNHMRSType;
    return ret;
}

+ (VFGlyphTabStruct*)glyphForTab:(NSNumber*)fret;
{
    /*
     Vex.Flow.tabToGlyph = function(fret) {
     var glyph = null;
     var width = 0;
     var shift_y = 0;

     if (fret.toString().toUpperCase() == @"X") {
     glyph = @"v7f";
     width = 7;
     shift_y = -4.5;
     } else {
     width = Vex.Flow.textWidth(fret.toString());
     }

     */

    NSString* glyphCode = nil;   //[NSNull null];
    float width = 0;
    float shift_y = 0;

    // TODO: convert all the @{str fret} dicts to have fret be a string?
    if([[[fret stringValue] uppercaseString] isEqualToString:@"X"])
    {
        glyphCode = @"v7f";
        width = 7;
        shift_y = -4.5;
    }
    else
    {
        width = [VFTables textWidthForText:[fret stringValue]];   // Vex.Flow.textWidth(fret.toString());
    }

    VFGlyphTabStruct* ret = [[VFGlyphTabStruct alloc] initWithDictionary:@{
        @"text" : fret,
        @"code" : (glyphCode != nil ? glyphCode : [NSNull null]),
        @"width" : @(width),
        @"shift_y" : @(shift_y)
    }];

    return ret;
}

// http://www.angelfire.com/in2/yala/t4scales.htm

+ (KeyProperty*)keyPropertiesForKey:(NSString*)key andClefString:(NSString*)clefTypeString
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return nil;
}

+ (KeyProperty*)keyPropertiesForKey:(NSString*)key andClef:(VFClefType)clefType andOptions:(NSDictionary*)params;
{
    // TODO: what if params passes in @{@"octave_shift" : @0}; ?

    if(params)
    {
        if(![params.allKeys containsObject:@"octave_shift"])
        {
            NSDictionary* options = @{@"octave_shift" : @0};
            params = [NSMutableDictionary merge:options with:params];
        }
    }

    NSArray* pieces = [key split:@"/"];

    if(pieces.count < 2)
    {
        VFLogError(@"BadArguments, Key must have note + octave and an optional glyph: %@", key);
    }

    NSString* k = [pieces[0] uppercaseString];
    NSDictionary* value = [VFTables.noteValues objectForKey:k];
    if(!value)
    {
        VFLogError(@"BadArguments, Invalid key name: %@", k);
    }

    float o = [pieces[1] floatValue];

    // Octave_shift is the shift to compensate for clef 8va/8vb.
    o += -1 * [params[@"octave_shift"] floatValue];

    //    if(value[@"octave"])
    //    {
    //        o = [value[@"octave"] floatValue];
    //    }
    //    else
    //    {
    //        o = ((NSString*)pieces[1]).floatValue;
    //    }

    // Octave_shift is the shift to compensate for clef 8va/8vb.
    float base_index = (o * 7) - (4 * 7);
    float line = (base_index + [value[@"index"] floatValue]) / 2;
    NSString* clefName = [VFClef clefNameForType:clefType];
    line += [((VFTables.clefProperties[clefName])[@"line_shift"])floatValue];

    NSInteger stroke = 0;

    if(line <= 0 && (fmodf((line * 2.), 2.f) == 0))
    {
        stroke = VFStrokeDirectionUp;   // stroke up
    }
    if(line >= 6 && (fmodf((line * 2.f), 2.f) == 0))
    {
        stroke = VFStrokeDirectionDown;   // stroke down
    }

    //    // Integer value for note arithmetic.
    //    var int_value = (typeof(value.int_val)!='undefined') ? (o * 12) +
    //    value.int_val : null;

    // integer value for note arithmetic
    NSInteger intValue = (value[@"int_val"] == [NSNull null])
                             ? ([value[@"octave"] integerValue] * 12) + [value[@"int_Val"] integerValue]
                             : 0;

    //   * Check if the user specified a glyph. *
    NSString* code = value[@"code"];
    NSUInteger shiftRight = [value[@"shift_right"] unsignedIntegerValue];
    if(pieces.count > 2 && pieces[2])
    {
        NSString* match = pieces[2];
        NSString* glyphName = [match uppercaseString];
        NoteGlyph* noteGlyph = [VFTables.noteGlyphsDictionary objectForKey:glyphName];
        if(noteGlyph)
        {
            code = noteGlyph.code;
            shiftRight = noteGlyph.shiftRight;
        }
    }

    KeyProperty* ret = [[KeyProperty alloc] initWithKey:key andClefType:clefType andOptionsDict:nil];

    ret.key = k;
    ret.octave = o;
    ret.line = line;
    ret.intValue = intValue;
    ret.accidental = value[@"accidenal"];
    ret.glyphCode = code;
    ret.stroke = stroke;
    ret.shiftRight = shiftRight;
    ret.displaced = NO;

    return ret;
}

static NSDictionary* _noteValues;
+ (NSDictionary*)noteValues
{
    if(!_noteValues)
    {
        _noteValues = @{
            @"C" : @{@"index" : @0, @"int_val" : @0, @"accidental" : [NSNull null]},
            @"CN" : @{@"index" : @0, @"int_val" : @0, @"accidental" : @"n"},
            @"C#" : @{@"index" : @0, @"int_val" : @1, @"accidental" : @"#"},
            @"C##" : @{@"index" : @0, @"int_val" : @2, @"accidental" : @"##"},
            @"CB" : @{@"index" : @0, @"int_val" : @(-1), @"accidental" : @"b"},
            @"CBB" : @{@"index" : @0, @"int_val" : @(-2), @"accidental" : @"bb"},
            @"D" : @{@"index" : @1, @"int_val" : @2, @"accidental" : [NSNull null]},
            @"DN" : @{@"index" : @1, @"int_val" : @2, @"accidental" : @"n"},
            @"D#" : @{@"index" : @1, @"int_val" : @3, @"accidental" : @"#"},
            @"D##" : @{@"index" : @1, @"int_val" : @4, @"accidental" : @"##"},
            @"DB" : @{@"index" : @1, @"int_val" : @1, @"accidental" : @"b"},
            @"DBB" : @{@"index" : @1, @"int_val" : @0, @"accidental" : @"bb"},
            @"E" : @{@"index" : @2, @"int_val" : @4, @"accidental" : [NSNull null]},
            @"EN" : @{@"index" : @2, @"int_val" : @4, @"accidental" : @"n"},
            @"E#" : @{@"index" : @2, @"int_val" : @5, @"accidental" : @"#"},
            @"E##" : @{@"index" : @2, @"int_val" : @6, @"accidental" : @"##"},
            @"EB" : @{@"index" : @2, @"int_val" : @3, @"accidental" : @"b"},
            @"EBB" : @{@"index" : @2, @"int_val" : @2, @"accidental" : @"bb"},
            @"F" : @{@"index" : @3, @"int_val" : @5, @"accidental" : [NSNull null]},
            @"FN" : @{@"index" : @3, @"int_val" : @5, @"accidental" : @"n"},
            @"F#" : @{@"index" : @3, @"int_val" : @6, @"accidental" : @"#"},
            @"F##" : @{@"index" : @3, @"int_val" : @7, @"accidental" : @"##"},
            @"FB" : @{@"index" : @3, @"int_val" : @4, @"accidental" : @"b"},
            @"FBB" : @{@"index" : @3, @"int_val" : @3, @"accidental" : @"bb"},
            @"G" : @{@"index" : @4, @"int_val" : @7, @"accidental" : [NSNull null]},
            @"GN" : @{@"index" : @4, @"int_val" : @7, @"accidental" : @"n"},
            @"G#" : @{@"index" : @4, @"int_val" : @8, @"accidental" : @"#"},
            @"G##" : @{@"index" : @4, @"int_val" : @9, @"accidental" : @"##"},
            @"GB" : @{@"index" : @4, @"int_val" : @6, @"accidental" : @"b"},
            @"GBB" : @{@"index" : @4, @"int_val" : @5, @"accidental" : @"bb"},
            @"A" : @{@"index" : @5, @"int_val" : @9, @"accidental" : [NSNull null]},
            @"AN" : @{@"index" : @5, @"int_val" : @9, @"accidental" : @"n"},
            @"A#" : @{@"index" : @5, @"int_val" : @10, @"accidental" : @"#"},
            @"A##" : @{@"index" : @5, @"int_val" : @11, @"accidental" : @"##"},
            @"AB" : @{@"index" : @5, @"int_val" : @8, @"accidental" : @"b"},
            @"ABB" : @{@"index" : @5, @"int_val" : @7, @"accidental" : @"bb"},
            @"B" : @{@"index" : @6, @"int_val" : @11, @"accidental" : [NSNull null]},
            @"BN" : @{@"index" : @6, @"int_val" : @11, @"accidental" : @"n"},
            @"B#" : @{@"index" : @6, @"int_val" : @12, @"accidental" : @"#"},
            @"B##" : @{@"index" : @6, @"int_val" : @13, @"accidental" : @"##"},
            @"BB" : @{@"index" : @6, @"int_val" : @10, @"accidental" : @"b"},
            @"BBB" : @{@"index" : @6, @"int_val" : @9, @"accidental" : @"bb"},
            @"R" : @{@"index" : @6, @"int_val" : @9, @"rest" : @(YES)},   // Rest
            @"X" : @{@"index" : @6, @"accidental" : @"", @"octave" : @4, @"code" : @"v3e", @"shift_right" : @5.5}
        };
    }
    return _noteValues;
}

+ (VFTablesAccidentalCodes*)objectForAccidental:(NSString*)acc
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return ([VFTables accidentalsDictionary])[acc];
}

+ (Metrics*)metricForArticulation:(NSString*)artic
{
    /*
     Vex.Flow.articulationCodes = function(artic) {
     return Vex.Flow.articulationCodes.articulations[artic];
     }
     */
    return [[VFTables articulationsDictionary] objectForKey:artic];
}

// TODO: finish and change to normal Vexflow name
+ (VFNote*)noteForIndex:(NSUInteger)index
{
    /*
    Vex.Flow.integerToNote = function(integer) {
        if (typeof(integer) == @"undefined")
            throw new Vex.RERR("BadArguments", @"Undefined integer for
    integerToNote");

        if (integer < -2)
            throw new Vex.RERR("BadArguments",
                               @"integerToNote requires integer > -2: @" +
    integer);

        var noteValue = Vex.Flow.integerToNote.table[integer];
        if (!noteValue)
            throw new Vex.RERR("BadArguments", @"Unkown note value for integer: @"
    +
                               integer);

        return noteValue;
    }
     */

    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return nil;
}

//======================================================================================================================

// TODO: finish the following
/*
Vex.Flow.integerToNote = function(integer) {
    if (typeof(integer) == @"undefined")
        throw new Vex.RERR("BadArguments", @"Undefined integer for
integerToNote");

    if (integer < -2)
        throw new Vex.RERR("BadArguments",
                           @"integerToNote requires integer > -2: @" + integer);

    var noteValue = Vex.Flow.integerToNote.table[integer];
    if (!noteValue)
        throw new Vex.RERR("BadArguments", @"Unknown note value for integer: @"
+
                           integer);

    return noteValue;
};
*/

/*
Vex.Flow.integerToNote.table = {
    0: @"C",
    1: @"C#",
    2: @"D",
    3: @"D#",
    4: @"E",
    5: @"F",
    6: @"F#",
    7: @"G",
    8: @"G#",
    9: @"A",
    10: @"A#",
    11: @"B"
};
 */

/*

Vex.Flow.tabToGlyph = function(fret) {
    var glyph = null;
    var width = 0;
    var shift_y = 0;

    if (fret.toString().toUpperCase() == @"X") {
        glyph = @"v7f";
        width = 7;
        shift_y = -4.5;
    } else {
        width = Vex.Flow.textWidth(fret.toString());
    }

    return {
    text: fret,
    @"code" : @glyph,
    @"width" : @(width,
    shift_y: shift_y
    };
};
 */

/*
Vex.Flow.textWidth = function(text) {
    return 6 * text.toString().count;
};
 */

/*
Vex.Flow.articulationCodes = function(artic) {
    return Vex.Flow.articulationCodes.articulations[artic];
};
 */

static NSDictionary* _accidentalCodes;
+ (NSDictionary*)accidentalCodes;
{
    if(!_accidentalCodes)
    {
        _accidentalCodes = @{
            @"#" : @{
                @"code" : @"v18",
                @"width" : @(10),
                @"gracenote_width" : @(4.5),
                @"shift_right" : @(0),
                @"shift_down" : @(0)
            },
            @"##" : @{
                @"code" : @"v7f",
                @"width" : @(13),
                @"gracenote_width" : @(6),
                @"shift_right" : @(-1),
                @"shift_down" : @(0)
            },
            @"b" : @{
                @"code" : @"v44",
                @"width" : @(8),
                @"gracenote_width" : @(4.5),
                @"shift_right" : @(0),
                @"shift_down" : @(0)
            },
            @"bb" : @{
                @"code" : @"v26",
                @"width" : @(14),
                @"gracenote_width" : @(8),
                @"shift_right" : @(-3),
                @"shift_down" : @(0)
            },
            @"n" : @{
                @"code" : @"v4e",
                @"width" : @(8),
                @"gracenote_width" : @(4.5),
                @"shift_right" : @(0),
                @"shift_down" : @(0)
            },
            @"{" : @{
                // Left paren for cautionary accidentals
                @"code" : @"v9c",
                @"width" : @(5),
                @"shift_right" : @(2),
                @"shift_down" : @(0)
            },
            @"}" : @{
                // Right paren for cautionary accidentals
                @"code" : @"v84",
                @"width" : @(5),
                @"shift_right" : @(0),
                @"shift_down" : @(0)
            },
            @"db" : @{@"code" : @"v9e", @"width" : @(16), @"shift_right" : @(0), @"shift_down" : @(0)},
            @"d" : @{@"code" : @"vab", @"width" : @(10), @"shift_right" : @(0), @"shift_down" : @(0)},
            @"bbs" : @{@"code" : @"v90", @"width" : @(13), @"shift_right" : @(0), @"shift_down" : @(0)},
            @"++" : @{@"code" : @"v51", @"width" : @(13), @"shift_right" : @(0), @"shift_down" : @(0)},
            @"+" : @{@"code" : @"v78", @"width" : @(8), @"shift_right" : @(0), @"shift_down" : @(0)}
        };
    }
    return _accidentalCodes;
}

static NSDictionary* _accidentalColumnsTable;
+ (NSDictionary*)accidentalColumnsTable;
{
    if(!_accidentalColumnsTable)
    {
        _accidentalColumnsTable = @{
            @"1" : @{@"a" : @[ @1 ], @"b" : @[ @1 ]},
            @"2" : @{@"a" : @[ @1, @2 ]},
            @"3" : @{@"a" : @[ @1, @3, @2 ], @"b" : @[ @1, @2, @1 ], @"second_on_bottom" : @[ @1, @2, @3 ]},
            @"4" : @{
                @"a" : @[ @1, @3, @4, @2 ],
                @"b" : @[ @1, @2, @3, @1 ],
                @"spaced_out_tetrachord" : @[ @1, @2, @1, @2 ]
            },
            @"5" : @{
                @"a" : @[ @1, @3, @5, @4, @2 ],
                @"b" : @[ @1, @2, @4, @3, @1 ],
                @"spaced_out_pentachord" : @[ @1, @2, @3, @2, @1 ],
                @"very_spaced_out_pentachord" : @[ @1, @2, @1, @2, @1 ]
            },
            @"6" : @{
                @"a" : @[ @1, @3, @5, @6, @4, @2 ],
                @"b" : @[ @1, @2, @4, @5, @3, @1 ],
                @"spaced_out_hexachord" : @[ @1, @3, @2, @1, @3, @2 ],
                @"very_spaced_out_hexachord" : @[ @1, @2, @1, @2, @1, @2 ]
            }
        };
    }
    return _accidentalColumnsTable;
}

static NSDictionary* _ornamentCodes;
+ (NSDictionary*)ornamentCodes;
{
    if(!_ornamentCodes)
    {
        _ornamentCodes = @{
            @"mordent" : @{
                @"code" : @"v1e",
                @"shift_right" : @(1),
                @"shift_up" : @(0),
                @"shift_down" : @(5),
                @"width" : @(14),
                @"between_lines" : @NO
            },
            @"mordent_inverted" : @{
                @"code" : @"v45",
                @"shift_right" : @(1),
                @"shift_up" : @(0),
                @"shift_down" : @(5),
                @"width" : @(14),
                @"between_lines" : @NO
            },
            @"turn" : @{
                @"code" : @"v72",
                @"shift_right" : @(1),
                @"shift_up" : @(0),
                @"shift_down" : @(5),
                @"width" : @(20),
                @"between_lines" : @NO
            },
            @"turn_inverted" : @{
                @"code" : @"v33",
                @"shift_right" : @(1),
                @"shift_up" : @(0),
                @"shift_down" : @(6),
                @"width" : @(20),
                @"between_lines" : @NO
            },
            @"tr" : @{
                @"code" : @"v1f",
                @"shift_right" : @(0),
                @"shift_up" : @(5),
                @"shift_down" : @(15),
                @"width" : @(10),
                @"between_lines" : @NO
            },
            @"upprall" : @{
                @"code" : @"v60",
                @"shift_right" : @(1),
                @"shift_up" : @(-3),
                @"shift_down" : @(6),
                @"width" : @(20),
                @"between_lines" : @NO
            },
            @"downprall" : @{
                @"code" : @"vb4",
                @"shift_right" : @(1),
                @"shift_up" : @(-3),
                @"shift_down" : @(6),
                @"width" : @(20),
                @"between_lines" : @NO
            },
            @"prallup" : @{
                @"code" : @"v6d",
                @"shift_right" : @(1),
                @"shift_up" : @(-3),
                @"shift_down" : @(6),
                @"width" : @(20),
                @"between_lines" : @NO
            },
            @"pralldown" : @{
                @"code" : @"v2c",
                @"shift_right" : @(1),
                @"shift_up" : @(-3),
                @"shift_down" : @(6),
                @"width" : @(20),
                @"between_lines" : @NO
            },
            @"upmordent" : @{
                @"code" : @"v29",
                @"shift_right" : @(1),
                @"shift_up" : @(-3),
                @"shift_down" : @(6),
                @"width" : @(20),
                @"between_lines" : @NO
            },
            @"downmordent" : @{
                @"code" : @"v68",
                @"shift_right" : @(1),
                @"shift_up" : @(-3),
                @"shift_down" : @(6),
                @"width" : @(20),
                @"between_lines" : @NO
            },
            @"lineprall" : @{
                @"code" : @"v20",
                @"shift_right" : @(1),
                @"shift_up" : @(-3),
                @"shift_down" : @(6),
                @"width" : @(20),
                @"between_lines" : @NO
            },
            @"prallprall" : @{
                @"code" : @"v86",
                @"shift_right" : @(1),
                @"shift_up" : @(-3),
                @"shift_down" : @(6),
                @"width" : @(20),
                @"between_lines" : @NO
            }
        };
        //        _ornamentCodes = [[VFTablesOrnamentCodes alloc]
        //        initWithDictionary:tmp_ornamentCodes];
    }
    return _ornamentCodes;
}

/*
Vex.Flow.keySignature = function(spec) {
    var keySpec = Vex.Flow.keySignature.keySpecs[spec];

    if (!keySpec) {
        throw new Vex.RERR("BadKeySignature",
                           @"Bad key signature spec: '" + spec + @"'");
    }

    if (!keySpec.acc) {
        return [];
    }

    var notes = Vex.Flow.keySignature.accidentalList(keySpec.acc);

    var acc_list = [];
    for (var i = 0; i < keySpec.num; ++i) {
        var line = notes[i];
        acc_list.push({type: keySpec.acc, line: line});
    }

    return acc_list;
};
*/
//======================================================================================================================

// TODO: test this method
+ (VFTablesNoteStringData*)parseNoteDurationString:(NSString*)noteStringData;
{
    NSString* regexpPattern = @"(\\d*\\/?\\d+|[a-z])(d*)([nrhms]|$)";
    NSArray* matches = [noteStringData match:regexpPattern];

    if(matches.count == 0)
    {
        [VFLog logError:@"Unable to match any patterns in the durationString"];
        return nil;
    }

    VFTablesNoteStringData* ret = [[VFTablesNoteStringData alloc] init];

    NSString* duration = matches[0];
    ret.durationString = duration;
    if(duration.length == 0)
    {
        ret.noteDurationType = VFDurationQuarterNote;
    }
    else
    {
        ret.noteDurationType = [VFTables noteDurationTypeForDurationString:ret.durationString];
    }
    NSUInteger dots = [matches[1] length] == 0 ? 0 : [matches[1] length];
    ret.dots = dots;

    NSString* noteNHSMSString = matches[2];
    ret.noteNHMRSString = noteNHSMSString;
    if(!ret.noteNHMRSString || ret.noteNHMRSString.length == 0)
    {
        ret.noteNHMRSString = @"n";
    }

    ret.noteNHMRSType = [VFEnum typeNoteNHMRSTypeForString:ret.noteNHMRSString];

    return ret;
}

+ (VFTablesNoteStringData*)parseNoteData:(VFTablesNoteInputData*)noteData;
{
    NSString* duration = noteData.durationString;

    // preserve backwards-compatibility
    VFTablesNoteStringData* ret = [VFTables parseNoteDurationString:duration];
    if(!ret)
    {
        VFLogError(@"Note parse error");
        return nil;
    }

    NSString* type = noteData.noteNHMRSString;

    if(type)
    {
        if(!([type isEqualToString:@"n"] || [type isEqualToString:@"r"] || [type isEqualToString:@"h"] ||
             [type isEqualToString:@"m"] || [type isEqualToString:@"s"]))
        {
            type = @"n";
        }
    }
    else
    {
        type = ret.noteNHMRSString;
        if(!type)
        {
            type = @"n";
        }
    }

    ret.noteNHMRSString = type;

    Rational* ticks = [VFTables ticksForDuration:ret.durationString];
    if(!ticks)
    {
        VFLogError(@"Note parse error");
        return nil;
    }
    ret.ticks = ticks;

    // calculate the ticks from the dots
    NSUInteger dots = 0;
    if(noteData.dots > 0)
    {
        dots = noteData.dots;
    }
    else
    {
        dots = ret.dots;
    }

    if(dots != 0)
    {
        // TODO: this is a little inefficient. isn't denominator always 1? faster to
        // do it with ints?
        Rational* currentTicks = [ret.ticks clone];
        for(NSUInteger i = 0; i < dots; i++)
        {
            [currentTicks divn:2];
            [ret.ticks add:currentTicks];
        }
    }

    return ret;
}

static NSDictionary* _noteDurationTypeForDurationStringDictionary;
+ (VFNoteDurationType)noteDurationTypeForDurationString:(NSString*)duration
{
    __block VFNoteDurationType ret = VFDurationNone;
    if(!_noteDurationTypeForDurationStringDictionary)
    {
        _noteDurationTypeForDurationStringDictionary = @{
            @"1/2" : @(VFDurationBreveNote),
            @"w" : @(VFDurationWholeNote),
            @"h" : @(VFDurationHalfNote),
            @"q" : @(VFDurationQuarterNote),
            @"1" : @(VFDurationWholeNote),
            @"2" : @(VFDurationHalfNote),
            @"4" : @(VFDurationQuarterNote),
            @"8" : @(VFDurationEighthNote),
            @"16" : @(VFDurationSixteenthNote),
            @"32" : @(VFDurationThirtyTwoNote),
            @"64" : @(VFDurationSixtyFourNote),
            @"128" : @(VFDurationOneTwentyEightNote),
            @"256" : @(VFDurationTwoFiftySixNote),
            @"b" : @(VFDurationTwoFiftySixNote),
        };
    }

    NSString* lookup = [duration lowercaseString];
    typedef VFNoteDurationType (^CaseBlock)();

    if(!duration || ![_noteDurationTypeForDurationStringDictionary.allKeys containsObject:duration])
    {
        ret = VFDurationNone;
    }
    else
    {
        ret = [_noteDurationTypeForDurationStringDictionary[lookup] integerValue];
    }

    return ret;
}

+ (Rational*)ticksForDuration:(NSString*)duration
{
    VFNoteDurationType durationType = [VFTables noteDurationTypeForDurationString:duration];
    switch(durationType)
    {
        case VFDurationBreveNote:
            return [Rational rationalWithNumerator:2 * kRESOLUTION andDenominator:1];
            break;
        case VFDurationWholeNote:
            return [Rational rationalWithNumerator:kRESOLUTION andDenominator:1];
            break;
        case VFDurationHalfNote:
            return [Rational rationalWithNumerator:kRESOLUTION andDenominator:2];
            break;
        case VFDurationQuarterNote:
            return [Rational rationalWithNumerator:kRESOLUTION andDenominator:4];
            break;
        case VFDurationEighthNote:
            return [Rational rationalWithNumerator:kRESOLUTION andDenominator:8];
            break;
        case VFDurationSixteenthNote:
            return [Rational rationalWithNumerator:kRESOLUTION andDenominator:16];
            break;
        case VFDurationThirtyTwoNote:
            return [Rational rationalWithNumerator:kRESOLUTION andDenominator:32];
            break;
        case VFDurationSixtyFourNote:
            return [Rational rationalWithNumerator:kRESOLUTION andDenominator:64];
            break;
        case VFDurationOneTwentyEightNote:
            return [Rational rationalWithNumerator:kRESOLUTION andDenominator:128];
            break;
        case VFDurationTwoFiftySixNote:
            return [Rational rationalWithNumerator:kRESOLUTION andDenominator:256];
            break;
        case VFDurationNone:
        default:
            return [Rational rationalWithNumerator:0 andDenominator:1];
            break;
    }
    return 0;
}

+ (NSUInteger)textWidthForText:(NSString*)text
{
    return 6 * text.length;
}

+ (NSArray*)durationsArray
{
    if(!_durationsArray)
    {
        _durationsArray = @[
            @"w",
            @"h",
            @"q",
            @"8",
            @"16",
            @"32",
            @"64",
        ];
    }
    return _durationsArray;
}

+ (BOOL)duration:(NSString*)a greaterThanDuration:(NSString*)b
{
    if([[VFTables durationsArray] containsObject:a] && [[VFTables durationsArray] containsObject:b])
    {
        if([VFTables noteDurationTypeForDurationString:a] < [VFTables noteDurationTypeForDurationString:b])
        {
            return YES;
        }
    }
    return NO;
}

/*

function sanitizeDuration(duration) {
    var alias = Vex.Flow.durationAliases[duration];
    if (alias !== undefined) {
        duration = alias;
    }

    if (Vex.Flow.durationToTicks.durations[duration] === undefined) {
        throw new Vex.RERR('BadArguments',
                           'The provided duration is not valid');
    }

    return duration;
}
*/
// Used to convert duration aliases to the number based duration.
// If the input isn't an alias, simply return the input.
//
// example: 'q' -> '4', '8' -> '8'
+ (NSString*)sanitizeDuration:(NSString*)str_duration
{
    // TODO: finish
    NSString* duration;
    id alias = [self.durationAliasesDictionary objectForKey:str_duration];
    if(alias != nil)
    {
        //        return [alias floatValue];
    }
    // TODO: finish

    return duration;
}
/*

Vex.Flow.durationToFraction = function(duration) {
    return new Vex.Flow.Fraction().parse(sanitizeDuration(duration));
};
 */

// Convert the `duration` to an fraction
+ (Rational*)durationToFraction:(NSString*)str_duration
{
    return [Rational parse:[VFTables sanitizeDuration:str_duration]];
}

// Convert the `duration` to an number
+ (NSNumber*)durationToNumber:(NSString*)duration
{
    return [NSNumber numberWithFloat:[VFTables durationToFraction:duration].floatValue];
}
/*
// Convert the `duration` to total ticks
Vex.Flow.durationToTicks = function(duration) {
    duration = sanitizeDuration(duration);

    var ticks = Vex.Flow.durationToTicks.durations[duration];
    if (ticks === undefined) {
        return null;
    }

    return ticks;
};
 */
+ (NSUInteger)durationToTicks:(NSString*)duration;
{
    return [[[[self class] durationToTicksDictionary] objectForKey:duration] unsignedIntegerValue];
}

@end
