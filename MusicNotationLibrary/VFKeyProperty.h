//
//  VFKeyProperties.h
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFEnum.h"
#import "IAModelBase.h"

@class VFAccidental;

//======================================================================================================================
/** The `VFKeyProperties` class performs ...


 In music theory, the key of a piece usually refers to the tonic note and chord, which gives a
    subjective sense of arrival and rest. Other notes and chords in the piece create varying degrees
    of tension, resolved when the tonic note and/or chord returns. The key may be major or minor,
    although major is assumed in a phrase like "this piece is in C." Popular songs are usually in a
    key, and so is classical music during the common practice period, about 1650–1900. Longer pieces
    in the classical repertoire may have sections in contrasting keys.

 The methods by which the key is established for a particular piece are not easy to explain,[citation needed]
    and vary considerably over the period of music history; however, the chords most often used in a
    piece in a particular key are those containing the notes in the corresponding scale, and conventional
    progressions of these chords, particularly cadences, serve to orient the listener around the tonic.

 The key signature is not a reliable guide to the key of a written piece. It does not discriminate
    between a major key and its relative minor; the piece may modulate to a different key; if the modulation
    is brief, it may not involve a change of key signature, being indicated instead with accidentals.
    Occasionally, a piece in a mode such as Mixolydian or Dorian will be written with a major or minor key
    signature appropriate to the tonic, and accidentals throughout the piece.

 Pieces in modes not corresponding to major or minor keys may sometimes be referred to as being in the key
    of the tonic. A piece using some other type of harmony, resolving e.g. to A, might be described as "in A"
    to indicate that A is the tonal center of the piece.

 An instrument may be said to be "in a key", an unrelated usage meaning it is a transposing instrument.

 A key relationship is the relationship between keys, measured by common tones and nearness on the circle
    of fifths. See: closely related key.

 http://en.wikipedia.org/wiki/Key_(music)

 The following demonstrates some basic usage of this class.

     KeyProperty *ret = [[KeyProperty alloc]init];
     ret.key = k;
     ret.octave = noteValue.octave;
     ret.line = line;
     ret.intValue = intValue;
     //    ret.accidental = accidenal;
     ret.glyphCode = code;
     ret.stroke = stroke;
     ret.shiftRight = shiftRight;
     ret.displaced = NO;
 */
@interface KeyProperty : IAModelBase
{
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

/** accidental - deviation from key
 */
@property (strong, nonatomic) NSString* accidental;

/** the key of the music: C D E F G A B
 */
@property (strong, nonatomic) NSString* key;

/** the code for the head drawn for the given key
 */
@property (strong, nonatomic) NSString* glyphCode;

/**
 */
@property (assign, nonatomic) VFClefType clefType;

/** the octave for this key
 */
@property (assign, nonatomic) NSUInteger octave;

/** the line on the staff that this key occupies
 */
@property (assign, nonatomic) float line;

/** the value of this key represented as an int TODO: frequency?
 */
@property (assign, nonatomic) NSUInteger intValue;

/** the amount to shift the note based on the accidental
 */
@property (assign, nonatomic) float shiftRight;

/** is the note displaced
 */
@property (assign, nonatomic) BOOL displaced;

///** the values of the notes for this key
// */
//@property (strong, nonatomic) NSDictionary *noteValues;

/** the line that this key will place rests
 */
@property (assign, nonatomic) NSUInteger restLine;

/** stroke
 */
@property (assign, nonatomic) VFStrokeDirectionType stroke;

@property (weak, nonatomic) id parent;   //<VFTickableDelegate> parent;

@property (assign, nonatomic) float octave_shift;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithKey:(NSString*)key andClefType:(VFClefType)clefType;
- (instancetype)initWithKey:(NSString*)key andClefType:(VFClefType)clefType andOptionsDict:(NSDictionary*)optionsDict;

//+ (KeyProperty *)keyPropertyWithKey:(NSString *)key
//                        andClefType:(VFClefType)clefType;

@end
