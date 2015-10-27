//
//  VFRect.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
//@import Foundation;
@import UIKit;
#elif TARGET_OS_MAC
@import AppKit;
#endif

//======================================================================================================================
/** The `VFRect` class tests ...
 
 */
@interface VFRect : NSObject
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

+ (VFRect *)boundingBoxAtX:(float)x atY:(float)y withWidth:(float)width andHeight:(float)height;
+ (VFRect *)boundingBoxZero;
+ (VFRect *)boundingBoxWithRect:(CGRect)rect;

- (NSString *)description;

- (void)mergeWithBox:(VFRect *)box; //andDrawWthContext:(CGContextRef)ctx;

@end
