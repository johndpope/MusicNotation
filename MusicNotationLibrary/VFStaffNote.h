//
//  VFStaffNote.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStemmableNote.h"
#import "VFModifier.h"
#import "VFStaff.h"
#import "VFDelegates.h"
//#import "VFRenderOptions.h"
#import "VFTypes.h"
#import "VFTablesGlyphStruct.h"

@class VFAccidental, VFArticulation, VFPoint;
@class VFAnnotation, VFModifierContext, VFTuplet, VFTablesGlyphStruct;
@class NoteHeadBounds, StaffNoteRenderOptions;

//======================================================================================================================
/** The `VFStaffNote` class calculates the position and renders a note to a staff.

 In music, the term note has two primary meanings:
 A sign used in musical notation to represent the relative duration and pitch of a sound;
 A pitched sound itself.

 Notes are the "atoms" of much Western music: discretizations of musical phenomena that
    facilitate performance, comprehension, and analysis.[1]

 The term note can be used in both generic and specific senses: one might say either "the
    piece 'Happy Birthday to You' begins with two notes having the same pitch," or "the
    piece begins with two repetitions of the same note." In the former case, one uses note
    to refer to a specific musical event; in the latter, one uses the term to refer to a
    class of events sharing the same pitch.


    The following demonstrates some basic usage of this class.

        ExampleCode
 */
@interface VFStaffNote : VFStemmableNote
{
    __weak VFStaff* _staff;

    NSString* _category;
    NSString* _positionString;
    NSString* _codeHead;

    NSMutableArray* _accidentals;
    //    NSMutableArray* _dots;
    //    __weak VFStaff *_staff;

    BOOL _rest;
    BOOL _renderStem;
    float _stemLengthHeight;
    BOOL _use_default_head_x;

    //    VFTuplet* _tuplet;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

//@property (assign, nonatomic) VFStaff *staff;
- (id)setStaff:(VFStaff*)staff;
- (VFStaff*)staff;

/** the type of note as a string to access in the tables dictionary
 */
//@property (strong, nonatomic) NSString *category;
@property (strong, nonatomic) NSString* position;

/** spacing between different modifiers and annotations of this note
 */
//@property (strong, nonatomic) StaffNoteOptions *renderOptions;
@property (strong, nonatomic) NSMutableArray* accidentals;
@property (strong, nonatomic) NSMutableArray* note_heads;

//@property (strong, nonatomic) NSArray *notes;

//`````````````````````
// property primitives

@property (assign, nonatomic) BOOL renderStem;

///** is this note object a rest? YES/NO
// */
//@property (assign, nonatomic, getter = isRest) BOOL rest;

/** displace note to right? YES/NO
 */
@property (assign, nonatomic, getter=isDisplaced) BOOL notesDisplaced;

/** the height of the stem
 */
@property (assign, nonatomic) float stemHeight;

/** allow to manually set note stem length, the length of the stem
    same as the height of the stem
 */
@property (assign, nonatomic) float stemLength;

/** height above this note that the dot belongs (this might better
    belong in renderOptions
 */
@property (assign, nonatomic) float dotShiftY;

//@property (assign, nonatomic) NSUInteger numDots;

/** the width of the note head
 */
@property (assign, nonatomic) float headWidth;

/** the x-direction offset from the oval that the stem is drawn from the head
 */
@property (assign, nonatomic) float stemOffset;

/** the stem maximum length
 */
@property (assign, nonatomic) float stemMaxLength;

/** the stem minimum length
 */
@property (assign, nonatomic) float stemMinLength;

@property (assign, nonatomic) float yForTopText;

@property (assign, nonatomic) float yForBottomText;

@property (strong, nonatomic) NoteHeadBounds* noteHeadBounds;

/** the staff parent that this note object is drawn to
 *  @note when the staff is set the ys array for the notes is configured
        using the key properties, ie. this is important
 */

///**  minimum length of stem
// */
//@property (assign, nonatomic) float stemMinumumLength;

/** the x-position on the staff that the stem occupies
 */
//@property (assign, nonatomic) float stemX;

/** left-most x-position of note tie
 */
@property (assign, nonatomic) float tieLeftX;

/** right-most x-position of note tie
 */
@property (assign, nonatomic) float tieRightX;

/** the line on the staff that this rest object occupies
 */
@property (assign, nonatomic) NSUInteger getLineForRest;

/**
 */
//@property (assign, nonatomic) float voiceShiftWidth;

//@property (assign, nonatomic) BOOL preFormatted;

@property (assign, nonatomic) BOOL flag;

@property (assign, nonatomic) NSUInteger beamCount;

@property (strong, nonatomic) NSString* codeFlagUpstem;

@property (strong, nonatomic) NSString* codeFlagDownstem;

@property (assign, nonatomic) BOOL isSlash;
@property (assign, nonatomic) BOOL isSlur;
@property (assign, nonatomic) BOOL use_default_head_x;

@property (nonatomic, copy) StyleBlock styleBlock;

//@property (strong, nonatomic) NSMutableArray* keyProps;   // the properties for all the keys in the note

@property (assign, nonatomic) float octaveShift;
@property (strong, nonatomic) NSString* clefName;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

//- (instancetype)initWithNote:(VFNote *)note;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

//+ (VFStaffNote *)noteWithDict:(NSDictionary *)dict;
//+ (VFStaffNote *)noteWithNote:(VFNote *)note;
+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration;
+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration autoStem:(BOOL)autoStem;
+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration andClef:(NSString*)clef;
+ (VFStaffNote*)noteWithKeys:(NSArray*)keys
                 andDuration:(NSString*)duration
                     andClef:(NSString*)clef
                 octaveShift:(float)octaveShift;
//+ (VFStaffNote *)noteWithKeys:(NSArray*)keys andDuration:(NSString *)duration autoStem:(BOOL)autoStem;
+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration dots:(NSUInteger)dots;
+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration type:(NSString*)type;
+ (VFStaffNote*)noteWithKeys:(NSArray*)keys andDuration:(NSString*)duration dots:(NSUInteger)dots type:(NSString*)type;

//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state;

- (float)getYForTopText:(float)textLine;
- (float)getYForBottomText:(float)textLine;
- (VFPoint*)getModifierstartXYforPosition:(VFPositionType)position andIndex:(NSUInteger)index;

- (void)setKeyLine:(NSUInteger)index withLine:(NSUInteger)line;
- (NSUInteger)getLineNumber:(BOOL)is_top_note;

- (float)tieRightX;
- (float)tieLeftX;

- (VFStaffNote*)addAccidental:(VFAccidental*)accidental atIndex:(NSUInteger)index;
- (id)addArticulation:(VFArticulation*)articulation;
- (id)addArticulation:(VFArticulation*)articulation atIndex:(NSUInteger)index;

- (id)addAnnotation:(VFAnnotation*)annotation atIndex:(NSUInteger)index;
- (id)addDotAtIndex:(NSUInteger)index;

- (VFStaffNote*)addDotToAll;

+ (BOOL)formatByY:(NSMutableArray*)notes state:(VFModifierState*)state;
//- (BOOL)preFormat;
//- (BOOL)postFormat:(NSArray*)notes;
+ (BOOL)postFormat:(NSMutableArray*)modifiers;

- (NSArray*)getDots;

//- (void)drawStem:(CGContextRef)ctx withStem:(VFStem*)stemStruct;

+ (VFStaffNote*)showNoteWithDictionary:(NSDictionary*)noteStruct
                           withContext:(CGContextRef)ctx
                               onStaff:(VFStaff*)staff
                                   atX:(float)x;
//CALayer Methods
- (CGMutablePathRef)path;
- (CAShapeLayer*)shapeLayer;

#if TARGET_OS_IPHONE
+ (UIImage*)imageForNoteWithDictionary:(NSDictionary*)noteStruct rect:(CGRect)rect;
+ (UIImage*)imageForNote:(VFStaffNote*)note rect:(CGRect)rect;
#endif

@end

@interface StaffNoteRenderOptions : NoteRenderOptions
@property (assign, nonatomic) float glyphFontScale;
@property (assign, nonatomic) float stemHeight;
@property (assign, nonatomic) float strokeSpacing;
@property (assign, nonatomic) float strokePx;
@property (assign, nonatomic) float annotation_spacing;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

@interface NoteHeadBounds : NSObject
@property (assign, nonatomic) float y_top;
@property (assign, nonatomic) float y_bottom;
@property (assign, nonatomic) float highest_line;
@property (assign, nonatomic) float lowest_line;
@end
