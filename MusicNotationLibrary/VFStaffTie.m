//
//  VFStaffTie.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

#import "VFStaffTie.h"
#import "VFVex.h"
#import "VFNoteTie.h"
#import "VFStaffNote.h"
#import "VFText.h"
#import "VFFont.h"

@interface VFStaffTie ()
//@property (assign, nonatomic) float cp1;
//@property (assign, nonatomic) float cp2;
@property (assign, nonatomic) float text_shift_x;
@property (assign, nonatomic) float first_x_shift;
@property (assign, nonatomic) float last_x_shift;
//@property (assign, nonatomic) float y_shift;
@property (assign, nonatomic) float tie_spacing;
@property (strong, nonatomic) NSString* font_family;
@property (assign, nonatomic) float font_size;
@property (strong, nonatomic) NSString* font_style;
@end

@implementation VFStaffTie
{
}

//- (instancetype)init {
//    self = [super init];
//    if (self) {
//        [self setup];
//    }
//    return self;
//}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)initWithNotes:(VFNoteTie*)notes andText:(NSString*)text;
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        self.notes = notes;
        self.text = text;
        [self setupStaffTie];

        [self setupNotes:notes];
    }
    return self;
}

/*!
 *  init
 *  @param last_note     <#last_note description#>
 *  @param first_note    <#first_note description#>
 *  @param first_indices <#first_indices description#>
 *  @param last_indices  <#last_indices description#>
 *  @return <#return value description#>
 */
- (instancetype)initWithLastNote:(VFNote*)last_note
                       firstNote:(VFNote*)first_note
                    firstIndices:(NSArray*)first_indices
                     lastIndices:(NSArray*)last_indices
{
    self = [self initWithDictionary:@{}];
    if(self)
    {
        [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    }
    return self;
}
- (void)setupStaffTie
{
    self.cp1 = 8;
    self.cp2 = 15;
    self.text_shift_x = 0;
    self.first_x_shift = 0;
    self.last_x_shift = 0;
    self.y_shift = 7;
    self.tie_spacing = 0;
    self.font_family = @"Arial";
    self.font_size = 10;
    self.font_style = @"";
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

// Set the notes to attach this tie to.
- (void)setupNotes:(VFNoteTie*)notes
{
    if(notes.first_note == nil && notes.last_note == nil)
    {
        [VFLog logError:@"BadArguments, Tie needs to have either first_note or last_note set."];
    }
    if(notes.first_indices == nil)
        notes.first_indices = @[];
    if(notes.last_indices == nil)
        notes.last_indices = @[];

    if(notes.first_indices.count != notes.last_indices.count)
    {
        [VFLog logError:@"BadArguments, Tied notes must have similarindex sizes"];
    }

    // Success. Lets grab 'em notes.
    self.firstNote = (VFStaffNote*)notes.first_note;
    self.firstIndices = notes.first_indices;
    self.lastNote = (VFStaffNote*)notes.last_note;
    self.lastIndices = notes.last_indices;
}

// Returns YES if this is a partial bar.
- (BOOL)isPartial
{
    return (self.firstNote == nil || self.lastNote == nil);
}

- (void)renderTieWithContext:(CGContextRef)ctx
                     firstYs:(NSArray*)first_ys
                      lastYs:(NSArray*)last_ys
                     lastXpx:(float)last_x_px
                    firstXpx:(float)first_x_px
                   direction:(VFStemDirectionType)direction
{
    float cp1, cp2;
    cp1 = self.cp1;
    cp2 = self.cp2;

    if(fabs(last_x_px - first_x_px) < 10)
    {
        cp1 = 2;
        cp2 = 8;
    }

    float first_x_shift = self.first_x_shift;
    float last_x_shift = self.last_x_shift;
    float y_shift = self.y_shift * direction;

    for(int i = 0; i < self.firstIndices.count; ++i)
    {
        float cp_x = ((last_x_px + last_x_shift) + (first_x_px + first_x_shift)) / 2;
        NSUInteger index = [self.firstIndices[i] integerValue];
        float first_y_px = [first_ys[index] floatValue] + y_shift;
        index = [self.lastIndices[i] integerValue];
        float last_y_px = [last_ys[index] floatValue] + y_shift;

        if(isnan(first_y_px) || isnan(last_y_px))
        {
            [VFLog logError:@"BadArguments, Bad indices for tie rendering."];
        }

        float top_cp_y = ((first_y_px + last_y_px) / 2) + (cp1 * direction);
        float bottom_cp_y = ((first_y_px + last_y_px) / 2) + (cp2 * direction);

        CGContextBeginPath(ctx);
        CGContextMoveToPoint(ctx, first_x_px + first_x_shift, first_y_px);
        CGContextAddQuadCurveToPoint(ctx, cp_x, top_cp_y, last_x_px + last_x_shift, last_y_px);
        CGContextAddQuadCurveToPoint(ctx, cp_x, bottom_cp_y, first_x_px + first_x_shift, first_y_px);
        CGContextClosePath(ctx);
        CGContextFillPath(ctx);
    }
}

- (void)renderText:(CGContextRef)ctx first_x_px:(float)first_x_px last_x_px:(float)last_x_px;
{
    if(self.text == nil)
    {
        return;
    }
    float center_x = (first_x_px + last_x_px) / 2;
    center_x -= [VFText measureText:self.text].width / 2;

    VFStaff* staff = (self.firstNote.staff != nil ? self.firstNote.staff : self.lastNote.staff);

    VFPoint* point = VFPointMake(center_x + self.text_shift_x, [staff getYForTopText] - 1);

    [VFText setFont:[VFFont fontWithName:self.font_family size:self.font_size]];
    [VFText setBold:YES];
    [VFText drawSimpleText:ctx atPoint:point withText:self.text];
}

- (void)draw:(CGContextRef)ctx;
{
    //    [super draw:ctx];
    if(!ctx)
    {
        VFLogError(@"NoCanvasContext, Can't draw without a canvas context.");
    }

    float first_x_px, last_x_px;
    NSArray* first_ys;
    NSArray* last_ys;
    VFStemDirectionType stem_direction;

    if(self.firstNote != nil)
    {
        first_x_px = self.firstNote.tieRightX + self.tie_spacing;
        stem_direction = self.firstNote.stemDirection;
        first_ys = self.firstNote.ys;
    }
    else
    {
        first_x_px = self.lastNote.staff.tieStartX;
        stem_direction = self.lastNote.stemDirection;
        first_ys = self.lastIndices;
    }

    if(self.lastNote != nil)
    {
        last_x_px = self.lastNote.staff.tieEndX;
        stem_direction = self.lastNote.stemDirection;
        last_ys = self.firstNote.ys;
    }
    else
    {
        last_x_px = self.firstNote.staff.tieEndX;
        last_ys = self.firstNote.ys;
        self.lastIndices = self.firstIndices;
    }

    [self renderTieWithContext:ctx
                       firstYs:first_ys
                        lastYs:last_ys
                       lastXpx:last_x_px
                      firstXpx:first_x_px
                     direction:stem_direction];
}

@end
