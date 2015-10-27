//
//  VFStaffVolta.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFStaffVolta.h"
#import "VFStaff.h"
#import "VFRenderer.h"
#import "VFText.h"

@implementation VFStaffVolta

- (instancetype)initWithType:(VFVoltaType)type number:(NSString*)number atX:(float)x yShift:(float)yShift
{
    self = [super init];
    if(self)
    {
        self.type = type;
        _x = x;
        self.number = number;
        self.y_shift = yShift;
        self.fontFamily = @"sans-serif";
        self.fontSize = 9;
        self.fontWeightBold = YES;
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

+ (NSString*)CATEGORY
{
    return @"voltas";
}

- (void)draw:(CGContextRef)ctx staff:(VFStaff*)staff atX:(float)x;
{
    //    if (self.staff.graphicsContext == NULL) {
    //        [VFLog logError:@"cannot draw without context"];
    //    }
    //    CGContextRef ctx = staff.graphicsContext;
    float width, top_y, vert_height;
    width = staff.width;
    top_y = [staff getYForTopTextWithLine:staff.options.numLines];
    vert_height = 1.5 * staff.spacingBetweenLines;
    switch(self.type)
    {
        case VFVoltaBegin:
            //            [VFRenderer fillRect:ctx withRect:CGRectMake(_x + x, top_y, 1, vert_height)];
            CGContextBeginPath(ctx);
            CGContextAddRect(ctx, CGRectMake(_x + x, top_y, 1, vert_height));
            CGContextClosePath(ctx);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            break;
        case VFVoltaEnd:
            width -= 5;
            //            [VFRenderer fillRect:ctx withRect:CGRectMake(_x + x + width, top_y, 1, vert_height)];
            CGContextBeginPath(ctx);
            CGContextAddRect(ctx, CGRectMake(_x + x + width, top_y, 1, vert_height));
            CGContextClosePath(ctx);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            break;
        case VFVoltaBeginEnd:
            width -= 3;
            //            [VFRenderer fillRect:ctx withRect:CGRectMake(_x + x, top_y, 1, vert_height)];
            CGContextBeginPath(ctx);
            CGContextAddRect(ctx, CGRectMake(_x + x, top_y, 1, vert_height));
            CGContextClosePath(ctx);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            //            [VFRenderer fillRect:ctx withRect:CGRectMake(_x + x + width, top_y, 1, vert_height)];
            CGContextBeginPath(ctx);
            CGContextAddRect(ctx, CGRectMake(_x + x + width, top_y, 1, vert_height));
            CGContextClosePath(ctx);
            CGContextDrawPath(ctx, kCGPathFillStroke);
            break;
        default:
            break;
    }

    // If the beginning of a volta, draw measure number
    if(self.type == VFVoltaBegin || self.type == VFVoltaBeginEnd)
    {
        CGContextSaveGState(ctx);
        // TODO: set font
        // draw text better
        [VFText drawSimpleText:ctx atPoint:VFPointMake(_x + x + 5, top_y + 15) withHeight:12 withText:self.number];
        CGContextRestoreGState(ctx);
    }
}

@end
