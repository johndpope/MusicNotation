//
//  VFClefNote.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFNote.h"

@class VFClef, VFGlyph;

//======================================================================================================================
/** The `VFClefNote` class tests ...

 */
@interface VFClefNote : VFNote
#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) NSString* clefName;
@property (strong, nonatomic) NSString* clefSize;
@property (assign, nonatomic) VFClefType clefType;
//@property (strong, nonatomic) VFClef* clef;
@property (strong, nonatomic) VFGlyph* glyph;
@property (strong, nonatomic) NSString* annotationName;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
+ (VFClefNote*)clefNoteWithClef:(NSString*)clef;
+ (VFClefNote*)clefNoteWithClef:(NSString*)clef size:(NSString*)size;
+ (VFClefNote*)clefNoteWithClef:(NSString*)clef size:(NSString*)size annotation:(NSString*)annotation;

@end
