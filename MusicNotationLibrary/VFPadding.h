//
//  VFPadding.h
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;

@class VFPoint;

//======================================================================================================================
/** The `VFPadding` class performs ...
 
    The following demonstrates some basic usage of this .
 
    ExampleCode
 */
@interface VFPadding : NSObject

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

/** coordinate of this padding
 */
@property (strong, nonatomic) VFPoint *point;

/** amount of padding to other elements
 */
@property (assign, nonatomic) float xRightPadding;
@property (assign, nonatomic) float xLeftPadding;
@property (assign, nonatomic) float yUpPadding;
@property (assign, nonatomic) float yDownPadding;

@property (assign, nonatomic, readonly) float width;
@property (assign, nonatomic, readonly) float height;


#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

//`````````````````````
// initializers

- (instancetype)initWithXRightPadding:(float)xRight
            andXLeftPadding:(float)xLeft
              andYUpPadding:(float)yUp
            andYDownPadding:(float)yDown;

- (instancetype)initWithXRightPadding:(float)xRight
            andXLeftPadding:(float)xLeft;

- (instancetype)initWithX:(float)x andY:(float)y;

//`````````````````````
// class methods

+ (VFPadding *)paddingWithX:(float)x
                       andY:(float)y;

+ (VFPadding *)paddingWithRightPadding:(float)xRight
                       andXLeftPadding:(float)xLeft
                         andYUpPadding:(float)yUp
                       andYDownPadding:(float)yDown;

+ (VFPadding *)paddingWith:(float)padding;

+ (VFPadding *)paddingZero;

//`````````````````````
// quick padding for everything

- (void)addPaddingToAllSidesWith:(float)padding;
- (void)padAllSidesBy:(float)padding;


@end
