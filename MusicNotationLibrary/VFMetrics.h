//
//  VFMetrics.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
@import Foundation;
#elif TARGET_OS_MAC
@import AppKit;
#endif

//#import "VFDelegates.h"
#import "IAModelBase.h"
//#import "VFPair.h"

@class VFFloatSize, VFColor;
@class VFPoint, VFBoundingBox, VFPadding;

//======================================================================================================================
/** The `Metrics` class is a container for all the positioning, spacing,
     direction, scale, and every other possible number you can assign to a thing that is
     gonna be stored, compared, calculated and drawn for music notation.

     The following demonstrates some basic usage of this class.

     ExampleCode
 */
@interface Metrics : IAModelBase
{
   @private
    NSString* _code;
    NSString* _name;
}
#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) float xMin;
@property (assign, nonatomic) float xMax;
@property (assign, nonatomic) float width;
@property (assign, nonatomic) float scale;
@property (assign, nonatomic) float length;

@property (assign, nonatomic) float notePoints;

// parent parent properties
@property (weak, nonatomic) id parent;
@property (assign, nonatomic) NSUInteger line;
@property (assign, nonatomic) float minLine;
@property (assign, nonatomic) float maxLine;
@property (assign, nonatomic) float lineAbove;
@property (assign, nonatomic) float lineBelow;
@property (assign, nonatomic) float textLine;
@property (assign, nonatomic) float spacing;

@property (assign, nonatomic) BOOL cached;
@property (strong, nonatomic) NSString* code;   // name ~ code ~ key
//@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString* name;
//@property (strong, nonatomic) NSString* font;
@property (strong, nonatomic) NSArray* arrayOutline;
@property (strong, nonatomic) NSString* stringOutline;

@property (strong, nonatomic) VFPoint* point;
//@property (strong, nonatomic) VFPoint* shift;
@property (strong, nonatomic) VFBoundingBox* bounds;

// used by VFTickContext
//@property (strong, nonatomic) VFPadding* padding;
//@property (strong, nonatomic) VFPadding *extra;
//@property (strong, nonatomic) VFPadding* mod;

//@property (strong, nonatomic) VFColor* strokeColor;
//@property (strong, nonatomic) VFColor* fillColor;

//@property (assign, nonatomic) CGContextRef graphicsContext;

//@property (weak, nonatomic) id<VFContextDelegate> context;

@property (strong, nonatomic) VFFloatSize* size;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithMetrics:(Metrics*)other;
+ (Metrics*)standardMetrics;
+ (Metrics*)metricsZero;
/*!
 *  gets a short description of this object
 *  @return a string showing properties of this object
 */
- (NSString*)description;

@end
