//
//  VFStaffLine.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFStaffLine.h"
#import "VFVex.h"
#import "VFPoint.h"
#import "VFStaffNote.h"
#import "VFKeyProperty.h"
#import "StaffLineRenderOptions.h"

@implementation StaffLineNotesStruct

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
    }
    return self;
}

@end

@implementation VFStaffLine

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
    }
    return self;
}

// ## Prototype Methods
// StaveLine.prototype = {
// Initialize the StaveLine with the given `notes`.
//
// `notes` is a struct that has:
//
//  ```
//  {
//    first_note: Note,
//    last_note: Note,
//    first_indices: [n1, n2, n3],
//    last_indices: [n1, n2, n3]
//  }
//  ```
- (instancetype)initWithNotes:(StaffLineNotesStruct*)notes
{
    self = [self initWithDictionary:@{}];
    if(self)
    {
        /*

            init: function(notes) {
                self.notes = notes;
                self.context = null;


                self.font = {
                family: "Arial",
                size: 10,
                weight: ""
                };
            },
         */
        self.staff_line_notes = notes;

        self.text = @"";

        _renderOptions = [[StaffLineRenderOptions alloc] init];
        StaffLineRenderOptions* render_options = _renderOptions;
        render_options.padding_left = 4;
        render_options.padding_right = 3;

        // The width of the line in pixels
        render_options.lineWidth = 1;
        // An array of line/space lengths. Unsupported with Raphael (SVG)
        render_options.lineDash = NO;
        // Can draw rounded line end, instead of a square. Unsupported with Raphael (SVG)
        render_options.lineCap = kCGLineCapButt;
        // The color of the line and arrowheads
        render_options.fillColor = VFColor.blackColor;
        render_options.strokeColor = VFColor.blackColor;

        // Flags to draw arrows on each end of the line
        render_options.draw_start_arrow = NO;
        render_options.draw_end_arrow = NO;

        // The length of the arrowhead sides
        render_options.arrowhead_length = 10;
        // The angle of the arrowhead
        render_options.arrowhead_angle = M_PI / 8;

        // The position of the text
        render_options.text_position_vertical = VFStaffLineVerticalJustifyTOP;
        render_options.text_justification = VFStaffLineJustifyCENTER;

        [self setNotes:notes];
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*!
 *  Set the notes for the `StaveLine`
 *  @param notes a StaffLineNotesStruct obj
 *       first_note: Note,
 *       last_note: Note,
 *       first_indices: [n1, n2, n3],
 *       last_indices: [n1, n2, n3]
 *  @return this object
 */
- (id)setNotes:(StaffLineNotesStruct*)notes
{
    if(!notes.first_note && !notes.last_note)
    {
        VFLogError("BadArguments, Notes needs to have either first_note or last_note set.");
    }
    if(!notes.first_indices)
    {
        notes.first_indices = @[ @0 ];
    }
    if(!notes.last_indices)
    {
        notes.last_indices = @[ @0 ];
    }
    if(notes.first_indices.count != notes.last_indices.count)
    {
        VFLogError(@"BadArguments, Connected notes must have similar index sizes");
    }

    self.first_note = notes.first_note;
    self.first_indices = notes.first_indices;
    self.last_note = notes.last_note;
    self.last_indices = notes.last_indices;
    return self;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (NSString*)text
{
    if(!_text)
    {
        _text = @"";
    }
    return _text;
}

- (StaffLineRenderOptions*)renderOptions
{
    if(!_renderOptions)
    {
        _renderOptions = [[StaffLineRenderOptions alloc] init];
    }
    return _renderOptions;
}

- (id)setRenderOptions:(StaffLineRenderOptions*)renderOptions
{
    _renderOptions = renderOptions;
    return self;
}

/*!
 *  Apply the style of the `StaveLine` to the context
 *  @param ctx the graphics context
 */
- (void)applyLineStyle:(CGContextRef)ctx
{
    StaffLineRenderOptions* render_options = [self renderOptions];

    if(render_options.lineDash)
    {
        if(render_options.lineDashLengths.count > 0)
        {
            CGFloat* lengths;
            malloc(sizeof(CGFloat) * render_options.lineDashLengths.count);
            [render_options.lineDashLengths foreach:^(NSNumber* element, NSUInteger index, BOOL* stop) {
              lengths[index] = (CGFloat)[element floatValue];
            }];
            size_t count = (size_t)render_options.lineDashCount;
            CGContextSetLineDash(ctx, render_options.lineDashPhase, lengths, count);
            free(lengths);
        }
        else
        {
            CGContextSetLineDash(ctx, 0, NULL, 0);
        }
    }
    //    if (render_options.lineWidth) {
    CGContextSetLineWidth(ctx, render_options.lineWidth);
    //    }
    CGContextSetLineCap(ctx, render_options.lineCap);
}

/*!
 *  Apply the text styling to the context
 */
- (void)applyFontStyle
{
    /*

            if (self.font) {
                ctx.setFont(self.font.family, self.font.size, self.font.weight);
            }

            if (self.render_options.color) {
                ctx.setStrokeStyle(self.render_options.color);
                ctx.setFillStyle(self.render_options.color);
            }
        },
     */
}

/*!
 *  Renders the `StaveLine` on the context
 *  @param ctx the graphics context
 */
- (void)draw:(CGContextRef)ctx
{
    [super draw:ctx];

    VFStaffNote* first_note = self.first_note;
    VFStaffNote* last_note = self.last_note;
    StaffLineRenderOptions* render_options = self.renderOptions;
    CGContextSaveGState(ctx);
    [self applyLineStyle:ctx];

    // Cycle through each set of indices and draw lines

    CGContextRestoreGState(ctx);
    __block VFPoint* start_position;
    __block VFPoint* end_position;
    [self.first_indices foreach:^(NSNumber* first_index_number, NSUInteger i, BOOL* stop) {
      NSUInteger first_index = [first_index_number unsignedIntegerValue];
      NSUInteger last_index = [self.last_indices[i] unsignedIntegerValue];

      // Get initial coordinates for the start/end of the line
      start_position = [first_note getModifierstartXYforPosition:VFPositionRight andIndex:first_index];
      end_position = [last_note getModifierstartXYforPosition:VFPositionLeft andIndex:first_index];
      BOOL upwards_slope = start_position.y > end_position.y;

      // Adjust `x` coordinates for modifiers
      start_position.x += first_note.metrics.modRightPx + render_options.padding_left;
      end_position.x -= last_note.metrics.modLeftPx + render_options.padding_right;

      // Adjust first `x` coordinates for displacements
      float notehead_width = first_note.glyphStruct.head_width;
      BOOL first_displaced = ((KeyProperty*)first_note.keyProps[first_index]).displaced;
      if(first_displaced && first_note.stemDirection == VFStemDirectionUp)
      {
          start_position.x += notehead_width + render_options.padding_left;
      }

      // Adjust last `x` coordinates for displacements
      BOOL last_displaced = ((KeyProperty*)last_note.keyProps[last_index]).displaced;
      if(last_displaced && last_note.stemDirection == VFStemDirectionDown)
      {
          end_position.x -= notehead_width + render_options.padding_right;
      }

      // Adjust y position better if it's not coming from the center of the note
      start_position.y += upwards_slope ? -3 : 1;
      end_position.y += upwards_slope ? 2 : 0;

      // drawArrowLine(ctx, start_position, end_position, self.render_options);
      [self drawArrowLine:ctx
                fromPoint:start_position
                  toPoint:end_position
           drawStartArrow:self.renderOptions.draw_start_arrow
             drawEndArrow:self.renderOptions.draw_end_arrow
          arrowheadLength:self.renderOptions.arrowhead_length
           arrowheadAngle:self.renderOptions.arrowhead_angle
                fillColor:self.renderOptions.fillColor
              strokeColor:self.renderOptions.strokeColor];
    }];

    // Determine the x coordinate where to start the text
    float text_width = self.text.length;   // TODO: measure text correctly //ctx.measureText(self.text).width;
    VFStaffLineJustiticationType justification = render_options.text_justification;
    float x = 0;
    if(justification == VFStaffLineJustifyLEFT)
    {
        x = start_position.x;
    }
    else if(justification == VFStaffLineJustifyCENTER)
    {
        float delta_x = (end_position.x - start_position.x);
        float center_x = (delta_x / 2) + start_position.x;
        x = center_x - (text_width / 2);
    }
    else if(justification == VFStaffLineJustifyRIGHT)
    {
        x = end_position.x - text_width;
    }

    // Determine the y value to start the text
    float y = 0;
    VFStaffLineVerticalJustifyType vertical_position = render_options.text_position_vertical;
    if(vertical_position == VFStaffLineVerticalJustifyTOP)
    {
        y = [first_note.staff getYForTopText];
    }
    else if(vertical_position == VFStaffLineVerticalJustifyBOTTOM)
    {
        y = [first_note.staff getYForBottomText];
    }

    /*
            // Draw the text
            ctx.save();
            self.applyFontStyle();
            ctx.fillText(self.text, x, y);
            ctx.restore();

     */

    // Draw the text
    CGContextSaveGState(ctx);
    [self applyFontStyle];

    VFFont* descriptionFont = [VFFont fontWithName:@"ArialMT" size:12];

    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTTextAlignmentCenter;
    NSAttributedString* description;

    description = [[NSAttributedString alloc] initWithString:self.text
                                                  attributes:@{
                                                      NSParagraphStyleAttributeName : paragraphStyle,
                                                      NSFontAttributeName : descriptionFont,
                                                      NSForegroundColorAttributeName : VFColor.blueColor
                                                  }];

    [description drawAtPoint:CGPointMake(x, y)];

    CGContextRestoreGState(ctx);
}

//======================================================================================================================
// ## Private Helpers

/*!
 *  Draw an arrow head that connects between 3 coordinates
 *  @param ctx    the graphics context
 *  @param points an array of 3 vfpoints
 *  @attribution  Arrow rendering implementations based off of
 *                  Patrick Horgan's article, "Drawing lines and arcs with
 *                  arrow heads on  HTML5 Canvas"
 */
- (void)drawArrowHead:(CGContextRef)ctx points:(NSArray*)points
{
    if(points.count != 3)
    {
        VFLogError(@"ArrowHeadError, arrowhead requires 3 points exactly.");
    }
    VFPoint* point0 = points[0];
    VFPoint* point1 = points[1];
    VFPoint* point2 = points[2];
    float x0, y0, x1, y1, x2, y2;
    x0 = point0.x;
    y0 = point0.y;
    x1 = point1.x;
    y1 = point1.y;
    x2 = point2.x;
    y2 = point2.y;
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, x0, y0);
    CGContextAddLineToPoint(ctx, x1, y1);
    CGContextAddLineToPoint(ctx, x2, y2);
    CGContextAddLineToPoint(ctx, x0, y0);
    CGContextClosePath(ctx);
    CGContextDrawPath(ctx, kCGPathFillStroke);
}

// Helper function to draw a line with arrow heads
- (void)drawArrowLine:(CGContextRef)ctx
            fromPoint:(VFPoint*)point1
              toPoint:(VFPoint*)point2
       drawStartArrow:(BOOL)draw_start_arrow
         drawEndArrow:(BOOL)draw_end_arrow
      arrowheadLength:(float)arrowhead_length
       arrowheadAngle:(float)arrowhead_angle
            fillColor:(VFColor*)fillColor
          strokeColor:(VFColor*)strokeColor
{
    float (^Distance)(VFPoint*, VFPoint*) = ^float(VFPoint* point1, VFPoint* point2) {
      float x1 = point1.x;
      float y1 = point1.y;
      float x2 = point2.x;
      float y2 = point2.y;
      float ret = sqrtf((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1));
      return ret;
    };

    BOOL both_arrows = draw_start_arrow && draw_end_arrow;

    float x1 = point1.x;
    float y1 = point1.y;
    float x2 = point2.x;
    float y2 = point2.y;

    // For ends with arrow we actually want to stop before we get to the arrow
    // so that wide lines won't put a flat end on the arrow.
    float distance = Distance(point1, point2);
    float ratio = (distance - arrowhead_length / 3) / distance;
    float end_x = 0, end_y = 0, start_x = 0, start_y = 0;
    if(draw_end_arrow || both_arrows)
    {
        end_x = roundf(x1 + (x2 - x1) * ratio);
        end_y = roundf(y1 + (y2 - y1) * ratio);
    }
    else
    {
        end_x = x2;
        end_y = y2;
    }

    if(draw_start_arrow || both_arrows)
    {
        start_x = x1 + (x2 - x1) * (1 - ratio);
        start_y = y1 + (y2 - y1) * (1 - ratio);
    }
    else
    {
        start_x = x1;
        start_y = y1;
    }

    /*

     if (config.color) {
     ctx.setStrokeStyle(config.color);
     ctx.setFillStyle(config.color);
     }
     */
    if(fillColor)
    {
        CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    }
    else
    {
        CGContextSetFillColorWithColor(ctx, VFColor.blackColor.CGColor);
    }
    if(strokeColor)
    {
        CGContextSetStrokeColorWithColor(ctx, strokeColor.CGColor);
    }
    else
    {
        CGContextSetStrokeColorWithColor(ctx, VFColor.blackColor.CGColor);
    }

    // Draw the shaft of the arrow
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, start_x, start_y);
    CGContextAddLineToPoint(ctx, end_x, end_y);
    CGContextClosePath(ctx);
    CGContextStrokePath(ctx);

    /*


     // calculate the angle of the line
     var line_angle = Math.atan2(y2 - y1, x2 - x1);
     // h is the line length of a side of the arrow head
     var h = Math.abs(config.arrowhead_length / Math.cos(config.arrowhead_angle));
     */

    // calculate the angle of the line
    float line_angle = atan2f(y2 - y1, x2 - x1);
    // h is the line length of a side of the arrow head
    float h = ABS(arrowhead_length / cosf(arrowhead_angle));

    float angle1, angle2;
    float top_x, top_y;
    float bottom_x, bottom_y;

    if(draw_end_arrow || both_arrows)
    {
        angle1 = line_angle + M_PI + arrowhead_angle;
        top_x = x2 + cosf(angle1) * h;
        top_y = y2 + sinf(angle1) * h;

        angle2 = line_angle + M_PI - arrowhead_angle;
        bottom_x = x2 + cosf(angle2) * h;
        bottom_y = y2 + sinf(angle2) * h;

        [self drawArrowHead:ctx
                     points:@[ VFPointMake(top_x, top_y), VFPointMake(x2, y2), VFPointMake(bottom_x, bottom_y) ]];
    }

    if(draw_start_arrow || both_arrows)
    {
        angle1 = line_angle + arrowhead_angle;
        top_x = x1 + cosf(angle1) * h;
        top_y = y1 + sinf(angle1) * h;

        angle2 = line_angle - arrowhead_angle;
        bottom_x = x1 + cosf(angle2) * h;
        bottom_y = y1 + sinf(angle2) * h;

        [self drawArrowHead:ctx
                     points:@[ VFPointMake(top_x, top_y), VFPointMake(x1, y1), VFPointMake(bottom_x, bottom_y) ]];
    }
}
@end
