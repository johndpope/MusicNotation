//
//  VFCurve.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFModifier.h"
#import "VFEnum.h"

//======================================================================================================================
/** The `VFCurve` class implements curves (for slurs)

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
@interface VFCurve : VFModifier
#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (assign, nonatomic) float spacing;
@property (assign, nonatomic) float thickness;
//@property (assign, nonatomic) float x_shift;
//@property (assign, nonatomic) float y_shift;
@property (strong, nonatomic) VFStaffNote* fromNote;
@property (strong, nonatomic) VFStaffNote* toNote;
@property (assign, nonatomic) VFCurveType position;
@property (assign, nonatomic) VFCurveType positionEnd;
@property (assign, nonatomic) BOOL invert;
@property (assign, nonatomic, readonly) BOOL isPartial;
@property (strong, nonatomic) NSArray* cps;   // array of vfpoint

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

/*!
 *  generate a curve object
 *  @param fromNote start note
 *  @param toNote   end note
 *  @return a curve object
 */
+ (VFCurve*)curveFromNote:(VFNote*)fromNote toNote:(VFNote*)toNote;

+ (VFCurve*)curveFromNote:(VFNote*)fromNote toNote:(VFNote*)toNote withDictionary:(NSDictionary*)optionsDict;

/*!
 *  set the notes to render this curve
 *  @param fromNote start note
 *  @param toNote   end note
 *  @return this object
 */
- (id)setNotesFrom:(VFStaffNote*)fromNote toNote:(VFStaffNote*)toNote;

@end
