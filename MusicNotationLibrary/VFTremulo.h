//
//  VFTremulo.h
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

//======================================================================================================================
/** The `VFTremulo` class performs ...

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFTremulo : VFModifier

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) float num;
//@property (strong, nonatomic) VFStaffNote* note;
//@property (assign, nonatomic) float index;
@property (assign, nonatomic) VFPositionType position;
//@property (strong, nonatomic) NSString* code;
@property (assign, nonatomic) float shift_right;
@property (assign, nonatomic) float y_spacing;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

@end
