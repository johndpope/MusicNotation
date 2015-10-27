//
//  VFTuning.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFTuning.h"
#import "VFLog.h"

@implementation TuningNames
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}
@end

@implementation VFTuning

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
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
        [self setupTuning];
    }
    return self;
}

- (void)setupTuning
{
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*
Vex.Flow.Tuning.names = {
    "standard": "E/5,B/4,G/4,D/4,A/3,E/3",
    "dagdad": "D/5,A/4,G/4,D/4,A/3,D/3",
    "dropd": "E/5,B/4,G/4,D/4,A/3,D/3",
    "eb": "Eb/5,Bb/4,Gb/4,Db/4,Ab/3,Db/3"
}
 */

static TuningNames* _tuningNames;
+ (TuningNames*)tuningNames
{
    if(!_tuningNames)
    {
        _tuningNames = [[TuningNames alloc] initWithDictionary:@{
            @"standard" : @[ @"E/5", @"B/4", @"G/4", @"D/4", @"A/3", @"E/3" ],
            @"dagdad" : @[ @"D/5", @"A/4", @"G/4", @"D/4", @"A/3", @"D/3" ],
            @"dropd" : @[ @"E/5", @"B/4", @"G/4", @"D/4", @"A/3", @"D/3" ],
            @"eb" : @[ @"Eb/5", @"Bb/4", @"Gb/4", @"Db/4", @"Ab/3", @"Db/3" ],
        }];
    }
    return _tuningNames;
}

/*
Vex.Flow.Tuning.prototype.init = function(tuningString) {
    // Default to standard tuning.
    self.setTuning(tuningString || "E/5,B/4,G/4,D/4,A/3,E/3");
}
 */
- (instancetype)initWithTuningString:(NSString*)tuningString
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    }
    return self;
}

/*
Vex.Flow.Tuning.prototype.noteToInteger = function(noteString) {
    return Vex.Flow.keyProperties(noteString).int_value;
}
 */

/*
Vex.Flow.Tuning.prototype.setTuning = function(noteString) {
    if (Vex.Flow.Tuning.names[noteString])
        noteString = Vex.Flow.Tuning.names[noteString];
    
    self.tuningString = noteString;
    self.tuningValues = [];
    self.numStrings = 0;
//    
// *    var keys = noteString.split(/\s*,\s*/   //);*/
//    if (keys.count == 0)
//        throw new Vex.RERR("BadArguments", "Invalid tuning string: " + noteString);
//
//    self.numStrings = keys.count;
//    for (var i = 0; i < self.numStrings; ++i) {
//        self.tuningValues[i] = self.noteToInteger(keys[i]);
//    }
//}
//*/
- (void)setTuning:(NSString*)noteString
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

/*
//Vex.Flow.Tuning.prototype.getValueForString = function(stringNum) {
//    var s = parseInt(stringNum);
//    if (s < 1 || s > self.numStrings)
//        throw new Vex.RERR("BadArguments", "String number must be between 1 and " +
//                           self.numStrings + ": " + stringNum);
//
//    return self.tuningValues[s - 1];
//}
 //*/
- (NSUInteger)getValueForString:(NSUInteger)stringNum
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return 0;
}

/*
//Vex.Flow.Tuning.prototype.getValueForFret = function(fretNum, stringNum) {
//    var stringValue = self.getValueForString(stringNum);
//    var f = parseInt(fretNum);
//
//    if (f < 0) {
//        throw new Vex.RERR("BadArguments", "Fret number must be 0 or higher: " +
//                           fretNum);
//    }
//
//    return stringValue + f;
//}
 //*/

/*
//Vex.Flow.Tuning.prototype.getNoteForFret = function(fretNum, stringNum) {
//    var noteValue = self.getValueForFret(fretNum, stringNum);
//
//    var octave = Math.floor(noteValue / 12);
//    var value = noteValue % 12;
//
//    return Vex.Flow.integerToNote(value) + "/" + octave;
//}
//
// */
- (NSString*)getNoteForFret:(NSUInteger)fretNum andStringNum:(NSUInteger)stringNum
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return @"";
}

@end
