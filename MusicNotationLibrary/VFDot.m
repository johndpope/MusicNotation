//
//  VFDot.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not finished
// Complete

#import "VFDot.h"
#import "VFVex.h"

#import "VFNote.h"
#import "VFStaff.h"
#import "VFStaffNote.h"
#import "VFTabNote.h"
#import "VFKeyProperty.h"
#import "VFMetrics.h"
#import "VFOptions.h"
#import "VFBezierPath.h"
#import "VFTypes.h"
#import "VFStemmableNote.h"
#import "VFShiftState.h"
#import "VFModifierContext.h"
#import "VFTables.h"
#import "VFNoteHead.h"

//======================================================================================================================

@interface DotStruct : NSObject
@property (strong, nonatomic) VFNote* note;
@property (assign, nonatomic) float line;
@property (assign, nonatomic) float shift;
@property (strong, nonatomic) VFDot* dot;
- (NSComparisonResult)compare:(DotStruct*)otherDot;
@end

@implementation DotStruct

// TODO: clean up these initializers
- (instancetype)initWithLine:(float)line shift:(float)shift note:(VFNote*)note dot:(VFDot*)dot
{
    self = [super init];
    if(self)
    {
        self.line = line;
        self.shift = shift;
        self.note = note;
        self.dot = dot;
    }
    return self;
}

- (NSComparisonResult)compare:(DotStruct*)otherDot
{
    return self.line < otherDot.line;
}
@end

//======================================================================================================================

@interface VFDot ()
@property (strong, nonatomic) NSString* type;
@end

@implementation VFDot

+ (VFDot*)dotWithType:(NSString*)type
{
    VFDot* ret = [[VFDot alloc] init];
    ret.type = type;
    return ret;
}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        //        [self setupDot];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [self setupDot];
    }
    return self;
}

- (void)setupDot
{
    self.note = nil;
    //    self.index = -1;
    self.position = VFPositionRight;
    self.radius = 2;
    self.width = 5;
    self.dotShiftY = 0;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (void)setNote:(VFStaffNote*)note
{
    _note = note;
    if([self.note.category isEqualToString:@"gracenotes"])
    {
        self.radius *= 0.5;
        self.width = 3;
    }
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"dots";
}

// Arrange dots inside a ModifierContext.
+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* dots = modifiers;
    float right_shift = state.right_shift;
    float dot_spacing = 1;

    if(dots == nil || dots.count == 0)
    {
        return NO;
    }

    VFDot* dot;
    VFNote* note;
    float shift = 0.0;
    DotStruct* dotStruct;

    NSMutableArray* dot_list = [NSMutableArray array]; // list of DotStruct

    for(int i = 0; i < dots.count; ++i)
    {
        VFDot* dot = [dots objectAtIndex:i];
        VFStaffNote* note = dot.note;
        KeyProperty* prop;
        // Only StaffNote has .getKeyProps()
        if([note isKindOfClass:[VFStaffNote class]])
        {
            NSMutableArray* props;
            props = note.keyProps;
            prop = [props objectAtIndex:dot.index];
            shift = prop.displaced ? note.extraRightPx : 0;
        }
        else if([note isKindOfClass:[VFTabNote class]])
        {   // Else it's a TabNote
            prop = [[KeyProperty alloc] init];
            prop.line = 0.5;
            shift = 0;
        }

        dotStruct = [[DotStruct alloc] initWithLine:prop.line shift:shift note:note dot:dot];
        [dot_list addObject:dotStruct];
    }

    // Sort dots by line number.
    [dot_list sortUsingComparator:^NSComparisonResult(DotStruct* a, DotStruct* b) {
//      return [obj1 compare:obj2];
        float al = a.line;
        float bl = b.line;
        if(al > bl)
        {
            return NSOrderedAscending;
        }
        else if(al < bl)
        {
            return NSOrderedDescending;
        }
        else
        {
            return NSOrderedSame;
        }

    }];

    float dot_shift = right_shift;
    float x_width = 0;
    float last_line = 0;
    VFNote* last_note;
    float prev_dotted_space = 0;
    float half_shiftY = 0;

    for(int i = 0; i < dot_list.count; ++i)
    {
        dotStruct = [dot_list objectAtIndex:i];
        dot = dotStruct.dot;
        note = dotStruct.note;
        shift = dotStruct.shift;
        float line = dotStruct.line;

        // Reset the position of the dot every line.
        if(line != last_line || note != last_note)
        {
            dot_shift = shift;
        }

        if(!note.isRest && line != last_line)
        {
            if(fabsf(fmodf(line, 1)) == 0.5)
            {
                // note is on a space, so no dot shift
                half_shiftY = 0;
            }
            else if(!note.isRest)
            {
                // note is on a line, so shift dot to space above the line
                half_shiftY = 0.5;
                if(last_note != nil && !last_note.isRest && last_line - line == 0.5)
                {
                    // previous note on a space, so shift dot to space below the line
                    half_shiftY = -0.5;
                }
                else if(line + half_shiftY == prev_dotted_space)
                {
                    // previous space is dotted, so shift dot to space below the line
                    half_shiftY = -0.5;
                }
            }
        }

        // convert half_shiftY to a multiplier for dots.draw()
        dot.dotShiftY += (-half_shiftY);
        prev_dotted_space = line + half_shiftY;

        dot.x_shift = dot_shift;                //.setX_shift(dot_shift);
        dot_shift += dot.width + dot_spacing;   // spacing
        x_width = (dot_shift > x_width) ? dot_shift : x_width;
        last_line = line;
        last_note = note;
    }

    // update state
    state.right_shift += x_width;

    return YES;
}

- (void)setDotShiftY:(float)dotShiftY
{
    _dotShiftY = dotShiftY;
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    if(self.note == nil || self.index == -1)
    {
        [VFLog logError:@"NoAttachedNote, Can't draw dot without a note and index."];
    }

    float line_space = self.note.staff.spacingBetweenLines;

    VFPoint* start = [self.note getModifierstartXYforPosition:self.position andIndex:self.index];

    // TODO: replace with class checking rather than category string
    if([self.note.category isEqualToString:@"tabnotes"])
    {
        start.y = ((VFStemmableNote*)self.note).stemExtents.baseY;
    }

    float dotX, dotY;

//    float shift = [((VFNoteHead*)self.note.note_heads[0])headWidth] * 1.25;   // CHANGE

    dotX = (start.x + self.x_shift) + self.width - self.radius; // + shift;   // CHANGE
    dotY = start.y + self.y_shift + (self.dotShiftY * line_space);

    //    VFBezierPath* bPath = [VFBezierPath bezierPath];
    //    [bPath addArcWithCenter:CGPointMake(dot_x, dot_y) radius:self.radius startAngle:0 endAngle:kPI clockwise:NO];
    //    [bPath fill];

    CGContextSaveGState(ctx);
    //    CGContextSetFillColorWithColor(ctx, NSColor.blueColor.CGColor);
    CGContextMoveToPoint(ctx, dotX, dotY);
    CGContextBeginPath(ctx);
    CGContextAddArc(ctx, dotX, dotY, self.radius, 0, 2 * M_PI, NO);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGContextRestoreGState(ctx);
}
@end
