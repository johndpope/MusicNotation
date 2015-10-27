//
//  VFNoteHead.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
//#import "VFModifier.h"
#import "VFNote.h"
#import "VFTypes.h"
#import "VFOptions.h"
#import "VFRenderOptions.h"
#import "VFEnum.h"

@class VFBoundingBox, VFColor, VFStaffNote, VFStaff;
@class NoteHeadRenderOptions, VFTablesGlyphStruct;

//======================================================================================================================
/** The `VFNoteHead` implements `NoteHeads`. `NoteHeads` are typically not manipulated
  directly, but used internally in `StaffNote`.

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface VFNoteHead : VFNote
{
   @private
//    __weak VFStaff* _staff;
    //    float _x;
    //    float _y;
}
#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

// Determine if the notehead is displaced
//@property (assign, nonatomic) BOOL displaced;

// Get/set the notehead's style
@property (assign, nonatomic) BOOL shadowBlur;
@property (strong, nonatomic) VFColor* shadowColor;
@property (strong, nonatomic) VFColor* fillColor;
@property (strong, nonatomic) VFColor* strokeColor;

// Set the X coordinate
@property (assign, nonatomic) float x;

// get/set the Y coordinate
@property (assign, nonatomic) float y;

// Get/set the stave line the notehead is placed on
//@property (assign, nonatomic) float line;

@property (assign, nonatomic) BOOL useCustomGlyph;
@property (strong, nonatomic) NSString* customGlyphCode;

//@property (assign, nonatomic) float extraLeftPx;
//@property (assign, nonatomic) float extraRightPx;

// Get/set the notehead's style
//
// `style` is an `object` with the following properties: `shadowColor`,
// `shadowBlur`, `fillStyle`, `strokeStyle`
@property (strong, nonatomic) NSDictionary* style;

@property (assign, nonatomic) VFStemDirectionType stemDirection;

// TODO: make sure style applied when drawn
@property (nonatomic, copy) StyleBlock styleBlock;

//@property (weak, nonatomic) VFStaff* staff;

//@property (strong, nonatomic) NoteHeadOptions *headRenderOptions;
@property (strong, nonatomic) NSString* noteTypeString;
//@property (assign, nonatomic) VFNoteNHMRSType noteNHMRSType;
@property (strong, nonatomic) NSString* noteName;
//@property (assign, nonatomic) VFNoteDurationType noteDurationType;
//@property (strong, nonatomic) NSString* duration;
@property (strong, nonatomic) NSString* glyph_code;

//@property (assign, nonatomic) NSInteger index;
//@property (assign, nonatomic) VFNoteType note_type;
@property (assign, nonatomic) BOOL slashed;
//@property (assign, nonatomic) BOOL displaced;
@property (assign, nonatomic) VFStemDirectionType stem_direction;
@property (assign, nonatomic) BOOL custom_glyph;
//@property (assign, nonatomic, setter=setGlyphFontScale:) float glyphFontScale;
//@property (strong, nonatomic) VFTablesGlyphStruct* glyphStruct;

@property (assign, nonatomic) float headWidth;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

+ (VFNoteHead*)noteHeadWithOptionsDict:(NSDictionary*)optionsDict;

@end

@interface NoteHeadRenderOptions : RenderOptions

@property (assign, nonatomic) float glyphFontScale;
@property (assign, nonatomic) float strokePx;

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

@end