//
//  VFShift.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

//#import <Cocoa/Cocoa.h>

#import "VFEnum.h"

//======================================================================================================================
/** The `Shift` class is a container for shifting 
 */
@interface Shift : NSObject

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) float shiftX;
@property (assign, nonatomic) float shiftY;
@property (assign, nonatomic) VFShiftDirectionType justification;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
+ (Shift *)shiftWithX:(float)shiftX andY:(float)shiftY;
+ (Shift *)shiftWithX:(float)shiftX;
+ (Shift *)shiftWithY:(float)shiftY;
+ (Shift *)shiftWithY:(float)shiftY justification:(VFShiftDirectionType)justification;

@end
