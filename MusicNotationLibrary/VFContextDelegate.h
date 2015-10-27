//
//  VFContext.h
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFDelegates.h"

@class TickableMetrics;

//======================================================================================================================
/** The `VFContextDelegate` protocol

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@protocol VFContextDelegate <NSObject>

@required

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (strong, nonatomic, readonly) id<TickableMetrics> metrics;   // NOTE: should there be separate ContextMetrics
@property (assign, nonatomic) CGContextRef graphicsContext;
@property (assign, nonatomic, readonly) float width;
@property (assign, nonatomic, readonly) BOOL preFormatted;
@property (assign, nonatomic, readonly) BOOL postFormatted;
@property (assign, nonatomic) BOOL shouldIgnoreTicks;
@property (assign, nonatomic) float x;
@property (assign, nonatomic) float pixelsUsed;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (BOOL)preFormat;
- (BOOL)postFormat;

//- (Metrics *)getMetrics;
//- (void)setGraphicsContext:(CGContextRef)graphicsContext;
//- (float)getWidth;
//- (BOOL)getPreFormatted;
//- (BOOL)getPostFormatted;
//- (BOOL)getShouldIgnoreTicks;
- (NSArray*)getCenterAlignedTickables;

//`````````````````````
//
@optional

@end
