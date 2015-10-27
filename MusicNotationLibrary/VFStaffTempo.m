//
//  VFStaffTempo.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFStaffTempo.h"
#import "VFStaff.h"
#import "VFVex.h"
#import "VFText.h"
#import "VFFont.h"
#import "Tempo.h"
#import "VFTables.h"
#import "VFRenderer.h"
#import "VFGlyph.h"
#import "VFTableTypes.h"

@implementation TempoOptionsStruct
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
    }
    return self;
}

@end

@implementation VFStaffTempo

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
    }
    return self;
}

- (instancetype)initWithTempo:(TempoOptionsStruct*)tempo atX:(float)x withShiftY:(float)shiftY;
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        self.tempo = tempo;
        _x = x;
        self.shiftY = shiftY;
        [self setupStaffTempo];
    }
    return self;
}

- (void)setupStaffTempo
{
    self.shiftX = 10;
    self.position = VFPositionAbove;
    self.fontFamily = @"times";
    self.fontSize = 14;
    self.fontWeightBold = YES;
    //    self.options.glyphFontScale = 30;
    self.font = [VFFont fontWithName:self.fontFamily size:self.fontSize];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

+ (NSString*)CATEGORY
{
    return @"stavetempo";
}

- (void)setTempo:(TempoOptionsStruct*)tempo
{
    _tempo = tempo;
}

- (void)setShiftX:(float)shiftX
{
    _shiftX = shiftX;
}

- (void)setShiftY:(float)shiftY
{
    _shiftY = shiftY;
}

- (void)draw:(CGContextRef)ctx toStaff:(VFStaff*)staff withShiftX:(float)shiftX
{
    [super draw:ctx];

    //    TempoOptions* options = self.options;
    //    float scale = options.glyphFontScale / 38;
    //    NSString* name = self.tempo.name;
    //    NSString* duration = self.tempo.duration;
    //    float dots = self.tempo.dots;
    //    float bpm = self.tempo.bpm;
    //    VFFont* font = self.font;
    //    //    CGContextRef ctx = staff.graphicsContext;
    //    float x = self.x + self.shiftX + shiftX;
    //    float y = [staff getYForTopTextWithLine:1] + self.shiftY;
    //
    //    CGContextSaveGState(ctx);
    //    if(name != nil)
    //    {
    //        [VFText setFont:font];
    //        [VFText drawSimpleText:ctx atPoint:VFPointMake(x, y) withText:name];
    //    }
    //
    //    if(duration > 0 && bpm > 0)
    //    {
    //        x += [VFText measureText:@" "].width;
    //        [VFText drawSimpleText:ctx atPoint:VFPointMake(x, y) withText:@"("];
    //        x += [VFText measureText:@")"].width;
    //
    //        VFTablesGlyphStruct* glyphStruct = [VFTables durationToGlyphStruct:duration];
    //        // TODO: finish
    //        VFGlyph* glyph =
    //            nil;   //[VFTables durationToGlyph:<#(VFNoteDurationType)#> withNHMRSType:<#(VFNoteNHMRSType)#>]
    //        x += 3 * scale;
    //        //        [glyph renderWithContext:ctx atX:x atY:y];
    //        [VFGlyph renderGlyph:ctx atX:x atY:y withScale:1 forGlyphCode:glyphStruct.metrics.code];
    //        x += glyphStruct.head_width * scale;
    //
    //        // Draw stem and flags
    //        if(glyphStruct.stem)
    //        {
    //            float stem_height = 30;
    //
    //            if(glyphStruct.beamCount)
    //            {
    //                stem_height += 3 * (glyphStruct.beamCount - 1);
    //            }
    //            stem_height *= scale;
    //            float y_top = y - stem_height;
    //            [VFRenderer fillRect:ctx withRect:CGRectMake(x, y_top, scale, stem_height)];
    //
    //            if(glyphStruct.flag)
    //            {
    //                [VFGlyph renderGlyph:ctx
    //                                 atX:x + scale
    //                                 atY:y_top
    //                           withScale:options.glyphFontScale
    //                        forGlyphCode:glyph.codeFlagUpstem];
    //                if(!dots)
    //                {
    //                    x += 6 * scale;
    //                }
    //            }
    //        }
    //
    //        // Draw dot
    //        for(NSUInteger i = 0; i < dots; ++i)
    //        {
    //            x += 6 * scale;
    //            CGContextBeginPath(ctx);
    //            CGContextAddArcToPoint(ctx, x, y + 2 * scale, 2 * scale, 0, kPI);
    //            CGContextFillPath(ctx);
    //        }
    //
    //        NSString* text;
    //        if(name.length > 0)
    //        {
    //            text = [NSString stringWithFormat:@" = %.0f)", bpm];
    //        }
    //        else
    //        {
    //            text = [NSString stringWithFormat:@" = %.0f", bpm];
    //        }
    //        [VFText drawSimpleText:ctx atPoint:VFPointMake(x + 3 * scale, y) withText:text];
    //    }
    //    CGContextRestoreGState(ctx);
}
@end
