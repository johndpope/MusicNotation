//
//  VFOrnament.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFOrnament.h"
#import "VFVex.h"
#import "VFTables.h"
#import "VFAccidental.h"
#import "VFStaffNote.h"
#import "VFExtentStruct.h"
#import "VFMath.h"
#import "VFTickContext.h"
#import "VFGlyph.h"
#import "VFTablesOrnamentCodes.h"

// Not Finished
// Complete

//@implementation State
//@end

//@interface VFOrnament (private)
//@property (strong, nonatomic) State *state;
//@end

@implementation VFOrnament
{
    float _width;
}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        /*
         self.note = null;
         self.index = null;
         self.type = type;
         self.position = Modifier.Position.ABOVE;
         self.delayed = NO;

         self.accidental_upper = "";
         self.accidental_lower = "";

         self.render_options = {
         font_scale: 38
         };

         self.ornament = Vex.Flow.ornamentCodes(self.type);
         if (!self.ornament) throw new Vex.RERR("ArgumentError",
         "Ornament not found: '" + self.type + "'");

         // Default width comes from ornament table.
         self.setWidth(self.ornament.width);
         */
        // TODO: complete this
        //    _note = nil;
        //    _index = -1;
        //    _position = VFPositionAbove;
        //    _delayed = NO;
        //
        //    _accidental_upper = @"";
        //    _accidental_lower = @"";
        //
        //    _font_scale = 38;
        //             [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

// Create a new ornament of type `type`, which is an entry in
// `Vex.Flow.ornamentCodes` in `tables.js`.
// TODO: replace type with an enum type derived from VFTaables orngmanetCodes dictionary keys
- (instancetype)initWithType:(NSString*)type
{
    self = [self initWithDictionary:@{}];
    if(self)
    {
        _type = type;
        NSDictionary* dict = VFTables.ornamentCodes[type];
        _ornament = [[OrnamentData alloc] initWithDictionary:dict];
        if(!_ornament)
        {
            VFLogError(@"ArgumentError %@ %@", @"Ornament not found: '%@'", _type);
        }
        _width = _ornament.width;
    }
    return self;
}

+ (VFOrnament*)ornamentWithType:(NSString*)type
{
    return [[VFOrnament alloc] initWithType:type];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

//+ (BOOL)format:(NSMutableArray *)ornaments state:(VFModifierState *)state; {
//    //+ (void)formatOrnaments:(NSArray *)ornaments state:(State *)state {
//    //    /*
//    //    if (!ornaments || ornaments.count === 0) return NO;
//    //
//    //    var text_line = state.text_line;
//    //    var max_width = 0;
//    //
//    //    // Format Articulations
//    //    var width;
//    //    for (var i = 0; i < ornaments.count; ++i) {
//    //        var ornament = ornaments[i];
//    //        ornament.setTextLine(text_line);
//    //        width = ornament.getWidth() > max_width ?
//    //        ornament.getWidth() : max_width;
//    //
//    //        var type = Vex.Flow.ornamentCodes(ornament.type);
//    //        if(type.between_lines)
//    //        text_line += 1;
//    //        else
//    //        text_line += 1.5;
//    //    }
//    //
//    //    state.left_shift += width / 2;
//    //    state.right_shift += width / 2;
//    //    state.text_line = text_line;
//    //    return YES;
//    //    */
//    //
//    //
//    ////    float width;
//    //    // Default width comes from ornament table.
//    //
//    //    //TODO: fix self.code
//    //    //self.code = nil; //" : @"v1e",
//    ////    state.shiftRight = [[_ornament objectForKey:@"shift_right"] floatValue];
//    ////    state.shiftUp = [[_ornament objectForKey:@"shift_up"] floatValue];
//    ////    state.shiftDown = [[_ornament objectForKey:@"shift_down"] floatValue];
//    ////    state.width = [[_ornament objectForKey:@"width"] floatValue];
//    //}
//    return YES;
//}

- (id)setDelayed:(BOOL)delayed;
{
    _delayed = delayed;
    return self;
}

- (BOOL)delayed;
{
    return _delayed;
}

- (id)setUpperAccidental:(NSString*)accidental;
{
    _accidental_upper = accidental;
    return self;
}

- (id)setLowerAccidental:(NSString*)accidental;
{
    _accidental_lower = accidental;
    return self;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"ornaments";
}

static NSDictionary* _acc_mods;

+ (NSDictionary*)acc_mods
{
    if(!_acc_mods)
    {
        _acc_mods = @{
            @"n" : @{@"shift_x" : @(1), @"shift_y_upper" : @(0), @"shift_y_lower" : @(0), @"height" : @(17)},
            @"#" : @{@"shift_x" : @(0), @"shift_y_upper" : @(-2), @"shift_y_lower" : @(-2), @"height" : @(20)},
            @"b" : @{@"shift_x" : @(1), @"shift_y_upper" : @(0), @"shift_y_lower" : @(3), @"height" : @(18)},
            @"##" : @{
                @"shift_x" : @(0),
                @"shift_y_upper" : @(0),
                @"shift_y_lower" : @(0),
                @"height" : @(12),
            },
            @"bb" : @{@"shift_x" : @(0), @"shift_y_upper" : @(0), @"shift_y_lower" : @(4), @"height" : @(17)},
            @"db" : @{@"shift_x" : @(-3), @"shift_y_upper" : @(0), @"shift_y_lower" : @(4), @"height" : @(17)},
            @"bbs" : @{@"shift_x" : @(0), @"shift_y_upper" : @(0), @"shift_y_lower" : @(4), @"height" : @(17)},
            @"d" : @{@"shift_x" : @(0), @"shift_y_upper" : @(0), @"shift_y_lower" : @(0), @"height" : @(17)},
            @"++" : @{@"shift_x" : @(-2), @"shift_y_upper" : @(-6), @"shift_y_lower" : @(-3), @"height" : @(22)},
            @"+" : @{@"shift_x" : @(1), @"shift_y_upper" : @(-4), @"shift_y_lower" : @(-2), @"height" : @(20)}
        };
    }
    return _acc_mods;
}

- (float)shiftRight
{
    return self.state.right_shift;
}

+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* ornaments = modifiers;
    if(!ornaments || ornaments.count == 0)
    {
        return NO;
    }

    float text_line = state.text_line;
    float max_width = 0;

    // format articulations
    float width = 0;
    for(int i = 0; i < ornaments.count; ++i)
    {
        VFOrnament* ornament = (VFOrnament*)ornaments[i];
        //[ornament setTextLine:text_line];
        ornament.text_line = text_line;
        width = ornament.width > max_width ? ornament.width : max_width;

        OrnamentData* type = ornament.ornament; // [VFTables.ornamentCodes valueForKey:ornament.type];
        if(type.between_lines)
        {
            text_line += 1;
        }
        else
        {
            text_line += 1.5;
        }
    }

    state.left_shift += width / 2;
    state.right_shift += width / 2;
    state.text_line = text_line;

    return YES;
}

// Render ornament in position next to note.
- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    void (^drawAccidental)(CGContextRef, NSString*, BOOL, VFPoint*);

    //    self.graphicsContext = ctx;
    if(!(self.note && (self.index != -1)))
    {
        [VFLog logError:[NSString
                            stringWithFormat:@"NoAttachedNote %@", @"Can't draw Ornament without a note and index."]];
    }

    VFStaffNote* note = self.note;
    if(![note isKindOfClass:[VFStaffNote class]])
    {
        VFLogError(@"NoStaffNote, expected a staffnote.");
    }
    VFStemDirectionType stem_direction = note.stemDirection;
    VFStaff* staff = note.staff;

    // Get stem extents
    VFExtentStruct* stem_ext = note.stemExtents;
    float top, bottom;
    if(stem_direction == VFStemDirectionDown)
    {
        top = stem_ext.baseY;
        bottom = stem_ext.topY;
    }
    else
    {
        top = stem_ext.topY;
        bottom = stem_ext.baseY;
    }

    // TabNotes don't have stems attached to them. Tab stems are rendered
    // outside the staff.
    BOOL is_tabnote = [note.category isEqualToString:@"tabnotes"];
    if(is_tabnote)
    {
        if(note.hasStem)
        {
            if(stem_direction == VFStemDirectionUp)
            {
                bottom = [staff getYForBottomTextWithLine:self.text_line - 2];
            }
            else if(stem_direction == VFStrokeDirectionDown)
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

    BOOL is_on_head = stem_direction == VFStemDirectionDown;
    float spacing = staff.spacingBetweenLines;
    float line_spacing = 1;

    // Beamed stems are longer than quarter note stems, adjust accordingly
    if(!is_on_head && note.beam)
    {
        line_spacing += 0.5;
    }

    float total_spacing = spacing * (self.text_line + line_spacing);
    float glyph_y_between_lines = (top - 7) - total_spacing;

    // Get initial coordinates for the modifier position
    VFPoint* start =
        [self.note getModifierstartXYforPosition:self.position andIndex:self.index];   // (self.position, self.index);
    float glyph_x = start.x + self.shiftRight;
    __block float glyph_y = MIN([staff getYForTopTextWithLine:(self.text_line) - 3], glyph_y_between_lines);
    glyph_y += self.shiftUp + self.shift_y;

    // Ajdust x position if ornament is delayed
    if(self.delayed)
    {
        glyph_x += self.width;
        VFTickContext* next_context = [VFTickContext getNextContext:note.tickContext];
        if(next_context != nil)
        {
            glyph_x += (next_context.x - glyph_x) * 0.5;
        }
        else
        {
            glyph_x += (staff.x + staff.width - glyph_x) * 0.5;
        }
    }

    VFOrnament* ornament = self;
    drawAccidental = ^(CGContextRef ctx, NSString* code, BOOL upper, VFPoint* point) {
      VFAccidental* accidental = [[VFTables accidentalsDictionary] objectForKey:code];

      float acc_x = point.x - 3;
      float acc_y = point.y + 2;

      // Fine tune position of accidental glyph
      NSDictionary* mods = _acc_mods[code];
      if(mods)
      {
          acc_x += [mods[@"shift_x"] floatValue];
          acc_y += upper ? [mods[@"shift_y_upper"] floatValue] : [mods[@"shift_y_lower"] floatValue];
      }

      // Special adjustments for trill glyph
      if(upper)
      {
          float ht = [_acc_mods[@"height"] floatValue];
          acc_y -= mods ? ht : 18;
          acc_y += [self.type isEqualToString:@"tr"] ? -8 : 0;
      }
      else
      {
          acc_y += [self.type isEqualToString:@"tr"] ? -6 : 0;
      }

      // Render the glyph
//      float scale = ornament.font_scale / 1.3;   // .render_options.font_scale / 1.3;
      VFPoint* pt = [VFPoint pointWithX:acc_x andY:acc_y];
      [VFGlyph renderGlyph:ctx atX:pt.x atY:pt.y withScale:1./1.3 /*scale*/ forGlyphCode:accidental.code];
      // renderGlyphWithContext:ctx atPoint:pt withScale:scale forCode:accidental.code];

      // If rendered a bottom accidental, increase the y value by the
      // accidental height so that the ornament's glyph is shifted up
      if(!upper)
      {
          glyph_y -= mods ? [mods[@"height"] floatValue] : 18;
      }
    };

    // Draw lower accidental for ornament
    if(self.accidental_lower)
    {
        VFPoint* pt = [VFPoint pointWithX:glyph_x andY:glyph_y];
        drawAccidental(ctx, self.accidental_lower, NO, pt);
    }

    [VFLog
        logDebug:[NSString stringWithFormat:@"Rendering ornament: %@ point:(%f, %f)", self.ornament, glyph_x, glyph_y]];

    VFPoint* pt = [VFPoint pointWithX:glyph_x andY:glyph_y];
    [VFGlyph renderGlyph:ctx atX:pt.x atY:pt.y withScale:1 /*self.font_scale*/ forGlyphCode:self.ornament.code];
    //    [self renderGlyphWithContext:ctx atPoint:pt withScale:self.font_scale forCode:ornament_code];

    // Draw upper accidental for ornament
    if(self.accidental_upper)
    {
        VFPoint* pt = [VFPoint pointWithX:glyph_x andY:glyph_y];
        drawAccidental(ctx, self.accidental_upper, YES, pt);
    }
}
@end
