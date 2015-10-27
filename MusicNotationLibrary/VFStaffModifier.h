//
//  VFStaffModifier.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
@import Foundation;
#elif TARGET_OS_MAC
@import AppKit;
#endif

#import "VFModifier.h"
#import "VFSymbol.h"
#import "VFNote.h"
//#import "VFDelegates.h"
#import "VFRenderOptions.h"

@class Metrics, Options, VFStaff, VFGlyph, VFColor;

//#import "VFMetrics.h"
//#import "VFStaff.h"
//#import "VFGlyph.h"

//======================================================================================================================
/** The `VFStaffModifier` class performs ...
/
    The following demonstrates some basic usage of this .

    ExampleCode
 */
@interface VFStaffModifier : VFModifier
{
   @public
    //    NSMutableArray* _list;
    //    NSMutableDictionary* _map;
    //    NSInteger _resolutionMultiplier;
    //    float _width;
    //    id<VFModifierContextDelegate> _modifierContext;
    //    __weak VFStaff* _staff;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

@property (strong, nonatomic) Rational* measure;
@property (strong, nonatomic) Rational* beat;

@property (strong, nonatomic) VFColor* strokeColor;
@property (strong, nonatomic) VFColor* fillColor;

@property (strong, nonatomic) NSMutableArray* subModifiers;

@property (assign, nonatomic) float padding;

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict NS_DESIGNATED_INITIALIZER;

/*!
 *  creates a blank glyph that does not render anything except it takes up space
 *  @param padding amount of space the blank glyph occupies
 *  @return a blank glyph
 */
- (VFGlyph*)makeSpacer:(float)padding;

/*!
 *  places a glyph on the staff at the given line
 *  @param glyph the glyph to add to the staff
 *  @param staff the staff to add the glyph to
 *  @param line  the line on the staff to place the glyph on
 */
- (void)placeGlyphOnLine:(VFGlyph*)glyph forStaff:(VFStaff*)staff onLine:(float)line;

/*!
 *  sets the overall padding for all staff modifiers
 *  @param padding the amount of padding
 */
- (void)setPadding:(float)padding;

/*!
 *  add this modifier to the given staff
 *  @param staff the staff to add this modifier to
 */
- (void)addToStaff:(VFStaff*)staff;

/*!
 *  add this modifier to the given staff
 *  @param staff      the staff to add this modifier to
 *  @param firstGlyph if this is the first glyph
 *  @return this object
 */
- (id)addToStaff:(VFStaff*)staff firstGlyph:(BOOL)firstGlyph;

/*!
 *  add this modifier to the end of the given staff
 *  @param staff      the staff to add this modifier to
 *  @param firstGlyph if this is the first glyph
 */
- (void)addToStaffEnd:(VFStaff*)staff firstGlyph:(BOOL)firstGlyph;

/*!
 *  abstract method for allowing a staffmodifier subclass to add glyphs to start of a staff
 *  @param staff a staff object
 */
- (void)addModifierToStaff:(VFStaff*)staff;

/*!
 *  abstract method for allowing a staffmodifier subclass to add glyphs to end of a staff
 *  @param staff a staff object
 */
- (void)addEndModifierToStaff:(VFStaff*)staff;

/*!
 *  draw this modifier
 *  @param ctx   graphics context
 *  @param staff the staff to draw to
 */
- (void)drawWithContext:(CGContextRef)ctx toStaff:(VFStaff*)staff withShiftX:(float)shiftX;

- (void)drawWithContext:(CGContextRef)ctx toStaff:(VFStaff*)staff;

@end
