//
//  VFStaffModifier.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFVex.h"
#import "VFStaffModifier.h"
#import "VFStaff.h"
#import "VFGlyph.h"
#import "VFMetrics.h"
#import "VFGlyphList.h"
#import "VFLog.h"
#import "VFTablesGlyphStruct.h"
#import "VFPadding.h"
#import "VFPoint.h"
#import "VFBoundingBox.h"

#import "VFClef.h"

@implementation VFStaffModifier

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        //        [((VFPadding*)[((Metrics*)self->_metrics)padding])padAllSidesBy:10];
        //        [((Metrics*)self->_metrics)setPoint:[VFPoint pointWithX:0 andY:0]];
        _padding = 10;
        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"staffmodifier";
}

- (NSMutableArray*)subModifiers
{
    if(!_subModifiers)
    {
        _subModifiers = [@[] mutableCopy];
    }
    return _subModifiers;
}

//- (id<VFModifierContextDelegate>) modifierContext {
//    return _modifierContext;
//
//}

#pragma mark - Configure
/**---------------------------------------------------------------------------------------------------------------------
 * @name Configuration
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (BOOL)preFormat
{
    return [super preFormat];
}

- (BOOL)postFormat
{
    BOOL ret = [super postFormat];
    //    for(VFSymbol* symbol in self.subModifiers)
    //    {
    //        ((Metrics*)symbol->_metrics).point.x += ((Metrics*)self->_metrics).point.x;
    //    }
    return ret;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

///*!
// *  creates a blank glyph that does not render anything except it takes up space
// *  @param padding amount of space the blank glyph occupies
// *  @return a blank glyph
// */
//- (VFGlyph*)makeSpacer:(float)padding
//{
//    VFGlyph* ret = [[VFGlyph alloc] init];
//    ret.metrics.width = padding;
////    ret.metrics.bounds =
////        [VFBoundingBox boundingBoxAtX:0
////                                  atY:0
////                            withWidth:padding
////                            andHeight:50];   //  NOTE: the height is arbitrary, perhaps there's a better way
//    return ret;
//}

/*!
 *  places a glyph on the staff at the given line
 *  @param glyph the glyph to add to the staff
 *  @param staff the staff to add the glyph to
 *  @param line  the line on the staff to place the glyph on
 */
- (void)placeGlyphOnLine:(VFGlyph*)glyph forStaff:(VFStaff*)staff onLine:(float)line
{
    glyph.y_shift = [staff getYForLine:line] - [staff getYForGlyphs];
}

/*!
 *  sets the overall padding for all staff modifiers
 *  @param padding the amount of padding
 */
- (void)setPadding:(float)padding
{
    _padding = padding;
}

/*!
 *  add this modifier to the given staff
 *  @param staff the staff to add this modifier to
 */
- (void)addToStaff:(VFStaff*)staff
{
    [self addToStaff:staff firstGlyph:NO];
}

/*!
 *  add this modifier to the given staff
 *  @param staff      the staff to add this modifier to
 *  @param firstGlyph if this is the first glyph
 *  @return this object
 */
- (id)addToStaff:(VFStaff*)staff firstGlyph:(BOOL)firstGlyph;
{
    if(firstGlyph)
    {
        [staff addGlyph:[self makeSpacer:self.padding]];
    }
    [self addModifierToStaff:staff];
    return self;
}

/*!
 *  add this modifier to the end of the given staff
 *  @param staff      the staff to add this modifier to
 *  @param firstGlyph if this is the first glyph
 */
- (void)addToStaffEnd:(VFStaff*)staff firstGlyph:(BOOL)firstGlyph;
{
    if(!firstGlyph)
    {
        [staff addEndGlyph:[self makeSpacer:self.padding]];
    }
    //    else
    //    {
    //        [staff addEndGlyph:[self makeSpacer:2]];
    //    }
    [self addEndModifierToStaff:staff];
}

/*!
 *  creates a blank glyph that does not render anything except it takes up space
 *  @param padding amount of space the blank glyph occupies
 *  @return a blank glyph
 */
- (VFGlyph*)makeSpacer:(float)padding
{
    VFGlyph* ret = [[VFGlyph alloc] init];
    ret.metrics.width = padding;
    //    ret.metrics.bounds =
    //        [VFBoundingBox boundingBoxAtX:0
    //                                  atY:0
    //                            withWidth:padding
    //                            andHeight:50];
    //  NOTE: the height is arbitrary, perhaps there's a better way
    ret.drawBlock = ^(CGContextRef context, float x, float y) {
    };
    return ret;
}

/*!
 *  abstract method for allowing a staffmodifier subclass to add glyphs to start of a staff
 *  @param staff a staff object
 */
- (void)addModifierToStaff:(VFStaff*)staff
{
    VFLogError(@"MethodNotImplemented, addModifier() not implemented for this stave modifier.");
}

/*!
 *  abstract method for allowing a staffmodifier subclass to add glyphs to end of a staff
 *  @param staff a staff object
 */
- (void)addEndModifierToStaff:(VFStaff*)staff
{
    VFLogError(@"MethodNotImplemented, addModifier() not implemented for this stave modifier.");
}

/*!
 *  draw this modifier
 *  @param ctx   graphics context
 *  @param staff the staff to draw to
 */
- (void)drawWithContext:(CGContextRef)ctx toStaff:(VFStaff*)staff withShiftX:(float)shiftX;
{
    [super draw:ctx];
}

- (void)drawWithContext:(CGContextRef)ctx toStaff:(VFStaff*)staff;
{
    [super draw:ctx];
}

@end
