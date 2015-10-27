//
//  VFStaffRepetition.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFStaffRepetition.h"
#import "VFStaff.h"
#import "VFText.h"
#import "VFGlyph.h"

@interface VFStaffRepetition ()
@end

@implementation VFStaffRepetition

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupStaffRepetition];
    }
    return self;
}

- (void)setupStaffRepetition
{
    self.x_shift = 0;
    _x = 0;
    self.fontName = @"times";
    self.fontSize = 12;
    self.fontBold = YES;
    self.fontItalic = YES;
}

- (instancetype)initWithType:(VFRepetitionType)type x:(float)x y_shift:(float)y_shift;
{
    self = [super init];
    if(self)
    {
        [self setupStaffRepetition];
        self.symbol_type = type;
        _x = x;   // TODO: self.x causeing error for unknown reason
        self.y_shift = y_shift;
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"repetitions";
}

- (void)draw:(CGContextRef)ctx staff:(VFStaff*)staff x:(float)x;
{
    switch(self.symbol_type)
    {
        case VFRepCodaRight:
            [self drawCodaFixed:ctx staff:self.staff x:x + self.staff.width];
            break;
        case VFRepCodaLeft:
            [self drawSymbolText:ctx staff:self.staff x:x withText:@"Coda" isCoda:YES];
            break;
        case VFRepSegnoLeft:
            [self drawSignoFixed:ctx staff:self.staff x:x];
            break;
        case VFRepSegnoRight:
            [self drawSignoFixed:ctx staff:self.staff x:x + staff.width];
            break;
        case VFRepDC:
            [self drawSymbolText:ctx staff:self.staff x:x withText:@"D.C." isCoda:NO];
            break;
        case VFRepDCALCoda:
            [self drawSymbolText:ctx staff:self.staff x:x withText:@"D.C. al" isCoda:YES];
            break;
        case VFRepDCALFine:
            [self drawSymbolText:ctx staff:self.staff x:x withText:@"D.C. al Fine" isCoda:NO];
            break;
        case VFRepDS:
            [self drawSymbolText:ctx staff:self.staff x:x withText:@"D.S." isCoda:NO];
            break;
        case VFRepDSALCoda:
            [self drawSymbolText:ctx staff:self.staff x:x withText:@"D.S. al" isCoda:YES];
            break;
        case VFRepDSALFine:
            [self drawSymbolText:ctx staff:self.staff x:x withText:@"D.S. al Fine" isCoda:NO];
            break;
        case VFRepFine:
            [self drawSymbolText:ctx staff:self.staff x:x withText:@"Fine" isCoda:NO];
            break;
        case VFRepNone:
            break;
        default:
            break;
    }
}

- (void)drawCodaFixed:(CGContextRef)ctx staff:(VFStaff*)staff x:(float)x;
{
    //    if (self.staff.graphicsContext == NULL) {
    //        [VFLog logError:@"cannot draw without context"];
    //    }
    float y = [self.staff getYForTopTextWithLine:self.staff.options.numLines] + self.y_shift;
    [VFGlyph renderGlyph:ctx atX:x atY:y withScale:1 forGlyphCode:@"v4d"];
}

- (void)drawSignoFixed:(CGContextRef)ctx x:(VFStaff*)staff x:(float)x;
{
    //    if (self.staff.graphicsContext == NULL) {
    //        [VFLog logError:@"cannot draw without context"];
    //    }
    float y = [self.staff getYForTopTextWithLine:self.staff.options.numLines] + self.y_shift;
    [VFGlyph renderGlyph:ctx atX:x atY:y withScale:1 forGlyphCode:@"v8c"];
}

- (void)drawSymbolText:(CGContextRef)ctx x:(VFStaff*)staff x:(float)x withText:(NSString*)text isCoda:(BOOL)drawCoda;
{
    //    if (self.staff.graphicsContext == NULL) {
    //        [VFLog logError:@"cannot draw without context"];
    //    }

    //    CGContextRef ctx = staff.graphicsContext;
    CGContextSaveGState(ctx);
    // Default to right symbol
    float text_x = 0 + self.x_shift;
    float symbol_x = x + self.x_shift;
    if(self.symbol_type == VFRepCodaLeft)
    {
        // Offset Coda text to right of stave beginning
        text_x = self.x + staff.options.verticalBarWidth;
        symbol_x = text_x + [VFText measureText:text].width;   // TODO: possibly incorrect text width
    }
    else
    {
        // Offset Signo text to left stave end
        symbol_x = self.x + x + staff.width - 5 + self.x_shift;
        text_x = symbol_x - +[VFText measureText:text].width - 12;   // TODO: possibly incorrect text width
    }

    if(drawCoda)
    {
        [VFGlyph renderGlyph:ctx atX:symbol_x atY:YES withScale:1 forGlyphCode:@"v4d"];
    }
    float y = [staff getYForTopTextWithLine:staff.options.numLines] + self.y_shift;
    VFPoint* pt = VFPointMake(text_x, y + 5);
    [VFText drawSimpleText:ctx atPoint:pt withHeight:12 withText:text];
    CGContextRestoreGState(ctx);
}

@end
