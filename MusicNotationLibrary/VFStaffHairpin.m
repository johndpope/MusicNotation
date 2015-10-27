//
//  VFStaffHairpin.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFStaffHairpin.h"
#import "VFVex.h"
#import "VFRenderOptions.h"
#import "VFFormatter.h"
#import "VFStaffNote.h"
#import "VFPoint.h"

@implementation VFStaffHairpin

/*
 **
 * Notes is a struct that has:
 *
 *  {
 *    first_note: Note,
 *    last_note: Note,
 *  }
 */

/**
 * Create a new hairpin from the specified notes.
 *
 * @constructor
 * @param {!Object} notes The notes to tie up.
 * @param {!Object} type The type of hairpin
 */
- (instancetype)initWithNotes:(NSArray*)notes
                    withStaff:(VFStaff*)staff
                      andType:(VFStaffHairpinType)type
                      options:(NSDictionary*)optionsDict;
{
    self = [self initWithDictionary:optionsDict];
    if(self)
    {
        _staff = staff;
        _notes = notes;
        _hairpin = type;

        [self setupStaffHairpin];
        [self setNotes:_notes];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setupStaffHairpin];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (void)setupStaffHairpin
{
    self.position = VFPositionBelow;
    //    self.graphicsContext = nil;
    self.height = 10;
    self.y_shift = 0;
    self.left_shift_px = 0;
    self.right_shift_px = 0;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    [propertiesEntriesMapping addEntriesFromDictionary:@{
        @"height" : @"height",
        @"y_shift" : @"yShift",
        @"left_shift_px" : @"left_shift_px",
        @"right_shift_px" : @"right_shift_px",
        @"vo" : @"vo",
        @"left_ho" : @"left_ho",
        @"right_ho" : @"right_ho",
    }];
    return propertiesEntriesMapping;
}

/** Helper function to convert ticks into pixels.
 * Requires a Formatter with voices joined and formatted (to
 * get pixels per tick)
 *
 * options is struct that has:
 *
 *  {
 *   height: px,
 *   y_shift: px, //vertical offset
 *   left_shift_ticks: 0, //left horizontal offset expressed in ticks
 *   right_shift_ticks: 0 // right horizontal offset expressed in ticks
 *  }
 *
 **/
+ (void)formatByTicksAndDraw:(CGContextRef)ctx
               withFormatter:(VFFormatter*)formatter
                    andNotes:(NSArray*)notes
                   withStaff:(VFStaff*)staff
                    withType:(VFStaffHairpinType)type
                   leftShift:(float)leftShiftTicks
                 righttShift:(float)righttShiftTicks
                      height:(float)height
                      yShift:(float)yShift;
{
    float ppt = formatter.pixelsPerTick;

    if(ppt == -1)
    {
        [VFLog logError:@"BadArguments, A valid Formatter must be provide to draw offsets by ticks."];
    }

    float l_shift_px = ppt * leftShiftTicks;
    float r_shift_px = ppt * righttShiftTicks;

    VFStaffHairpin* staffHairPin =
        [[VFStaffHairpin alloc] initWithNotes:notes withStaff:staff andType:type options:nil];
    [staffHairPin setContext:ctx];
    [staffHairPin setRenderOptionsWithHeight:height yShift:yShift leftShift:l_shift_px rightShift:r_shift_px];
    //    [staffHairPin setPosition:position];
    [staffHairPin draw:ctx];
}

//- (void)setContext:(CGContextRef)ctx
//{
//    self.graphicsContext = ctx;
//}

- (void)setPosition:(VFPositionType)position
{
    if(position == VFPositionAbove || position == VFPositionBelow)
    {
        _position = position;
    }
}

- (void)setRenderOptions:(NSDictionary*)renderOptions;
{
    if(renderOptions[@"height"])
    {
        self.height = [renderOptions[@"height"] floatValue];
    }
    if(renderOptions[@"y_shift"])
    {
        self.y_shift = [renderOptions[@"y_shift"] floatValue];
    }
    if(renderOptions[@"left_shift_px"])
    {
        self.left_shift_px = [renderOptions[@"left_shift_px"] floatValue];
    }
    if(renderOptions[@"right_shift_px"])
    {
        self.right_shift_px = [renderOptions[@"right_shift_px"] floatValue];
    }
}

- (void)setRenderOptionsWithHeight:(float)height
                            yShift:(float)y_shift
                         leftShift:(float)left_shift_px
                        rightShift:(float)right_shift_px
{
    self.height = height;
    self.y_shift = y_shift;
    self.left_shift_px = left_shift_px;
    self.right_shift_px = right_shift_px;

    // NOTE: this function broke RenderOptions out put directly into class
}

/*
 * Set the notes to attach this hairpin to.
 *
 * @param {!Object} notes The start and end notes.
 *
 */
- (void)setNotes:(NSArray*)notes
{
    if([notes firstObject] == nil && [notes lastObject] == nil)
    {
        [VFLog logError:@"BadArguments, Hairpin needs to have either first_note or last_note set."];
    }

    // Success. Lets grab 'em notes.
    self.first_note = [notes firstObject];
    self.last_note = [notes lastObject];
}

- (void)renderHairpin:(CGContextRef)ctx
               firstX:(float)first_x
                lastX:(float)last_x
               firstY:(float)first_y
                lastY:(float)last_y
          staffHeight:(float)staff_height
{
    float dis = self.y_shift + 50;
    float y_shift = first_y;

    if(self.position == VFPositionAbove)
    {
        dis = -dis + 60;
        y_shift = first_y - staff_height;
    }

    float l_shift = self.left_shift_px;
    float r_shift = self.right_shift_px;

    switch(self.hairpin)
    {
        case VFStaffHairpinCres:
        {
            CGContextMoveToPoint(ctx, last_x + r_shift, y_shift + dis);
            CGContextAddLineToPoint(ctx, first_x + l_shift, y_shift + self.height / 2 + dis);
            CGContextAddLineToPoint(ctx, last_x + r_shift, y_shift + self.height + dis);
        }
        break;
        case VFStaffHairpinDescres:
        {
            CGContextMoveToPoint(ctx, first_x + l_shift, y_shift + dis);
            CGContextAddLineToPoint(ctx, last_x + r_shift, y_shift + self.height / 2 + dis);
            CGContextAddLineToPoint(ctx, first_x + l_shift, y_shift + self.height + dis);
        }
        break;

        default:
            // Default is NONE, so nothing to draw
            break;
    }
    CGContextStrokePath(ctx);
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    VFStaffNote* first_note = self.first_note;
    VFStaffNote* last_note = self.last_note;

    VFPoint* start = [first_note getModifierstartXYforPosition:self.position andIndex:0];
    VFPoint* end = [last_note getModifierstartXYforPosition:self.position andIndex:0];

    float staff_height = self.staff.height;
    float first_x = start.x;
    float last_x = end.x;
    float first_y = first_note.staff.y + first_note.staff.height;
    float last_y = last_note.staff.y + last_note.staff.height;

    [self renderHairpin:ctx firstX:first_x lastX:last_x firstY:first_y lastY:last_y staffHeight:staff_height];
}

@end
