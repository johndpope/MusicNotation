//
//  VFBend.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFModifier.h"
#import "VFOptions.h"

@class VFColor;

@interface BendRenderOptions : Options
@property (assign, nonatomic) float line_width;
//@property (strong, nonatomic) VFColor *line_style;
@property (strong, nonatomic) NSString* line_style;
@property (assign, nonatomic) float bend_width;
@property (assign, nonatomic) float release_width;

@property (assign, nonatomic) CGPatternRef pattern;
@property (strong, nonatomic) NSArray* components;
@end

//======================================================================================================================
/** The `VFBend` class makes tablature bends

    The following demonstrates some basic usage of this .

 @constructor

 @param text Text for bend ("Full", "Half", etc.) (DEPRECATED)
 @param release If YES, render a release. (DEPRECATED)
 @param phrase If set, ignore "text" and "release", and use the more
 sophisticated phrase specified.

    Example of a phrase

 @[@{
        @"type" : @(VFBendUP),
        @"text" : @"whole"
        @"width" : @8;
    },
    @{
        @"type" : @(VFBendDOWN),
        @"text" : @"whole"
        @"width" : @8;
    },
    @{
         @"type" : @(VFBendUP),
         @"text" : @"half"
         @"width" : @8;
     },
     @{
         @"type" : @(VFBendUP),
         @"text" : @"whole"
         @"width" : @8;
     },
     @{
         @"type" : @(VFBendDOWN),
         @"text" : @"1 1/2"
         @"width" : @8;
     }]
 */
@interface VFBend : VFModifier
{
    NSString* _text;
    //    float           _x_shift;
    BOOL _release_;
    NSString* _fontName;
    NSMutableArray* _phrase;
    float _draw_width;
    VFBendDirectionType _type;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) NSString* text;
//@property (assign, nonatomic) float x_shift;
@property (assign, nonatomic) BOOL release_;
@property (strong, nonatomic) NSString* fontName;
@property (strong, nonatomic) NSMutableArray* phrase;   // array of VFBendStruct objects
@property (assign, nonatomic) float draw_width;
@property (assign, nonatomic) VFBendDirectionType type;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithText:(NSString*)text;
- (instancetype)initWithPhrase:(NSArray*)phrase;
- (instancetype)initWithText:(NSString*)text release:(BOOL)release phrase:(NSArray*)phrase;
+ (VFBend*)bendWithText:(NSString*)text;

//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state;

@end

@interface VFBendStruct : IAModelBase
@property (assign, nonatomic) VFBendDirectionType type;
@property (strong, nonatomic) NSString* text;
@property (assign, nonatomic) float width;
@property (assign, nonatomic) float draw_width;
+ (VFBendStruct*)bendStructWithType:(VFBendDirectionType)type andText:(NSString*)text;
@end