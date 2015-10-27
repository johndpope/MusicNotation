//
//  VFCrescendo.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFCrescendo.h"
#import "VFVex.h"
#import "VFBezierPath.h"
#import "VFTickContext.h"
#import "VFNote.h"
#import "VFStaff.h"

@implementation VFCrescendo

- (instancetype)initWithNote:(VFNote*)note
{
    self = [super init];   // WithNote:note];
    if(self)
    {
        //        self->_note = note;
        [self setupCresendo];
        self.line = note.line;   // The staff line to be placed on
        self.height = 15;        // The height at the open end of the cresc/decresc

        // Extensions to the length of the crescendo on either side
        //        self.extend_left = 0;
        //        self.extend_right = 0;
        //        self.y_shift = 0; // Vertical shift
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupCresendo];
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setupCresendo
{
    self.decrescendo = NO;
}

// Set the full height at the open end
- (void)setHeight:(float)height
{
    self.height = height;
}

// Set whether the sign should be a descresendo by passing a bool
// to `decresc`
- (void)setDescrescendo:(BOOL)decres
{
    self.decrescendo = decres;
}

- (BOOL)preFormat
{
    self.preFormatted = YES;
    return YES;
}

// Private helper to draw the hairpin
- (void)renderHairpin:(CGContextRef)ctx
               beginX:(float)beginX
                 endX:(float)endX
                  atY:(float)y
           withHeight:(float)height
              reverse:(BOOL)reverse
{
    CGContextSaveGState(ctx);

    float begin_x = beginX;
    float end_x = endX;
    float half_height = height / 2;

    VFBezierPath* bPath = [VFBezierPath bezierPath];
    [bPath setLineWidth:1.0];
    [VFColor.blackColor setStroke];
    [VFColor.blackColor setFill];

    // TODO: perhaps better to drop VFBezierPath and draw using CG
    if(reverse)
    {
        [bPath moveToPoint:CGPointMake(begin_x, y - half_height)];
#if TARGET_OS_IPHONE
        [bPath addLineToPoint:CGPointMake(end_x, y)];
        [bPath addLineToPoint:CGPointMake(begin_x, y + half_height)];
#elif TARGET_OS_MAC
        [bPath lineToPoint:CGPointMake(end_x, y)];
        [bPath lineToPoint:CGPointMake(begin_x, y + half_height)];
#endif
    }
    else
    {
        [bPath moveToPoint:CGPointMake(end_x, y - half_height)];
#if TARGET_OS_IPHONE
        [bPath addLineToPoint:CGPointMake(begin_x, y)];
        [bPath addLineToPoint:CGPointMake(end_x, y + half_height)];
#elif TARGET_OS_MAC
        [bPath lineToPoint:CGPointMake(begin_x, y)];
        [bPath lineToPoint:CGPointMake(end_x, y + half_height)];
#endif
    }

    //    [bPath stroke];
    [bPath fill];

    CGContextRestoreGState(ctx);
}

// Render the Crescendo object onto the canvas
- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    VFTickContext* tick_context = self.tickContext;
    VFTickContext* next_context = [VFTickContext getNextContext:tick_context];
    float begin_x = self.absoluteX;
    float end_x;
    if(next_context != nil)
    {
        end_x = next_context.x;
    }
    else
    {
        end_x = self.staff.x + self.staff.width;
    }

    float y = [self.staff getYForLine:(self.line + (-3)) + 1];

    NSString* type = self.decrescendo ? @"decrescendo " : @"crescendo ";
    VFLogDebug(@"%@", [NSString stringWithFormat:@"Drawing %@ %f %@ %f", type, self.height, @"x", begin_x - end_x]);

    [self renderHairpin:ctx beginX:begin_x endX:end_x atY:y withHeight:self.height reverse:self.decrescendo];
}
@end
