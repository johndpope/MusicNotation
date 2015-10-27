//
//  VFStaffConnector.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFStaffConnector.h"
#import "VFVex.h"
#import "VFStaff.h"
#import "VFBezierPath.h"
#import "VFRenderer.h"
#import "VFText.h"
#import "VFGlyph.h"

@implementation VFStaffConnector
{
    NSString* _category;
}

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        [self setupStaffConnector];
    }
    return self;
}

- (instancetype)initWithTopStaff:(VFStaff*)topStaff andBottomStaff:(VFStaff*)bottomStaff
{
    /*
    Vex.Flow.StaffConnector.prototype.init = function(top_Staff, bottom_Staff) {
        self.width = 3;
        self.top_Staff = top_Staff;
        self.bottom_Staff = bottom_Staff;
        self.type = Vex.Flow.StaffConnector.type.DOUBLE;
    }
     */
    self = [super init];
    if(self)
    {
        [self setupStaffConnector];
        _topStaff = topStaff;
        _bottomStaff = bottomStaff;
        _connectorType = VFStaffConnectorDouble;
    }
    return self;
}

+ (VFStaffConnector*)staffConnectorWithTopStaff:(VFStaff*)topStaff andBottomStaff:(VFStaff*)bottomStaff
{
    return [[VFStaffConnector alloc] initWithTopStaff:topStaff andBottomStaff:bottomStaff];
}

- (void)setupStaffConnector
{
    _shift_x = 0;
    _shift_y = 0;
    _width = 3;
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

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"staffconnector";
}

- (void)setConnectorType:(VFStaffConnectorType)connectorType
{
    if(connectorType >= VFStaffConnectorNone && connectorType <= VFStaffConnectorThinDouble)
    {
        _connectorType = connectorType;
    }
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)draw:(CGContextRef)ctx
{
    [self renderWithContext:ctx];
}

- (void)renderWithContext:(CGContextRef)ctx
{
    float topY, botY, width, topX, attachment_height;
    topY = [self.topStaff getYForLine:0];
    botY = [self.bottomStaff getYForLine:self.bottomStaff.options.numLines - 1];
    width = self.width;
    //    topX = [self.topStaff xPosition];
    topX = self.topStaff.x;
    attachment_height = botY - topY;

    switch(self.type)
    {
        case VFStaffConnectorBoldDoubleLeft:
            [self drawBoldDoublLine:ctx withType:self.type topX:topX + self.shift_x topY:topY bottomY:botY];
            break;
        case VFStaffConnectorBoldDoubleRight:
            [self drawBoldDoublLine:ctx withType:self.type topX:topX topY:topY bottomY:botY];
            break;
        case VFStaffConnectorBrace:
        {
            width = 12;
            // May need additional code to draw brace
            float x1 = self.topStaff.x - 2;
            float y1 = topY;
            float x3 = x1;
            float y3 = botY;
            float x2 = x1 - width;
            float y2 = y1 + attachment_height / 2.0;
            float cpx1, cpx2, cpx3, cpx4, cpx5, cpx6, cpx7, cpx8;
            float cpy1, cpy2, cpy3, cpy4, cpy5, cpy6, cpy7, cpy8;
            cpx1 = x2 - (0.90 * width);
            cpy1 = y1 + (0.2 * attachment_height);
            cpx2 = x1 + (1.10 * width);
            cpy2 = y2 - (0.135 * attachment_height);
            cpx3 = cpx2;
            cpy3 = y2 + (0.135 * attachment_height);
            cpx4 = cpx1;
            cpy4 = y3 - (0.2 * attachment_height);
            cpx5 = x2 - width;
            cpy5 = cpy4;
            cpx6 = x1 + (0.40 * width);
            cpy6 = y2 + (0.135 * attachment_height);
            cpx7 = cpx6;
            cpy7 = y2 - (0.135 * attachment_height);
            cpx8 = cpx5;
            cpy8 = cpy1;
            CGPoint cp1, cp2, cp3, cp4, cp5, cp6, cp7, cp8;
            cp1 = CGPointMake(cpx1, cpy1);
            cp2 = CGPointMake(cpx2, cpy2);
            cp3 = CGPointMake(cpx3, cpy3);
            cp4 = CGPointMake(cpx4, cpy4);
            cp5 = CGPointMake(cpx5, cpy5);
            cp6 = CGPointMake(cpx6, cpy6);
            cp7 = CGPointMake(cpx7, cpy7);
            cp8 = CGPointMake(cpx8, cpy8);
            //            VFBezierPath* bPath = [VFBezierPath bezierPath];
            //            [bPath setLineWidth:1.0];
            //            [VFColor.blackColor setStroke];
            //            [VFColor.blackColor setFill];
            //            [bPath moveToPoint:CGPointMake(x1, y1)];
            //
            //            [bPath addCurveToPoint:cp1 controlPoint1:cp2 controlPoint2:CGPointMake(x2, y2)];
            //            [bPath addCurveToPoint:cp3 controlPoint1:cp4 controlPoint2:CGPointMake(x3, y3)];
            //            [bPath addCurveToPoint:cp5 controlPoint1:cp6 controlPoint2:CGPointMake(x2, y2)];
            //            [bPath addCurveToPoint:cp7 controlPoint1:cp8 controlPoint2:CGPointMake(x1, y1)];
            //
            //            [bPath closePath];
            //            bPath.miterLimit = -10;
            //            bPath.lineJoinStyle = kCGLineJoinRound;
            //            [bPath fill];
            CGContextBeginPath(ctx);
            CGContextMoveToPoint(ctx, x1, y1);
            CGContextAddCurveToPoint(ctx, cpx1, cpy1, cpx2, cpy2, x2, y2);
            CGContextAddCurveToPoint(ctx, cpx3, cpy3, cpx4, cpy4, x3, y3);
            CGContextAddCurveToPoint(ctx, cpx5, cpy5, cpx6, cpy6, x2, y2);
            CGContextAddCurveToPoint(ctx, cpx7, cpy7, cpx8, cpy8, x1, y1);
            CGContextSetStrokeColorWithColor(ctx, VFColor.blackColor.CGColor);
            CGContextSetFillColorWithColor(ctx, VFColor.blackColor.CGColor);
            CGContextDrawPath(ctx, kCGPathFillStroke);
        }
        break;
        case VFStaffConnectorBracket:
            topY -= 4;
            botY += 4;
            attachment_height = botY - topY;
            [VFGlyph renderGlyph:ctx atX:topX - 5 atY:topY - 3 withScale:1 forGlyphCode:@"v1b"];
            [VFGlyph renderGlyph:ctx atX:topX - 5 atY:botY + 3 withScale:1 forGlyphCode:@"v10"];
            topX -= (self.width + 2);
            break;
        case VFStaffConnectorDouble:
            topX -= (self.width + 2);
            break;
        case VFStaffConnectorSingle:
            width = 1;
            break;
        case VFStaffConnectorSingleLeft:
            width = 1;
            break;
        case VFStaffConnectorSingleRight:
            width = 1;
            break;
        case VFStaffConnectorThinDouble:
            width = 1;
            break;
        case VFStaffConnectorNone:
            [VFLog logError:@"no connector type specified"];
            break;
        default:
            break;
    }

    if(self.type != VFStaffConnectorBrace && self.type != VFStaffConnectorBoldDoubleLeft &&
       self.type != VFStaffConnectorBoldDoubleRight)
    {
        //        [VFRenderer fillRect:ctx withRect:CGRectMake(topX, topY, width, attachment_height)];
        CGContextBeginPath(ctx);
        CGContextAddRect(ctx, CGRectMake(topX, topY, width, attachment_height));
        CGContextClosePath(ctx);
        CGContextDrawPath(ctx, kCGPathFillStroke);
    }

    // If the connector is a thin double barline, draw the paralell line
    if(self.type == VFStaffConnectorThinDouble)
    {
        //        [VFRenderer fillRect:ctx withRect:CGRectMake(topX - 3, topY, width, attachment_height)];
        CGContextBeginPath(ctx);
        CGContextAddRect(ctx, CGRectMake(topX - 3, topY, width, attachment_height));
        CGContextClosePath(ctx);
        CGContextDrawPath(ctx, kCGPathFillStroke);
    }

    // Add staff connector text
    if(self.text)
    {
        CGContextSaveGState(ctx);
        float x, y;
        //        textWidth = [VFText measureText:self.text withFont:nil].width;
        x = self.topStaff.x - 34 + self.shift_x;
        y = (topY + botY) / 2 +
            self.shift_y;   // [self.topStaff getYForLine:0] + [self.bottomStaff getBottomY] / 2 + self.shift_y;
        [self drawText:ctx atPoint:VFPointMake(x - 35, y - 10) withWidth:50 withText:self.text];
        CGContextRestoreGState(ctx);
    }
}

static BOOL _debugMode = NO;
+ (void)setDebugMode:(BOOL)mode
{
    _debugMode = mode;
}

- (void)drawText:(CGContextRef)ctx atPoint:(VFPoint*)point withWidth:(float)width withText:(NSString*)text
{
    point.x -= width;

    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTTextAlignmentRight;
    VFFont* font1 = [VFFont fontWithName:@"Helvetica" size:15];

    NSAttributedString* titleString = [[NSAttributedString alloc]
        initWithString:text
            attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
    [titleString drawInRect:CGRectMake(point.x, point.y, 2 * width, 30)];
    //    [titleString drawAtPoint:CGPointMake(point.x, point.y))];

    if(_debugMode)
    {
        [[self class] drawCrossHairs:ctx atPoint:point];
    }
}

+ (void)drawCrossHairs:(CGContextRef)ctx atPoint:(VFPoint*)point
{
    float n = 10;
    CGContextBeginPath(ctx);
    CGContextSetLineWidth(ctx, 1);
    CGContextSetFillColorWithColor(ctx, VFColor.blackColor.CGColor);
    CGContextMoveToPoint(ctx, point.x - n, point.y);
    CGContextAddLineToPoint(ctx, point.x + n, point.y);
    CGContextMoveToPoint(ctx, point.x, point.y - n);
    CGContextAddLineToPoint(ctx, point.x, point.y + n);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

- (void)drawBoldDoublLine:(CGContextRef)ctx
                 withType:(VFStaffConnectorType)type
                     topX:(float)topX
                     topY:(float)topY
                  bottomY:(float)botY
{
    if(self.type != VFStaffConnectorBoldDoubleLeft && self.type != VFStaffConnectorBoldDoubleRight)
    {
        [VFLog logError:@"InvalidConnector, A REPEAT_BEGIN or REPEAT_END type must be provided."];
    }

    float x_shift = 3;
    float variableWidth = 3.5;   // Width for avoiding anti-aliasing width issues
    float thickLineOffset = 2;   // For aesthetics

    if(self.type == VFStaffConnectorBoldDoubleRight)
    {
        x_shift -= 5;
        variableWidth = 3;
    }

    // thin line
    //    [VFRenderer fillRect:ctx withRect:CGRectMake(topX + x_shift, topY, 1, botY - topY)];
    CGContextBeginPath(ctx);
    CGContextAddRect(ctx, CGRectMake(topX + x_shift, topY, 1, botY - topY));
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    // thick line
    //    [VFRenderer fillRect:ctx withRect:CGRectMake(topX - thickLineOffset, topY, variableWidth, botY - topY)];
    CGContextBeginPath(ctx);
    CGContextAddRect(ctx, CGRectMake(topX - thickLineOffset, topY, variableWidth, botY - topY));
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

@end
