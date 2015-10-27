//
//  VFLine.h
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;

//======================================================================================================================
/** The `VFLine` class performs ...
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFLine : NSObject

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) float startX;
@property (assign, nonatomic) float startY;
@property (assign, nonatomic) float endX;
@property (assign, nonatomic) float endY;
@property (assign, nonatomic) BOOL visible;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initAtStartX:(float)x startY:(float)y endX:(float)endX endY:(float)endY;
+ (VFLine *)lineAtStartX:(float)x startY:(float)y endX:(float)endX endY:(float)endY;

@end