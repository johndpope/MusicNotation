//
//  VFVibrato.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Complete

#import "VFVibrato.h"
#import "VFModifierContext.h"
#import "VFBend.h"
#import "VFLog.h"
#import "VFStaffNote.h"

@implementation VibratoRenderOptions
@end

@implementation VFVibrato

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
        [self setupVibrato];
    }
    return self;
}

- (void)setupVibrato
{
    _harsh = NO;
    self.position = VFPositionRight;
    self->_renderOptions = [[VibratoRenderOptions alloc] init];
    [self->_renderOptions setVibrato_width:20];
    [self->_renderOptions setWave_height:6];
    [self->_renderOptions setWave_width:4];
    [self->_renderOptions setWave_girth:2];

    [self setVibratoWidth:[self->_renderOptions vibrato_width]];
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
    return @"vibratos";
}

// Arrange vibratos inside a `ModifierContext`.
// TODO: this prototype differs from the other VFModifiers
+ (BOOL)format:(NSMutableArray*)modifiers state:(VFModifierState*)state context:(VFModifierContext*)context;
{
    NSMutableArray* vibratos = modifiers;
    if(!vibratos || vibratos.count == 0)
    {
        return NO;
    }

    NSUInteger text_line = state.text_line;
    float width = 0;
    float shift = state.right_shift - 7;

    // If there's a bend, drop the text line
    NSArray* bends = [context getModifiersForType:[VFBend CATEGORY]];
    if(bends && bends.count > 0)
    {
        text_line--;
    }

    // Format Vibratos
    for(VFVibrato* vibrato in vibratos)
    {
        vibrato.x_shift = shift;
        vibrato.text_line = text_line;
        width += vibrato.width;
        shift += width;
    }

    state.right_shift += width;
    state.text_line += 1;
    return YES;
}

- (id)setVibratoWidth:(float)width;
{
    _vibrato_width = width;
    //    _width = width;
    return self;
}

- (id)setHarsh:(BOOL)harsh
{
    _harsh = harsh;
    return self;
}
- (BOOL)harsh;
{
    return _harsh;
}

- (void)draw:(CGContextRef)ctx;
{
    [super draw:ctx];

    if(!self->_note)
    {
        [VFLog logError:[NSString
                            stringWithFormat:@"NoNoteForVibrato %@", @"Can't draw vibrato without an attached note."]];
    }

    VFPoint* start = [((VFStaffNote*)self->_note)getModifierstartXYforPosition:VFPositionRight andIndex:self.index];

    VFVibrato* that = self;
    float vibrato_width = self.vibrato_width;

    void (^renderVibrato)(float, float) = ^void(float x, float y) {
      float wave_width = [that->_renderOptions wave_width];
      float wave_girth = [that->_renderOptions wave_girth];
      float wave_height = [that->_renderOptions wave_height];
      float num_waves = vibrato_width / wave_width;

      CGContextBeginPath(ctx);

      NSUInteger i;
      if(that.hash)
      {
          CGContextMoveToPoint(ctx, x, y + wave_girth + 1);
          for(i = 0; i < num_waves / 2; ++i)
          {
              CGContextAddLineToPoint(ctx, x + wave_width, y - (wave_height / 2));
              x += wave_width;
              CGContextAddLineToPoint(ctx, x + wave_width, y + (wave_height / 2));
              x += wave_width;
          }
          for(i = 0; i < num_waves / 2; ++i)
          {
              CGContextAddLineToPoint(ctx, x - wave_width, (y - (wave_height / 2)) + wave_girth + 1);
              x -= wave_width;
              CGContextAddLineToPoint(ctx, x - wave_width, (y + (wave_height / 2)) + wave_girth + 1);
              x -= wave_width;
          }
          // ctx.fill();
          CGContextFillPath(ctx);
      }
      else
      {
          CGContextMoveToPoint(ctx, x, y + wave_girth);
          for(i = 0; i < num_waves / 2; ++i)
          {
              CGContextAddQuadCurveToPoint(ctx, x + (wave_width / 2), y - (wave_height / 2), x + wave_width, y);
              x += wave_width;
              CGContextAddQuadCurveToPoint(ctx, x + (wave_width / 2), y + (wave_height / 2), x + wave_width, y);
              x += wave_width;
          }

          for(i = 0; i < num_waves / 2; ++i)
          {
              CGContextAddQuadCurveToPoint(ctx, x - (wave_width / 2), (y + (wave_height / 2)) + wave_girth,
                                           x - wave_width, y + wave_girth);

              x -= wave_width;
              CGContextAddQuadCurveToPoint(ctx, x - (wave_width / 2), (y - (wave_height / 2)) + wave_girth,
                                           x - wave_width, y + wave_girth);
              x -= wave_width;
          }
          CGContextFillPath(ctx);
      }
    };

    float vx = start.x + self.x_shift;
    float vy = [((VFStaffNote*)self->_note)getYForTopText:self.text_line] + 2;

    renderVibrato(vx, vy);
}

@end
