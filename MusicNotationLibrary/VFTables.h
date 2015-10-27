//
//  VFTables.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;

#import "VFMetrics.h"
#import "VFEnum.h"

@class VFGlyph, VFAccidental, VFNote, KeyProperty, Rational, VFClef, VFKeySignature, VFStaffNote;
@class VFTablesOrnamentCodes, VFTablesAccidentalCodes, VFTablesNoteInputData, VFTablesGlyphStruct,
    VFTablesNoteStringData;
@class VFGlyphTabStruct;

static const NSUInteger kRESOLUTION = 16384;   // ticks per measure
static const float kSCALE = 0.025f;
static const float kSTEM_WIDTH = 1.5;
static const float kSTEM_HEIGHT = 32.f;
static const float kSTAFF_LINE_THICKNESS = 1.f;
static const float kPI = 3.14159f;
static float kTHICKNESS = 2.f;

//======================================================================================================================
/** The `NoteGlyph` class stores a code and a shift value

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface NoteGlyph : NSObject

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) NSString* code;
@property (assign, nonatomic) float shiftRight;

+ (NoteGlyph*)noteGlyphWithCode:(NSString*)code andShiftRight:(float)shiftRight;
@end

//======================================================================================================================
/** The `NoteValue` class performs ...

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface NoteValue : NSObject <NSCopying>   // : VFNote { }

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) NSUInteger index;
@property (assign, nonatomic) NSInteger intVal;
@property (strong, nonatomic) NSString* accidental;
@property (assign, nonatomic) float octave;
@property (strong, nonatomic) NSString* code;
@property (assign, nonatomic) float shiftRight;
@property (assign, nonatomic) BOOL isRest;
- (instancetype)initWithIndex:(NSUInteger)index andIntVal:(NSInteger)intVal andAccidental:(NSString*)accidental;
@end

//@interface ClefProperty : NSObject { }
//@property (assign, nonatomic) NSUInteger lineShift;
//- (instancetype)initWithLineShift:(NSUInteger)lineShift;
//+ (ClefProperty *)propWithLineShift:(NSUInteger)lineShift;
//@end

//======================================================================================================================
/** The `VFTables` class has lots data and formatting of music objects.
    It is a singleton but has a dealloc to free resources of C objects

     The following demonstrates some basic usage of this class.

         ExampleCode
 */
@interface VFTables : NSObject
{
}

#pragma mark - Class Collections
/**---------------------------------------------------------------------------------------------------------------------
 * @name Class Collections
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (NSDictionary*)accidentalColumnsTable;
+ (NSDictionary*)accidentalCodes;

+ (NSDictionary*)accidentalsDictionary;

+ (NSDictionary*)articulationsDictionary;

//+ (NSDictionary *)clefPropertiesDictionary;

+ (NSDictionary*)durationAliasesDictionary;

//+ (NSDictionary *)durationCodesDictionary;

/** note that this is a dictionary of float values
 */
+ (NSDictionary*)durationToTicksDictionary;

/** piano key frequencies LUT
    http://en.wikipedia.org/wiki/Piano_key_frequencies
 */
+ (float*)frequenciesArray;

/** the labels on the piano keys LUT
 */
+ (NSArray*)pianoLabels;

+ (NSArray*)integerToNoteArray;

+ (NSDictionary*)integerToNoteDictionary;

//+ (NSDictionary*)keyNoteValuesDictionary;

+ (NSArray*)keyPropertiesArray;

+ (NSDictionary*)keySpecsDictionary;

+ (NSDictionary*)noteGlyphsDictionary;

+ (NSDictionary*)noteTypesDictionary;

//+ (NSDictionary *)pianoKeyForNoteDictionary;

#pragma mark - Class Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Class Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (NSArray*)accidentalListForAcc:(NSString*)accidental;

+ (void)configureStaffNoteForNote:(VFStaffNote*)note;

//+ (VFGlyph*)durationToGlyph:(NSString*)noteDurationString withNHMRSNoteType:(NSString*)noteTypeString;
//+ (VFGlyph*)durationToGlyph:(VFNoteDurationType)noteDurationType withNHMRSType:(VFNoteNHMRSType)noteNHMRSType;
+ (VFTablesGlyphStruct*)durationToGlyphStruct:(NSString*)noteDurationString;
+ (VFTablesGlyphStruct*)durationToGlyphStruct:(NSString*)noteDurationString
                          withNHMRSNoteString:(NSString*)noteNHSMSString;
+ (VFTablesGlyphStruct*)durationToGlyphStruct:(VFNoteDurationType)noteDurationType
                                withNHMRSType:(VFNoteNHMRSType)noteNHMRSType;

+ (VFGlyphTabStruct*)glyphForTab:(NSString*)fret;

/**  Take a note in the format "Key/Octave" (e.g., "C/5") and return properties.
 */
+ (KeyProperty*)keyPropertiesForKey:(NSString*)key andClef:(VFClefType)clefType andOptions:(NSDictionary*)params;

+ (VFKeySignature*)keySignatureWithString:(NSString*)key;

+ (NSMutableArray*)keySignatureForSpec:(NSString*)spec;

+ (VFTablesAccidentalCodes*)objectForAccidental:(NSString*)accidental;

+ (Metrics*)metricForArticulation:(NSString*)articulation;

+ (VFNote*)noteForIndex:(NSUInteger)index;

//+ (VFNoteType)noteTypeForTypeString:(NSString *)type;

//+ (VFNote *)parseNoteDurationString:(NSString *)durationString;

//+ (NSString *)noteStringTypeForNoteType:(VFNoteType)noteType;

+ (VFTablesNoteStringData*)parseNoteData:(VFTablesNoteInputData*)noteData;

//+ (VFTablesNoteStringData*)parseNoteDurationString:(NSString*)noteStringData;

+ (NSUInteger)textWidthForText:(NSString*)text;

/** determines the Fraction object for the given duration
 */
+ (Rational*)ticksForDuration:(NSString*)duration;

/** determines the note type for the given duration
 */
+ (VFNoteDurationType)noteDurationTypeForDurationString:(NSString*)duration;

+ (BOOL)duration:(NSString*)a greaterThanDuration:(NSString*)b;

+ (NSString*)sanitizeDuration:(NSString*)str_duration;
+ (NSNumber*)durationToNumber:(NSString*)duration;
+ (Rational*)durationToFraction:(NSString*)duration;

+ (NSUInteger)durationToTicks:(NSString*)duration;

+ (NSDictionary*)ornamentCodes;

+ (NSString*)articulationCodeForType:(VFArticulationType)type;
//+ (NSDictionary *)articulationsDictionary;

@end
