//
//  VFAnnotation.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFAnnotation.h"

#import "VFFont.h"
#import "VFText.h"
#import "VFVex.h"
#import "VFStem.h"
#import "VFStaffNote.h"

@implementation VFAnnotation
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

+ (VFAnnotation*)annotationWithText:(NSString*)text;
{
    return [[VFAnnotation alloc] initWithText:text];
}

- (instancetype)initWithText:(NSString*)text
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        self.text = text;
        [self setupAnnotation];
    }
    return self;
}

- (void)setupAnnotation
{
    self.text_line = 0;

    _justification = VFJustifyCENTER;
    _verticalJustification = VFVerticalJustifyTOP;
    self.font = [VFFont fontWithName:@"Arial" size:10 weight:@""];

    // The default width is calculated from the text.
    self.width = [VFText measureText:self.text].width;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"annotations";
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //    [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

- (id)setFontName:(NSString*)fontName withSize:(NSUInteger)size;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return self;
}

- (id)setFontName:(NSString*)fontName withSize:(NSUInteger)size withStyle:(NSString*)style;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return self;
}

- (id)setJustification:(VFJustiticationType)justification;
{
    _justification = justification;
    return self;
}

- (id)setVerticalJustification:(VFVerticalJustifyType)verticalJustification;
{
    _verticalJustification = verticalJustification;
    return self;
}

- (VFJustiticationType)justification;
{
    return _justification;
}

- (VFVerticalJustifyType)vert_justification;
{
    return _verticalJustification;
}

- (void)setText:(NSString*)text
{
    _text = text;
}
- (NSString*)text
{
    if(!_text)
    {
        _text = @"failed to initiailize text";
    }
    return _text;
}

// Arrange annotations within a `ModifierContext`
+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* annotations = modifiers;
    if(!annotations || annotations.count == 0)
    {
        return NO;
    }

    NSUInteger text_line = state.text_line;
    float max_width = 0;

    // Format Annotations
    float width = 0;
    for(NSUInteger i = 0; i < annotations.count; ++i)
    {
        VFAnnotation* annotation = annotations[i];
        [annotation setText_line:text_line];
        width = annotation.width > max_width ? annotation.width : max_width;
        text_line++;
    }

    state.left_shift += width / 2;
    state.right_shift += width / 2;

    return YES;
}

// Render text beside the note.
- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    if(!self.note)
    {
        VFLogError(@"NoNoteForAnnotation, Can't draw text annotation without an attached note.");
    }

    VFPoint* start = [self.note getModifierstartXYforPosition:VFPositionAbove andIndex:self.index];

    // We're changing context parameters. Save current state.
    CGContextSaveGState(ctx);
    //    self.context.setFont(self.font.family, self.font.size, self.font.weight);

    // measure the text
    NSDictionary* attributes = [NSDictionary
        dictionaryWithObjectsAndKeys:[VFFont fontWithName:@"Helvetica" size:12], NSFontAttributeName, nil];
    NSAttributedString* text = [[NSAttributedString alloc] initWithString:self.text attributes:attributes];

    float text_width = text.size.width;
    float text_height = text.size.height;
    float x, y;

    if(self.justification == VFJustifyLEFT)
    {
        x = start.x;
    }
    else if(self.justification == VFJustifyRIGHT)
    {
        x = start.x - text_width;
    }
    else if(self.justification == VFJustifyCENTER)
    {
        x = start.x - text_width / 2;
    }
    else /* VFJustifyCENTER_STEM */
    {
        x = self.note.stemX - text_width / 2;
    }

    VFExtentStruct* stem_ext;
    float spacing = 0;
    BOOL has_stem = self.note.hasStem;
    VFStaff* staff = self.note.staff;

    // The position of the text varies based on whether or not the note
    // has a stem.
    if(has_stem)
    {
        stem_ext = self.note.stem.extents;
        spacing = staff.spacingBetweenLines;
    }

    /*

        if (self.vert_justification == Annotation.VerticalJustify.BOTTOM) {
            y = staff.getYForBottomText(self.text_line);
            if (has_stem) {
                var stem_base = (self.note.getStemDirection() === 1 ? stem_ext.baseY : stem_ext.topY);
                y = Math.max(y, stem_base + (spacing * (self.text_line + 2)));
            }
        } else if (self.vert_justification ==
                   Annotation.VerticalJustify.CENTER) {
            var yt = self.note.getYForTopText(self.text_line) - 1;
            var yb = staff.getYForBottomText(self.text_line);
            y = yt + ( yb - yt ) / 2 + text_height / 2;
        } else if (self.vert_justification ==
                   Annotation.VerticalJustify.TOP) {
            y = Math.min(staff.getYForTopText(self.text_line), self.note.getYs()[0] - 10);
            if (has_stem) {
                y = Math.min(y, (stem_ext.topY - 5) - (spacing * self.text_line));
            }
        } else / * CENTER_STEM * /{
            var extents = self.note.getStemExtents();
            y = extents.topY + (extents.baseY - extents.topY) / 2 +
            text_height / 2;
        }
     */

    if(self.vert_justification == VFVerticalJustifyBOTTOM)
    {
        y = [staff getYForBottomTextWithLine:self.text_line];
        if(has_stem)
        {
            float stem_base = (self.note.stemDirection == VFStemDirectionUp ? stem_ext.baseY : stem_ext.topY);
            y = MAX(y, stem_base + (spacing * (self.text_line + 2)));
        }
    }
    else if(self.vert_justification == VFVerticalJustifyCENTER)
    {
        float yt = [self.note getYForTopText:self.text_line] - 1;
        float yb = [staff getYForBottomTextWithLine:self.text_line];
        y = yt + (yb - yt) / 2 + text_height / 2;
    }
    else if(self.vert_justification == VFVerticalJustifyTOP)
    {
        y = MIN([staff getYForTopTextWithLine:self.text_line], [self.note.ys[0] floatValue] - 10);
        if(has_stem)
        {
            y = MIN(y, (stem_ext.topY - 5) - (spacing * self.text_line));
        }
    }
    else /* CENTER_STEM */
    {
        VFExtentStruct* extents = self.note.stemExtents;
        y = extents.topY + (extents.baseY - extents.topY) / 2 + text_height / 2;
    }

    /*
        L("Rendering annotation: ", self.text, x, y);
        self.context.fillText(self.text, x, y);
        self.context.restore();
    }
    });
    */

    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTTextAlignmentLeft;
    VFFont* font1 = [VFFont fontWithName:@"Helvetica" size:12];

    NSAttributedString* title = [[NSAttributedString alloc]
        initWithString:self.text
            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
    //    [title drawInRect:CGRectMake(self.x, y - 3, 50, 100)];
    [title drawAtPoint:CGPointMake(x, y)];

    VFLogInfo(@"Rendering annotation: %@ %f %f", self.text, x, y);
    CGContextRestoreGState(ctx);
}

@end
