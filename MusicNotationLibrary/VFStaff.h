//
//  VFStaff.h
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
#import "VFVex.h"
#import "VFDelegates.h"
#import "VFEnum.h"
#import "VFShift.h"
#import "VFSymbol.h"

@class VFGlyph, VFModifier, VFKeySignature, VFClef, VFStaffText, VFPadding;
@class VFLine, VFTimeSignature, Options, VFBoundingBox, VFFont, VFStaffModifier, TempoOptionsStruct;

//======================================================================================================================
/** The `StaffOptions` class sets many staff-specific 'options'
 *  used to render metrics
 */
@interface StaffOptions : IAModelBase
@property (assign, nonatomic) float verticalBarWidth;
@property (assign, nonatomic) float glyphSpacingPoints;
@property (assign, nonatomic) NSUInteger numLines;
@property (assign, nonatomic) float pointsBetweenLines;
@property (assign, nonatomic) float spaceAboveStaffLine;
@property (assign, nonatomic) float spaceBelowStaffLine;
@property (assign, nonatomic) float topTextPosition;
@property (assign, nonatomic) float bottomTextPosition;
// collection of VFLines - holding the line Option objects
@property (strong, nonatomic) NSMutableArray* lineConfig;
@property (assign, nonatomic) float spacing_between_lines_px;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

//======================================================================================================================
/** The `VFStaff` class contains glyphs and holds position data which VFVoice
        uses to draw notes at the appropriate position on the NSView that the VFStaff object occupies.

    In standard Western musical notation, the staff is a set of five
        horizontal lines and four spaces that each represent a different musical pitch—or,
        in the case of a percussion staff, different percussion instruments.

     https://en.wikipedia.org/wiki/Staff_(music)

     The following demonstrates some basic usage of this class.


 */
@interface VFStaff : VFSymbol
{
    float _x;
    float _y;
    //    float _width;
    //    float _height;
    //    VFPoint *_startPosition;
    float _cursorXPosition;

    //    NSMutableArray *_mutableArrayOfRects;
    //    CGRect *_rects;

    //    VFKeySignature *_keySignature;
    //    BOOL _preformatted;
    //    float _cursorXPosition;
    NSMutableArray* _glyphs;
    NSMutableArray* _endGlyphs;

    StaffOptions* _options;

    float _thickNess;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) NSMutableArray* list;
@property (strong, nonatomic) NSMutableDictionary* map;
@property (assign, nonatomic) NSInteger resolutionMultiplier;
//@property (weak, nonatomic) id parent;

//@property (strong, nonatomic) Metrics* metrics;

//@property (assign, nonatomic, readonly) BOOL preFormatted;
//@property (assign, nonatomic, readonly) BOOL postFormatted;

@property (assign, nonatomic) float endXPosition;
@property (assign, nonatomic) float startYPosition;

//@property (retain, nonatomic) VFBoundingBox* boundingBox;
@property (assign, nonatomic, readonly) float x;
@property (assign, nonatomic, readonly) float y;
@property (assign, nonatomic) float width;
@property (assign, nonatomic, readonly) float height;

@property (assign, nonatomic, readonly) float glyph_start_x;
@property (assign, nonatomic, readonly) float glyph_end_x;
@property (assign, nonatomic, readonly) float start_x;
@property (assign, nonatomic, readonly) float end_x;

@property (strong, nonatomic, readonly) StaffOptions* options;

/** righmost point position of this staff
 */
//@property (readonly, nonatomic) float glyphEndX;

//@property (assign, nonatomic) float glyphStartXPosition;

@property (strong, nonatomic) VFLine* noteBounds;
@property (strong, nonatomic) VFLine* tieBounds;

/** the glyphs to be rendered to this Staff
 */
@property (strong, nonatomic) NSMutableArray* glyphs;
@property (strong, nonatomic) NSMutableArray* endGlyphs;

/** non-glyph Staff items (barlines, coda, segno, etc.)
 *  modifiers, Staffmodifiers, all kinds of stuff i guess, TODO: edit this descriptor
 */
@property (strong, nonatomic) NSMutableArray* modifiers;

@property (strong, nonatomic) VFKeySignature* keySignature;
@property (strong, nonatomic) VFTimeSignature* timeSignature;

///** the beginning bar type
// */
//@property (assign, nonatomic) VFBarLineType begBarType;
///** the ending bar type
// */
//@property (assign, nonatomic) VFBarLineType endBarType;

@property (assign, nonatomic) VFRepetitionType repetitionTypeLeft;

/** the starting measure for this Staff
 */
@property (assign, nonatomic) NSUInteger measure;

/** "treble" i guess, this could actually be replaced by an enum
 */
//@property (strong, nonatomic) NSString* category;
@property (strong, nonatomic) VFClef* clef;
@property (strong, nonatomic) NSString* clefName;
@property (assign, nonatomic) VFClefType clefType;

/** font to use when writing text with the staff
 */
@property (strong, nonatomic) VFFont* font;

@property (strong, nonatomic) VFColor* strokeColor;
@property (strong, nonatomic) VFColor* fillColor;

/** wrapper for options points between lines property
 */
@property (readonly, nonatomic) float spacingBetweenLines;

@property (assign, nonatomic, readonly) float cursorXPosition;

@property (strong, nonatomic) VFStaffText* staffText;

@property (assign, nonatomic) NSUInteger numberOfLines;

@property (assign, nonatomic, readonly, getter=getTieStartX) float tieStartX;
@property (assign, nonatomic, readonly, getter=getTieEndX) float tieEndX;

@property (assign, nonatomic, setter=setNoteStartX:, getter=getNoteStartX) float noteStartX;
@property (assign, nonatomic, readonly, getter=getNoteEndX) float noteEndX;

@property (assign, nonatomic, readonly) float getBottomY;
@property (assign, nonatomic, readonly) float getYForTopText;
@property (assign, nonatomic, readonly) float getYForGlyphs;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

///////////////////////////////////////////////////////////////////////////
//
// @name initialization

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initAtX:(float)x
                    atY:(float)y
                  width:(float)width
                 height:(float)height
            optionsDict:(NSDictionary*)optionsDict;
+ (VFStaff*)staffWithBoundingBox:(VFBoundingBox*)frame;
+ (VFStaff*)staffWithRect:(CGRect)rect;
+ (VFStaff*)staffAtX:(float)x atY:(float)y width:(float)width height:(float)height;
//+ (VFStaff*)staffWithRect:(CGRect)rect optionsStruct:(StaffOptions*)optionsStruct;
+ (VFStaff*)staffWithRect:(CGRect)rect optionsDict:(NSDictionary*)optionsDict;
+ (VFStaff*)currentStaff;

///////////////////////////////////////////////////////////////////////////
//
// @name Configuration

/**
 * Get the current configuration for the staff.
 * @return {Array} An array of NSDictionaries configuration objects.
 */
- (NSMutableArray*)getConfigForLines;

/*!
 *  Configure properties of the lines in the staff
 *  @param lineNumber The index of the line to configure.
 *  @param lineConfig An configuration object for the specified line.
 *  @return this object
 */
- (id)setConfigForLine:(NSInteger)lineNumber withConfig:(NSDictionary*)lineConfig;

/*!
 *  Set the staff line configuration array for all of the lines at once.
 *  @param linesConfiguration An array of line configuration dictionaries.  These objects
 *   are of the same format as the single one passed in to setLineConfiguration().
 *   The caller can set null for any line config entry if it is desired that the default be used
 *  @return this object
 */
- (id)setConfigForLines:(NSArray*)linesConfiguration;

/*!
 *  Bar Line functions
 *  @param begBarType beginning bar type
 *  @return this object
 */
- (id)setBegBarType:(VFBarLineType)begBarType;

/*!
 *  Bar Line functions
 *  @param endBarType ending bar type
 *  @return this object
 */
- (id)setEndBarType:(VFBarLineType)endBarType;

/*!
 *  Gets the pixels to shift from the beginning of the stave
 *  following the modifier at the provided index
 *  @return The amount of pixels shifted
 */
- (float)getModifierXShift;

/*!
 *  Gets the pixels to shift from the beginning of the stave
 *  following the modifier at the provided index
 *  @param index The index from which to determine the shift
 *  @return The amount of pixels shifted
 */
- (float)getModifierXShift:(NSInteger)index;

///////////////////////////////////////////////////////////////////////////
//
// @name set staff types

/*!
 *  Coda & Segno Symbol functions
 *  @param type repetition type
 *  @param y    y position relative to staff origin
 *  @return this object
 */
- (id)setRepetitionTypeLeft:(VFRepetitionType)type atY:(float)y;

/*!
 *  Coda & Segno Symbol functions
 *  @param type repetition type
 *  @param y    y position relative to staff origin
 *  @return this object
 */
- (id)setRepetitionTypeRight:(VFRepetitionType)type atY:(float)y;

/*!
 *  Volta functions
 *  @param type    volta type
 *  @param numberT number of 'times' to repeat displayed
 *  @param y       y position relative to staff origin
 *  @return this object
 */
- (id)setVoltaType:(VFVoltaType)type withNumber:(NSString*)numberT atY:(float)y;

/*!
 *  Section functions
 *  @param section the section
 *  @param y       shift up from staff origin
 *  @return this object
 */
- (id)setSectionWithSection:(NSString*)section atY:(float)y;

/*!
 *  sets the tempo label for the staff
 *  @param tempo options for the tempo:
 *                  `name`, `duration`, `dots`, `bpm`
 *  @param y     y position relative to staff origin
 *  @return this object
 */
- (id)setTempoWithTempo:(TempoOptionsStruct*)tempo atY:(float)y;

/*!
 *  Text functions
 *  @param text     text to add
 *  @param position position of the text relative to the staff origin
 *  @param options  the following options to set text position:
 *                      `shift_x`
 *                      `shift_y`
 *                      `justification`
 *  @return this object
 */
- (id)setTextWithText:(NSString*)text atPosition:(VFPositionType)position withOptions:(NSDictionary*)options;

/*!
 *  Text functions
 *  @param text     text to add
 *  @param position position of the text relative to the staff origin
 *  @param options  the following options to set text position:
 *  @return this object
 */
- (id)setTextWithText:(NSString*)text atPosition:(VFPositionType)position;

///////////////////////////////////////////////////////////////////////////
//
// @name get y for line

/*!
 *  gets the bottom y coordinate in global space
 *  @return the bottom y coordinate
 */
- (float)getBottomY;

/*!
 *  gets absolute y position for line
 *  @param line staff line
 *  @return y position
 */
- (float)getYForLine:(float)line;

/*!
 *  gets absolute y position for top text line
 *  @param line staff line
 *  @return y position
 */
- (float)getYForTopTextWithLine:(float)line;

/*!
 *  gets absolute y position for top text line
 *  @return y position
 */
- (float)getYForTopText;

/*!
 *  gets absolute y position for bottom text line
 *  @param line staff line
 *  @return y position
 */
- (float)getYForBottomTextWithLine:(float)line;

/*!
 *  gets absolute y position for top text line
 *  @return y position
 */
- (float)getYForBottomText;

/*!
 *  gets absolute y position for a note
 *  @param line staff line
 *  @return y position
 */
- (float)getYForNoteWithLine:(float)line;

/*!
 *  gets absolute y position for glyphs
 *  @return y position
 */
- (float)getYForGlyphs;

///////////////////////////////////////////////////////////////////////////
//
// @name add staff modifiers

/*!
 *  adds a glyph
 *  @param glyph the glyph object
 *  @return this object
 */
- (id)addGlyph:(VFGlyph*)glyph;

/*!
 *  creates a blank glyph that does not render anything except it takes up space
 *  @param padding amount of space the blank glyph occupies
 *  @return a blank glyph
 */
- (VFGlyph*)makeSpacer:(float)padding;

/*!
 *  adds a glyph to end
 *  @param glyph the glyph object
 *  @return this object
 */
- (id)addEndGlyph:(VFGlyph*)glyph;

/*!
 *  adds a modifier
 *  @param modifier a staff modifier
 *  @return this object
 */
- (id)addModifier:(VFStaffModifier*)modifier;

/*!
 *  adds a modifier to end
 *  @param modifier a staff modifier
 *  @return this object
 */
- (id)addEndModifier:(VFStaffModifier*)modifier;

/*!
 *  adds a key signature to the start of this staff
 *  @param signature the specifier for the signature
 *  @return this object
 */
- (id)addKeySignature:(NSString*)signature;

/*!
 *  adds a key signature to the start of this staff
 *  @param keySpec. one of:
 *              'C', 'CN', 'C#', 'C##', 'CB', 'CBB', 'D', 'DN', 'D#',
 *              'D##', 'DB', 'DBB', 'E', 'EN', 'E#', 'E##', 'EB',
 *              'EBB', 'F', 'FN', 'F#', 'F##', 'FB', 'FBB', 'G', 'GN', 'G#',
 *              'G##', 'GB', 'GBB', 'A', 'AN', 'A#', 'A##',
 *              'AB', 'ABB', 'B', 'BN', 'B#', 'B##', 'BB', 'BBB', 'R', 'X'
 *  @return this object
 */
- (id)addKeySignatureWithSpec:(NSString*)keySpec;

/*!
 *  adds a treble clef to the start of this staff
 *  @return this object
 */
- (id)addTrebleGlyph;

/*!
 *  adds a clef to the start of this staff
 *  @param clefType the clef type enum value
 *  @return this object
 */
- (id)addClefWithType:(VFClefType)clefType;

/*!
 *  adds a clef to the start of this staff
 *  @param clefName name of the clef. one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @return this object
 */
- (id)addClefWithName:(NSString*)clefName;

/*!
 *  adds a clef to the start of this staff
 *  @param clef the clef object
 *  @return thix object
 */
- (id)addClef:(VFClef*)clef;

/*!
 *  adds a clef to the start of this staff
 *  @param clefName name of the clef. one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @param size     the size of the clef
 *  @return this object
 */
- (id)addClefWithName:(NSString*)clefName size:(NSString*)size;

/*!
 *  adds a clef to the start of this staff
 *  @param clefName   name of the clef. one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @param size       the size of the clef
 *  @param annotation a clef annotation
 *  @return this object
 */
- (id)addClefWithName:(NSString*)clefName size:(NSString*)size annotation:(NSString*)annotation;

/*!
 *  adds a clef to the end of this staff
 *  @param clefName name of the clef. one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @return this object
 */
- (id)addEndClefWithName:(NSString*)clefName;

/*!
 *  adds a clef to the end of this staff
 *  @param clefName name of the clef. one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @param size     the size of the clef
 *  @return this object
 */
- (id)addEndClefWithName:(NSString*)clefName size:(NSString*)size;

/*!
 *  adds a clef to the end of this staff
 *  @param clefName   the name of the clef, one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @param size       the size of the clef
 *  @param annotation an annotation
 *  @return this object
 */
- (id)addEndClefWithName:(NSString*)clefName size:(NSString*)size annotation:(NSString*)annotation;

/*!
 *  adds a time signature to the start
 *  @param signature time signature name
 *  @return this object
 */
- (id)addTimeSignatureWithName:(NSString*)signature;

/*!
 *  adds a time signature to the end
 *  @param signature time signature name
 *  @return this object
 */
- (id)addEndTimeSignatureWithName:(NSString*)signature;

/*!
 *  adds a time signature to the start
 *  @param signature time signature name
 *  @param padding   amount of space between time siganture and next glyph
 *  @return this object
 */
- (id)addTimeSignatureWithName:(NSString*)signature padding:(float)padding;

/*!
 *  adds a time signature to the start
 *  @param signature time signature object
 *  @param padding   amount of space between time siganture and next glyph
 *  @return this object
 */
- (id)addTimeSignature:(VFTimeSignature*)signature padding:(float)padding;

/*!
 *  adds a time signature to the end
 *  @param signature     time signature object
 *  @return this object
 */
- (id)addEndTimeSignature:(VFTimeSignature*)signature;

//`````````````````````
// @name drawing

- (void)draw:(CGContextRef)ctx;
- (void)drawVertical:(CGContextRef)ctx x:(float)x;
- (void)drawVertical:(CGContextRef)ctx x:(float)x isDouble:(BOOL)isDouble;
- (void)drawVerticalBar:(CGContextRef)ctx x:(float)x;
- (void)drawBoundingBox:(CGContextRef)ctx;

@end
