//
//  VFStaffBarLine.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStaffModifier.h"
#import "VFDelegates.h"

@class VFStaffBarLine;

// TODO: are these typedefs necessary?
typedef VFStaffBarLine VFBarLine;
//typedef VFStaffBarLine VFStaffLine;

@class VFStaff, StaffLineRenderOptions;

//======================================================================================================================
/** The `VFStaffBarLine` class modifies a `VFStaff` object.

    Implements barlines (single, double, repeat, end)

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFStaffBarLine : VFStaffModifier   //<VFDrawableDelegate>
{
    //    __weak VFStaff* _staff;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (assign, nonatomic) VFBarLineType barLinetype;

@property (assign, nonatomic, readonly) BOOL doubleBar;
@property (strong, nonatomic) NSString* text;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

//`````````````````````
// initializers

//- (instancetype)initWithType:(VFBarLineType)type AtX:(float)x;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
+ (VFStaffBarLine*)barLineWithType:(VFBarLineType)type atX:(float)x;

//`````````````````````
//

- (void)setX:(float)x;

- (void)draw:(CGContextRef)ctx;

@end

