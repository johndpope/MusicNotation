//
//  VFStaffHairpin.h
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

@class VFFormatter, VFStaffNote;

//======================================================================================================================
/** The `VFStaffHairpin` class implements hairpins between notes.
      Hairpins can be either Crescendo or Descrescendo.

    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFStaffHairpin : VFModifier

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@property (strong, nonatomic) NSArray* notes;
@property (weak, nonatomic) VFStaff* staff;
@property (strong, nonatomic) VFStaffNote* first_note;
@property (strong, nonatomic) VFStaffNote* last_note;
@property (assign, nonatomic) VFStaffHairpinType hairpin;
@property (assign, nonatomic) VFPositionType position;

// render options
@property (assign, nonatomic) float height;
@property (assign, nonatomic) float yShift;           // vertical offset
@property (assign, nonatomic) float left_shift_px;    // left horizontal offset
@property (assign, nonatomic) float right_shift_px;   // right horizontal offset
@property (assign, nonatomic) float vo;               // vertical offset
@property (assign, nonatomic) float left_ho;          // left horizontal offset
@property (assign, nonatomic) float right_ho;         // right horizontal offset

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (instancetype)initWithNotes:(NSArray*)notes
                    withStaff:(VFStaff*)staff
                      andType:(VFStaffHairpinType)type
                      options:(NSDictionary*)optionsDict;
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

+ (void)formatByTicksAndDraw:(CGContextRef)ctx
               withFormatter:(VFFormatter*)formatter
                    andNotes:(NSArray*)notes
                   withStaff:(VFStaff*)staff
                    withType:(VFStaffHairpinType)type
                   leftShift:(float)leftShiftTicks
                 righttShift:(float)righttShiftTicks
                      height:(float)height
                      yShift:(float)yShift;

- (void)setContext:(CGContextRef)ctx;
- (void)setPosition:(VFPositionType)position;

- (void)setRenderOptions:(NSDictionary*)renderOptions;

- (void)setRenderOptionsWithHeight:(float)height
                            yShift:(float)y_shift
                         leftShift:(float)left_shift_px
                        rightShift:(float)right_shift_px;
- (void)setNotes:(NSArray*)notes;

- (void)draw:(CGContextRef)ctx;

@end
