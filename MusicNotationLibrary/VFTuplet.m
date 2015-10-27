//
//  VFTuplet.m
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

#import "VFTuplet.h"
#import "VFVex.h"
#import "VFNote.h"
#import "VFStaffNote.h"
#import "VFPoint.h"
#import "VFFormatter.h"
#import "VFGlyph.h"
#import "VFBezierPath.h"
#import "VFExtentStruct.h"
#import "VFGlyph.h"
#import "VFMetrics.h"
#import "NSObject+NSObjectAdditions.h"
#import "VFTableTypes.h"

@implementation VFTuplet
{
}

#pragma mark - Initialize
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialize
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setupTuplet];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)initWithNotes:(NSArray*)notes
{
    self = [self initWithNotes:notes andOptionsDict:nil];
    if(self)
    {
        //        [self setupTuplet];
    }
    return self;
}

// Create a new tuplet from the specified notes. The notes must
// be part of the same line, and have the same duration (in ticks).
- (instancetype)initWithNotes:(NSArray*)notes andOptionsDict:(NSDictionary*)optionsDict;
{
    self = [self initWithDictionary:optionsDict];
    if(self)
    {
        if(!notes || notes.count == 0)
        {
            [VFLog logError:@"BadArguments, No notes provided for tuplet."];
        }

        if(notes.count == 1)
        {
            [VFLog logError:@"BadArguments, Too few notes for tuplet."];
        }
        _notes = [notes mutableCopy];
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

// Set the notes to attach this tuplet to.
- (void)setupTuplet
{
    _beatsOccupied = _beatsOccupied > 0 ? _beatsOccupied : 2;
    _bracketed = ((VFStaffNote*)_notes[0]).beam == nil;
    _ratioed = NO;
    _point = 28;
    _position = [VFPoint pointWithX:100 andY:16];
    _width = 200;
    _tupletLocation = VFTupletLocationTop;

    [VFFormatter alignRestsToNotes:_notes withNoteAlignment:YES andTupletAlignment:YES];
    [self resolveGlyphs];
    [self attach];
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

// Set whether or not the bracket is drawn.
- (void)setBracketed:(BOOL)bracketed
{
    _bracketed = bracketed ? YES : NO;
}

// Set whether or not the ratio is shown.
- (void)setRatioed:(BOOL)ratioed
{
    _ratioed = ratioed ? YES : NO;
}

- (void)setTupletLocation:(VFTupletLocationType)tupletLocation
{
    if(tupletLocation == VFTupletLocationNone)
    {
        tupletLocation = VFTupletLocationTop;
    }
    switch(tupletLocation)
    {
        case VFTupletLocationBottom:
        case VFTupletLocationTop:
            _tupletLocation = tupletLocation;
            break;
        default:
            VFLogError(@"BadArgument, Invalid tuplet location: %lu", tupletLocation);
            break;
    }
}

- (NSMutableArray*)notes
{
    if(!_notes)
    {
        _notes = [NSMutableArray array];
    }
    return _notes;
}

- (NSUInteger)getNoteCount
{
    if(_notes)
    {
        return _notes.count;
    }
    else
        return 0;
}

- (NSUInteger)numNotes
{
    return self.noteCount;
}

- (void)setBeatsOccupied:(NSUInteger)beatsOccupied
{
    [self detach];

    _beatsOccupied = beatsOccupied;

    [self resolveGlyphs];

    [self attach];
}

- (NSMutableArray*)numeratorGlyphs
{
    if(!_numeratorGlyphs)
    {
        _numeratorGlyphs = [NSMutableArray array];
    }
    return _numeratorGlyphs;
}

- (NSMutableArray*)denominatorGlyphs
{
    if(!_denominatorGlyphs)
    {
        _denominatorGlyphs = [NSMutableArray array];
    }
    return _denominatorGlyphs;
}

- (void)setPosition:(VFPoint*)pointPosn
{
    _position = pointPosn;
}

- (VFPoint*)pointPosition
{
    if(!_position)
    {
        _position = [VFPoint pointZero];
    }
    return _position;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)attach
{
    for(NSUInteger i = 0; i < self.notes.count; ++i)
    {
        VFStaffNote* note = self.notes[i];
        note.tuplet = self;
    }
}

- (void)detach
{
    for(NSUInteger i = 0; i < self.notes.count; ++i)
    {
        VFStaffNote* note = self.notes[i];
        note.tuplet = nil;
    }
}

- (void)resolveGlyphs
{
    for(NSUInteger n = self.numNotes; n >= 1; n /= 10)
    {
        VFGlyph* glyph = [VFGlyph glyphWithCode:[NSString stringWithFormat:@"v%lu", (n % 10)] withPointSize:1];
        [self.numeratorGlyphs addObject:glyph];
    }
    for(NSUInteger n = self.beatsOccupied; n >= 1; n /= 10)
    {
        VFGlyph* glyph = [VFGlyph glyphWithCode:[NSString stringWithFormat:@"v%lu", (n % 10)] withPointSize:1];
        [self.denominatorGlyphs addObject:glyph];
    }
}

- (void)draw:(CGContextRef)ctx;
{
    if(!ctx)
    {
        VFLogError(@"NoCanvasContext, Can't draw without a canvas context.");
    }

    // determine x value of left bound of tuplet
    VFStaffNote* firstNote = [self.notes objectAtIndex:0];
    VFStaffNote* lastNote = [self.notes lastObject];

    if(!self.bracketed)
    {
        self.position.x = firstNote.stemX;
        self.width = lastNote.stemX - self.position.x;
    }
    else
    {
        self.position.x = firstNote.tieLeftX - 5;
        self.width = lastNote.tieRightX - self.position.x + 5;
    }

    // determine y value for tuplet
    if(self.tupletLocation == VFTupletLocationTop)
    {
        self.position.y = [firstNote.staff getYForLine:0] - 15;
        for(VFStaffNote* note in self.notes)
        {
            float topY =
                note.stemDirection == VFStemDirectionUp ? note.stemExtents.topY - 10 : note.stemExtents.baseY - 20;
            if(topY < self.position.y)
            {
                self.position.y = topY;
            }
        }
    }
    else
    {
        self.position.y = [firstNote.staff getYForLine:4] + 20;
        for(VFStaffNote* note in self.notes)
        {
            float bottomY =
                note.stemDirection == VFStemDirectionUp ? note.stemExtents.baseY + 20 : note.stemExtents.topY + 10;
            if(bottomY > self.position.y)
            {
                self.position.y = bottomY;
            }
        }
    }

    // calculate total width of tuplet notation
    float width = 0;
    for(VFTablesGlyphStruct* glyph in self.numeratorGlyphs)
    {
        width += glyph.metrics.width;
    }
    if(self.ratioed)
    {
        for(VFTablesGlyphStruct* glyph in self.denominatorGlyphs)
        {
            width += glyph.metrics.width;
        }
        width += self.point * 0.32;
    }
    float notationCenterX = self.position.x + self.width / 2;
    float notationStartX = notationCenterX - width / 2;

    // draw bracket if the tuplet is not beamed
    if(self.bracketed)
    {
        float lineWidth = self.width / 2 - width / 2 - 5;

        // only draw the bracket if it has positive length
        if(lineWidth > 0)
        {
            float x = self.position.x;
            float y = self.position.y;
            float w = lineWidth;

            CGRect rect1 = CGRectMake(x, y, width, 1);
            VFBezierPath* path = (VFBezierPath*)[VFBezierPath bezierPathWithRect:rect1];
            [path stroke];
            [path fill];

            CGRect rect2 = CGRectMake(x + self.width / 2 + w / 2 + 5, y, w, 1);
            path = (VFBezierPath*)[VFBezierPath bezierPathWithRect:rect2];
            [path stroke];
            [path fill];

            CGRect rect3 =
                CGRectMake(x, y + (self.tupletLocation == VFTupletLocationBottom), 1, self.tupletLocation * 10);
            path = (VFBezierPath*)[VFBezierPath bezierPathWithRect:rect3];
            [path stroke];
            [path fill];

            CGRect rect4 =
                CGRectMake(x + w, y + (self.tupletLocation == VFTupletLocationBottom), 1, self.tupletLocation * 10);
            path = (VFBezierPath*)[VFBezierPath bezierPathWithRect:rect4];
            [path stroke];
            [path fill];
        }
    }

    // draw numerator glyphs
    float xOffset = 0;
    float size = self.numeratorGlyphs.count;
    for(NSUInteger i = 0; i < self.numeratorGlyphs.count; ++i)
    {
        NSUInteger index = size - i - 1;
        VFTablesGlyphStruct* glyph = self.numeratorGlyphs[index];
        CGFloat x, y;
        x = notationStartX + xOffset;
        y = self.position.y + (self.point / 3) - 2;
        [VFGlyph renderGlyph:ctx atX:x atY:y withScale:1 forGlyphCode:glyph.metrics.code];
        xOffset += ((VFTablesGlyphStruct*)self.numeratorGlyphs[index]).metrics.width;
    }

    // display colon and denominator if the ratio is to be shown
    if(self.ratioed)
    {
        float colonX = notationStartX + xOffset + self.point * 0.16;
        float colonRadius = self.point * 0.06;
        VFBezierPath* path = (VFBezierPath*)[VFBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(colonX, self.position.y - self.point * 0.08)
                        radius:colonRadius
                    startAngle:0
                      endAngle:M_2_PI
                     clockwise:YES];
        [path closePath];
        [path stroke];
        [path fill];
        path = (VFBezierPath*)[VFBezierPath bezierPath];
        [path addArcWithCenter:CGPointMake(colonX, self.position.y + self.point * 0.12)
                        radius:colonRadius
                    startAngle:0
                      endAngle:M_2_PI
                     clockwise:YES];
        [path stroke];
        [path fill];
        xOffset += self.point * 0.32;
        size = self.denominatorGlyphs.count;
        for(NSUInteger i = 0; i < self.denominatorGlyphs.count; ++i)
        {
            NSUInteger index = size - i - 1;
            VFTablesGlyphStruct* glyph = (VFTablesGlyphStruct*)self.numeratorGlyphs[index];
            CGFloat x, y;
            x = notationStartX + xOffset;
            y = self.position.y + (self.point / 3) - 2;
            [VFGlyph renderGlyph:ctx atX:x atY:y withScale:1 forGlyphCode:glyph.metrics.code];
            xOffset += ((VFTablesGlyphStruct*)self.numeratorGlyphs[index]).metrics.width;
        }
    }
}

@end
