//
//  VFVibrato.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

@import Foundation;
#import "VFModifier.h"
#import "VFOptions.h"
#import "VFEnum.h"

@class VFPoint;

@interface VibratoRenderOptions : Options
@property (assign, nonatomic) float vibrato_width;
@property (assign, nonatomic) float wave_height;
@property (assign, nonatomic) float wave_width;
@property (assign, nonatomic) float wave_girth;
@end

//======================================================================================================================
/** The `VFVibrato` class implements vibratos

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFVibrato : VFModifier
{
    BOOL _harsh;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (assign, nonatomic) BOOL harsh;
//@property (strong, nonatomic) VFPoint *position;
@property (assign, nonatomic) VFPositionType position;
//@property (strong, nonatomic) VibratoRenderOptions *renderOptions;
@property (assign, nonatomic) float vibrato_width;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;

- (id)setVibratoWidth:(float)width;
- (id)setHarsh:(BOOL)harsh;
- (BOOL)harsh;

@end
