//
//  VFStemmableNote.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
#import "VFNote.h"
#import "VFEnum.h"
#import "VFRenderOptions.h"

@class VFStem, VFBeam, VFExtentStruct, VFTablesGlyphStruct;

//@interface StemmableNoteRenderOptions : NoteRenderOptions
//@property (assign, nonatomic) float annotation_spacing;
//- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
//@end

//======================================================================================================================
/** The `VFStemmableNote`  is an abstract interface for notes with optional stems.
    Examples of stemmable notes are `StaveNote` and `TabNote` and `ghostnote`
 */
@interface VFStemmableNote : VFNote
{
   @private
    NSDictionary* _stemMinimumLengthsDictionary;

   @protected
    __weak VFBeam* _beam;
    VFStemDirectionType _stemDirection;
    VFStem* _stem;
    float _stem_extension_override;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) VFStem* stem;
@property (assign, nonatomic) BOOL hasStem;
@property (assign, nonatomic) BOOL drawStem;
@property (weak, nonatomic) VFBeam* beam;
/** up or down depending on position on staff and relation to other notes
 */
@property (assign, nonatomic) VFStemDirectionType stemDirection;
@property (assign, nonatomic) float stemExtension;
@property (assign, nonatomic) float stem_extension_override;
@property (strong, nonatomic) VFExtentStruct* stemExtents;
//@property (assign, nonatomic) BOOL postFormatted;
//@property (strong, nonatomic) StemmableNoteRenderOptions *renderOptions;
@property (assign, nonatomic) float shift_x;
//@property (assign, nonatomic, readonly) float stemX;
@property (assign, nonatomic, readonly) float centerGlyphX;
@property (assign, nonatomic, readonly, getter=getStemLength) float height;
//@property (strong, nonatomic) VFTablesGlyphStruct* glyphStruct;
@property (strong, nonatomic) VFGlyph* glyph;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

/*!
 *  gets the stem
 *  @return stem
 */
- (VFStem*)stem;

/*!
 *  sets the stem
 *  @param stem the stem of this note
 */
- (void)setStem:(VFStem*)stem;

/*!
 *  Builds and sets a new stem
 */
- (void)buildStem;

/*!
 *  Get the full length of stem
 *  @return length of stem in pixels
 */
- (float)stemLength;

/*!
 *  Get the count of beams for this duration
 *  @return number of beams
 */
- (NSUInteger)beamCount;

/*!
 *  Get the minimum length of stem
 *  @return length in pixels
 */
- (float)stemMinimumLength;

/*!
 *  Get the direction of the stem
 *  @return +1 is up -1 is down 0 is undecided
 */
- (VFStemDirectionType)stemDirection;

/*!
 *  Set the direction of the stem
 *  @param stemDirection +1 is up -1 is down 0 is undecided
 */
- (void)setStemDirection:(VFStemDirectionType)stemDirection;

/*!
 *  Get the `x` coordinate of the stem
 *  @return x pixel coord
 */
- (float)stemX;

/*!
 *  Get the `x` coordinate for the center of the glyph.
 *  Used for `TabNote` stems and stemlets over rests
 *  @return the center of the x coordinate glyph in global pixels
 */
- (float)centerGlyphX;

/*!
 *  Get the stem extension for the current duration
 *  @return extension of stem in pixels
 */
- (float)stemExtension;

/*!
 *  Set the stem length to a specific. Will override the default length.
 *  @param height stem height in pixels
 */
- (void)setStemLength:(float)height;
/*!
 *  Get the top and bottom `y` values of the stem.
 *  @return pixels struct
 */
- (VFExtentStruct*)stemExtents;
/*!
 *  Sets the current note's beam
 *  @param beam the beam for this note
 */
- (void)setBeam:(VFBeam*)beam;

/*!
 *  Get the `y` value for the top modifiers at a specific `text_line`
 *  @param textLine line number on staff for text
 *  @return y position on canvas
 */
- (float)yForTopText:(NSUInteger)textLine;

/*!
 *  Get the `y` value for the bottom modifiers at a specific `text_line`
 *  @param textLine line number on staff for text
 *  @return y position on canvas
 */
- (float)yForBottomText:(NSUInteger)textLine;

/*!
 *  Post format the note
 *  @return YES if successful
 */
- (BOOL)postFormat;

/*!
 *  Render the stem onto the canvas
 *  @param ctx  graphics context
 *  @param stem stem object to draw
 */
- (void)drawStem:(CGContextRef)ctx withStem:(VFStem*)stem;

@end
