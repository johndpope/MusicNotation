//
//  VFModifierContext.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

@import Foundation;
#import "VFEnum.h"
#import "VFModifier.h"
#import "VFMetrics.h"
#import "IAModelBase.h"
#import "VFDelegates.h"


@interface VFModifierState : NSObject
@property (assign, nonatomic) float left_shift;
@property (assign, nonatomic) float right_shift;
@property (assign, nonatomic) NSUInteger text_line;
@end

//======================================================================================================================
/** The `VFModifierContext` class implements various types of modifiers to notes (e.g. bends,
 fingering positions etc.)
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFModifierContext : IAModelBase //<VFContextDelegate>

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

//@property (strong, nonatomic, readonly) Metrics *metrics;
@property (assign, nonatomic, readonly) float width;
@property (assign, nonatomic, readonly) BOOL preFormatted;
@property (assign, nonatomic, readonly) BOOL postFormatted;
@property (assign, nonatomic, readonly) float spacing;
@property (strong, nonatomic, readonly) VFModifierState *state;
//@property (assign, nonatomic) CGContextRef graphicsContext;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
+ (VFModifierContext *)modifierContext;
- (NSString *)description;
- (void)addModifier:(VFModifier *)modifier;
//- (NSArray *)getModifiersForType:(NSString *)modifierType;

- (NSMutableArray *)getModifiersForType:(NSString *)modifierType;

- (float)getExtraLeftPx;
- (float)getExtraRightPx;


- (BOOL)preFormat;
- (BOOL)postFormat;

@end