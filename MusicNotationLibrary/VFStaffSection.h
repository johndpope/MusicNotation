//
//  VFStaffSection.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFModifier.h"
#import "VFFont.h"

@class VFStaff;

//======================================================================================================================
/** The `VFStaffSection` class draws separation vertical lines between measures on the staff
    and also draws text.

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFStaffSection : VFModifier

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (assign, nonatomic) NSUInteger width;
//@property (assign, nonatomic) float x;
@property (strong, nonatomic) NSString* section;
//@property (strong, nonatomic) VFFont* font;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (VFStaffSection*)staffSectionWithSection:(NSString*)section withX:(float)x yShift:(float)yShift;
//- (instancetype)initWithSection:(NSString *)section withX:(NSUInteger)x yShift:(NSUInteger)yShift;

- (void)draw:(CGContextRef)ctx withStaff:(VFStaff*)staff withShiftX:(float)shiftX;

@end
