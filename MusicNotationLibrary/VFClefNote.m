//
//  VFClefNote.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFClefNote.h"
#import "VFVex.h"
#import "VFGlyph.h"
#import "VFClef.h"
#import "VFStaff.h"

@implementation VFClefNote

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        /*
        Vex.Flow.ClefNote = (function() {
            function ClefNote(clef, size, annotation) { self.init(clef, size, annotation); }

            Vex.Inherit(ClefNote, Vex.Flow.Note, {
            init: function(clef, size, annotation) {
                ClefNote.superclass.init.call(this, {duration: "b"});

                self.setClef(clef, size, annotation);

                // Note properties
                self.ignore_ticks = YES;
            },
         */

        [self setClefWithClefName:self.clefName size:self.clefSize annotationName:self.annotationName];

        [self setIgnoreTicks:YES];
    }
    return self;
}

+ (VFClefNote*)clefNoteWithClef:(NSString*)clef;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return nil;
}

+ (VFClefNote*)clefNoteWithClef:(NSString*)clef size:(NSString*)size;
{
    return [[VFClefNote alloc] initWithDictionary:@{@"clefName" : clef, @"clefSize" : size, @"duration" : @"b"}];
}

+ (VFClefNote*)clefNoteWithClef:(NSString*)clef size:(NSString*)size annotation:(NSString*)annotation;
{
    return [[VFClefNote alloc]
        initWithDictionary:
            @{@"clefName" : clef, @"clefSize" : size, @"annotationName" : annotation, @"duration" : @"b"}];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*
    setStave: function(stave) {
        var superclass = Vex.Flow.ClefNote.superclass;
        superclass.setStave.call(this, stave);
    },

    getBoundingBox: function() {
        return new Vex.Flow.BoundingBox(0, 0, 0, 0);
    },

    addToModifierContext: function() {
        // overridden to ignore
        return this;
    },

    getCategory: function() {
        return @"clefnote";
    },
*/

+ (NSString*)CATEGORY
{
    return @"clefnote";
}

- (NSString*)category
{
    return @"clefnote";
}

- (id)setClefWithClefName:(NSString*)clefName size:(NSString*)size annotationName:(NSString*)annotationName
{
    /*

        setClef: function(clef, size, annotation) {
            self.clef_obj = new Vex.Flow.Clef(clef, size, annotation);
            self.clef = self.clef_obj.clef;
            self.glyph = new Vex.Flow.Glyph(self.clef.code, self.clef.point);
            self.setWidth(self.glyph.getMetrics().width);
            return this;
        },

        getClef: function() {
            return self.clef;
        },
    */

    self.clef = [VFClef clefWithName:clefName size:size annotationName:annotationName];
    // new Vex.Flow.Clef(clef, size, annotation);
    self.clefName = self.clef.clefName;
    self.clefType = self.clef.type;
    self.glyph = [VFGlyph glyphWithCode:self.clef.code withPointSize:1];
    // new Vex.Flow.Glyph(self.clef.code, self.clef.point);
    self.width = self.glyph.metrics.width;

    return self;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (BOOL)preFormat
{
    BOOL ret = [super preFormat];
    self.preFormatted = YES;
    return ret;
}

/*
    preFormat: function() {
        self.setPreFormatted(YES);
        return this;
    },
*/

- (void)draw:(CGContextRef)ctx
{
    [super draw:ctx];
    /*
        draw: function() {
            if (!self.stave) throw new Vex.RERR("NoStave", "Can't draw without a stave.");

            if (!self.glyph.getContext()) {
                self.glyph.setContext(self.context);
            }
            var abs_x = self.getAbsoluteX();

            self.glyph.setStave(self.stave);
            self.glyph.setYShift(
                                 self.stave.getYForLine(self.clef.line) - self.stave.getYForGlyphs());
            self.glyph.renderToStave(abs_x);

            // If the Vex.Flow.Clef has an annotation, such as 8va, draw it.
            if (self.clef_obj.annotation !== undefined) {
                var attachment = new Vex.Flow.Glyph(self.clef_obj.annotation.code, self.clef_obj.annotation.point);
                if (!attachment.getContext()) {
                    attachment.setContext(self.context);
                }
                attachment.setStave(self.stave);
                attachment.setYShift(
                                     self.stave.getYForLine(self.clef_obj.annotation.line) -
       self.stave.getYForGlyphs());
                attachment.setX_shift(self.clef_obj.annotation.x_shift);
                attachment.renderToStave(abs_x);
            }

        }

    */
    if(!self.staff)
    {
        VFLogError(@"NoStaff, Can't draw without a staff.");
    }

    float abs_x = self.absoluteX;

    self.glyph.y_shift = [self.staff getYForLine:self.clef.line] - [self.staff getYForGlyphs];
    [self.glyph renderWithContext:ctx toStaff:self.staff atX:abs_x];

    // If the Vex.Flow.Clef has an annotation, such as 8va, draw it.
    if(self.clef.annotation)
    {
        VFGlyph* attachment =
            [VFGlyph glyphWithCode:self.clef.annotation.code withPointSize:self.clef.annotation.point];
        attachment.y_shift = [self.staff getYForLine:self.clef.annotation.line] - [self.staff getYForGlyphs];
        attachment.x_shift = self.clef.annotation.xShift;
        [attachment renderWithContext:ctx toStaff:self.staff atX:abs_x];
    }
}

@end
