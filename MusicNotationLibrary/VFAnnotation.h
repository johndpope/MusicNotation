//
//  VFAnnotation.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFModifier.h"

#import "VFEnum.h"

@class VFNote, VFFont;

//======================================================================================================================
/** The `VFAnnotation` class implements text annotations.

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFAnnotation : VFModifier
{
   @private
    VFJustiticationType _justification;
    VFVerticalJustifyType _verticalJustification;
    NSString* _text;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

// Get and set horizontal justification. `justification` is a value in
//@property (assign, nonatomic) VFJustiticationType justification;

//@property (assign, nonatomic) VFVerticalJustifyType vert_justification;
@property (strong, nonatomic) NSString* text;
//@property (strong, nonatomic) VFFont* font;
//@property (assign, nonatomic) VFJustiticationType justification;
//@property (assign, nonatomic) VFVerticalJustifyType vert_justification;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
+ (VFAnnotation*)annotationWithText:(NSString*)text;

//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state;

- (id)setFontName:(NSString*)fontName withSize:(NSUInteger)size;
- (id)setFontName:(NSString*)fontName withSize:(NSUInteger)size withStyle:(NSString*)style;

- (id)setJustification:(VFJustiticationType)justification;
- (id)setVerticalJustification:(VFVerticalJustifyType)verticalJustification;
- (VFJustiticationType)justification;
- (VFVerticalJustifyType)vert_justification;

@end
