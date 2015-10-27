//
//  VFTextBracket.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Complete

#import "VFTextBracket.h"
#import "VFVex.h"
#import "VFColor.h"
#import "VFText.h"
#import "VFFont.h"
#import "VFStaff.h"
#import "VFStaffNote.h"
#import "VFRenderer.h"
#import "VFLine.h"
#include "VFGlyph.h"

@implementation VFTextBracket

- (instancetype)initWithStart:(VFStaffNote*)start
                         stop:(VFStaffNote*)stop
                         text:(NSString*)text
                  superscript:(NSString*)superscript
                     position:(VFTextBracketPosition)position
{
    self = [super init];
    if(self)
    {
        self.start = start;
        self.stop = stop;
        self.text = (text != nil ? text : @"");
        self.superscript = (superscript != nil ? superscript : @"");
        if(position == VFTextBracketBottom || position == VFTextBrackTop)
        {
            self.position = position;
        }
        else
        {
            self.position = VFTextBrackTop;
        }
        [self setupTextBracket];
    }
    return self;
}

- (void)setupTextBracket
{
    _line = 1;
    _fontFamily = @"Serif";
    _fontSize = 15;
    _fontBold = NO;
    _fontItalic = YES;
    _dashed = YES;
    _color = VFColor.blackColor;
    _dash = @[ @(5), @(5) ];
    _lineWidth = 1;
    _showBracket = YES;
    _bracketHeight = 8;
    // In the BOTTOM position, the bracket line can extend
    // under the superscript.
    _underlineSuperscript = YES;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

// Apply the text backet styling to the provided `context`
- (void)applyStyle:(CGContextRef)ctx
{
    // Apply style for the octave bracket
    CGContextSetStrokeColorWithColor(ctx, self.color.CGColor);
    CGContextSetFillColorWithColor(ctx, self.color.CGColor);
    CGContextSetLineWidth(ctx, self.lineWidth);
}

//// set the draw style of a stem:
//- (void)applyStyle:(DrawStyle)drawStyle {
//    _drawStyle = drawStyle;
//}
//- (DrawStyle)getStyle {
//    return _drawStyle;
//}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    float y = 0;
    switch(self.position)
    {
        case VFTextBrackTop:
            y = [self.start.staff getYForTopTextWithLine:self.line];
            break;
        case VFTextBracketBottom:
            y = [self.start.staff getYForBottomTextWithLine:self.line];
            break;
        default:
            [VFLog logError:@"InvalidBracketPosition, only top or bottom allowed"];
    }

    VFPoint* start = [VFPoint pointWithX:self.start.absoluteX andY:y];
    VFPoint* stop = [VFPoint pointWithX:self.start.absoluteX andY:y];

    VFLogDebug(@"%@", [NSString stringWithFormat:@"Rendering TextBracket: start:%@ stop:%@", [start toString],
                                               [stop toString]]);

    float bracketHeight = self.bracketHeight * self.position;

    CGContextSaveGState(ctx);

    [self applyStyle:ctx];

    // Draw text
    VFFont* font = [VFFont fontWithName:self.fontFamily size:self.fontSize];
    font.bold = self.fontBold;
    // TODO: cannot set font size
    //    font.size = self.fontSize;
    //         context.setFont(self.font.family, self.font.size, self.font.weight);
    [VFText drawSimpleText:ctx withFont:font atPoint:[VFPoint pointWithX:start.x andY:start.y] withText:self.text];

    // Get the width and height for the octave number
    float mainWidth = [VFText measureText:self.text withFont:font].width;
    float mainHeight = [VFText measureText:@"M" withFont:font].width;

    // Calculate the y position for the super script
    float super_y = start.y - (mainHeight / 2.5);

    // Draw the superscript
    // TODO: cannot set font size
    //    font.size = font.size / 1.4;
    [VFText drawSimpleText:ctx
                  withFont:font
                   atPoint:[VFPoint pointWithX:(start.x + mainWidth + 1)andY:super_y]
                  withText:self.superscript];

    // Determine width and height of the superscript
    float superscript_width = [VFText measureText:self.superscript withFont:font].width;
    float super_height = [VFText measureText:@"M" withFont:font].height;

    // Setup initial coordinates for the bracket line
    float start_x = start.x;
    float line_y = super_y;
    float end_x = stop.x + self.stop.glyphStruct.head_width;

    // Adjust x and y coordinates based on position
    if(self.position == VFTextBrackTop)
    {
        start_x += mainWidth + superscript_width + 5;
        line_y -= super_height / 2.7;
    }
    else if(self.position == VFTextBracketBottom)
    {
        line_y += super_height / 2.7;
        start_x += mainWidth + 2;
        if(!self.underlineSuperscript)
        {
            start_x += superscript_width;
        }
    }

    if(self.dashed)
    {
        ////TODO: finish the following
        //        // Main line
        //        [VFRenderer drawDashedLine:ctx
        //                         withPhase:0
        //                       withLengths:self.dash
        //                          withLine:[VFLine lineAtStartX:start_x startY:line_y endX:end_x endY:line_y]];
        //
        //
        //        // Ending bracket
        //        if(self.showBracket)
        //        {
        //            [VFRenderer drawDashedLine:ctx
        //                             withPhase:0
        //                           withLengths:self.dash
        //                              withLine:[VFLine lineAtStartX:end_x
        //                                                     startY:line_y + (1 * self.position)
        //                                                       endX:end_x
        //                                                       endY:line_y + bracketHeight]];
        //        }
    }
    else
    {
        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, start_x, line_y);
        // Main line
        CGContextAddLineToPoint(ctx, end_x, line_y);
        if(self.showBracket)
        {
            // Ending bracket
            CGContextAddLineToPoint(ctx, end_x, line_y + bracketHeight);
        }
        CGContextStrokePath(ctx);
        CGContextClosePath(ctx);
    }

    CGContextRestoreGState(ctx);
}

@end
