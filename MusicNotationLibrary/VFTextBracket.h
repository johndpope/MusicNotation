//
//  VFTextBracket.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Complete

#import "VFModifier.h"

typedef NS_ENUM(NSInteger, VFTextBracketPosition) {
    VFTextBrackTop = 1,
    VFTextBracketBottom = -1,
};

@class VFLine, VFFont, VFStaffNote;

//======================================================================================================================
/** The `VFTextBracket` class implement `TextBrackets` which extend between two notes.
      The octave transposition markings (8va, 8vb, 15va, 15vb) can be created
      using this class.
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFTextBracket : VFModifier
#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (assign, nonatomic) BOOL dashed;
@property (assign, nonatomic) float line;
//@property (strong, nonatomic) VFFont *font;

@property (strong, nonatomic) VFStaffNote *start;
@property (strong, nonatomic) VFStaffNote *stop;
@property (strong, nonatomic) NSString *text;
@property (strong, nonatomic) NSString *superscript;
@property (assign, nonatomic) VFTextBracketPosition position;

@property (strong, nonatomic) NSString *fontFamily;
@property (assign, nonatomic) float fontSize;
@property (assign, nonatomic) BOOL fontBold;
@property (assign, nonatomic) BOOL fontItalic;

@property (strong, nonatomic) NSArray *dash;

@property (assign, nonatomic) float lineWidth;
@property (assign, nonatomic) BOOL showBracket;
@property (assign, nonatomic) float bracketHeight;
@property (assign, nonatomic) BOOL underlineSuperscript;
#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */


@end
