//
//  VFMusic.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;

#import "IAModelBase.h"

@class RootAccidentalTypeStruct, VFMusicScales, /*VFMusicRootIndices,*/ VFMusicDiatonicAccidentals;

//======================================================================================================================
/** The `VFMusic` class implements some standard music theory routines.

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFMusic : NSObject
{
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (strong, nonatomic) NSArray *roots;
//@property (strong, nonatomic) NSArray *rootValues;
//@property (strong, nonatomic) NSDictionary *rootIndices;
//@property (strong, nonatomic) NSArray *canonicalNotes;
//@property (strong, nonatomic) NSArray *diatonicIntervals;
//@property (strong, nonatomic) NSDictionary *diatonicAccidentals;
//@property (strong, nonatomic) NSDictionary *intervals;
//@property (strong, nonatomic) NSDictionary *scales;
//@property (strong, nonatomic) NSArray *accidentals;
//@property (strong, nonatomic) NSDictionary *noteValues;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (id)sharedManager;

+ (NSArray*)roots;
+ (NSArray*)rootValues;
+ (NSDictionary*)rootIndices;
+ (NSArray*)canonicalNotes;
+ (NSArray*)diatonicIntervals;
+ (VFMusicDiatonicAccidentals*)diatonicAccidentalsObject;
+ (NSDictionary*)intervals;
+ (VFMusicScales*)scales;
+ (NSArray*)accidentals;
+ (NSDictionary*)noteValues;

+ (BOOL)isValidNoteValue:(NSInteger)note;
+ (BOOL)isValidIntervalValue:(NSInteger)interval;

+ (RootAccidentalTypeStruct*)getNoteParts:(NSString*)noteString;
+ (RootAccidentalTypeStruct*)getKeyParts:(NSString*)keyString;
+ (NSUInteger)getNoteValue:(NSString*)noteString;
+ (NSArray*)getIntervalValue:(NSString*)intervalString;

+ (NSString*)getCanonicalNoteName:(NSUInteger)noteValue;
+ (NSString*)getCanonicalIntervalName:(NSUInteger)intervalValue;
+ (NSUInteger)getRelativeNoteValueForNoteValue:(NSUInteger)noteValue
                              forIntervalValue:(NSUInteger)intervalValue
                                  andDirection:(NSInteger)direction;
+ (NSString*)getRelativeNoteNameForRoot:(NSString*)root andNoteValue:(NSUInteger)noteValue;
+ (NSArray*)getScaleTonesForKey:(NSUInteger)key andIntervals:(NSArray*)intervals;
+ (NSUInteger)getIntervalBetweenNote:(NSUInteger)note
                        andOtherNote:(NSUInteger)otherNote
                       withDirection:(NSInteger)direction;
+ (NSDictionary*)createScaleMap:(NSString*)keySignature;

@end

@interface RootAccidentalTypeStruct : NSObject //IAModelBase
@property (strong, nonatomic) NSString* root;
@property (strong, nonatomic) NSString* accidental;
@property (strong, nonatomic) NSString* type;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end