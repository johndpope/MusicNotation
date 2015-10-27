//
//  VFCrescendo.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;

#import "VFNote.h"

/** The `VFCrescendo` implements the `Crescendo` object which draws crescendos and
      decrescendo dynamics markings. A `Crescendo` is initialized with a
      duration and formatted as part of a `Voice` like any other `Note`
      type in VexFlow. This object would most likely be formatted in a Voice
      with `TextNotes` - which are used to represent other dynamics markings.

 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFCrescendo : VFNote

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) BOOL decrescendo;
@property (assign, nonatomic) float height;

// Extensions to the length of the crescendo on either side
//@property (assign, nonatomic) float extend_left;
//@property (assign, nonatomic) float extend_right;
// Vertical shift
//@property (assign, nonatomic) float y_shift;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)init;
- (instancetype)initWithNote:(VFNote *)note;

- (void)setHeight:(float)height;

- (void)setDescrescendo:(BOOL)decres;

//- (void)preFormat;

- (void)draw:(CGContextRef)ctx;

@end
