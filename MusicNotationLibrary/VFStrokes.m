//
//  VFStrokes.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFStrokes.h"
#import "VFVex.h"
#import "VFFont.h"
#import "VFEnum.h"
#import "VFStaffNote.h"
#import "VFModifierContext.h"
#import "VFGlyph.h"
#import "VFKeyProperty.h"

@implementation VFStroke

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
        [self setupStrokesithDictionary:optionsDict];
    }
    return self;
}

+ (VFStroke*)strokeWithType:(VFStrokeType)type
{
    VFStroke* ret = [[VFStroke alloc] initWithDictionary:nil];
    ret.type = type;
    return ret;
}

+ (VFStroke*)strokeWithType:(VFStrokeType)type allVoices:(BOOL)allVoices
{
    VFStroke* ret = [[VFStroke alloc] initWithDictionary:nil];
    ret.type = type;
    ret.allVoices = allVoices;
    return ret;
}

- (void)setupStrokesithDictionary:(NSDictionary*)optionsDict;
{
    /*
     // ## Prototype Methods
     Vex.Inherit(Stroke, Modifier, {
         init: function(type, options) {
         Stroke.superclass.init.call(this);

         self.note = nil;
         self.options = Vex.Merge({}, options);

         // multi voice - span stroke across all voices if YES
         self.all_voices = 'all_voices' in self.options ?
         self.options.all_voices : YES;

         // multi voice - end note of stroke, set in draw()
         self.note_end = nil;
         self.index = nil;
         self.type = type;
         self.position = Modifier.Position.LEFT;

         self.render_options = {
         font_scale: 38,
         stroke_px: 3,
         stroke_spacing: 10
         };

         self.font = {
         family: "serif",
         size: 10,
         weight: "bold italic"
         };

         self.setX_shift(0);
         self.setWidth(10);
     },
     */
    self.note = nil;
    //    self.options = Vex.Merge({}, options);

    // multi voice - span stroke across all voices if YES
    self.allVoices = [optionsDict.allKeys containsObject:@"all_voices"] ? [optionsDict[@"all_voices"] boolValue] : YES;

    // multi voice - end note of stroke, set in draw()
    self.noteEnd = nil;
    self.index = -999;   // nil;
                         //    self.type = type;
    self.position = VFPositionLeft;

    [self->_renderOptions setFontSize:38];   // = {font_scale : 38, stroke_px : 3, stroke_spacing : 10};

    //    self.font = [VFFont fontWithName:@"serif" size:10 weight:@"bold italic"];

    self.xShift = 0;   // self.setX_shift(0);
    self.width = 10;   // self.setWidth(10);
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"strokes";
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"note_end" : @"noteEnd"}];
    return propertiesEntriesMapping;
}

/*!
 *  Arrange strokes inside `ModifierContext`
 *  @param modifiers <#modifiers description#>
 *  @param state     <#state description#>
 *  @param context   <#context description#>
 *  @return <#return value description#>
 */
+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* strokes = modifiers;

    float left_shift = state.left_shift;
    float stroke_spacing = 0;

    if(!strokes || strokes.count == 0)
    {
        return YES;
    }

    NSMutableArray* str_list = [NSMutableArray array];
    NSUInteger i = 0;
    VFStroke* str = nil;
    float shift = 0;
    for(i = 0; i < strokes.count; ++i)
    {
        str = strokes[i];
        VFNote* note = str.note;
        KeyProperty* props;
        if([note isKindOfClass:[VFStaffNote class]])
        {
            props = note.keyProps[str.index];
            shift = (props.displaced ? note.extraLeftPx : 0);
            [str_list push:@{@"line" : @(props.line), @"shift" : @(shift), @"str" : str}];
        }
        else
        {
            // TODO: finish for tabnote
            //            props = note.getPositions()[str.getIndex()];
            //            [str_list push:@{@"line" : @(props.str), @"shift" : @(0), @"str" : str}];
        }
    }

    float str_shift = left_shift;
    float x_shift = 0.f;

    // There can only be one stroke .. if more than one, they overlay each other
    for(i = 0; i < str_list.count; ++i)
    {
        str = str_list[i][@"str"];
        shift = [str_list[i][@"shift"] floatValue];

        str.xShift = (str_shift + shift);
        x_shift = MAX(str.width + stroke_spacing, x_shift);
    }

    state.left_shift += x_shift;

    return YES;
}

/*
getPosition: function() { return self.position; },
addEndNote: function(note) { self.note_end = note; return this; },
 */

- (id)addEndNote:(VFNote*)note;
{
    self.noteEnd = note;
    return self;
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    if(!(self.note && (self.index != -999)))
    {
        VFLogError("NoAttachedNote, Can't draw stroke without a note and index.");
    }
    if(![self.note isKindOfClass:[VFStaffNote class]])
    {
        VFLogError(@"StrokeNoteError, not yet ready for tabnotes.");
    }
    VFStaffNote* note = note;
    VFPoint* start = [self.note getModifierstartXYforPosition:self.position andIndex:self.index];
    NSArray* ys = self.note.ys;
    float topY = start.y;
    float botY = start.y;
    float x = start.x - 5.f;
    float line_space = self.note.staff.options.spacing_between_lines_px;

    NSArray* notes = [self.modifierContext getModifiersForType:self.note.category];
    NSUInteger i;
    for(i = 0; i < notes.count; ++i)
    {
        ys = [notes[i] ys];
        for(NSUInteger n = 0; n < ys.count; ++n)
        {
            if(self.note == notes[i] || self.allVoices)
            {
                topY = MIN(topY, [ys[n] floatValue]);
                botY = MAX(botY, [ys[n] floatValue]);
            }
        }
    }

    NSString* arrow;
    float arrow_shift_x = 0;
    float arrow_y = 0;
    float text_shift_x = 0;
    float text_y = 0;
    switch(self.type)
    {
        case VFStrokeBrushDown:
        {
            arrow = @"vc3";
            arrow_shift_x = -3;
            arrow_y = topY - (line_space / 2) + 10;
            botY += (line_space / 2);
            break;
        }
        case VFStrokeBrushUp:
        {
            arrow = @"v11";
            arrow_shift_x = 0.5;
            arrow_y = botY + (line_space / 2);
            topY -= (line_space / 2);
            break;
        }
        case VFStrokeRollDown:
        case VFStrokeRasquedoDown:
        {
            arrow = @"vc3";
            arrow_shift_x = -3;
            text_shift_x = self.x_shift + arrow_shift_x - 2;
            if([self.note isKindOfClass:[VFStaffNote class]])
            {
                topY += 1.5 * line_space;
                if(fmodf((botY - topY), 2) != 0.f)
                {
                    botY += 0.5 * line_space;
                }
                else
                {
                    botY += line_space;
                }
                arrow_y = topY - line_space;
                text_y = botY + line_space + 2;
            }
            else /* tabnote */
            {
                topY += 1.5 * line_space;
                botY += line_space;
                arrow_y = topY - 0.75 * line_space;
                text_y = botY + 0.25 * line_space;
            }
            break;
        }
        case VFStrokeRollUp:
        case VFStrokeRasquedoUp:
        {
            arrow = @"v52";
            arrow_shift_x = -4;
            text_shift_x = self.x_shift + arrow_shift_x - 1;
            if([self.note isKindOfClass:[VFStaffNote class]])
            {
                arrow_y = line_space / 2;
                topY += 0.5 * line_space;
                if(fmodf((botY - topY), 2) == 0.f)
                {
                    botY += line_space / 2;
                }
                arrow_y = botY + 0.5 * line_space;
                text_y = topY - 1.25 * line_space;
            }
            else /* tabnote */
            {
                topY += 0.25 * line_space;
                botY += 0.5 * line_space;
                arrow_y = botY + 0.25 * line_space;
                text_y = topY - line_space;
            }
            break;
        }
    }

    // Draw the stroke
    if(self.type == VFStrokeBrushDown || self.type == VFStrokeBrushUp)
    {
        CGContextFillRect(ctx, CGRectMake(x + self.x_shift, topY, 1, botY - topY));
    }
    else
    {
        if([self.note isKindOfClass:[VFStaffNote class]])
        {
            for(i = topY; i <= botY; i += line_space)
            {
                [VFGlyph renderGlyph:ctx
                                 atX:x + self.x_shift - 4
                                 atY:i
                           withScale:1 /* self.render_options.font_scale */
                        forGlyphCode:@"va3"];
            }
        }
        else
        {
            for(i = topY; i <= botY; i += 10)
            {
                [VFGlyph renderGlyph:ctx
                                 atX:x + self.x_shift - 4
                                 atY:i
                           withScale:1 /* self.render_options.font_scale */
                        forGlyphCode:@"va3"];
            }
            if(self.type == VFStrokeRasquedoDown)
                text_y = i + 0.25 * line_space;
        }
    }

    // Draw the arrow head
    [VFGlyph renderGlyph:ctx
                     atX:x + self.x_shift + arrow_shift_x
                     atY:arrow_y
               withScale:1 /* self.render_options.font_scale */
            forGlyphCode:arrow];

    // Draw the rasquedo "R"
    if(self.type == VFStrokeRasquedoDown || self.type == VFStrokeRasquedoUp)
    {
        // TODO:  update the font    self.context.setFont(self.font.family, self.font.size, self.font.weight);
        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = kCTTextAlignmentCenter;
        VFFont* font1 = [VFFont fontWithName:@"Helvetica" size:12];
        NSAttributedString* r = [[NSAttributedString alloc]
            initWithString:@"R"
                attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
        [r drawAtPoint:CGPointMake(x + text_shift_x, text_y)];
        VFLogInfo(@"Rendering stroke: %@ %f %f", @"R", x + text_shift_x, text_y);
    }
}
@end
