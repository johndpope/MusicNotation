//
//  VFOrnament.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFModifier.h"
#import "VFEnum.h"

// Not Finished
// Complete

@class VFAccidental, VFStaffNote, OrnamentData;

//======================================================================================================================
/** The `VFOrnament` class implements ornaments as modifiers that can be
      attached to notes. The complete list of ornaments is available in
      `tables.js` under `Vex.Flow.ornamentCodes`.

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface VFOrnament : VFModifier
{
   @private
    NSString* _type;
    VFPositionType _position;
    BOOL _delayed;
    NSString* _accidental_upper;
    NSString* _accidental_lower;
    float _font_scale;

    float _shiftRight;
    float _shift_y;
    float _shiftUp;

    OrnamentData* ornament;
}
#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (strong, nonatomic) VFStaffNote *note;
//@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) NSString* type;
@property (assign, nonatomic) VFPositionType position;
//@property (assign, nonatomic) BOOL delayed;
@property (strong, nonatomic) NSString* accidental_upper;
@property (strong, nonatomic) NSString* accidental_lower;
@property (assign, nonatomic) float font_scale;
//@property (strong, nonatomic) VFAccidental *accidental_upper;
//@property (strong, nonatomic) VFAccidental *accidental_lower;

@property (assign, nonatomic, readonly) float shiftRight;
@property (assign, nonatomic, readonly) float shift_y;
@property (assign, nonatomic, readonly) float shiftUp;

@property (strong, nonatomic) OrnamentData* ornament;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
+ (VFOrnament*)ornamentWithType:(NSString*)type;

//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state;

- (id)setDelayed:(BOOL)delayed;
- (BOOL)delayed;
- (id)setUpperAccidental:(NSString*)accidental;
- (id)setLowerAccidental:(NSString*)accidental;

@end
