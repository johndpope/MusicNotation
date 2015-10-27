//
//  VFStaffSection.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFStaffSection.h"
#import "VFStaff.h"
#import <CoreText/CoreText.h>
#import "VFBoundingBox.h"
#import "VFPoint.h"

@interface VFStaffSection (private)
@property (strong, nonatomic) NSString* category;
@property (assign, nonatomic) float width;
@end

@implementation VFStaffSection
{
}

+ (VFStaffSection*)staffSectionWithSection:(NSString*)section withX:(float)x yShift:(float)yShift;
{
    return [[VFStaffSection alloc] initWithSection:section withX:x yShift:yShift];
}

- (instancetype)initWithSection:(NSString*)section withX:(float)x yShift:(float)yShift;
{
    self = [super init];
    if(self)
    {
        self.width = 16;
        self.section = section;
        self.position = VFPositionAbove;
        self.point.x = x;
        //        self.x = x;
        self.x_shift = 0;
        self.y_shift = yShift;
        self.font = (VFFont*)[VFFont boldSystemFontOfSize:12];
    }
    return self;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"stavesection";
}

/*!
 *  draws this modifier
 *  @param ctx    graphics context
 *  @param staff  staff to draw to
 *  @param shiftX amount to shift x from init position to match current measure
 */
- (void)draw:(CGContextRef)ctx withStaff:(VFStaff*)staff withShiftX:(float)shiftX;
{
    float x = self.point.x + shiftX;
    float textWidth = self.section.length;
    float y = [staff getYForTopTextWithLine:3];
    float height = 20;
    float width = textWidth + 6;
    y += 16;

    // draw box
    CGContextSaveGState(ctx);
    CGContextBeginPath(ctx);
    CGContextSetLineWidth(ctx, 2);
    CGContextAddRect(ctx, CGRectMake(x, y, height, height));
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);

    x += (width - textWidth) / 2;

    // draw text
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTCenterTextAlignment;                          // kCTTextAlignmentCenter
    VFFont* font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:16];   // self.fontSize];
    NSAttributedString* title = [[NSAttributedString alloc]
        initWithString:self.section
            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
    //    [title drawInRect:CGRectMake(x, y, 50, 100)];
    [title drawAtPoint:CGPointMake(x, y)];
}

- (CGSize)getTextSize:(NSAttributedString*)attributedString
{
    CTFramesetterRef frameSetter =
        CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)(attributedString));
    CFRange ran = CFRangeMake(0, attributedString.length);
    return CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, ran, NULL, CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX),
                                                        NULL);
}

@end
