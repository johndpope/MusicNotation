//
//  VFBoundingBox.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
@import Foundation;
#elif TARGET_OS_MAC
@import AppKit;
#endif
#import "VFColor.h"
#import "VFBoundingBox.h"
#import "VFFont.h"
#import "VFStaff.h"
//#import "Typeset.h"

//@interface VFBoundingBox()
//@property (assign, nonatomic) CGRect rect;
//@end

@implementation VFBoundingBox
{
}

#pragma mark - Initialization

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupBoudingBox];
    }
    return self;
}

- (instancetype)initWithRect:(CGRect)rect
{
    self = [super init];
    if(self)
    {
        [self setupBoudingBox];
        _r = rect;
        _x = CGRectGetMinX(self.rect);     // self.rect.origin.x;
        _y = CGRectGetMinY(self.rect);     // self.rect.origin.y;
        _w = CGRectGetWidth(self.rect);    // self.rect.size.width;
        _h = CGRectGetHeight(self.rect);   // self.rect.size.height;
    }
    return self;
}

- (instancetype)initAtX:(float)x atY:(float)y withWidth:(float)width andHeight:(float)height
{
    self = [self init];
    if(self)
    {
        [self setupBoudingBox];
        _r = CGRectMake(x, y, width, height);
        _x = x;
        _y = y;
        _w = width;
        _h = height;
    }
    return self;
}

- (void)setupBoudingBox
{
    _r = CGRectZero;
    _x = 0.0;
    _y = 0.0;
    _w = 0.0;
    _h = 0.0;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */
@synthesize xPosition = _x;
@synthesize yPosition = _y;
@synthesize width = _w;
@synthesize height = _h;
@synthesize rect = _r;

- (void)setXPosition:(float)xPosition
{
    _x = xPosition;
    _r = CGRectMake(_x, _y, _w, _h);
}

- (void)setYPosition:(float)yPosition
{
    _y = yPosition;
    _r = CGRectMake(_x, _y, _w, _h);
}

- (void)setWidth:(float)width
{
    _w = width;
    _r = CGRectMake(_x, _y, _w, _h);
}

- (void)setHeight:(float)height
{
    _h = height;
    _r = CGRectMake(_x, _y, _w, _h);
}

- (void)setRect:(CGRect)rect
{
    _r = rect;
    _x = _r.origin.x;
    _y = _r.origin.y;
    _w = _r.size.width;
    _h = _r.size.height;
}

- (CGPoint)origin
{
    return CGPointMake(self.xPosition, self.yPosition);
}

- (float)xEnd
{
    return CGRectGetMaxX(self.rect);   // self.rect.origin.x + self.rect.size.width;
}

- (float)yEnd
{
    return CGRectGetMaxY(self.rect);   // self.rect.origin.y + self.rect.size.height;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
+ (VFBoundingBox*)boundingBoxAtX:(float)x atY:(float)y withWidth:(float)width andHeight:(float)height;
{
    return [[VFBoundingBox alloc] initAtX:x atY:y withWidth:width andHeight:height];
}

+ (VFBoundingBox*)boundingBoxZero
{
    return [[VFBoundingBox alloc] init];
}

+ (VFBoundingBox*)boundingBoxWithRect:(CGRect)rect
{
    return [[VFBoundingBox alloc] initWithRect:rect];
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"rect: (%f.01, %f.01, %f.01, %f.01)\n", self.xPosition, self.yPosition,
                                      self.width, self.height];
}

- (void)mergeWithBox:(VFBoundingBox*)box;
{   // andDrawWthContext:(CGContextRef)ctx; {
    [self setRect:CGRectUnion(self.rect, box.rect)];

    //    if (context != nil)
    //        [self draw:context];
}

- (void)draw:(CGContextRef)ctx
{
    CGContextSaveGState(ctx);
    [[VFColor blueColor] setStroke];
    CGContextSetFillColorWithColor(ctx, [VFColor blueColor].CGColor);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.rect);
    CGContextAddPath(ctx, path);
    CGContextSetLineWidth(ctx, 1.0);
    CGContextDrawPath(ctx, kCGPathStroke);
    CGPathRelease(path);
    CGContextRestoreGState(ctx);

    //    [[VFColor crayolaApricotColor] setStroke];
    VFFont* descriptionFont = [VFFont fontWithName:@"ArialMT" size:8];

    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTTextAlignmentCenter;
    NSAttributedString* description;

    float y_top_text_line = CGRectGetMinY(self.rect) - 30;
    y_top_text_line = y_top_text_line < 0 ? 0 : y_top_text_line;
    float y_bottom_text_line = CGRectGetMaxY(self.rect) + 5;

    description = [[NSAttributedString alloc]
        initWithString:[NSString stringWithFormat:@"%.00f\n%.00f\n", self.xPosition, self.yPosition]
            attributes:@{
                NSParagraphStyleAttributeName : paragraphStyle,
                NSFontAttributeName : descriptionFont,
                NSForegroundColorAttributeName : [VFColor blueColor]
            }];
    float x = CGRectGetMinX(self.rect) - 15;
    float y = y_top_text_line;
    [description drawAtPoint:CGPointMake(x, y)];

    description = [[NSAttributedString alloc]
        initWithString:[NSString stringWithFormat:@"%.00f\n%.00f\n", self.xPosition + self.width,
                                                  self.yPosition + self.height]
            attributes:@{
                NSParagraphStyleAttributeName : paragraphStyle,
                NSFontAttributeName : descriptionFont,
                NSForegroundColorAttributeName : [VFColor blueColor]
            }];
    x = CGRectGetMinX(self.rect) + 15;
    y = y_bottom_text_line;   // CGRectGetMinY(self.rect) + 30;
    [description drawAtPoint:CGPointMake(x, y)];

    // TODO: the following hack fixes a color issue where every draw after this is set to this color
    description = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@" "]
                                                  attributes:@{NSForegroundColorAttributeName : VFColor.blackColor}];
    [description drawAtPoint:CGPointMake(0, 0)];
}
@end
