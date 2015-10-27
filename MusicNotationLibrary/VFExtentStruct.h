//
//  VFExtent.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;

//======================================================================================================================
/** The `VFAbcXyz` class holds a pair of floats
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFExtentStruct : NSObject
#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (assign, nonatomic) float topY;
@property (assign, nonatomic) float baseY;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
//- (instancetype)initWithTopY:(float)topY andBaseY:(float)baseY;
+ (VFExtentStruct *)extentWithTopY:(float)topY andBaseY:(float)baseY;

@end

//======================================================================================================================

//======================================================================================================================
/** The `StemExtent` class is a tuple container used to store the positions used for
 representing a stem attached to a staff note.
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
//@interface StemExtent : VFPair { }
//
//@property (assign, nonatomic) float baseY;
//@property (assign, nonatomic) float topY;
//
//@end
