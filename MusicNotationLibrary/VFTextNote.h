//
//  VFTextNote.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFNote.h"
/*
 Vex.Flow.TextNote.Justification = {
 LEFT: 1,
 CENTER: 2,
 RIGHT: 3
 };
 */

//======================================================================================================================
/** The `VFTextNote` class performs ...

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFTextNote : VFNote

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (strong, nonatomic) VFGlyph* glyph;
@property (strong, nonatomic) NSString* text;
@property (strong, nonatomic) NSString* glyph_type;
//@property (assign, nonatomic) float line;
@property (assign, nonatomic) BOOL smooth;
@property (assign, nonatomic) BOOL ignore_ticks;
@property (assign, nonatomic) VFJustiticationType justification;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

@end
