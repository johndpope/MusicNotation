//
//  VFBend.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFBend.h"
#import "VFEnum.h"
#import "VFColor.h"
#import "VFStaffNote.h"
#import "VFModifierContext.h"
#import "NSMutableArray+JSAdditions.h"
#import "VFText.h"

@implementation BendRenderOptions
@end

@implementation VFBendStruct
+ (VFBendStruct*)bendStructWithType:(VFBendDirectionType)type andText:(NSString*)text;
{
    VFBendStruct* ret = [[VFBendStruct alloc] initWithDictionary:nil];
    ret.type = type;
    ret.text = text;
    ret.width = 0;
    return ret;
}
@end

@implementation VFBend

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)initWithText:(NSString*)text;
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [self setupBendWith:text release:NO phrase:nil];
    }
    return self;
}

- (instancetype)initWithPhrase:(NSArray*)phrase;
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    }
    return self;
}

- (instancetype)initWithText:(NSString*)text release:(BOOL)release phrase:(NSArray*)phrase;
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [self setupBendWith:text release:release phrase:phrase];
    }
    return self;
}

+ (VFBend*)bendWithText:(NSString*)text;
{
    return [[VFBend alloc] initWithText:text release:NO phrase:nil];
}

- (void)setupBendWith:(NSString*)text release:(BOOL)release phrase:(NSArray*)phrase
{
    self.text = text;
    self.x_shift = 0;
    self.release_ = release;
    self.fontName = @"10pt Arial";

    self->_renderOptions = [[BendRenderOptions alloc] initWithDictionary:nil];
    [self->_renderOptions setLine_width:1.5];
    [self->_renderOptions setLine_style:@"#777777"];
    [self->_renderOptions setBend_width:8];
    [self->_renderOptions setRelease_width:8];

    if(phrase)
    {
        self.phrase = [phrase mutableCopy];
    }
    else
    {
        // Backward compatibility
        self.phrase = [@[ @{ @"type" : @(VFBendUP), @"text" : self.text } ] mutableCopy];
        if(self.release_)
        {
            [self.phrase push:@{ @"type" : @(VFBendDOWN), @"text" : @"" }];
        }
    }
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
    return @"bends";
}

// Arrange bends in `ModifierContext`
+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* bends = modifiers;
    if(!bends || bends.count == 0)
    {
        return NO;
    }

    float last_width = 0;
    NSUInteger text_line = state.text_line;

    // Format Bends
    for(VFBend* bend in bends)
    {
        bend.x_shift = last_width;
        last_width = bend.width;
        bend.text_line = text_line;
    }

    state.right_shift += last_width;
    state.text_line += 1;

    return YES;
}

- (void)setX_shift:(float)x_shift;
{
    /*
        setX_shift: function(value) {
            self.x_shift = value;
            self.updateWidth();
        },
    */
    _x_shift = x_shift;
    [self updateWidth];
}

/*
    setFont: function(font) { self.font = font; return this; },

    getText: function() { return self.text; },
*/

- (id)updateWidth
{
    /*
        updateWidth: function() {
            var that = this;

            function measure_text(text) {
                var text_width;
                if (that.context) {
                    text_width = that.context.measureText(text).width;
                } else {
                    text_width = Vex.Flow.textWidth(text);
                }

                return text_width;
            }

            var total_width = 0;
            for (var i=0; i<self.phrase.length; ++i) {
                var bend = self.phrase[i];
                if ('width' in bend) {
                    total_width += bend.width;
                } else {
                    var additional_width = (bend.type == Bend.UP) ?
                    self.render_options.bend_width : self.render_options.release_width;

                    bend.width = Vex.Max(additional_width, measure_text(bend.text)) + 3;
                    bend.draw_width = bend.width / 2;
                    total_width += bend.width;
                }
            }

            self.setWidth(total_width + self.x_shift);
            return this;
        },
    */

//    __weak VFBend* that = self;

    //    function measure_text(text) {
    //        var text_width;
    //        if (that.context) {
    //            text_width = that.context.measureText(text).width;
    //        } else {
    //            text_width = Vex.Flow.textWidth(text);
    //        }
    //
    //        return text_width;
    //    }
    float (^measure_text)(NSString*) = ^float(NSString* text) {
      float text_width;
      //      if(that.graphicsContext)
      //      {
      //          text_width = [VFText measureText:text].width;
      //      }
      //      else
      //      {
      //          text_width = [VFText measureText:text].width;
      //      }
      return text_width;
    };

    float total_width = 0;
    for(uint i = 0; i < self.phrase.count; ++i)
    {
        VFBendStruct* bend = self.phrase[i];
        if(bend.width != 0)
        {
            total_width += bend.width;
        }
        else
        {
            BendRenderOptions* renderOptions = self->_renderOptions;
            float additional_width = (bend.type == VFBendUP) ? renderOptions.bend_width : renderOptions.release_width;

            bend.width = MAX(additional_width, measure_text(bend.text)) + 3;
            bend.draw_width = bend.width / 2;
            total_width += bend.width;
        }
    }

    [self setWidth:(total_width + self.x_shift)];
    return self;
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    VFStaffNote* note = (VFStaffNote*)self->_note;
    VFPoint* start = [note getModifierstartXYforPosition:VFPositionRight andIndex:self.index];

    start.x += 3;
    start.y += 0.5;
    float x_shift = self.x_shift;

    float bend_height = [note.staff getYForTopTextWithLine:self.text_line] + 3;
    float annotation_y = [note.staff getYForTopTextWithLine:self.text_line] - 1;
    __block VFBend* that = self;

    void (^setStrokeStyle)(BendRenderOptions*);
    void (^renderBend)(float, float, float, float);
    void (^renderRelease)(float, float, float, float);
    void (^renderArrowHead)(float, float, VFBendDirectionType);
    void (^renderText)(float, NSString*);

    setStrokeStyle = ^void(BendRenderOptions* renderOptions) {
      if(renderOptions.components)
      {
          CGFloat* components = malloc(sizeof(CGFloat) * renderOptions.components.count);
          NSUInteger i = 0;
          for(NSNumber* component in renderOptions.components)
          {
              components[i++] = component.floatValue;
          }
          CGContextSetStrokePattern(ctx, renderOptions.pattern, components);
          CGContextSetFillPattern(ctx, renderOptions.pattern, components);
          free(components);
      }
    };
    /*
            function renderBend(x, y, width, height) {
                var cp_x = x + width;
                var cp_y = y;

                ctx.save();
                ctx.beginPath();
                ctx.setLineWidth(that.render_options.line_width);
                ctx.setStrokeStyle(that.render_options.line_style);
                ctx.setFillStyle(that.render_options.line_style);
                ctx.moveTo(x, y);
                ctx.quadraticCurveTo(cp_x, cp_y, x + width, height);
                ctx.stroke();
                ctx.restore();
            }
     */
    renderBend = ^void(float x, float y, float width, float height) {
      float cp_x = x + width;
      float cp_y = y;
      CGContextSaveGState(ctx);
      CGContextBeginPath(ctx);
      CGContextSetLineWidth(ctx, [that->_renderOptions line_width]);
      //        CGContextSetStrokeColorWithColor(ctx, <#CGColorRef color#>)

      CGContextMoveToPoint(ctx, x, y);
      CGContextAddQuadCurveToPoint(ctx, cp_x, cp_y, x + width, height);
      CGContextStrokePath(ctx);
      CGContextRestoreGState(ctx);
    };

    /*
        function renderRelease(x, y, width, height) {
            ctx.save();
            ctx.beginPath();
            ctx.setLineWidth(that.render_options.line_width);
            ctx.setStrokeStyle(that.render_options.line_style);
            ctx.setFillStyle(that.render_options.line_style);
            ctx.moveTo(x, height);
            ctx.quadraticCurveTo(
                                 x + width, height,
                                 x + width, y);
            ctx.stroke();
            ctx.restore();
        }
     */
    renderRelease = ^void(float x, float y, float width, float height) {
      CGContextSaveGState(ctx);
      CGContextBeginPath(ctx);
      BendRenderOptions* renderOptions = that->_renderOptions;
      CGContextSetLineWidth(ctx, [that->_renderOptions line_width]);
      setStrokeStyle(renderOptions);
      CGContextMoveToPoint(ctx, x, height);
      CGContextAddQuadCurveToPoint(ctx, x + width, height, x + width, y);
      CGContextStrokePath(ctx);
      CGContextRestoreGState(ctx);
    };

    /*
        function renderArrowHead(x, y, direction) {
            var width = 4;
            var dir = direction || 1;

            ctx.beginPath();
            ctx.moveTo(x, y);
            ctx.lineTo(x - width, y + width * dir);
            ctx.lineTo(x + width, y + width * dir);
            ctx.closePath();
            ctx.fill();
        }
     */
    renderArrowHead = ^void(float x, float y, VFBendDirectionType direction) {
      NSUInteger width = 4;
      VFBendDirectionType dir = direction != 0 ? direction : 1;
      CGContextBeginPath(ctx);
      CGContextMoveToPoint(ctx, x, y);
      CGContextAddLineToPoint(ctx, x - width, y + width * dir);
      CGContextAddLineToPoint(ctx, x + width, y + width * dir);
      CGContextClosePath(ctx);
    };

    /*
        function renderText(x, text) {
            ctx.save();
            ctx.setRawFont(that.font);
            var render_x = x - (ctx.measureText(text).width / 2);
            ctx.fillText(text, render_x, annotation_y);
            ctx.restore();
        }
     */
    renderText = ^void(float x, NSString* text) {
      CGContextSaveGState(ctx);

      float render_x = x - ([VFText measureText:text].width / 2);
      [VFText drawSimpleText:ctx atPoint:VFPointMake(render_x, annotation_y) withText:text];
      CGContextRestoreGState(ctx);
    };

    /*
        var last_bend = null;
        var last_drawn_width = 0;
        for (var i=0; i<self.phrase.length; ++i) {
            var bend = self.phrase[i];
            if (i === 0) bend.draw_width += x_shift;

            last_drawn_width = bend.draw_width + (last_bend?last_bend.draw_width:0) - (i==1?x_shift:0);
            if (bend.type == Bend.UP) {
                if (last_bend && last_bend.type == Bend.UP) {
                    renderArrowHead(start.x, bend_height);
                }

                renderBend(start.x, start.y, last_drawn_width, bend_height);
            }

            if (bend.type == Bend.DOWN) {
                if (last_bend && last_bend.type == Bend.UP) {
                    renderRelease(start.x, start.y, last_drawn_width, bend_height);
                }

                if (last_bend && last_bend.type == Bend.DOWN) {
                    renderArrowHead(start.x, start.y, -1);
                    renderRelease(start.x, start.y, last_drawn_width, bend_height);
                }

                if (last_bend == null) {
                    last_drawn_width = bend.draw_width;
                    renderRelease(start.x, start.y, last_drawn_width, bend_height);
                }
            }

            renderText(start.x + last_drawn_width, bend.text);
            last_bend = bend;
            last_bend.x = start.x;

            start.x += last_drawn_width;
        }
    */
    __block VFBend* last_bend = nil;
    __block float last_drawn_width = 0;
    [self.phrase enumerateObjectsUsingBlock:^(VFBend* bend, NSUInteger i, BOOL* stop) {
      if(i == 0)
      {
          bend.draw_width += x_shift;
      }
      last_drawn_width = bend.draw_width + (last_bend ? last_bend.draw_width : 0) - (i == 1 ? x_shift : 0);
      if(bend.type == VFBendUP)
      {
          if(last_bend && last_bend.type == VFBendUP)
          {
              renderArrowHead(start.x, bend_height, 0);
          }

          renderBend(start.x, start.y, last_drawn_width, bend_height);
      }

      if(bend.type == VFBendDOWN)
      {
          if(last_bend && last_bend.type == VFBendUP)
          {
              renderRelease(start.x, start.y, last_drawn_width, bend_height);
          }

          if(last_bend && last_bend.type == VFBendDOWN)
          {
              renderArrowHead(start.x, start.y, -1);
              renderRelease(start.x, start.y, last_drawn_width, bend_height);
          }

          if(last_bend == nil)
          {
              last_drawn_width = bend.draw_width;
              renderRelease(start.x, start.y, last_drawn_width, bend_height);
          }
      }

      renderText(start.x + last_drawn_width, bend.text);
      last_bend = bend;
      last_bend.x = start.x;

      start.x += last_drawn_width;

    }];

    /*
        // Final arrowhead and text
        if (last_bend.type == Bend.UP) {
            renderArrowHead(last_bend.x + last_drawn_width, bend_height);
        } else if (last_bend.type == Bend.DOWN) {
            renderArrowHead(last_bend.x + last_drawn_width, start.y, -1);
        }
    }
    });
     */
    // Final arrowhead and text
    if(last_bend.type == VFBendUP)
    {
        renderArrowHead(last_bend.x + last_drawn_width, bend_height, VFBendNONE);
    }
    else if(last_bend.type == VFBendDOWN)
    {
        renderArrowHead(last_bend.x + last_drawn_width, start.y, -1);
    }
}
@end
