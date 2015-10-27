//
//  VFPoint.h
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
//@import Foundation;
@import UIKit;
#elif TARGET_OS_MAC
@import AppKit;
#endif

//======================================================================================================================
/** The `VFPoint` class represents a cartesian point
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFPoint : NSObject

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (assign, nonatomic) float x;
@property (assign, nonatomic) float y;
@property (readonly, nonatomic) CGPoint CGPoint;
#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithX:(float)x andY:(float)y;
+ (VFPoint *)pointWithX:(float)x andY:(float)y;
+ (VFPoint *)pointZero;

- (NSString *)toString;

- (float)distance:(VFPoint *)otherPoint;
- (void)translateByX:(float)x andY:(float)y;
- (void)setX:(float)x andY:(float)y;
//- (CGPoint)CGPoint;


@end
