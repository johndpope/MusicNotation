//
//  VFArticulation.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFModifier.h"
#import "VFEnum.h"

//@interface ArticulationState : NSObject
//@property (assign, nonatomic) float left_shift;
//@property (assign, nonatomic) float right_shift;
//@property (assign, nonatomic) float text_line;
//- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
//@end

@class VFStaffNote;

//======================================================================================================================
/** The `VFArticulation` class articulations and accents as modifiers that can be
      attached to notes. The complete list of articulations is available in
      `vftables ` under `articulationCodes`.

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFArticulation : VFModifier
{
   @private
    VFModifierState* _state;
    VFArticulation* _articulation;
    VFArticulationType _articulationType;
    __unsafe_unretained NSString* _articulationCode;

    float _shiftRight;
    float _shiftUp;
    float _shiftDown;
    BOOL _betweenLines;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
//@property (weak, nonatomic) VFStaffNote *note;
//@property (strong, nonatomic) VFModifierState* state;
//@property (assign, nonatomic) NSUInteger index;
@property (strong, nonatomic) VFArticulation* articulation;
@property (assign, nonatomic) VFArticulationType articulationType;
//@property (assign, nonatomic) VFPositionType position;
@property (assign, nonatomic, readonly) NSString* articulationCode;

@property (assign, nonatomic) float shiftRight;
@property (assign, nonatomic) float shiftUp;
@property (assign, nonatomic) float shiftDown;
@property (assign, nonatomic) BOOL betweenLines;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithType:(VFArticulationType)articulationType;

//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state;

- (id)setPosition:(VFPositionType)positionType;

@end
