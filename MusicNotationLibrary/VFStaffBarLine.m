//
//  VFStaffBarLine.m
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

#import "VFBezierPath.h"

#import "VFStaffBarLine.h"
#import "VFStaffModifier.h"
#import "VFVex.h"

#import "VFStaff.h"
#import "VFPoint.h"
#import "VFPadding.h"
#import "StaffLineRenderOptions.h"

// TODO: update this class and use StaffLineRenderOptions

@interface VFStaffBarLine ()
{
    VFBarNoteType _type;
    BOOL _doubleBar;
}
@property (assign, nonatomic) BOOL doubleBar;
@end

@implementation VFStaffBarLine

#pragma mark - Initialize
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialize
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        //        [self setupStaffBarLine];
    }
    return self;
}

- (instancetype)initWithType:(VFBarLineType)type AtX:(float)x
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        //        [self setupStaffBarLine];
        _barLinetype = type;
        //        [self point];
        //        _point = [VFPoint pointZero];
        self.point.x = x;
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setupStaffBarLine];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (void)setupStaffBarLine
{
    _doubleBar = NO;
    self.preFormatted = YES;
    //    [((Metrics*)self->_metrics)setPadding:[VFPadding paddingZero]];
    self->_renderOptions = [[StaffLineRenderOptions alloc] init];
}

+ (VFStaffBarLine*)barLineWithType:(VFBarLineType)type atX:(float)x
{
    return [[VFStaffBarLine alloc] initWithType:type AtX:x];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"barlines";
}

- (void)setX:(float)x
{
    self.point.x = x;
}

//@synthesize staff = _staff;
//- (void)setStaff:(VFStaff*)staff {
//    _staff = staff;
//}

#pragma mark - Draw
/**---------------------------------------------------------------------------------------------------------------------
 * @name Draw
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)draw:(CGContextRef)ctx
{
    VFLogError(@"StaffBarLineError, do not call draw.");
}

/*!
 *  draw this modifier
 *  @param ctx   graphics context
 *  @param staff the staff to draw to
 */
- (void)drawWithContext:(CGContextRef)ctx toStaff:(VFStaff*)staff withShiftX:(float)shiftX;
{
    [super drawWithContext:ctx toStaff:staff withShiftX:(float)shiftX];

    if(!self.staff)
    {
        // unlikely to ever not have a context.
        VFLogError(@"NoStaffError, Can't draw bar line without a staff.");
    }

    // draw barlines
    switch(self.barLinetype)
    {
        case VFBarLineSingle:
            _doubleBar = NO;
            [self drawVerticalBar:ctx withShiftX:self.point.x];
            break;
        case VFBarLineDouble:
            _doubleBar = YES;
            [self drawVerticalBar:ctx withShiftX:self.point.x];
            break;
        case VFBarLineEnd:
            [self drawVertialEndBar:ctx withShiftX:self.point.x];
            break;
        case VFBarLineRepeatBegin:
            if(shiftX > 0)
            {
                [self drawVerticalBar:ctx withShiftX:self.point.x];
            }
            [self drawRepeatBar:ctx withShiftX:self.point.x + shiftX begin:YES];
            break;
        case VFBarLineRepeatEnd:
            [self drawRepeatBar:ctx withShiftX:self.point.x begin:NO];
            break;
        case VFBarLineRepeatBoth:
            [self drawRepeatBar:ctx withShiftX:self.point.x begin:NO];
            [self drawRepeatBar:ctx withShiftX:self.point.x begin:YES];
            break;
        case VFBarLineNone:
            break;
        default:
            VFLogError(@"DrawBarLineWarning, tried to draw a bar line with unknown value: %li", self.barLinetype);
            break;
    }
}

- (void)drawVerticalBar:(CGContextRef)ctx withShiftX:(float)x;
{
    //    float x = self.point.x;
    float topLine = [self.staff getYForLine:0];
    float bottomLine = [self.staff getYForLine:self.staff.options.numLines - 1];
    VFBezierPath* path;
    if(self.doubleBar)
    {
        path = (VFBezierPath*)[VFBezierPath bezierPathWithRect:CGRectMake(x - 3, topLine, 1, bottomLine - topLine + 1)];
        //[path stroke];
        [path fill];
    }
    path = (VFBezierPath*)[VFBezierPath bezierPathWithRect:CGRectMake(x, topLine, 1, bottomLine - topLine + 1)];
    //[path stroke];
    [path fill];
}

- (void)drawVertialEndBar:(CGContextRef)ctx withShiftX:(float)x;
{
    //    float x = self.point.x;
    float topLine = [self.staff getYForLine:0];
    float bottomLine = [self.staff getYForLine:self.staff.options.numLines - 1];
    VFBezierPath* path =
        (VFBezierPath*)[VFBezierPath bezierPathWithRect:CGRectMake(x - 5, topLine, 1, bottomLine - topLine + 1)];
    [path stroke];
    [path fill];
    path = (VFBezierPath*)[VFBezierPath bezierPathWithRect:CGRectMake(x - 2, topLine, 3, bottomLine - topLine + 1)];
    [path stroke];
    [path fill];
}

- (void)drawRepeatBar:(CGContextRef)ctx withShiftX:(float)x begin:(BOOL)begin
{
    float xShift = 3;
    //    float x = self.point.x;
    float topY = [self.staff getYForLine:0];
    float botY = [self.staff getYForLine:self.staff.options.numLines - 1];

    if(!begin)
    {
        xShift = -5;
    }

    CGContextSaveGState(ctx);
    CGContextBeginPath(ctx);
    CGContextAddRect(ctx, CGRectMake(x + xShift, topY, 1, botY - topY));
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextBeginPath(ctx);
    CGContextAddRect(ctx, CGRectMake(x + xShift - 5, topY, 3, botY - topY));
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextRestoreGState(ctx);

    float dotRadius = (self.staff.options.pointsBetweenLines / 7);   // 5; // 22;

    // shift dots left or right
    if(begin)
    {
        xShift += 4;
    }
    else
    {
        xShift -= 4;
    }

    float dotX = (x + xShift) + (dotRadius / 2);

    // calculate the y offset based on number of staff lines
    float yOffset = (self.staff.options.numLines - 1) * self.staff.options.pointsBetweenLines;
    yOffset = (yOffset / 2) - (self.staff.options.pointsBetweenLines / 2);
    //    float dotY = topY - yOffset + (dotRadius / 2);

    float dotY = [self.staff getYForLine:1.5];

    // draw the top repeat dot
    CGContextSaveGState(ctx);
    CGContextMoveToPoint(ctx, dotX, dotY);
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, dotX, dotY, dotRadius, 0, 2 * M_PI, NO);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);

    //    dotY += self.staff.options.pointsBetweenLines;
    dotY = [self.staff getYForLine:2.5];

    // draw the bottom repeat dot
    CGContextMoveToPoint(ctx, dotX, dotY);
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, dotX, dotY, dotRadius, 0, 2 * M_PI, NO);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextRestoreGState(ctx);
}

//- (void)renderWithContext:(CGContextRef)ctx
//{
//    //    self.graphicsContext = context;
//    [self draw:ctx];
//}

@end
