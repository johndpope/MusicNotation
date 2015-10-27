//
//  VFGhostNote.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStemmableNote.h"

@class VFStaff;

//======================================================================================================================
/** The `VFGhostNote` class performs ...
 
    The following demonstrates some basic usage of this .
 
    ExampleCode
 */
@interface VFGhostNote : VFStemmableNote

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic, readonly) BOOL isRest;
//@property (strong , nonatomic) NSArray *modifiers;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithNote:(VFNote *)note;
- (void)draw:(CGContextRef)ctx;

@end
