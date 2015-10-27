//
//  VFStaffTempo.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFStaffModifier.h"
#import "VFEnum.h"
#import "IAModelBase.h"

@class VFFont;   // TODO: delete this file --> Tempo.h

@interface TempoOptions : IAModelBase
@property (assign, nonatomic) NSUInteger glyphFontScale;
@end

@interface TempoOptionsStruct : IAModelBase
@property (strong, nonatomic) NSString* name;
@property (assign, nonatomic) float duration;
@property (assign, nonatomic) NSUInteger dots;
@property (assign, nonatomic) float bpm;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
@end

//======================================================================================================================
/** The `VFStaffTempo` class performs tempo markers

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFStaffTempo : VFStaffModifier
{
   @private
    float _x;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (strong, nonatomic) TempoOptionsStruct* tempo;
//@property (assign, nonatomic) float x;
@property (assign, nonatomic) float shiftX;
@property (assign, nonatomic) float shiftY;
//@property (assign, nonatomic) VFPositionType position;

//@property (strong, nonatomic) VFFont* font;
@property (strong, nonatomic) NSString* fontFamily;
@property (assign, nonatomic) float fontSize;
@property (assign, nonatomic) BOOL fontWeightBold;

//@property (strong, nonatomic) TempoOptions* options;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithTempo:(TempoOptionsStruct*)tempo atX:(float)x withShiftY:(float)shiftY;
- (void)draw:(CGContextRef)ctx toStaff:(VFStaff*)staff withShiftX:(float)shiftX;
//- (void)setTempo:(TempoOptionsStruct*)tempo;
- (void)setShiftX:(float)shiftX;
- (void)setShiftY:(float)shiftY;

@end
