//
//  VFFretHandFinger.h
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
/** The `VFFretHandFinger` class draws string numbers into the notation.

 Tapping is a guitar playing technique, where a string is fretted and set into vibration
 as part of a single motion of being pushed onto the fretboard, as opposed to the standard
 technique being fretted with one hand and picked with the other. It is similar to the
 technique of hammer-ons and pull-offs, but used in an extended way compared to them:
 hammer-ons would be performed by only the fretting hand, and in conjunction with
 conventionally picked notes; whereas tapping passages involve both hands and consist of
 only tapped, hammered and pulled notes. Some players (such as Stanley Jordan) use
 exclusively tapping, and it is standard on some instruments, such as the Chapman Stick.


    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFFretHandFinger : VFModifier
{
   @private
    NSString* _finger;
    float _x_offset;
    float _y_offset;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (strong, nonatomic) NSString* finger;
//@property (assign, nonatomic) NSUInteger x_offset;
//@property (assign, nonatomic) NSUInteger y_offset;
//@property (assign, nonatomic) NSInteger index;
//@property (strong, nonatomic) NSArray* nums;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithFingerNumber:(NSString*)fingerNumber;
- (instancetype)initWithFingerNumber:(NSString*)fingerNumber andPosition:(VFPositionType)position;
//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state;
- (id)setOffsetY:(float)y;

@end
