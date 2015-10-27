//
//  VFTextNote.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFTextNote.h"
#import "VFVex.h"
#import "VFGlyph.h"
#import "VFTables.h"
#import "VFStaff.h"

@interface VFTextNote ()
@property (strong, nonatomic) NSDictionary* glyphTextNoteStruct;
@end

@implementation VFTextNote

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        // Note properties
        self.text = optionsDict[@"text"];
        self.glyph_type = optionsDict[@"glyph"];
        self.glyph = nil;
        //        self.font = {
        //        family: "Arial",
        //        size: 12,
        //        weight: ""
        //        }

        //        if (optionsDict.font) self.font = optionsDict.font;

        if(self.glyph_type)
        {
            NSDictionary* textNoteglyphTextNoteStruct = [[self class] textNoteGlyphs][self.glyph_type];
            //            if (!struct) throw new Vex.RERR("Invalid glyph type: " + self.glyph_type);
            if(!textNoteglyphTextNoteStruct)
            {
                VFLogError(@"Invalid glyph type: %@", self.glyph_type);
            }

            NSString* code = textNoteglyphTextNoteStruct[@"code"];
            float pointSize = [textNoteglyphTextNoteStruct[@"point"] floatValue];
            self.glyph = [[VFGlyph alloc] initWithCode:code withPointSize:pointSize];

            //            if(struct.width)
            //                self.setWidth(struct.width) else self.setWidth(self.glyph.getMetrics().width);

            self.glyphTextNoteStruct = textNoteglyphTextNoteStruct;
        }
        else
        {
            self.width = [VFTables textWidthForText:self.text];
        }
        self.line = optionsDict[@"line"] ? [optionsDict[@"line"] floatValue] : 0;
        self.smooth = optionsDict[@"smooth"] ? [optionsDict[@"smooth"] boolValue] : NO;
        self.ignoreTicks = optionsDict[@"ignore_ticks"] ? [optionsDict[@"ignore_ticks"] boolValue] : NO;
        self.justification = VFJustifyLEFT;
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

static NSDictionary* _textNoteGlyphs;
- (NSDictionary*)textNoteGlyphs;
{
    if(!_textNoteGlyphs)
    {
        _textNoteGlyphs = @{

            @"segno" : @{
                @"code" : @"v8c",
                @"point" : @40,
                @"x_shift" : @0,
                @"y_shift" : @-10
                // width: 10 // optional
            },
            @"tr" : @{
                @"code" : @"v1f",
                @"point" : @40,
                @"x_shift" : @0,
                @"y_shift" : @0
                // width: 10 // optional
            },
            @"mordent" : @{
                @"code" : @"v1e",
                @"point" : @40,
                @"x_shift" : @0,
                @"y_shift" : @0
                // width: 10 // optional
            },
            @"f" : @{
                @"code" : @"vba",
                @"point" : @40,
                @"x_shift" : @0,
                @"y_shift" : @0
                // width: 10 // optional
            },
            @"p" : @{
                @"code" : @"vbf",
                @"point" : @40,
                @"x_shift" : @0,
                @"y_shift" : @0
                // width: 10 // optional
            },
            @"m" : @{
                @"code" : @"v62",
                @"point" : @40,
                @"x_shift" : @0,
                @"y_shift" : @0
                // width: 10 // optional
            },
            @"s" : @{
                @"code" : @"v4a",
                @"point" : @40,
                @"x_shift" : @0,
                @"y_shift" : @0
                // width: 10 // optional
            },
            @"coda" : @{
                @"code" : @"v4d",
                @"point" : @40,
                @"x_shift" : @0,
                @"y_shift" : @-8
                // width: 10 // optional
            }
        };
    }
    return _textNoteGlyphs;
}

// Pre-render formatting
- (BOOL)preFormat
{
    if(self.preFormatted)
    {
        return YES;
    }

    if(self.smooth)
    {
        self.width = 0;
    }
    else
    {
        if(self.glyph)
        {
            // Width already set.
        }
        else
        {
            self.width = (float)self.text.length;   // TODO: measure text properly
        }
    }

    if(self.justification == VFJustifyCENTER)
    {
        self.extraLeftPx = self.width / 2;
    }
    else if(self.justification == VFJustifyRIGHT)
    {
        self.extraLeftPx = self.width;
    }

    self.preFormatted = YES;
    return YES;
}

- (void)draw:(CGContextRef)ctx
{
    /*

        if (self.justification == Vex.Flow.TextNote.Justification.CENTER) {
            x -= self.getWidth() / 2;
        } else if (self.justification == Vex.Flow.TextNote.Justification.RIGHT) {
            x -= self.getWidth();
        }

        if (self.glyph) {
            var y = self.Staff.getYForLine(self.line + (-3));
            self.glyph.render(self.context,
                              x + self.glyph_struct.x_shift,
                              y + self.glyph_struct.y_shift)
        } else {
            var y = self.Staff.getYForLine(self.line + (-3));
            ctx.save();
            ctx.setFont(self.font.family, self.font.size, self.font.weight);
            ctx.fillText(self.text, x, y);
            ctx.restore();
        }
    }

     */

    if(!self.staff)
    {
        VFLogError(@"NoStaff, Can't draw without a Staff.");
    }
    float x = self.absoluteX;

    if(self.glyph)
    {
        [self.glyph renderWithContext:ctx
                                  atX:(x + [self.glyphTextNoteStruct[@"x_shift"] floatValue])
                                  atY:(x + [self.glyphTextNoteStruct[@"y_shift"] floatValue])];
    }
    else
    {
        float y = [self.staff getYForLine:self.line + (-3)];
        NSFont* descriptionFont = [VFFont fontWithName:@"ArialMT" size:8];

        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = kCTTextAlignmentCenter;
        NSAttributedString* description;

        description = [[NSAttributedString alloc] initWithString:self.text
                                                      attributes:@{
                                                          NSParagraphStyleAttributeName : paragraphStyle,
                                                          NSFontAttributeName : descriptionFont,
                                                          NSForegroundColorAttributeName : VFColor.blackColor
                                                      }];
        [description drawAtPoint:CGPointMake(x, y)];
    }
}

@end
