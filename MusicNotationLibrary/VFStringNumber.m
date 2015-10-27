//
//  VFStringNumber.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFStringNumber.h"
#import "VFVex.h"

@implementation VFStringNumber
{
}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)initWithNums:(NSArray*)nums
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        _nums = nums;
        [self setupStringNumber];
    }
    return self;
}

- (instancetype)initWithString:(NSString*)nums
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
        [self setupStringNumber];
    }
    return self;
}

- (void)setupStringNumber
{
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
    return @"stringnumber";
}

+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    /*
    Vex.Flow.StringNumber = (function() {
        function StringNumber(number) {
            if (arguments.length > 0) self.init(number);
        }

        var Modifier = Vex.Flow.Modifier;

        // ## Static Methods
        // Arrange string numbers inside a `ModifierContext`
        StringNumber.format = function(nums, state) {
            var left_shift = state.left_shift;
            var right_shift = state.right_shift;
            var num_spacing = 1;

            if (!nums || nums.length === 0) return this;

            var nums_list = [];
            var prev_note = null;
            var shift_left = 0;
            var shift_right = 0;

            var i, num, note, pos, props_tmp;
            for (i = 0; i < nums.length; ++i) {
                num = nums[i];
                note = num.getNote();

                for (i = 0; i < nums.length; ++i) {
                    num = nums[i];
                    note = num.getNote();
                    pos = num.getPosition();
                    var props = note.getKeyProps()[num.getIndex()];

                    if (note != prev_note) {
                        for (var n = 0; n < note.keys.length; ++n) {
                            props_tmp = note.getKeyProps()[n];
                            if (left_shift === 0)
                            shift_left = (props_tmp.displaced ? note.getExtraLeftPx() : shift_left);
                            if (right_shift === 0)
                            shift_right = (props_tmp.displaced ? note.getExtraRightPx() : shift_right);
                        }
                        prev_note = note;
                    }

                    nums_list.push({ line: props.line, pos: pos, shiftL: shift_left, shiftR: shift_right, note: note,
    num: num });
                }
            }

            // Sort string numbers by line number.
            nums_list.sort(function(a, b) { return (b.line - a.line); });

            var num_shiftL = 0;
            var num_shiftR = 0;
            var x_widthL = 0;
            var x_widthR = 0;
            var last_line = null;
            var last_note = null;
            for (i = 0; i < nums_list.length; ++i) {
                var num_shift = 0;
                note = nums_list[i].note;
                pos = nums_list[i].pos;
                num = nums_list[i].num;
                var line = nums_list[i].line;
                var shiftL = nums_list[i].shiftL;
                var shiftR = nums_list[i].shiftR;

                // Reset the position of the string number every line.
                if (line != last_line || note != last_note) {
                    num_shiftL = left_shift + shiftL;
                    num_shiftR = right_shift + shiftR;
                }

                var num_width = num.getWidth() + num_spacing;
                if (pos == Vex.Flow.Modifier.Position.LEFT) {
                    num.setX_shift(left_shift);
                    num_shift = shift_left + num_width; // spacing
                    x_widthL = (num_shift > x_widthL) ? num_shift : x_widthL;
                } else if (pos == Vex.Flow.Modifier.Position.RIGHT) {
                    num.setX_shift(num_shiftR);
                    num_shift += num_width; // spacing
                    x_widthR = (num_shift > x_widthR) ? num_shift : x_widthR;
                }
                last_line = line;
                last_note = note;
            }

            state.left_shift += x_widthL;
            state.right_shift += x_widthR;
            return true;
        };
     */

    return YES;
}

/*


// ## Prototype Methods
Vex.Inherit(StringNumber, Modifier, {
init: function(number) {
    StringNumber.superclass.init.call(this);

    self.note = null;
    self.last_note = null;
    self.index = null;
    self.string_number = number;
    self.setWidth(20);                                 // ???
    self.position = Modifier.Position.ABOVE;  // Default position above stem or note head
    self.x_shift = 0;
    self.y_shift = 0;
    self.x_offset = 0;                               // Horizontal offset from default
    self.y_offset = 0;                               // Vertical offset from default
    self.dashed = true;                              // true - draw dashed extension  false - no extension
    self.leg = Vex.Flow.Renderer.LineEndType.NONE;   // draw upward/downward leg at the of extension line
    self.radius = 8;
    self.font = {
    family: "sans-serif",
    size: 10,
    weight: "bold"
    };
},

getNote: function() { return self.note; },
setNote: function(note) { self.note = note; return this; },
getIndex: function() { return self.index; },
setIndex: function(index) { self.index = index; return this; },

setLineEndType: function(leg) {
    if (leg >= Vex.Flow.Renderer.LineEndType.NONE &&
        leg <= Vex.Flow.Renderer.LineEndType.DOWN)
    self.leg = leg;
    return this;
},

*/

- (id)setLineEndType:(VFRendererLineEndType)leg
{
    if(leg >= VFLineEndNone && leg <= VFLineEndDown)
    {
        _leg = leg;
    }
    return self;
}
/*

getPosition: function() { return self.position; },
setPosition: function(position) {
    if (position >= Modifier.Position.LEFT &&
        position <= Modifier.Position.BELOW)
    self.position = position;
    return this;
},

setStringNumber: function(number) { self.string_number = number; return this; },
setOffsetX: function(x) { self.x_offset = x; return this; },
setOffsetY: function(y) { self.y_offset = y; return this; },
 */
- (VFStringNumber*)setOffsetX:(NSUInteger)x
{
    _x_offset = x;
    return self;
}
- (VFStringNumber*)setOffsetY:(NSUInteger)y
{
    _y_offset = y;
    return self;
}
/*

setLastNote: function(note) { self.last_note = note; return this; },

 */
- (id)setLastNote:(VFStaffNote*)lastNote
{
    _lastNote = lastNote;
    return self;
}
/*

setDashed: function(dashed) { self.dashed = dashed; return this; },
*/
- (id)setDashed:(BOOL)dashed
{
    _dashed = dashed;
    return self;
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    /*
    draw: function() {
        if (!self.context) throw new Vex.RERR("NoContext",
                                              "Can't draw string number without a context.");
        if (!(self.note && (self.index != null))) throw new Vex.RERR("NoAttachedNote",
                                                                     "Can't draw string number without a note and
index.");

        var ctx = self.context;
        var line_space = self.note.stave.options.spacing_between_lines_px;

        var start = self.note.getModifierStartXY(self.position, self.index);
        var dot_x = (start.x + self.x_shift + self.x_offset);
        var dot_y = start.y + self.y_shift + self.y_offset;

        switch (self.position) {
            case Modifier.Position.ABOVE:
            case Modifier.Position.BELOW:
            var stem_ext = self.note.getStemExtents();
            var top = stem_ext.topY;
            var bottom = stem_ext.baseY + 2;

            if (self.note.stem_direction == Vex.Flow.StaveNote.STEM_DOWN) {
                top = stem_ext.baseY;
                bottom = stem_ext.topY - 2;
            }

            if (self.position == Modifier.Position.ABOVE) {
                dot_y = self.note.hasStem() ? top - (line_space * 1.75)
                : start.y - (line_space * 1.75);
            } else {
                dot_y = self.note.hasStem() ? bottom + (line_space * 1.5)
                : start.y + (line_space * 1.75);
            }

            dot_y += self.y_shift + self.y_offset;

            break;
            case Modifier.Position.LEFT:
            dot_x -= (self.radius / 2) + 5;
            break;
            case Modifier.Position.RIGHT:
            dot_x += (self.radius / 2) + 6;
            break;
        }

        ctx.save();
        ctx.beginPath();
        ctx.arc(dot_x, dot_y, self.radius, 0, Math.PI * 2, false);
        ctx.lineWidth = 1.5;
        ctx.stroke();
        ctx.setFont(self.font.family, self.font.size, self.font.weight);
        var x = dot_x - ctx.measureText(self.string_number).width / 2;
        ctx.fillText("" + self.string_number, x, dot_y + 4.5);

        if (self.last_note != null) {
            var end = self.last_note.getStemX() - self.note.getX() + 5;
            ctx.strokeStyle="#000000";
            ctx.lineCap = "round";
            ctx.lineWidth = 0.6;
            if (self.dashed)
            Vex.Flow.Renderer.drawDashedLine(ctx, dot_x + 10, dot_y, dot_x + end, dot_y, [3,3]);
            else
            Vex.Flow.Renderer.drawDashedLine(ctx, dot_x + 10, dot_y, dot_x + end, dot_y, [3,0]);

            var len, pattern;
            switch (self.leg) {
                case Vex.Flow.Renderer.LineEndType.UP:
                len = -10;
                pattern = self.dashed ? [3,3] : [3,0];
                Vex.Flow.Renderer.drawDashedLine(ctx, dot_x + end, dot_y, dot_x + end, dot_y + len, pattern);
                break;
                case Vex.Flow.Renderer.LineEndType.DOWN:
                len = 10;
                pattern = self.dashed ? [3,3] : [3,0];
                Vex.Flow.Renderer.drawDashedLine(ctx, dot_x + end, dot_y, dot_x + end, dot_y + len, pattern);
                break;
            }
        }

        ctx.restore();
    }
    });

    return StringNumber;
}());
*/
}
@end
