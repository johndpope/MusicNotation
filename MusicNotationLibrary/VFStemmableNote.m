//
//  VFStemmableNote.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFStemmableNote.h"
#import "VFStem.h"
#import "VFBeam.h"
#import "VFTables.h"
#import "VFGlyph.h"
#import "VFExtentStruct.h"
#import "VFVex.h"
#import "VFMath.h"
#import "VFTableTypes.h"

//@implementation StemmableNoteRenderOptions
//- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
//{
//    self = [super initWithDictionary:optionsDict];
//    if(self)
//    {
//        [self setValuesForKeyPathsWithDictionary:optionsDict];
//    }
//    return self;
//}
//
//- (instancetype)init
//{
//    self = [self initWithDictionary:nil];
//    if(self)
//    {
//    }
//    return self;
//}
//@end

@implementation VFStemmableNote

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        self.postFormatted = NO;
        _stem = nil;
        _stem_extension_override = -1;
        _beam = nil;
        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
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

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"stem_direction" : @"stemDirection"}];
    return propertiesEntriesMapping;
}

/*!
 *  hhelps create a debug description from the specified string to properties dictionary
 *  @return a dictionary of property names
 */
- (NSDictionary*)dictionarySerialization;
{
    return [self dictionaryWithValuesForKeyPaths:@[]];
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  gets the stem
 *  @return stem
 */
- (VFStem*)stem
{
    return _stem;
}

/*!
 *  sets the stem
 *  @param stem the stem of this note
 */
- (void)setStem:(VFStem*)stem
{
    _stem = stem;
}

/*!
 *  Builds and sets a new stem
 */
- (void)buildStem
{
    self.stem = [[VFStem alloc] init];
}

/*!
 *  Get the full length of stem
 *  @return length of stem in pixels
 */
- (float)stemLength
{
    return kSTEM_HEIGHT + self.stemExtension;
}

/*!
 *  Get the count of beams for this duration
 *  @return number of beams
 */
- (NSUInteger)beamCount
{
    //    VFGlyph* glyph = self.glyph;
    VFTablesGlyphStruct* glyphStruct = self.glyphStruct;
    if(glyphStruct)
    {
        return glyphStruct.beamCount;
    }
    else
    {
        return 0;
    }
}

/*!
 *  Get the minimum length of stem
 *  @return length in pixels
 */
- (float)stemMinimumLength
{
    Rational* frac = [VFTables durationToFraction:self.durationString];
    __block float length = (frac.floatValue <= 1) ? 0 : 20;
    // if note is flagged, cannot shorten beam
    NSString* lookup = self.durationString;
    typedef void (^CaseBlock)();
    if(!_stemMinimumLengthsDictionary)
    {
        _stemMinimumLengthsDictionary = @{
            @"8" : ^{
              if(self.beam == nil)
                  length = 35;
            },
            @"16" : ^{
              if(self.beam == nil)
                  length = 35;
              else
                  length = 25;
            },
            @"32" : ^{
              if(self.beam == nil)
                  length = 45;
              else
                  length = 35;
            },
            @"64" : ^{
              if(self.beam == nil)
                  length = 50;
              else
                  length = 40;
            },
            @"128" : ^{
              if(self.beam == nil)
                  length = 55;
              else
                  length = 45;
            }
        };
    }

    ((CaseBlock)_stemMinimumLengthsDictionary[lookup])();   // invoke block

    return length;
}

/*!
 *  Get the direction of the stem
 *  @return +1 is up -1 is down 0 is undecided
 */
- (VFStemDirectionType)stemDirection
{
    return _stemDirection;
}

/*!
 *  Set the direction of the stem
 *  @param stemDirection +1 is up -1 is down 0 is undecided
 */
- (void)setStemDirection:(VFStemDirectionType)stemDirection
{
    if(stemDirection == VFStemDirectionNone)
    {
        stemDirection = VFStemDirectionUp;
    }
    if(stemDirection != VFStemDirectionUp && stemDirection != VFStemDirectionDown)
    {
        VFLogError(@"BadArgument, Invalid stem direction: %li", stemDirection);
    }
    _stemDirection = stemDirection;
    self.stem.stemDirection = _stemDirection;
    if(self.stem != nil)
    {
        self.stem.stemDirection = stemDirection;
        self.stem.extension = self.stemExtension;
    }

    self.beam = nil;
    if(self.preFormatted)
    {
        [self preFormat];
    }
}

/*!
 *  Get the `x` coordinate of the stem
 *  @return x pixel coord
 */
- (float)stemX
{
    float x_begin, x_end;

    x_begin = self.absoluteX + self.shift_x;
    x_end = x_begin + self.glyphStruct.head_width;

    float stem_x = self.stemDirection == VFStemDirectionDown ? x_begin : x_end;

    stem_x -= ((kSTEM_WIDTH / 2) * ((float)self.stemDirection));

    return stem_x;
}

// Get the `x` coordinate for the center of the glyph.
// Used for `TabNote` stems and stemlets over rests
- (float)centerGlyphX
{
    return self.absoluteX + self.shift_x + self.glyphStruct.head_width / 2;
}

// Get the stem extension for the current duration
- (float)stemExtension
{
    VFTablesGlyphStruct* glyphStruct = self.glyphStruct;
    if(self.stem_extension_override != -1)
    {
        return self.stem_extension_override;
    }

    if(glyphStruct != nil)
    {
        return self.stemDirection == 1 ? glyphStruct.stem_up_extension : glyphStruct.stem_down_extension;
    }

    return 0;
}

/*!
 *  Set the stem length to a specific. Will override the default length.
 *  @param height stem height in pixels
 */
- (void)setStemLength:(float)height
{
    self.stem_extension_override = height - kSTEM_HEIGHT;
}

/*!
 *  Get the top and bottom `y` values of the stem.
 *  @return pixels struct
 */
- (VFExtentStruct*)stemExtents
{
    if(self.ys == nil || self.ys.count == 0)
    {
        VFLogError(@"NoYValues, Can't get top stem Y when note has no Y values.");
        return nil;
    }

    float top_pixel = [self.ys[0] floatValue];
    float base_pixel = [self.ys[0] floatValue];
    float stem_height = kSTEM_HEIGHT + self.stemExtension;

    for(NSUInteger i = 0; i < self.ys.count; ++i)
    {
        float stem_top;
        stem_top = [[self.ys objectAtIndex:i] floatValue] + (stem_height * -((float)self.stemDirection));

        if(self.stemDirection == VFStemDirectionDown)
        {
            top_pixel = (top_pixel > stem_top) ? top_pixel : stem_top;
            base_pixel = (base_pixel < [self.ys[i] floatValue]) ? base_pixel : [self.ys[i] floatValue];
        }
        else
        {
            top_pixel = (top_pixel < stem_top) ? top_pixel : stem_top;
            base_pixel = (base_pixel > [self.ys[i] floatValue]) ? base_pixel : [self.ys[i] floatValue];
        }

        if(self.noteNHMRSType == VFNoteSlash || self.noteNHMRSType == VFNoteX)
        {
            top_pixel -= ((float)self.stemDirection) * 7;
            base_pixel -= ((float)self.stemDirection) * 7;
        }
    }
    //    VFLogInfo(@"Stem extents: (top:%f base:%f)", top_pixel, base_pixel);
    return [VFExtentStruct extentWithTopY:top_pixel andBaseY:base_pixel];
}

/*!
 *  Sets the current note's beam
 *  @param beam the beam for this note
 */
- (void)setBeam:(VFBeam*)beam
{
    _beam = beam;
}

/*!
 *  Get the `y` value for the top modifiers at a specific `text_line`
 *  @param textLine line number on staff for text
 *  @return y position on canvas
 */
- (float)yForTopText:(NSUInteger)textLine
{
    VFExtentStruct* extents = self.stemExtents;
    if(self.hasStem)
    {
        float a, b;
        a = [self.staff getYForTopTextWithLine:textLine];
        b = extents.topY - (self.renderOptions.annotation_spacing * (textLine + 1));
        return MIN(a, b);
    }
    else
    {
        return [self.staff getYForTopTextWithLine:textLine];
    }
}
/*!
 *  Get the `y` value for the bottom modifiers at a specific `text_line`
 *  @param textLine line number on staff for text
 *  @return y position on canvas
 */
- (float)yForBottomText:(NSUInteger)textLine
{
    VFExtentStruct* extents = self.stemExtents;
    if(self.hasStem)
    {
        float a, b;
        a = [self.staff getYForTopTextWithLine:textLine];
        b = extents.baseY + (self.renderOptions.annotation_spacing * textLine);
        return MAX(a, b);
    }
    else
    {
        return [self.staff getYForTopTextWithLine:textLine];
    }
}

/*!
 *  Post format the note
 *  @return YES if successful
 */
- (BOOL)postFormat
{
    if(self.beam != nil)
    {
        [self.beam postFormat];
    }
    self.postFormatted = YES;
    return YES;
}

/*!
 *  Render the stem onto the canvas
 *  @param ctx  graphics context
 *  @param stem stem object to draw
 */
- (void)drawStem:(CGContextRef)ctx withStem:(VFStem*)stem
{
    [super draw:ctx];

    self.stem = stem;
    if(self.drawStem)
    {
        [self.stem draw:ctx];
    }
}

@end
