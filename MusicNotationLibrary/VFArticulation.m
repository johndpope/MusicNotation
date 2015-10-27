//
//  VFArticulation.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFArticulation.h"
#import "VFVex.h"
#import "VFNote.h"
#import "VFStaffNote.h"
#import "VFStem.h"
#import "VFExtentStruct.h"
#import "VFGlyph.h"
#import "VFTables.h"

@implementation VFArticulation

- (instancetype)init;
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [self setupArticulation];
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        //        _index = nil;
        [self setupArticulation];
    }
    return self;
}

- (instancetype)initWithType:(VFArticulationType)articulationType;
{
    self =
        [self initWithDictionary:VFTables.articulationsDictionary[[VFTables articulationCodeForType:articulationType]]];
    if(self)
    {
        _articulationType = articulationType;
        //        _articulationCode = [VFTables articulationCodeForType:articulationType];
        //        [self setupArticulation];
    }
    return self;
}

- (instancetype)initWithCode:(NSString*)code
{
    self = [self initWithDictionary:VFTables.articulationsDictionary[code]];
    if(self)
    {
        //        [self setupArticulation];
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{
        @"shift_right" : @"shiftRight",
        @"shift_up" : @"shiftUp",
        @"shift_down" : @"shiftDown",
        @"between_lines" : @"betweenLines",
    }];
    return propertiesEntriesMapping;
}

/*
Vex.Inherit(Articulation, Modifier, {

init: function(type) {
    Articulation.superclass.init.call(self);

    self.note = null;
    self.index = null;
    self.type = type;
    self.position = Modifier.Position.BELOW;

    self.render_options = {
    font_scale: 38
    };

    self.articulation = Vex.Flow.articulationCodes(self.type);
    if (!self.articulation) throw new Vex.RERR("ArgumentError",
                                               "Articulation not found: '" + self.type + "'");

    // Default width comes from articulation table.
    self.setWidth(self.articulation.width);
},*/

- (void)setupArticulation
{
    //    self.note = nil;
    ////    _index = NULL;
    //    _position = VFPositionBelow;
    //    self.renderOptions.fontScale = 38;
    //    _articulationCode = [self class]articulationCodeForType:<#(VFArticulationType)#>
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"articulations";
}

+ (VFArticulation*)articulationWithOptionsDict:(NSDictionary*)optionsDict;
{
    VFArticulation* ret = [[VFArticulation alloc] initWithDictionary:optionsDict];
    return ret;
}

// Create a new articulation of type `type`, which is an entry in
// `Vex.Flow.articulationCodes` in `tables.js`.
+ (VFArticulation*)articulationForType:(VFArticulationType)type
{
    VFArticulation* ret = [[VFArticulation alloc] initWithType:type];
    return ret;
}

- (NSString*)getArticulationCode
{
    return [[self class] articulationCodeForType:_articulationType];
}

- (void)setArticulationType:(VFArticulationType)articulationType
{
    _articulationType = articulationType;
}

- (id)setPosition:(VFPositionType)positionType;
{
    _positionType = positionType;
    return self;
}

// ## Static Methods
// Arrange articulations inside `ModifierContext`
+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* articulations = modifiers;
    if(!articulations || articulations.count == 0)
    {
        return NO;
    }

    NSUInteger text_line = state.text_line;
    float max_width = 0;

    // Format Articulations
    float width = 0;
    for(uint i = 0; i < articulations.count; ++i)
    {
        VFArticulation* articulation = articulations[i];
        [articulation setText_line:text_line];
        width = articulation.width > max_width ? articulation.width : max_width;

        NSDictionary* type = VFTables.articulationsDictionary[articulation.articulationCode];
        if([type[@"between_lines"] boolValue])
            text_line += 1;
        else
            text_line += 1.5;
    }

    state.left_shift += width / 2;
    state.right_shift += width / 2;
    state.text_line = text_line;

    return YES;
}

- (void)draw:(CGContextRef)ctx withStaff:(VFStaff*)staff withShiftX:(float)shiftX;
{
    [super draw:ctx withStaff:staff withShiftX:shiftX];
}

// Render articulation in position next to note.
- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    if(!self.note && (self.index == -1))
    {
        VFLogError(@"NoAttachedNote, Can't draw Articulation without a note and index.");
    }

    VFStemDirectionType stem_direction = [self.note stemDirection];
    VFStaff* staff = [self.note staff];

    BOOL is_on_head = ((self.position == VFPositionAbove && stem_direction == VFStemDirectionDown) ||
                       (self.position == VFPositionBelow && stem_direction == VFStemDirectionUp));

    BOOL (^needsLineAdjustment)(VFArticulation*, NSUInteger, float) =
        ^BOOL(VFArticulation* articulation, NSUInteger note_line, float line_spacing) {
          NSInteger offset_direction = (articulation.position == VFPositionAbove) ? 1 : -1;
          NSString* duration = ((VFStaffNote*)articulation.note).durationString;
          if(!is_on_head && [[VFTables durationToNumber:duration] floatValue] <= 1)
          {
              // Add stem length, unless it's on a whole note.
              note_line += offset_direction * 3.5;
          }

          NSUInteger articulation_line = note_line + (offset_direction * line_spacing);

          if(articulation_line >= 1 && articulation_line <= 5 && articulation_line % 1 == 0)
          {
              return YES;
          }

          return NO;
        };

    // Articulations are centered over/under the note head.
    VFPoint* start = [self.note getModifierstartXYforPosition:self.position andIndex:self.index];
    float glyph_y = start.y;
    float shiftY = 0;
    float line_spacing = 1;
    float spacing = staff.spacingBetweenLines;
    BOOL is_tabnote = [[self.note category] isEqualToString:@"tabnotes"];
    VFExtentStruct* stem_ext = [[(VFStemmableNote*)self.note stem] extents];

    float top = stem_ext.topY;
    float bottom = stem_ext.baseY;

    if(stem_direction == VFStemDirectionDown)
    {
        top = stem_ext.baseY;
        bottom = stem_ext.topY;
    }

    // TabNotes don't have stems attached to them. Tab stems are rendered
    // outside the staff.
    if(is_tabnote)
    {
        if([self.note hasStem])
        {
            if(stem_direction == VFStemDirectionUp)
            {
                bottom = [staff getYForBottomTextWithLine:(self.text_line - 2)];
            }
            else if(stem_direction == VFStemDirectionDown)
            {
                top = [staff getYForTopTextWithLine:(self.text_line - 1.5)];
            }
        }
        else
        {   // Without a stem
            top = [staff getYForTopTextWithLine:(self.text_line - 1)];
            bottom = [staff getYForBottomTextWithLine:(self.text_line - 2)];
        }
    }

    BOOL is_above = (self.position == VFPositionAbove) ? YES : NO;
    NSUInteger note_line = [self.note getLineNumber:is_above];

    // Beamed stems are longer than quarter note stems.
    if(!is_on_head && [self.note beam])
        line_spacing += 0.5;

    // If articulation will overlap a line, reposition it.
    if(needsLineAdjustment(self, note_line, line_spacing))
        line_spacing += 0.5;

    float glyph_y_between_lines;
    if(self.position == VFPositionAbove)
    {
        shiftY = self.articulation.shiftUp;
        glyph_y_between_lines = (top - 7) - (spacing * (self.text_line + line_spacing));

        if(self.articulation.betweenLines)
            glyph_y = glyph_y_between_lines;
        else
            glyph_y = MIN([staff getYForTopTextWithLine:(self.text_line)] - 3, glyph_y_between_lines);
    }
    else
    {
        shiftY = self.articulation.shiftDown - 10;

        glyph_y_between_lines = bottom + 10 + spacing * (self.text_line + line_spacing);
        if(self.articulation.betweenLines)
            glyph_y = glyph_y_between_lines;
        else
            glyph_y = MAX([staff getYForBottomTextWithLine:(self.text_line)], glyph_y_between_lines);
    }

    float glyph_x = start.x + self.articulation.shiftRight;
    glyph_y += shiftY + self.y_shift;

    [VFLog
        logInfo:[NSString stringWithFormat:@"Rendering articulation: %@ %f %f", self.articulation, glyph_x, glyph_y]];
    [VFGlyph renderGlyph:ctx
                     atX:glyph_x
                     atY:glyph_y
               withScale:1 //[self->_renderOptions glyphFontScale]
            forGlyphCode:self.code];
}

@end
