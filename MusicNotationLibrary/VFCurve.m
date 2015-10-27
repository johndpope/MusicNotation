//
//  VFCurve.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFCurve.h"
#import "VFLog.h"
#import "VFPoint.h"
#import "vfMacros.h"
#import "VFStaffNote.h"

@interface VFCurve ()

@end

@implementation VFCurve

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        _spacing = 2;
        _thickness = 2;
        _x_shift = 0;
        _y_shift = 10;
        _position = VFCurveNearHead;
        _invert = NO;
        _cps = @[ VFPointMake(0, 10), VFPointMake(0, 10) ];   // control points
        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

/*!
 *  generate a curve object
 *  @param fromNote start note
 *  @param toNote   end note
 *  @return a curve object
 */
+ (VFCurve*)curveFromNote:(VFNote*)fromNote toNote:(VFNote*)toNote;
{
    VFCurve* ret = [[VFCurve alloc] initWithDictionary:@{@"fromNote" : fromNote, @"toNote" : toNote}];
    return ret;
}


+ (VFCurve*)curveFromNote:(VFNote*)fromNote toNote:(VFNote*)toNote withDictionary:(NSDictionary*)optionsDict;
{
    VFCurve* ret = [[VFCurve alloc] initWithDictionary:@{@"fromNote" : fromNote, @"toNote" : toNote}];
    [ret setValuesForKeyPathsWithDictionary:optionsDict];
    return ret;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*!
 *  set the notes to render this curve
 *  @param fromNote start note
 *  @param toNote   end note
 *  @return this object
 */
- (id)setNotesFrom:(VFStaffNote*)fromNote toNote:(VFStaffNote*)toNote;
{
    if(!fromNote && !toNote)
    {
        VFLogError(@"BadArguments, Curve needs to have either first_note or last_note set.");
    }
    self.fromNote = fromNote;
    self.toNote = toNote;
    return self;
}

/*!
 *  Returns YES if this is a partial bar.
 *  @return YES if this is a partial bar.
 */
- (BOOL)isPartial
{
    return (!self.fromNote || !self.toNote);
}

/*!
 *  actually renders the curve
 *  @param ctx            the graphics context
 *  @param firstPoint     the starting point
 *  @param lastPoint      the ending point
 *  @param curveDirection up or down
 */
- (void)renderCurve:(CGContextRef)ctx
     fromFirstPoint:(VFPoint*)firstPoint
        toLastPoint:(VFPoint*)lastPoint
          direction:(float)curveDirection

{
    float direction = curveDirection;

    NSArray* cps = self.cps;

    float x_shift = self.x_shift;
    float y_shift = self.y_shift * direction;

    float first_x = firstPoint.x + x_shift;
    float first_y = firstPoint.y + y_shift;
    float last_x = lastPoint.x - x_shift;
    float last_y = lastPoint.y + y_shift;
    float thickness = self.thickness;

    float cp_spacing = (last_x - first_x) / (cps.count + 2);

    CGContextSaveGState(ctx);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, first_x, first_y);
    VFPoint* cp0 = cps[0];
    VFPoint* cp1 = cps[1];
    CGContextAddCurveToPoint(ctx, first_x + cp_spacing + cp0.x, first_y + (cp0.y * direction),
                             last_x - cp_spacing + cp1.x, last_y + (cp1.y * direction), last_x, last_y);
    CGContextAddCurveToPoint(ctx, last_x - cp_spacing + cp1.x, last_y + ((cp1.y + thickness) * direction),
                             first_x + cp_spacing + cp0.x, first_y + ((cp0.y + thickness) * direction), first_x,
                             first_y);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextRestoreGState(ctx);
}

- (void)draw:(CGContextRef)ctx
{
    [super draw:ctx];
    VFStaffNote* first_note = self.fromNote;
    VFStaffNote* last_note = self.toNote;
    float first_x, last_x, first_y, last_y;
    VFStemDirectionType stem_direction = VFStemDirectionUp;   // TODO: verify this is correct initializer

    NSString* metric = @"baseY";
    NSString* end_metric = @"baseY";
    VFCurveType position = self.position;
    VFCurveType position_end = self.positionEnd;

    if(position == VFCurveNearTop)
    {
        metric = @"topY";
        end_metric = @"topY";
    }

    if(position_end == VFCurveNearHead)
    {
        end_metric = @"baseY";
    }
    else if(position_end == VFCurveNearTop)
    {
        end_metric = @"topY";
    }

    if(first_note)
    {
        first_x = first_note.tieRightX;
        stem_direction = first_note.stemDirection;
        first_y = [[first_note.stemExtents valueForKey:metric] floatValue];   // .getStemExtents()[metric];
    }
    else
    {
        first_x = last_note.staff.tieStartX;                                 // .getStave().getTieStartX();
        first_y = [[last_note.stemExtents valueForKey:metric] floatValue];   // getStemExtents()[metric];
    }

    if(last_note)
    {
        last_x = last_note.tieLeftX;                                            // getTieLeftX();
        stem_direction = last_note.stemDirection;                               // getStemDirection();
        last_y = [[last_note.stemExtents valueForKey:end_metric] floatValue];   // getStemExtents()[end_metric];
    }
    else
    {
        last_x = first_note.staff.tieEndX;                                       // getStave().getTieEndX();
        last_y = [[first_note.stemExtents valueForKey:end_metric] floatValue];   // getStemExtents()[end_metric];
    }
    float direction = stem_direction * (self.invert ? -1.f : 1.f);
    [self renderCurve:ctx
        fromFirstPoint:VFPointMake(first_x, first_y)
           toLastPoint:VFPointMake(last_x, last_y)
             direction:direction];
}

@end
