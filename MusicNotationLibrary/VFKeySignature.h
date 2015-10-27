//
//  VFKeySignature.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStaffModifier.h"

@class VFClef, VFStaff, VFAccidental;

//======================================================================================================================
/** The `VFKeySignature` class implements key signatures.

 In musical notation, a key signature is a set of sharp or flat symbols placed together on the staff.
    Key signatures are generally written immediately after the clef at the beginning of a line of
    musical notation, although they can appear in other parts of a score, notably after a double
    barline.

 A key signature designates notes that are to be played higher or lower than the corresponding natural
    notes and applies through to the end of the piece or up to the next key signature. A sharp symbol on
    a line or space in the key signature raises the notes on that line or space one semitone above the
    natural, and a flat lowers such notes one semitone. Further, a symbol in the key signature affects
    all the notes of one letter: for instance, a sharp on the top line of the treble staff applies to
    F's not only on that line, but also to F's in the bottom space of the staff, and to any other F's.

 An accidental is an exception to the key signature, applying only in the measure in which it appears,
    and the choice of key signature can increase or decrease the need for accidentals.

 Although a key signature may be written using any combination of sharp and flat symbols, about a dozen
    diatonic key signatures are by far the most common, and their use is assumed in much of this
    article. A piece scored using a single diatonic key signature and no accidentals contains notes of
    at most seven of the twelve pitch classes, which seven being determined by the particular key
    signature.

 Each major and minor key has an associated key signature that sharpens or flattens the notes which are
    used in its scale. However, it is not uncommon for a piece to be written with a key signature that
    does not match its key, for example, in some Baroque pieces,[1] or in transcriptions of traditional
    modal folk tunes.[2]

    http://en.wikipedia.org/wiki/Key_signature

     The following demonstrates some basic usage of this class.

     `ExampleCode``ExampleCode``ExampleCode``ExampleCode``ExampleCode`
     `ExampleCode``ExampleCode``ExampleCode``ExampleCode``ExampleCode`...
 */
@interface VFKeySignature : VFStaffModifier
{
   @private
    NSString* _code;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) float glyphFontScale;

/** flat or sharp key signature flavor
 */
@property (assign, nonatomic) VFKeySignatureFlavorType keyAccType;

/**
 */
@property (assign, nonatomic) NSUInteger num;

/** key signature
 * one of:
 * 'C', 'CN', 'C#', 'C##', 'CB', 'CBB', 'D', 'DN', 'D#', 'D##', 'DB', 'DBB', 'E', 'EN', 'E#', 'E##', 'EB',
 * 'EBB', 'F', 'FN', 'F#', 'F##', 'FB', 'FBB', 'G', 'GN', 'G#', 'G##', 'GB', 'GBB', 'A', 'AN', 'A#', 'A##', 'AB', 'ABB',
 * 'B', 'BN', 'B#', 'B##', 'BB', 'BBB', 'R', 'X'
 */
@property (strong, nonatomic) NSString* key;

/** accidental
 */
@property (strong, nonatomic) NSString* acc;

/** points between sharps or flats symbols
 */
@property (assign, nonatomic) float spacerPoints;

/** padding between sharps or flats symbols
 */
@property (strong, nonatomic) VFPadding* spacerPadding;

/** accidental list
 */
@property (strong, nonatomic) NSMutableArray* accList;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithAcc:(NSString*)acc andNumber:(NSUInteger)num;
- (instancetype)initWithKeySpecifier:(NSArray*)keySpecifier;

/*!
 *  gets a key signature for the specified key
 *  @param key the key
 *  @return a key signature object
 */
+ (VFKeySignature*)keySignatureWithKey:(NSString*)key;

/*!
 *  Add an accidental glyph to the `staff`. `acc` is the data of the
 *  accidental to add. If the `next` accidental is also provided, extra
 *  width will be added to the initial accidental for optimal spacing.
 *  @param staff   staff
 *  @param acc     accidental to add
 *  @param nextAcc the optional next accidenal to add
 */
- (void)addAccToStaff:(VFStaff*)staff acc:(VFAccidental*)acc nextAcc:(VFAccidental*)nextAcc;

/*!
 *  Cancel out a key signature provided in the `spec` parameter. This will
 *  place appropriate natural accidentals before the key signature.
 *  @param spec the key specifier
 *  @return this object
 */
- (id)cancelKey:(NSString*)spec;

/*!
 *  Add the key signature to the `staff`. You probably want to use the
 *  helper method `.addToStave()` instead
 *  @param staff the staff to add the modifier to
 */
- (void)addModifierToStaff:(VFStaff*)staff;

/*!
 *  Add the key signature to the `staff`, if it's the not the `firstGlyph`
 *  a spacer will be added as well.
 *  @param staff      the staff
 *  @param firstGlyph if this is the first glyph
 *  @return this object
 */
- (id)addToStaff:(VFStaff*)staff firstGlyph:(BOOL)firstGlyph;

/*!
 *  Apply the accidental staff line placement based on the `clef` and
 *  the  accidental `type` for the key signature ('# or 'b').
 *  @param clef the clef of the staff
 *  @param type the type of the accidental for the clef
 */
- (void)convertAccLinesWithClef:(VFClef*)clef andType:(NSString*)type;

@end
