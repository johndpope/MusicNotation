//
//  VFMusic.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFMusic.h"
#import "VFVex.h"
#import "VFMusicDiatonicAccidentals.h"
#import "VFMusicScales.h"
#import "VFMusicRootIndices.h"
#import "VFKeyManager.h"

#import <RegExCategories/RegExCategories.h>

@implementation RootAccidentalTypeStruct

//- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
//{
//    self = [super initWithDictionary:optionsDict];
//    if(self)
//    {
//        [self setValuesForKeyPathsWithDictionary:optionsDict];
//    }
//    return self;
//}

@end

@implementation VFMusic

static NSArray* _roots;
static NSArray* _rootValues;
// static NSDictionary *_rootIndices;
static NSArray* _canonicalNotes;
static NSArray* _diatonicIntervals;
// static NSDictionary *_diatonicAccidentals;
static NSDictionary* _intervals;
// static NSDictionary *_scales;
static NSArray* _accidentals;
static NSDictionary* _noteValues;

static NSUInteger kNUM_TONES = 12;

+ (id)sharedManager
{
    static VFMusic* sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init
{
    if(self = [super init])
    {
    }
    return self;
}

+ (NSArray*)roots
{
    if(!_roots)
    {
        _roots = @[ @"c", @"d", @"e", @"f", @"g", @"a", @"b" ];
    }
    return _roots;
}

+ (NSArray*)rootValues
{
    if(!_rootValues)
    {
        _rootValues = @[
            @0,
            @2,
            @4,
            @5,
            @7,
            @9,
            @11,
        ];
    }
    return _rootValues;
}

// static VFMusicRootIndices* _rootIndices;
static NSDictionary* _rootIndices;
+ (NSDictionary*)rootIndices
{
    if(!_rootIndices)
    {
        _rootIndices = @{ @"c" : @0, @"d" : @1, @"e" : @2, @"f" : @3, @"g" : @4, @"a" : @5, @"b" : @6 };
        //        _rootIndices = [[VFMusicRootIndices alloc] initWithDictionary:tmp_rootIndices];
    }
    return _rootIndices;
}

+ (NSArray*)canonicalNotes
{
    if(!_canonicalNotes)
    {
        _canonicalNotes = @[ @"c", @"c#", @"d", @"d#", @"e", @"f", @"f#", @"g", @"g#", @"a", @"a#", @"b" ];
    }
    return _canonicalNotes;
}

+ (NSArray*)diatonicIntervals
{
    if(!_diatonicIntervals)
    {
        _diatonicIntervals =
            @[ @"unison", @"m2", @"M2", @"m3", @"M3", @"p4", @"dim5", @"p5", @"m6", @"M6", @"b7", @"M7", @"octave" ];
    }
    return _diatonicIntervals;
}

//+ (NSDictionary *)diatonicAccidentals {
//    if (!_diatonicAccidentals) {
//        _diatonicAccidentals = @{
//                                 @"unison" : @{ @"note" : @0, @"accidental" : @(0)},
//                                 @"m2" :     @{ @"note" : @1, @"accidental" : @(-1)},
//                                 @"M2" :     @{ @"note" : @1, @"accidental" : @(0)},
//                                 @"m3" :     @{ @"note" : @2, @"accidental" : @(-1)},
//                                 @"M3" :     @{ @"note" : @2, @"accidental" : @(0)},
//                                 @"p4" :     @{ @"note" : @3, @"accidental" : @(0)},
//                                 @"dim5" :   @{ @"note" : @4, @"accidental" : @(-1)},
//                                 @"p5" :     @{ @"note" : @4, @"accidental" : @(0)},
//                                 @"m6" :     @{ @"note" : @5, @"accidental" : @(-1)},
//                                 @"M6" :     @{ @"note" : @5, @"accidental" : @(0)},
//                                 @"b7" :     @{ @"note" : @6, @"accidental" : @(-1)},
//                                 @"M7" :     @{ @"note" : @6, @"accidental" : @(0)},
//                                 @"octave" : @{ @"note" : @7, @"accidental" : @(0)}
//            };
//    }
//    return _diatonicAccidentals;
//}

static VFMusicDiatonicAccidentals* _diatonicAccidentalsObject;
+ (VFMusicDiatonicAccidentals*)diatonicAccidentalsObject
{
    if(!_diatonicAccidentalsObject)
    {
        NSDictionary* tmp_diatonicAccidentals = @{
            @"unison" : @{@"note" : @0, @"accidental" : @(0)},
            @"m2" : @{@"note" : @1, @"accidental" : @(-1)},
            @"M2" : @{@"note" : @1, @"accidental" : @(0)},
            @"m3" : @{@"note" : @2, @"accidental" : @(-1)},
            @"M3" : @{@"note" : @2, @"accidental" : @(0)},
            @"p4" : @{@"note" : @3, @"accidental" : @(0)},
            @"dim5" : @{@"note" : @4, @"accidental" : @(-1)},
            @"p5" : @{@"note" : @4, @"accidental" : @(0)},
            @"m6" : @{@"note" : @5, @"accidental" : @(-1)},
            @"M6" : @{@"note" : @5, @"accidental" : @(0)},
            @"b7" : @{@"note" : @6, @"accidental" : @(-1)},
            @"M7" : @{@"note" : @6, @"accidental" : @(0)},
            @"octave" : @{@"note" : @7, @"accidental" : @(0)}
        };

        _diatonicAccidentalsObject = [[VFMusicDiatonicAccidentals alloc] initWithDictionary:tmp_diatonicAccidentals];
    }
    return _diatonicAccidentalsObject;
}

+ (NSDictionary*)intervals
{
    if(!_intervals)
    {
        _intervals = @{
            @"u" : @0,
            @"unison" : @0,
            @"m2" : @1,
            @"b2" : @1,
            @"min2" : @1,
            @"S" : @1,
            @"H" : @1,
            @"2" : @2,
            @"M2" : @2,
            @"maj2" : @2,
            @"T" : @2,
            @"W" : @2,
            @"m3" : @3,
            @"b3" : @3,
            @"min3" : @3,
            @"M3" : @4,
            @"3" : @4,
            @"maj3" : @4,
            @"4" : @5,
            @"p4" : @5,
            @"#4" : @6,
            @"b5" : @6,
            @"aug4" : @6,
            @"dim5" : @6,
            @"5" : @7,
            @"p5" : @7,
            @"#5" : @8,
            @"b6" : @8,
            @"aug5" : @8,
            @"6" : @9,
            @"M6" : @9,
            @"maj6" : @9,
            @"b7" : @10,
            @"m7" : @10,
            @"min7" : @10,
            @"dom7" : @10,
            @"M7" : @11,
            @"maj7" : @11,
            @"8" : @12,
            @"octave" : @12,
        };
    }
    return _intervals;
}

static VFMusicScales* _scales;
+ (VFMusicScales*)scales
{
    if(!_scales)
    {
        NSDictionary* tmp_scales = @{
            @"major" : @[ @2, @2, @1, @2, @2, @2, @1 ],
            @"dorian" : @[ @2, @1, @2, @2, @2, @1, @2 ],
            @"mixolydian" : @[ @2, @2, @1, @2, @2, @1, @2 ],
            @"minor" : @[ @2, @1, @2, @2, @1, @2, @2 ],
        };
        _scales = [[VFMusicScales alloc] initWithDictionary:tmp_scales];
    }
    return _scales;
}

+ (NSArray*)accidentals
{
    if(!_accidentals)
    {
        _accidentals = @[ @"bb", @"b", @"n", @"#", @"##" ];
    }
    return _accidentals;
}

+ (NSDictionary*)noteValues
{
    if(!_noteValues)
    {
        _noteValues = @{
            @"c" : @{@"root_index" : @0, @"int_val" : @0},
            @"cn" : @{@"root_index" : @0, @"int_val" : @0},
            @"c#" : @{@"root_index" : @0, @"int_val" : @1},
            @"c##" : @{@"root_index" : @0, @"int_val" : @2},
            @"cb" : @{@"root_index" : @0, @"int_val" : @11},
            @"cbb" : @{@"root_index" : @0, @"int_val" : @10},
            @"d" : @{@"root_index" : @1, @"int_val" : @2},
            @"dn" : @{@"root_index" : @1, @"int_val" : @2},
            @"d#" : @{@"root_index" : @1, @"int_val" : @3},
            @"d##" : @{@"root_index" : @1, @"int_val" : @4},
            @"db" : @{@"root_index" : @1, @"int_val" : @1},
            @"dbb" : @{@"root_index" : @1, @"int_val" : @0},
            @"e" : @{@"root_index" : @2, @"int_val" : @4},
            @"en" : @{@"root_index" : @2, @"int_val" : @4},
            @"e#" : @{@"root_index" : @2, @"int_val" : @5},
            @"e##" : @{@"root_index" : @2, @"int_val" : @6},
            @"eb" : @{@"root_index" : @2, @"int_val" : @3},
            @"ebb" : @{@"root_index" : @2, @"int_val" : @2},
            @"f" : @{@"root_index" : @3, @"int_val" : @5},
            @"fn" : @{@"root_index" : @3, @"int_val" : @5},
            @"f#" : @{@"root_index" : @3, @"int_val" : @6},
            @"f##" : @{@"root_index" : @3, @"int_val" : @7},
            @"fb" : @{@"root_index" : @3, @"int_val" : @4},
            @"fbb" : @{@"root_index" : @3, @"int_val" : @3},
            @"g" : @{@"root_index" : @4, @"int_val" : @7},
            @"gn" : @{@"root_index" : @4, @"int_val" : @7},
            @"g#" : @{@"root_index" : @4, @"int_val" : @8},
            @"g##" : @{@"root_index" : @4, @"int_val" : @9},
            @"gb" : @{@"root_index" : @4, @"int_val" : @6},
            @"gbb" : @{@"root_index" : @4, @"int_val" : @5},
            @"a" : @{@"root_index" : @5, @"int_val" : @9},
            @"an" : @{@"root_index" : @5, @"int_val" : @9},
            @"a#" : @{@"root_index" : @5, @"int_val" : @10},
            @"a##" : @{@"root_index" : @5, @"int_val" : @11},
            @"ab" : @{@"root_index" : @5, @"int_val" : @8},
            @"abb" : @{@"root_index" : @5, @"int_val" : @7},
            @"b" : @{@"root_index" : @6, @"int_val" : @11},
            @"bn" : @{@"root_index" : @6, @"int_val" : @11},
            @"b#" : @{@"root_index" : @6, @"int_val" : @0},
            @"b##" : @{@"root_index" : @6, @"int_val" : @1},
            @"bb" : @{@"root_index" : @6, @"int_val" : @10},
            @"bbb" : @{@"root_index" : @6, @"int_val" : @9}
        };
    }
    return _noteValues;
}

#pragma mark - Validate

/*
Vex.Flow.Music.prototype.isValidNoteValue = function(note) {
    if (note == null || note < 0 || note >= Vex.Flow.Music.NUM_TONES)
        return NO;
    return YES;
}
 */

+ (BOOL)isValidNoteValue:(NSInteger)note
{
    if(!note || note < 0 || note >= kNUM_TONES)
    {
        return NO;
    }
    return YES;
}

/*

Vex.Flow.Music.prototype.isValidIntervalValue = function(interval) {
    return self.isValidNoteValue(interval);
}
 */

+ (BOOL)isValidIntervalValue:(NSInteger)interval
{
    return [self isValidNoteValue:interval];
}

#pragma mark - Get Music Notation Dicts and Arrs

/*

Vex.Flow.Music.prototype.getNoteParts = function(noteString) {
    if (!noteString || noteString.count < 1)
        throw new Vex.RERR("BadArguments", "Invalid note name: " + noteString);

    if (noteString.count > 3)
        throw new Vex.RERR("BadArguments", "Invalid note name: " + noteString);

    var note = noteString.toLowerCase();

    var regex = /^([cdefgab])(b|bb|n|#|##)?$/;
    var match = regex.exec(note);

    if (match != null) {
        var root = match[1];
        var accidental = match[2];

        return {
            @"root': root,
            @"accidental': accidental
        }
    } else {
        throw new Vex.RERR("BadArguments", "Invalid note name: " + noteString);
    }
}
 */

+ (RootAccidentalTypeStruct*)getNoteParts:(NSString*)noteString
{
    if(!noteString || noteString.length < 1)
    {
        VFLogError(@"BadArguments, Invalid note name: %@", noteString);
        return nil;
    }

    if(noteString.length > 3)
    {
        VFLogError(@"BadArguments, Invalid note name: %@", noteString);
        return nil;
    }

    // http://userguide.icu-project.org/strings/regexp
    // http://proquest.safaribooksonline.com.ezproxy.lib.utah.edu/book/programming/mobile/9780132978767/26dot-uisplitviewcontroller-and-nsregularexpression/idp9096848?query=((nsregularexpression))&reader=html&imagepage=#snippet
        NSString* note = [noteString lowercaseString];   // don't really need to do lowercase since apple already has
    //    option
    // for lowercase below
    NSError* error = NULL;
    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^([cdefgab])|(b|bb|n|#|##)?$"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:&error];
    NSArray* matches = [regex matchesInString:note options:0 range:NSMakeRange(0, note.length)];

    //    NSUInteger numberOfMatches = [regex numberOfMatchesInString:noteString options:0 range:NSMakeRange(0,
    //    noteString.length)];

    if(matches)
    {
        NSString* root;
        NSString* accidental;
        typedef enum
        {
            rootIndex = 0,
            accIndex = 1,
        } NoteAccEnumType;
        NSTextCheckingResult* result1 = [matches objectAtIndex:rootIndex];
        NSRange r1 = [result1 range];
        root = [noteString substringWithRange:r1];
        if (matches.count > 1) {
            NSTextCheckingResult* result2 = [matches objectAtIndex:accIndex];
            NSRange r2 = [result2 range];
            accidental = [noteString substringWithRange:r2];
            if (accidental.length == 0) {
                accidental = nil;
            }
        }
//        return [[RootAccidentalTypeStruct alloc] initWithDictionary:@{ @"root" : root, @"accidental" : accidental }];
        RootAccidentalTypeStruct* ret = [[RootAccidentalTypeStruct alloc]init];
        ret.root = root;
        ret.accidental = accidental;
        return ret;
    }
    else
    {
        VFLogError(@"BadArguments, Invalid note name: %@", noteString);
        return nil;
    }
}

/*

Vex.Flow.Music.prototype.getKeyParts = function(keyString) {
    if (!keyString || keyString.count < 1)
        throw new Vex.RERR("BadArguments", "Invalid key: " + keyString);

    var key = keyString.toLowerCase();

    // Support Major, Minor, Melodic Minor, and Harmonic Minor key types.
    var regex = /^([cdefgab])(b|#)?(mel|harm|m|M)?$/;
    var match = regex.exec(key);

    if (match != null) {
        var root = match[1];
        var accidental = match[2];
        var type = match[3];

        // Unspecified type implies major
        if (!type) type = "M";

        return {
            @"root': root,
            @"accidental': accidental,
            @"type': type
        }
    } else {
        throw new Vex.RERR("BadArguments", "Invalid key: " + keyString);
    }
}
 */

+ (RootAccidentalTypeStruct*)getKeyParts:(NSString*)keyString
{
    if(!keyString || [keyString length] < 1)
    {
        VFLogError(@"BadArguments, Invalid note name: %@", keyString);
        return nil;
    }

    //    if(keyString.length < 3)
    //    {
    //        VFLogError(@"BadArguments, Invalid note name: %@", keyString);
    //        return nil;
    //    }

    NSString* key = [keyString lowercaseString];
//    NSError* error = NULL;
//    NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"^([cdefgab])|(b|#)?|(mel|harm|m|M)?$"
//                                                                           options:NSRegularExpressionCaseInsensitive
//                                                                             error:&error];
//    NSArray* matches = [regex matchesInString:key options:0 range:NSMakeRange(0, [key length])];
//
//    //    NSUInteger numberOfMatches = [regex numberOfMatchesInString:key options:0 range:NSMakeRange(0, [key length])];
    
    
    NSArray* matches = [key matches:[@"^([cdefgab])|(b|#)?|(mel|harm|m|M)?$" toRxWithOptions:NSRegularExpressionCaseInsensitive]];

    if(matches)
    {
        NSString* root;
        NSString* accidental;
        NSString* type;
        if(matches.count > 0)
        {
//            NSTextCheckingResult* result1 = [matches objectAtIndex:0];
//            NSRange r1 = [result1 range];
//            root = [key substringWithRange:r1];
            root = matches[0];
        }
        if(matches.count > 1)
        {
//            NSTextCheckingResult* result2 = [matches objectAtIndex:1];
//            NSRange r2 = [result2 range];
//            accidental = [key substringWithRange:r2];
            accidental = matches[1];
        }
        else
        {
            accidental = @"";
        }
        if(matches.count > 2)
        {
//            NSTextCheckingResult* result3 = [matches objectAtIndex:1];
//            NSRange r3 = [result3 range];
//            type = [key substringWithRange:r3];
            type = matches[2];
            if (type.length == 0) {
                type = @"M";
            }
        }
        else
        {
            type = @"M";
        }

        return [[RootAccidentalTypeStruct alloc] initWithDictionary:@{
            @"root" : root,
            @"accidental" : accidental,
            @"type" : type
        }];
    }
    else
    {
        VFLogError(@"BadArguments, Invalid note name: %@", keyString);
        return nil;
    }
}

/*

Vex.Flow.Music.prototype.getNoteValue = function(noteString) {
    var value = Vex.Flow.Music.noteValues[noteString];
    if (value == null)
        throw new Vex.RERR("BadArguments", "Invalid note name: " + noteString);

    return value.int_val;
}
 */

+ (NSUInteger)getNoteValue:(NSString*)noteString
{
    NSDictionary* value = [self.noteValues objectForKey:noteString];
    if(!value)
    {
        VFLogError(@"BadArguments, Invalid note name: %@", noteString);
        return 0;
    }
    return [[value objectForKey:@"int_val"] unsignedIntegerValue];
}

/*

Vex.Flow.Music.prototype.getIntervalValue = function(intervalString) {
    var value = Vex.Flow.Music.intervals[intervalString];
    if (value == null)
        throw new Vex.RERR("BadArguments",
                           "Invalid interval name: " + intervalString);

    return value;
}
 */

+ (NSArray*)getIntervalValue:(NSString*)intervalString
{
    NSArray* value = [self.intervals objectForKey:intervalString];
    if(!value)
    {
        VFLogError(@"BadArguments, Invalid note name: %@", intervalString);
        return nil;
    }
    return value;
}

/*

Vex.Flow.Music.prototype.getCanonicalNoteName = function(noteValue) {
    if (!self.isValidNoteValue(noteValue))
        throw new Vex.RERR("BadArguments",
                           "Invalid note value: " + noteValue);

    return Vex.Flow.Music.canonical_notes[noteValue];
}
 */

+ (NSString*)getCanonicalNoteName:(NSUInteger)noteValue
{
    if(![self isValidNoteValue:noteValue])
    {
        VFLogError(@"BadArguments, Invalid note name: %lu", (unsigned long)noteValue);
        return nil;
    }
    return [self.canonicalNotes objectAtIndex:noteValue];
}

/*

Vex.Flow.Music.prototype.getCanonicalIntervalName = function(intervalValue) {
    if (!self.isValidIntervalValue(intervalValue))
        throw new Vex.RERR("BadArguments",
                           "Invalid interval value: " + intervalValue);

    return Vex.Flow.Music.diatonic_intervals[intervalValue];
}

 */

+ (NSString*)getCanonicalIntervalName:(NSUInteger)intervalValue
{
    if(![self isValidNoteValue:intervalValue])
    {
        [VFLog
            logError:[NSString stringWithFormat:@"BadArguments, Invalid note name: %lu", (unsigned long)intervalValue]];
        return nil;
    }
    return [self.canonicalNotes objectAtIndex:intervalValue];
}

/*
* Given a note, interval, and interval direction, product the
 * relative note.
 *
Vex.Flow.Music.prototype.getRelativeNoteValue =
function(noteValue, intervalValue, direction) {
    if (direction == null) direction = 1;
    if (direction != 1 && direction != -1)
        throw new Vex.RERR("BadArguments", "Invalid direction: " + direction);

    var sum = (noteValue + (direction * intervalValue)) %
    Vex.Flow.Music.NUM_TONES;
    if (sum < 0) sum += Vex.Flow.Music.NUM_TONES;

    return sum;
}
 */

+ (NSUInteger)getRelativeNoteValueForNoteValue:(NSUInteger)noteValue
                              forIntervalValue:(NSUInteger)intervalValue
                                  andDirection:(NSInteger)direction
{
    if(!direction)
    {
        direction = 1;
    }

    if(direction != 1 && direction != -1)
    {
        VFLogError(@"BadArguments, Invalid direction: %li", (long)direction);
    }

    NSInteger sum = (noteValue + (direction * intervalValue)) % kNUM_TONES;
    if(sum < 0)
        sum += kNUM_TONES;

    return sum;
}

/*

Vex.Flow.Music.prototype.getRelativeNoteName =
function(root, noteValue) {
    var parts = self.getNoteParts(root);
    var rootValue = self.getNoteValue(parts.root);
    var interval = noteValue - rootValue;

    if (Math.abs(interval) > Vex.Flow.Music.NUM_TONES - 3) {
        var multiplier = 1;
        if (interval > 0 ) multiplier = -1;

        // Possibly wrap around. (Add +1 for modulo operator)
        var reverse_interval = (((noteValue + 1) + (rootValue + 1)) %
                                Vex.Flow.Music.NUM_TONES) * multiplier;

        if (Math.abs(reverse_interval) > 2) {
            throw new Vex.RERR("BadArguments", "Notes not related: " + root + ", " +
                               noteValue);
        } else {
            interval = reverse_interval;
        }
    }

    if (Math.abs(interval) > 2)
        throw new Vex.RERR("BadArguments", "Notes not related: " + root + ", " +
                           noteValue);

    var relativeNoteName = parts.root;
    if (interval > 0) {
        for (var i = 1; i <= interval; ++i)
            relativeNoteName += "#";
    } else if (interval < 0) {
        for (var i = -1; i >= interval; --i)
            relativeNoteName += "b";
    }

    return relativeNoteName;
}
 */

+ (NSString*)getRelativeNoteNameForRoot:(NSString*)root andNoteValue:(NSUInteger)noteValue
{
    RootAccidentalTypeStruct* parts = [self getNoteParts:root];
    // var parts = self.getNoteParts(root);

    NSInteger rootValue = [self getNoteValue:parts.root];

    // var interval = noteValue - rootValue;
    NSInteger interval = noteValue - rootValue;

    if(labs(interval) > kNUM_TONES - 3)
    {
        NSInteger multiplier = 1;
        if(interval > 0)
            multiplier = -1;

        // Possibly wrap around. (Add +1 for modulo operator)
        NSInteger reverse_interval = (((noteValue + 1) + (rootValue + 1)) % kNUM_TONES) * multiplier;

        if(labs(reverse_interval) > 2)
        {
            VFLogError(@"BadArguments Notes not related: %@, %lu", root, (unsigned long)noteValue);
            return nil;
        }
        else
        {
            interval = reverse_interval;
        }
    }

    if(labs(interval) > 2)
    {
        VFLogError(@"BadArguments Notes not related: %@, %lu", root, (unsigned long)noteValue);
        return nil;
    }

    NSMutableString* relativeNoteName = [parts.root mutableCopy];
    if(interval > 0)
    {
        for(NSUInteger i = 1; i <= interval; ++i)
        {
            [relativeNoteName appendString:@"#"];
        }
    }
    else if(interval < 0)
    {
        for(NSUInteger i = -1; i >= interval; --i)
        {
            [relativeNoteName appendString:@"b"];
        }
    }

    return relativeNoteName;
}

/*
/ * Return scale tones, given intervals. Each successive interval is
 * relative to the previous one, e.g., Major Scale:
 *
 *   TTSTTTS = [2,2,1,2,2,2,1]
 *
 * When used with key = 0, returns C scale (which is isomorphic to
 * interval list).
 *
Vex.Flow.Music.prototype.getScaleTones = function(key, intervals) {
    var tones = [];
    tones.push(key);

    var nextNote = key;
    for (var i = 0; i < intervals.count; ++i) {
        nextNote = self.getRelativeNoteValue(nextNote,
                                             intervals[i]);
        if (nextNote != key) tones.push(nextNote);
    }

    return tones;
}
 */

+ (NSArray*)getScaleTonesForKey:(NSUInteger)key andIntervals:(NSArray*)intervals
{
    NSMutableArray* tones = [NSMutableArray array]; //initWithCapacity:7];
    [tones insertObject:[NSNumber numberWithInteger:key] atIndex:0];
    NSUInteger nextNote = key; //(NSUInteger)[NSNumber numberWithInteger:key];
    for(NSUInteger i = 0; i < intervals.count; i++)
    {
        nextNote =
            [self getRelativeNoteValueForNoteValue:nextNote forIntervalValue:[intervals[i] unsignedIntegerValue] andDirection:0];
        if(nextNote != key)
        {
            [tones push:[NSNumber numberWithInteger:nextNote]]; //insertObject:[NSNumber numberWithInteger:nextNote] atIndex:i + 1];
        }
    }
    return tones;
}

/* Returns the interval of a note, given a diatonic scale.
 *
 * E.g., Given the scale C, and the note E, returns M3
 *
Vex.Flow.Music.prototype.getIntervalBetween =
function(note1, note2, direction) {
    if (direction == null) direction = 1;
    if (direction != 1 && direction != -1)
        throw new Vex.RERR("BadArguments", "Invalid direction: " + direction);
    if (!self.isValidNoteValue(note1) || !self.isValidNoteValue(note2))
        throw new Vex.RERR("BadArguments",
                           "Invalid notes: " + note1 + ", " + note2);
    if (direction == 1)
        var difference = note2 - note1;
    else
        var difference = note1 - note2;

    if (difference < 0) difference += Vex.Flow.Music.NUM_TONES;
    return difference;
}
 */

+ (NSUInteger)getIntervalBetweenNote:(NSUInteger)note
                        andOtherNote:(NSUInteger)otherNote
                       withDirection:(NSInteger)direction
{
    NSInteger difference = 0;

    if(!direction)
        direction = 1;

    if(direction != 1 && direction != -1)
    {
        VFLogError(@"BadArguments, Invalid direction: %li", (long)direction);
        return -999;
    }

    if(![self isValidNoteValue:note] || ![self isValidNoteValue:otherNote])
    {
        VFLogError(@"BadArguments, Invalid notes: %lu, %lu", (unsigned long)note, (unsigned long)otherNote);
        return -999;
    }

    if(direction == 1)
    {
        difference = otherNote - note;
    }
    else
    {
        difference = note - otherNote;
    }
    if(difference < 0)
    {
        difference += kNUM_TONES;
    }
    return difference;
}

/*!
 *   Create a scale map that represents the pitch state for a
 *   `keySignature`. For example, passing a `G` to `keySignature` would
 *   return a scale map with every note naturalized except for `F` which
 *   has an `F#` state.
 *  @param keySignature <#keySignature description#>
 *  @return <#return value description#>
 */
+ (NSDictionary*)createScaleMap:(NSString*)keySignature;
{
    /*
createScaleMap: function(keySignature) {
    var keySigParts = this.getKeyParts(keySignature);
    var scaleName = Vex.Flow.KeyManager.scales[keySigParts.type];

    var keySigString = keySigParts.root;
    if (keySigParts.accidental) keySigString += keySigParts.accidental;

    if (!scaleName) throw new Vex.RERR("BadArguments", "Unsupported key type: " + keySignature);

    var scale = this.getScaleTones(this.getNoteValue(keySigString), scaleName);
    var noteLocation = Vex.Flow.Music.root_indices[keySigParts.root];

    var scaleMap = {};
    for (var i = 0; i < Vex.Flow.Music.roots.length; ++i) {
        var index = (noteLocation + i) % Vex.Flow.Music.roots.length;
        var rootName = Vex.Flow.Music.roots[index];
        var noteName = this.getRelativeNoteName(rootName, scale[i]);

        if (noteName.length === 1) {
            noteName += "n";
        }

        scaleMap[rootName] = noteName;
    }

    return scaleMap;
}
     */

    //    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];

    RootAccidentalTypeStruct* keySigParts = [self getKeyParts:keySignature];
    NSArray* scaleName = VFKeyManager.scales[keySigParts.type];

    NSString* keySigString = keySigParts.root;
    if(keySigParts.accidental)
    {
        keySigString = [NSString stringWithFormat:@"%@%@", keySigString, keySigParts.accidental];
    }

    if(!scaleName)
    {
        VFLogError(@"BadArguments, Unsupported key type: %@", keySignature);
    }

    NSArray* scale = [self getScaleTonesForKey:[self getNoteValue:keySigString] andIntervals:scaleName];
    NSUInteger noteLocation = [VFMusic.rootIndices[keySigParts.root] unsignedIntegerValue];

    NSMutableDictionary* scaleMap = [NSMutableDictionary dictionary];
    for(NSUInteger i = 0; i < VFMusic.rootIndices.count; ++i)
    {
        NSUInteger rootCount = VFMusic.roots.count;
        NSUInteger index = (noteLocation + i) % rootCount;
        NSString* rootName = VFMusic.roots[index];
        NSMutableString* noteName =
            [[self getRelativeNoteNameForRoot:rootName andNoteValue:[scale[i] unsignedIntegerValue]] mutableCopy];

        if(noteName.length == 1)
        {
            [noteName appendString:@"n"];
        }

        scaleMap[rootName] = noteName;
    }

    return scaleMap;
}

@end
