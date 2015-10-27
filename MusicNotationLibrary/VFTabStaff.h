//
//  VFTabStaff.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStaff.h"

//======================================================================================================================
/** The `VFTabStaff` class is an implementation of the VFStaff but for guitar tabs

    The following demonstrates some basic usage of this class.

    ExampleCode
 */
@interface VFTabStaff : VFStaff

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

// defined in superclass
//@property (assign, nonatomic) float x;
//@property (assign, nonatomic) float y;
//@property (assign, nonatomic) float width;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

//`````````````````````
// initialization

+ (VFTabStaff*)staffWithRect:(CGRect)rect;

- (instancetype)initWithBoundingBox:(VFBoundingBox*)frame;

+ (VFTabStaff*)tabStaffWithBoundingBox:(VFBoundingBox*)boundingBox;

//`````````````````````
// configuration

/** set the number of lines (property setter)
 *  Note: might not be necessary to explicit declare, but useful for end-user
 *        TODO: read up on objective-c polymorphism
 */
- (void)setNumberOfLines:(float)numberOfLines;

/** gets vertical points position for particular line
 */
- (float)getYForGlyphs;

/** adds "TAB" vertical phrase to the Staff
 */
- (id)addTabGlyph;
@end
