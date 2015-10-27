//
//  VFStaffText.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFStaffText.h"

#import "VFEnum.h"
#import "VFStaff.h"
#import "VFVex.h"
#import "VFFont.h"

//======================================================================================================================

@implementation VFStaffText
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        self.width = 16;
        self.justification = kCTTextAlignmentCenter;
        self.shift_x = 0;
        self.shift_y = 0;
        self.fontFamily = @"TimesNewRomanPS-BoldMT";
        self.fontSize = 16;
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)initWithText:(NSString*)text atPosition:(VFPositionType)position WithOptions:(NSDictionary*)optionsDict
{
    self = [self initWithDictionary:optionsDict];
    if(self)
    {
        self.text = text;
        self.position = position;
    }
    return self;
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

+ (NSString*)CATEGORY
{
    return @"stafftext";
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)drawWithContext:(CGContextRef)ctx toStaff:(VFStaff*)staff
{
    [super draw:ctx];

    CGContextSaveGState(ctx);
    CTTextAlignment justification = kCTTextAlignmentLeft;
    NSUInteger text_width = self.text.length;

    float x, y;
    switch(self.position)
    {
        case VFPositionLeft:
        case VFPositionRight:
        {
            y = ([staff getYForTopTextWithLine:0] + [staff getBottomY]) / 2 + self.shift_y;
            if(self.position == VFPositionLeft)
            {
                x = staff.x - text_width - 24 + self.shift_x;
            }
            else
            {
                x = staff.x + staff.width + 24 + self.shift_x;
            }
        }
        break;
        case VFPositionAbove:
        case VFPositionBelow:
        {
            x = staff.x + self.shift_x;
            if(self.justification == kCTTextAlignmentCenter)
            {
                x += staff.width / 2 - text_width / 2;
            }
            else if(self.justification == kCTTextAlignmentRight)
            {
                x += staff.width - text_width;
            }

            if(self.position == VFPositionAbove)
            {
                y = [staff getYForTopTextWithLine:2] + self.shift_y;
            }
            else
            {
                y = [staff getYForBottomTextWithLine:2] + self.shift_y;
            }
            break;
        }
        break;
        default:
        {
            VFLogError(@"InvalidPosition, Value Must be in Modifier.Position.");
        }
        break;
    }

    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = justification;
    VFFont* font1 = [VFFont fontWithName:self.fontFamily size:self.fontSize];
    NSAttributedString* title = [[NSAttributedString alloc]
        initWithString:self.text
            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
    //    [title drawInRect:CGRectMake(x, y, 50, 100)];
    [title drawAtPoint:CGPointMake(x, y)];

    CGContextRestoreGState(ctx);
}

@end
