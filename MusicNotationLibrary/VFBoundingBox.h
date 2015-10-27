//
//  VFBoundingBox.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFRect.h"


//======================================================================================================================
/** The `VFBoundingBox` class is really just a wrapper around CGRect that allows
    for drawing boxes for debugging.
 
    The following demonstrates some basic usage of this .
 
    ExampleCode
 */
@interface VFBoundingBox : VFRect

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic, readonly) CGRect rect;
@property (assign, nonatomic) float xPosition;
@property (assign, nonatomic) float yPosition;
@property (assign, nonatomic) float width;
@property (assign, nonatomic) float height;
@property (readonly, nonatomic) CGPoint origin;
@property (readonly, nonatomic) float xEnd;
@property (readonly, nonatomic) float yEnd;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithRect:(CGRect)rect;
- (instancetype)initAtX:(float)x atY:(float)y withWidth:(float)width andHeight:(float)height;

+ (VFBoundingBox *)boundingBoxAtX:(float)x atY:(float)y withWidth:(float)width andHeight:(float)height;
+ (VFBoundingBox *)boundingBoxZero;
+ (VFBoundingBox *)boundingBoxWithRect:(CGRect)rect;

- (NSString *)description;

- (void)mergeWithBox:(VFBoundingBox *)box; //andDrawWthContext:(CGContextRef)ctx;
- (void)draw:(CGContextRef)ctx;

@end
