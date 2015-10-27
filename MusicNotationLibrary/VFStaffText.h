//
//  VFStaffText.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;

#import "VFStaffModifier.h"

@class VFFont;

//======================================================================================================================
/** The `VFStaffText` class performs ...
 /
 The following demonstrates some basic usage of this .

 ExampleCode
 */
@interface VFStaffText : VFStaffModifier
{
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (strong, nonatomic) VFFont* font;
@property (strong, nonatomic) NSString* fontFamily;
@property (assign, nonatomic) NSUInteger fontSize;
@property (strong, nonatomic) NSString* text;
@property (assign, nonatomic) float shift_x;
@property (assign, nonatomic) float shift_y;
@property (assign, nonatomic) CTTextAlignment justification;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

- (instancetype)initWithText:(NSString*)text atPosition:(VFPositionType)position WithOptions:(NSDictionary*)optionsDict;

@end
