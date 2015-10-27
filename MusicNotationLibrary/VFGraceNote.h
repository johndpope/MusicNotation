//
//  VFGraceNote.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFStaffNote.h"

@class GraceNoteOptions;

//======================================================================================================================
/** The `VFGraceNote` class tests ...

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface VFGraceNote : VFStaffNote

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

//@property (assign, nonatomic) float stroke_px;
//@property (strong, nonatomic) GraceNoteOptions *renderOptions;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

//- (instancetype)initWithStaffNote:(VFStaffNote *)staffNote;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (float)getStemExtension;
- (void)draw:(CGContextRef)ctx;

@end

@interface GraceNoteOptions : RenderOptions
@property (assign, nonatomic) NSUInteger glyphFontScale;
@property (assign, nonatomic) NSUInteger stemHeight;
@property (assign, nonatomic) NSUInteger strokePoints;
@end
