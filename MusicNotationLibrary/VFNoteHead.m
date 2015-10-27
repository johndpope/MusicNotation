//
//  VFNoteHead.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

//@import AppKit;

#import "VFNoteHead.h"
#import "VFBoundingBox.h"
#import "VFVex.h"
#import "Rational.h"
#import "VFStaff.h"
#import "VFStaffNote.h"
#import "VFGlyph.h"
#import "VFTablesGlyphStruct.h"
#import "VFTables.h"

@implementation NoteHeadRenderOptions
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
    }
    return self;
}
@end

@implementation VFNoteHead

//+ (VFNoteHead *)noteHeadWithCustomGlyphCode:(NSString *)code {
//    return [[VFNoteHead alloc]initWithCustomGlyphCode:code];
//}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        //    self.index = [optionsDict[@"index"] unsignedIntegerValue];
        self.x = 0;   // [optionsDict[@"x"]unsignedIntegerValue] || 0;
        self.y = 0;   //[optionsDict[@"y"] unsignedIntegerValue] || 0;

        if(![optionsDict.allKeys containsObject:@"displaced"])
        {
            self.displaced = NO;
        }

        // [optionsDict[@"stem_direction"] unsignedIntegerValue] || VFStemDirectionUp;
        //    self.line = [optionsDict[@"line"] unsignedIntegerValue];

        // Get glyph code based on duration and note type. This could be
        // regular notes, rests, or other custom codes.
        self.noteDurationType = [VFEnum typeNoteDurationTypeForString:self.durationString];
        //        self.noteNHMRSType = [VFEnum typeNoteNHMRSTypeForString:self.noteTypeString];
        self.glyphStruct = [VFTables durationToGlyphStruct:self.noteDurationType withNHMRSType:self.noteNHMRSType];
        if(!self.glyphStruct)
        {
            VFLogError(@"BadArguments %@ %@ %@ %@", @"No glyph found for duration '%@'", self.durationString,
                       @" and type '%@'", self.noteName);
        }
        self.glyph_code = self.glyphStruct.code_head;
        self.xShift = [optionsDict[@"x_shift"] floatValue];
        if(optionsDict[@"custom_glyph_code"])
        {
            self.custom_glyph = YES;
            self.glyph_code = optionsDict[@"custom_glyph_code"];
        }

        self.style = optionsDict[@"style"];
        self.slashed = [optionsDict[@"slashed"] boolValue];

        self->_renderOptions = [[NoteHeadRenderOptions alloc] initWithDictionary:nil];
        [self->_renderOptions setGlyphFontScale:35];   // font size for note heads
        [self->_renderOptions setStrokePx:3];          // number of stroke px to the left and right of head

        if(optionsDict[@"glyph_font_scale"])
        {
            [self->_renderOptions setGlyphFontScale:[optionsDict[@"glyph_font_scale"] floatValue]];
        }

        // TODO: perhaps widths should be taken from calculated widths (VFGlyphList)
        //        self.width = self.glyphStruct.head_width;
        self.headWidth = self.glyphStruct.head_width;
        self.width = self.headWidth;

        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

//- (instancetype)initWithCustomGlyphCode:(NSString *)code
//{
//    // TODO: might be necessary to use head_options as actual struct
//    self = [self initWithDictionary:nil];
//    if (self) {
//        self.customGlyphCode = code;
//        self.useCustomGlyph = YES;
//        [self setupNoteHeadWithOptions:nil];
//    }
//    return self;
//}

+ (VFNoteHead*)noteHeadWithOptionsDict:(NSDictionary*)optionsDict;
{
    return nil;
}

- (void)setupNoteHeadWithOptions:(NSDictionary*)optionsDict
{
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"note_type" : @"noteTypeString"}];
    return propertiesEntriesMapping;
}

/*

        // Set the Cavnas context for drawing
    setContext: function(context) { self.context = context; return this;},

        // Get the width of the notehead
    getWidth: function() { return self.width; },

        // Determine if the notehead is displaced
    isDisplaced: function() { return self.displaced === YES; },


    getStyle: function() { return self.style; },
    setStyle: function(style) { self.style = style; return this; },

        // Get the glyph data
    getGlyph: function(){ return self.glyph; },

        // Set the X coordinate
    setX: function(x){ self.x = x; return this; },

        // get/set the Y coordinate
    getY: function() { return self.y; },
    setY: function(y) { self.y = y;  return this; },

        // Get/set the stave line the notehead is placed on
    getLine: function() { return self.line; },
    setLine: function(line) { self.line = line; return this; },
     */

- (float)glyphFontScale
{
    return [self->_renderOptions glyphFontScale];
}

- (void)setGlyphFontScale:(float)glyphFontScale
{
    [self->_renderOptions setGlyphFontScale:glyphFontScale];
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"notehead";
}

//- (NoteHeadRenderOptions *)renderOptions {
//    if (!renderOptions) {
//        _renderOptions = [[NoteHeadRenderOptions alloc]init];
//    }
//    return renderOptions;
//}

- (VFStaff*)staff
{
    if([self.parent isKindOfClass:[VFModifier class]])
    {
        return [((VFModifier*)self.parent)staff];
    }
    else
    {
        return super.staff;
    }
}

// Get the canvas `x` coordinate position of the notehead.
- (float)absoluteX
{
    // If the note has not been preformatted, then get the static x value
    // Otherwise, it's been formatted and we should use it's x value relative
    // to its tick context

    float x = !self.preFormatted ? self.x : super.absoluteX;

    return x + (self.displaced ? self.width * ((float)self.stemDirection) : 0.f);
}

- (void)setX:(float)x
{
    self.point.x = x;
}

- (float)x
{
    return self.point.x;
}

- (void)setY:(float)y
{
    self.point.y = y;
}

- (float)y
{
    return self.point.y;
}

- (void)setLine:(float)line
{
    super.line = line;
}

// Get the `BoundingBox` for the `NoteHead`
- (VFBoundingBox*)boundingBox
{
    if(!self.preFormatted)
    {
        VFLogError(@"UnformattedNote, Can't call getBoundingBox on an unformatted note.");
    }
    float spacing, half_spacing, min_y;
    spacing = self.staff.spacingBetweenLines;
    half_spacing = spacing / 2;
    min_y = self.y - half_spacing;

    return [VFBoundingBox boundingBoxAtX:self.absoluteX atY:min_y withWidth:self.width andHeight:spacing];
}

// Apply current style to Canvas `context`
- (void)applyStyle:(CGContextRef)ctx
{
    float blur = 0;
    if(self.style[@"shadowBlur"])
    {
        blur = [self.style[@"shadowBlur"] floatValue];
    }
    if(self.style[@"shadowColor"])
    {
        CGContextSetShadowWithColor(ctx, CGSizeMake(1, 1), blur, (CGColorRef)self.style[@"shadowColor"]);
    }
    if(self.style[@"fillStyle"])
    {
        CGContextSetFillColorWithColor(ctx, (CGColorRef)self.style[@"fillStyle"]);
    }
    if(self.style[@"strokeStyle"])
    {
        CGContextSetStrokeColorWithColor(ctx, (CGColorRef)self.style[@"strokeStyle"]);
    }
}

// Set notehead to a provided `stave`
- (void)setStaff:(VFStaff*)staff
{
        [super setStaff:staff];
    //    super.staff = staff;
//    _staff = staff;
    
    float line = self.line;
    [self setY:[staff getYForNoteWithLine:line]];
    //    self.graphicsContext = self.staff.graphicsContext;
}

// Pre-render formatting
- (BOOL)preFormat
{
    if(self.preFormatted)
    {
        return YES;
    }
    VFTablesGlyphStruct* glyphStruct = self.glyphStruct;
    float width = glyphStruct.head_width + self.extraLeftPx + self.extraRightPx;

    self.width = width;
    [self setPreFormatted:YES];
    return YES;
}

// Draw slashnote head manually. No glyph exists for self.
//
// Parameters:
// * `ctx`: the Canvas context
// * `duration`: the duration of the note. ex: "4"
// * `x`: the x coordinate to draw at
// * `y`: the y coordinate to draw at
// * `stem_direction`: the direction of the stem
- (void)drawSlashNoteHead:(CGContextRef)ctx
                 duration:(NSString*)duration
                        x:(float)x
                        y:(float)y
            stemDirection:(VFStemDirectionType)stemDirection;
{
    float width = 15 + kSTEM_WIDTH / 2;
    CGContextSaveGState(ctx);
    CGContextSetLineWidth(ctx, kSTEM_WIDTH);

    BOOL fill = NO;

    if([[VFTables durationToNumber:duration] floatValue] > 2)
    {
        fill = YES;
    }

    if(fill == NO)
    {
        x -= (kSTEM_WIDTH / 2) * stemDirection;
    }

    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, x, y + 11);
    CGContextAddLineToPoint(ctx, x, y + 1);
    CGContextAddLineToPoint(ctx, x + width, y - 10);
    CGContextAddLineToPoint(ctx, x + width, y);
    CGContextAddLineToPoint(ctx, x, y + 11);
    CGContextClosePath(ctx);

    if(fill)
    {
        CGContextFillPath(ctx);
    }
    else
    {
        CGContextStrokePath(ctx);
    }

    if([[VFTables durationToFraction:duration] equalsFloat:0.5])
    {
        NSArray* breve_lines = @[ @(-3), @(-1), @(width + 1), @(width + 3) ];
        for(NSUInteger i = 0; i < breve_lines.count; ++i)
        {
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, x + [breve_lines[i] floatValue], y - 10);
            CGContextAddLineToPoint(ctx, x + [breve_lines[i] floatValue], y + 11);
            CGContextStrokePath(ctx);
        }
    }

    CGContextRestoreGState(ctx);
}

// Draw the notehead
- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    float head_x = self.absoluteX;
    float y = self.y;

    VFLogDebug(@"%@", [NSString stringWithFormat:@"Drawing note head: '%@', '%@' at (%f, %f)", self.noteTypeString,
                                                 self.durationString, head_x, y]);

    // Begin and end positions for head.

    VFStemDirectionType stem_direction = self.stemDirection;
    //    float glyph_font_scale = [self->_renderOptions glyphFontScale];

    float line = self.line;
    y = [[VFStaff currentStaff] getYForNoteWithLine:self.line];

    // If note above/below the staff, draw the small staff
    if(line <= 0 || line >= 6)
    {
        float line_y = y;
        float floor = floorf(line);
        if(line < 0 && floor - line == -0.5)
        {
            line_y -= 5;
        }
        else if(line > 6 && floor - line == -0.5)
        {
            line_y += 5;
        }
        if(self.noteNHMRSType != VFNoteRest)
        {
            CGContextFillRect(ctx,
                              CGRectMake(head_x - [self->_renderOptions strokePx], line_y,
                                         (self.glyphStruct.head_width) + ([self->_renderOptions strokePx] * 2), 1));
        }
    }

    if(self.noteNHMRSType == VFNoteSlash)
    {
        [self drawSlashNoteHead:ctx duration:self.durationString x:head_x y:y stemDirection:stem_direction];
    }
    else
    {
        if(self.style)
        {
            CGContextSaveGState(ctx);
            [self applyStyle:ctx];   // TODO: this needs updated to latest styling method. see: VFStaffNote.m -
                                     // (void)drawModifiers:(CGContextRef)ctx
            [VFGlyph renderGlyph:ctx atX:head_x atY:y withScale:1 forGlyphCode:self.glyph_code];
            CGContextRestoreGState(ctx);
        }
        else
        {
            [VFGlyph renderGlyph:ctx atX:head_x atY:y withScale:1 forGlyphCode:self.glyph_code];
        }
    }
}

#pragma mark - CALayer methods

- (CGMutablePathRef)pathConvertPoint:(CGPoint)convertPoint
{
//    convertPoint = CGCombinePoints(self.point.CGPoint, convertPoint);
    CGMutablePathRef path = [super pathConvertPoint:convertPoint];
    
//    float head_x = self.absoluteX;
//    float y = self.staff.y;
    float x = self.absoluteX; // - convertPoint.x;
    float y = [[VFStaff currentStaff] getYForNoteWithLine:self.line] - self.staff.y;
    
    CGPathRef subPath = [VFGlyph createPathwithCode:self.glyph_code withScale:1 atPoint:CGPointMake(x, y)];
    CGPathAddPath(path, NULL, subPath);
    return path;
}

@end
