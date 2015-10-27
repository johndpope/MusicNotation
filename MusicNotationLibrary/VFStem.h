//
//  VFStem.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
#import "VFEnum.h"
#import "VFModifier.h"
#import "VFTypes.h"

@class VFBoundingBox, VFExtentStruct, VFRect;

typedef void (^DrawStyle)(CGContextRef);

//======================================================================================================================
/** The `VFStem` gnerally is handled by its parent `StemmableNote`.

 */
@interface VFStem : VFModifier

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) VFStemDirectionType stemDirection;
@property (assign, nonatomic) float extension;

@property (strong, nonatomic) DrawStyle drawStyle;

@property (assign, nonatomic) float x_begin;
@property (assign, nonatomic) float x_end;
@property (assign, nonatomic) float y_top;
@property (assign, nonatomic) float y_bottom;
@property (assign, nonatomic) float y_extend;
@property (assign, nonatomic) float stem_extension;

//@property (assign, nonatomic) VFStemDirectionType stem_direction;

@property (assign, nonatomic) BOOL hide;

@property (strong, nonatomic, readonly) VFExtentStruct* extents;

@property (assign, readonly, nonatomic) float height;

// TODO: make sure style applied when drawn
@property (nonatomic, copy) StyleBlock styleBlock;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithRect:(VFRect*)rect
                 withYExtend:(float)yExtend
           withStemExtension:(float)stemExtension
            andStemDirection:(VFStemDirectionType)stemDirection;

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

- (void)applyStyle:(DrawStyle)drawStyle;

- (void)setNoteHeadXBoundsBegin:(float)x_begin andEnd:(float)x_end;
- (void)setYBoundsTop:(float)y_top andBottom:(float)y_bottom;
- (void)draw:(CGContextRef)ctx;

@end
