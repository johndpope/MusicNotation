//
//  VFOptions.h
//  VFVexCore
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
#import "VFColor.h"
#import "IAModelBase.h"

@class Options;

//======================================================================================================================
/** The `Options` class holds various properties for rendering and general drawing 
    "options".
 
    The following demonstrates some basic usage of this class.
 
    [Options options];
    options.code = @"v4b";
    options.fillColor = [UIColor redColor];
    options.visible = NO;
    options.cache = YES;
    options.strokePoints = 5.0f;

 */
@interface Options : IAModelBase {
}
#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

//`````````````````````
// property objects

@property (strong, nonatomic) NSString *font;

@property (strong, nonatomic) NSString *code;

@property (strong, nonatomic) VFColor *fillColor;

@property (strong, nonatomic) VFColor *strokeColor;

//`````````````````````
// property primitives

@property (assign, nonatomic) BOOL cache;

@property (assign, nonatomic) BOOL visible;

@property (assign, nonatomic) float strokePoints;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
+ (Options *)options;

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

@end

