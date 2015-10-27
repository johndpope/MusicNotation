//
//  VFTabNote.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStemmableNote.h"
#import "VFOptions.h"

@interface TabNoteRenderOptions : RenderOptions
{
   @private
    float _glyph_font_scale;
    BOOL _draw_stem;
    BOOL _draw_dots;
    float _draw_stem_through_staff;
}
@property (assign, nonatomic) float glyph_font_scale;
@property (assign, nonatomic) BOOL draw_stem;
@property (assign, nonatomic) BOOL draw_dots;
// Flag to extend the main stem through the staff and fret positions
@property (assign, nonatomic) float draw_stem_through_staff;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

@interface TabNotePositionsStruct : NSObject
{
   @private
    NSUInteger _str;
    NSUInteger _fret;
}
@property (assign, nonatomic) NSUInteger str;
@property (assign, nonatomic) NSUInteger fret;
@end

@class VFGhostNote, VFTabStaff;

//======================================================================================================================
/** The `VFTabNote` implements notes for Tablature notation. This consists of one or
  more fret positions, and can either be drawn with or without stems.


    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFTabNote : VFStemmableNote

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) VFGhostNote* ghostNote;
@property (assign, nonatomic) BOOL ghost;
//@property (weak, nonatomic) VFStaff* staff;
@property (strong, nonatomic) NSMutableArray* positions;   // positions for the notes in a chord
@property (assign, nonatomic) float stemY;
//@property (assign, nonatomic) float stemX;
@property (strong, nonatomic) NSArray* stem_extents;
//@property (strong, nonatomic) TabNoteOptions *renderOptions;
@property (strong, nonatomic) NSMutableArray* glyphs;   // array of VFGlyphTabStruct
//@property (weak, nonatomic) VFTabStaff* staff; //FIXME:rename to tabStaff?
@property (weak, nonatomic) VFTabStaff* tabStaff;
//@property (strong, nonatomic) VFTablesGlyphStruct* glyphStruct;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

- (TabNoteRenderOptions*)renderOptions;

//- (void)setGhost:(VFGhostNote*)ghost;
//- (BOOL)hasStem;
//- (float)getStemExtension;
/*!
 *  Add a dot to the note
 *  @return this object
 */
- (id)addDot;
//- (void)updateWidth;
//- (void)setStaff:(VFStaff*)staff;
//- (NSArray*)getPositions;
//- (void)addToModifierContext:(VFModifierContext*)mc;
//- (float)getTieRightX;
//- (float)getTieLeftX;
//- (VFPoint*)getModifierStartXY;
//- (BOOL)preFormat;
//- (float)getLineForRest;
//- (float)getStemX;
//- (float)getStemY;
//
//- (NSArray*)getStemExtents;
//- (void)drawFlag:(CGContextRef)ctx;
//- (void)drawModifiers:(CGContextRef)ctx;
//- (void)drawStemThrough:(CGContextRef)ctx;
//- (void)drawPositions:(CGContextRef)ctx;
//- (void)draw:(CGContextRef)ctx;

@end
