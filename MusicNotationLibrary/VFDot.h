//
//  VFDot.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;
#import "VFModifier.h"

@class VFStaffNote, VFModifierState;

//======================================================================================================================
/** The `VFDot` class implements dot modifiers for notes.

 In Western musical notation, a dotted note is a note with a small dot written after it.
 In modern practice the first dot increases the duration of the basic note by half of its
 original value. A dotted note is equivalent to writing the basic note tied to a note of
 half the value; or with more than one dots, tied to notes of progressively halved value.[1]
 The length of any given note a with n dots is therefore given by the geometric series
 a_n=a\left(1+\tfrac 12+\tfrac 14+ \cdots + \tfrac 1{2^n}\right)=a(2-\frac 1{2^n}).
 More than three dots are highly uncommon but theoretically possible;[2] only quadruple
 dots have been attested.[3]

 A rhythm using longer notes alternating with shorter notes (whether notated with dots or not)
 is sometimes called a dotted rhythm. Historical examples of music performance styles using
 dotted rhythm include notes inégales and swing. The precise performance of dotted rhythms
 can be a complex issue. Even in notation that includes dots, their performed values may be
 longer than the dot mathematically indicates, a practice known as over-dotting.[4]

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFDot : VFModifier
{
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

//@property (weak, nonatomic) VFStaffNote* note;
@property (assign, nonatomic) float dotShiftY;
@property (assign, nonatomic) float lineSpace;
@property (assign, nonatomic) float radius;
@property (strong, nonatomic, readonly) NSString* type;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
+ (VFDot*)dotWithType:(NSString*)type;
//- (void)setNote:(VFNote *)note;
//+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state;
- (void)setDotShiftY:(float)dotShiftY;

- (void)draw:(CGContextRef)ctx;

@end
