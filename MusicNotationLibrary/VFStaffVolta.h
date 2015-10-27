//
//  VFStaffVolta.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStaffModifier.h"

/*
 Vex.Flow.Volta.type = {
 NONE: 1,
 BEGIN: 2,
 MID: 3,
 END: 4,
 BEGIN_END: 5
 };
 */

//======================================================================================================================
/** The `VFStaffVolta` class performs ...

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFStaffVolta : VFStaffModifier
{
   @private
    float _x;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) VFVoltaType type;
@property (strong, nonatomic) NSString* number;
//@property (assign, nonatomic) float x;
@property (assign, nonatomic) float yShift;

@property (strong, nonatomic) NSString* fontFamily;
@property (assign, nonatomic) NSUInteger fontSize;
@property (assign, nonatomic) BOOL fontWeightBold;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithType:(VFVoltaType)type number:(NSString*)number atX:(float)x yShift:(float)yShift;
- (void)draw:(CGContextRef)ctx staff:(VFStaff*)staff atX:(float)x;

@end
