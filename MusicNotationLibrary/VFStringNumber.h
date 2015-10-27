//
//  VFStringNumber.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFModifier.h"

@class VFStaffNote;

//======================================================================================================================
/** The `VFStringNumber` which renders string
      number annotations beside notes.

 The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFStringNumber : VFModifier
{
    NSArray* _nums;
    VFStaffNote* _lastNote;
    VFRendererLineEndType _lineEndType;
    NSUInteger _y_offset;
    NSUInteger _x_offset;
    BOOL _dashed;
    VFRendererLineEndType _leg;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) NSArray* nums;
//@property (weak, nonatomic) VFStaffNote* lastNote;
//@property (assign, nonatomic) VFRendererLineEndType lineEndType;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithNums:(NSArray*)nums;
- (instancetype)initWithString:(NSString*)nums;
//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state;

- (VFStringNumber*)setOffsetY:(NSUInteger)y;
- (VFStringNumber*)setOffsetX:(NSUInteger)x;

- (id)setLineEndType:(VFRendererLineEndType)leg;
- (id)setLastNote:(VFStaffNote*)lastNote;
- (id)setDashed:(BOOL)dashed;

@end
