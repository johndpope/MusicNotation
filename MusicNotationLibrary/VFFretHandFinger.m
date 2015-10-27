//
//  VFFretHandFinger.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFFretHandFinger.h"
#import "VFFont.h"
#import "VFLog.h"
#import "VFStaffNote.h"
#import "VFText.h"
#import "NSMutableArray+JSAdditions.h"
#import "VFStaffNote.h"
#import "VFKeyProperty.h"

@interface Num : IAModelBase
{
   @private
    NSUInteger _line;
    VFPositionType _pos;
    NSUInteger _shiftL;
    NSUInteger _shiftR;
    VFStaffNote* _note;
    VFFretHandFinger* _num;
}
@property (assign, nonatomic) NSUInteger line;
@property (assign, nonatomic) VFPositionType pos;
@property (assign, nonatomic) NSUInteger shiftL;
@property (assign, nonatomic) NSUInteger shiftR;
@property (strong, nonatomic) VFStaffNote* note;
@property (strong, nonatomic) VFFretHandFinger* num;
@end

@implementation Num
@end

@implementation VFFretHandFinger

- (instancetype)initWithFingerNumber:(NSString*)fingerNumber
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        self.finger = fingerNumber;
        [self setupFretHandFinger];
    }
    return self;
}

- (instancetype)initWithFingerNumber:(NSString*)fingerNumber andPosition:(VFPositionType)position
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        self.finger = fingerNumber;
        self.position = position;
        [self setupFretHandFinger];
    }
    return self;
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

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [self setupFretHandFinger];
    }
    return self;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"frethandfingers";
}

- (void)setupFretHandFinger
{
    self->_note = nil;
    self.index = -1;
    self.width = 7;
    self.position = VFPositionLeft;   // Default position above stem or note head
    self.x_shift = 0;
    self.y_shift = 0;
    _x_offset = 0;   // Horizontal offset from default
    _y_offset = 0;   // Vertical offset from default
    self.font = [VFFont fontWithName:@"sans-serif" size:9 weight:@"bold"];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* fingers = modifiers;

    /*
    Vex.Flow.FretHandFinger = (function() {
        function FretHandFinger(number) {
            if (arguments.length > 0) self.init(number);
        }

        var Modifier = Vex.Flow.Modifier;

        // Arrange fingerings inside a ModifierContext.
        FretHandFinger.format = function(nums, state) {
            var left_shift = state.left_shift;
            var right_shift = state.right_shift;
            var num_spacing = 1;

            if (!nums || nums.length === 0) return false;

            var nums_list = [];
            var prev_note = nil;
            var shift_left = 0;
            var shift_right = 0;

            var i, num, note, pos, props_tmp;
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

                nums_list.push({ line: props.line, pos: pos, shiftL: shift_left, shiftR: shift_right, note: note, num:
    num });
            }
    */
    NSMutableArray* nums = modifiers;
    float left_shift = state.left_shift;
    float right_shift = state.right_shift;
    NSUInteger num_spacing = 1;

    if(!nums || nums.count == 0)
    {
        return false;
    }

    NSMutableArray* nums_list = [NSMutableArray array];
    VFNote* prev_note = nil;
    float shift_left = 0;
    float shift_right = 0;

    VFFretHandFinger* num;
    VFStaffNote* note;
    VFPositionType pos;
    KeyProperty* props_tmp;
    KeyProperty* props;
    for(NSUInteger i = 0; i < nums.count; ++i)
    {
        num = nums[i];
        note = num.note;
        pos = num.position;
        props = note.keyProps[num.index];
        if(note != prev_note)
        {
            for(NSUInteger n = 0; n < note.keyStrings.count; ++n)
            {
                props_tmp = note.keyProps[n];
                if(left_shift == 0)
                    shift_left = (props_tmp.displaced ? note.extraLeftPx : shift_left);
                if(right_shift == 0)
                    shift_right = (props_tmp.displaced ? note.extraRightPx : shift_right);
            }
            prev_note = note;
        }

        //        [nums_list push:@{
        //            @"line" : @(props.line),
        //            @"pos" : pos,
        //            @"shiftL" : @(shift_left),
        //            @"shiftR" : @(shift_right),
        //            @"note" : note,
        //            @"num" : num
        //        }];

        //        id (^newNum)() = ^id() {
        //          return [[Num alloc] initWithDictionary:@{
        //              @"line" : @(props.line),
        //              @"pos" : pos,
        //              @"shiftL" : @(shift_left),
        //              @"shiftR" : @(shift_right),
        //              @"note" : note,
        //              @"num" : num
        //          }];
        //        };
        //
        //        [nums_list push:newNum()];

        [nums_list push:[[Num alloc] initWithDictionary:@{
                       @"line" : @(props.line),
                       @"pos" : @(pos),
                       @"shiftL" : @(shift_left),
                       @"shiftR" : @(shift_right),
                       @"note" : note,
                       @"num" : num
                   }]];
    }

    /*
            // Sort fingernumbers by line number.
            nums_list.sort(function(a, b) { return (b.line - a.line); });

            var num_shiftL = 0;
            var num_shiftR = 0;
            var x_widthL = 0;
            var x_widthR = 0;
            var last_line = nil;
            var last_note = nil;

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
                    num.setX_shift(left_shift + num_shiftL);
                    num_shift = left_shift + num_width; // spacing
                    x_widthL = (num_shift > x_widthL) ? num_shift : x_widthL;
                } else if (pos == Vex.Flow.Modifier.Position.RIGHT) {
                    num.setX_shift(num_shiftR);
                    num_shift = shift_right + num_width; // spacing
                    x_widthR = (num_shift > x_widthR) ? num_shift : x_widthR;
                }
                last_line = line;
                last_note = note;
            }

            state.left_shift += x_widthL;
            state.right_shift += x_widthR;
        };
        */

    // Sort fingernumbers by line number.
    //    nums_list.sort(function(a, b) { return (b.line - a.line); });

    float num_shiftL = 0;
    float num_shiftR = 0;
    float x_widthL = 0;
    float x_widthR = 0;
    float last_line = NSUIntegerMax;
    VFStaffNote* last_note = nil;

    for(NSUInteger i = 0; i < nums_list.count; ++i)
    {
        float num_shift = 0;
        Num* num_i = nums_list[i];
        VFStaffNote* note = num_i.note;
        VFPositionType pos = num_i.pos;
        VFFretHandFinger* num = num_i.num;
        float line = num_i.line;
        float shiftL = num_i.shiftL;
        float shiftR = num_i.shiftR;

        // Reset the position of the string number every line.
        if(line != last_line || note != last_note)
        {
            num_shiftL = left_shift + shiftL;
            num_shiftR = right_shift + shiftR;
        }

        float num_width = num.width + num_spacing;
        if(pos == VFPositionLeft)
        {
            [num setX_shift:(left_shift + num_shiftL)];
            num_shift = left_shift + num_width;   // spacing
            x_widthL = (num_shift > x_widthL) ? num_shift : x_widthL;
        }
        else if(pos == VFPositionRight)
        {
            [num setX_shift:num_shiftR];
            num_shift = shift_right + num_width;   // spacing
            x_widthR = (num_shift > x_widthR) ? num_shift : x_widthR;
        }
        last_line = line;
        last_note = note;
    }

    state.left_shift += x_widthL;
    state.right_shift += x_widthR;

    return YES;
}

/*

    getNote: function() { return self.note; },
    setNote: function(note) { self.note = note; return this; },
    getIndex: function() { return self.index; },
    setIndex: function(index) { self.index = index; return this; },
    getPosition: function() { return self.position; },
    setPosition: function(position) {
        if (position >= Modifier.Position.LEFT &&
            position <= Modifier.Position.BELOW)
        self.position = position;
        return this;
    },
    setFretHandFinger: function(number) { self.finger = number; return this; },
    setOffsetX: function(x) { self.x_offset = x; return this; },
    setOffsetY: function(y) { self.y_offset = y; return this; },
 */

- (id)setOffsetY:(float)y
{
    _y_offset = y;
    return self;
}

- (void)setPosition:(VFPositionType)position
{
    if(position >= VFPositionLeft && position <= VFPositionBelow)
    {
        super.position = position;
    }
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    if(!(self->_note && (self.index != -1)))
    {
        VFLogError(@"NoAttachedNote, Can't draw string number without a note and index.");
    }

    VFPoint* start = [self->_note getModifierstartXYforPosition:self.position andIndex:self.index];
    float dot_x = (start.x + self.x_shift + _x_offset);
    float dot_y = start.y + self.y_shift + _y_offset + 5;

    switch(self.position)
    {
        case VFPositionAbove:
            dot_x -= 4;
            dot_y -= 12;
            break;
        case VFPositionBelow:
            dot_x -= 2;
            dot_y += 10;
            break;
        case VFPositionLeft:
            dot_x -= self.width;
            break;
        case VFPositionRight:
            dot_x += 1;
            break;
    }

    VFFont* descriptionFont = [VFFont fontWithName:@"ArialMT" size:12];

    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTTextAlignmentCenter;
    NSAttributedString* description;

    description = [[NSAttributedString alloc] initWithString:self.finger
                                                  attributes:@{
                                                      NSParagraphStyleAttributeName : paragraphStyle,
                                                      NSFontAttributeName : descriptionFont,
                                                      NSForegroundColorAttributeName : VFColor.blackColor
                                                  }];
    [description drawAtPoint:CGPointMake(dot_x, dot_y)];
}

@end
