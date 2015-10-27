//
//  CurveTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "CurveTests.h"
#import "VexFlowTestHelpers.h"
#import "NSArray+JSAdditions.h"

@implementation CurveTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple Curve"  func:@selector(simple:)];

    [self runTest:@"Rounded Curve"  func:@selector(rounded:)];

    [self runTest:@"Thick Thin Curves"  func:@selector(thickThin:)];

    [self runTest:@"Top Curve"  func:@selector(topCurve:)];
}




- (ViewStaffStruct*)setupContextWithSize:(VFUIntSize*)size withParent:(TestCollectionItemView*)parent
{
    /*
     Vex.Flow.Test.ThreeVoices.setupContext = function(options, x, y) {
     Vex.Flow.Test.resizeCanvas(options.canvas_sel, x || 350, y || 150);
     var ctx = Vex.getCanvasContext(options.canvas_sel);
     ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
     ctx.font = " 10pt Arial";
     VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 30, x || 350, 0) addTrebleGlyph].
     setContext(ctx).draw();

     return {context: ctx, staff: staff};
     }
     */
    NSUInteger w = size.width;
    NSUInteger h = size.height;

    w = w != 0 ? w : 350;
    h = h != 0 ? h : 150;

    [VFFont setFont:@" 10pt Arial"];

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h) withParent:parent];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

- (void)simple:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(350, 140) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      [c.staff addTrebleGlyph];
      [c.staff draw:ctx];
      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/6" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];

      // VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];

      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]] autoStem:YES];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]] autoStem:YES];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      VFCurve* curve1 = [VFCurve curveFromNote:notes[0]
                                        toNote:notes[3]
                                withDictionary:@{
                                    @"cps" : @[ @{@"x" : @(0), @"y" : @(10)}, @{@"x" : @(0), @"y" : @(50)} ]
                                }];

      [curve1 draw:ctx];

      VFCurve* curve2 = [VFCurve curveFromNote:notes[4]
                                        toNote:notes[7]
                                withDictionary:@{
                                    @"cps" : @[ @{@"x" : @(0), @"y" : @(10)}, @{@"x" : @(0), @"y" : @(20)} ]
                                }];

      [curve2 draw:ctx];

      ok(YES, @"Simple Curve");
    };
}

- (void)rounded:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(350, 140) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      [c.staff addTrebleGlyph];
      [c.staff draw:ctx];
      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/6" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/6" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];
      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];

      // VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]] autoStem:YES];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]] autoStem:YES];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      VFCurve* curve1 = [VFCurve curveFromNote:notes[0]
                                        toNote:notes[3]
                                withDictionary:@{
                                    @"x_shift" : @(-10),
                                    @"y_shift" : @(30),
                                    @"cps" : @[ @{@"x" : @(0), @"y" : @(20)}, @{@"x" : @(0), @"y" : @(50)} ]
                                }];

      [curve1 draw:ctx];

      VFCurve* curve2 = [VFCurve curveFromNote:notes[4]
                                        toNote:notes[7]
                                withDictionary:@{
                                    @"cps" : @[ @{@"x" : @(0), @"y" : @(50)}, @{@"x" : @(0), @"y" : @(50)} ]
                                }];

      [curve2 draw:ctx];

      ok(YES, @"Rounded Curve");

    };
}

- (void)thickThin:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(350, 140) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      [c.staff addTrebleGlyph];
      [c.staff draw:ctx];
      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/6" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/6" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];

      // VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]] autoStem:YES];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]] autoStem:YES];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      VFCurve* curve1 = [VFCurve curveFromNote:notes[0]
                                        toNote:notes[3]
                                withDictionary:@{
                                    @"thickness" : @(10),
                                    @"x_shift" : @(-10),
                                    @"y_shift" : @(30),
                                    @"cps" : @[ @{@"x" : @(0), @"y" : @(20)}, @{@"x" : @(0), @"y" : @(50)} ]
                                }];

      [curve1 draw:ctx];

      VFCurve* curve2 = [VFCurve curveFromNote:notes[4]
                                        toNote:notes[7]
                                withDictionary:@{
                                    @"thickness" : @(0),
                                    @"cps" : @[ @{@"x" : @(0), @"y" : @(50)}, @{@"x" : @(0), @"y" : @(50)} ]
                                }];

      [curve2 draw:ctx];

      ok(YES, @"Thick Thin Curve");
    };
}

- (void)topCurve:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(350, 140) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      [c.staff addTrebleGlyph];
      [c.staff draw:ctx];
      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/6" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/6" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];

      // VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]] autoStem:YES];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]] autoStem:YES];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      VFCurve* curve1 = [VFCurve curveFromNote:notes[0]
                                        toNote:notes[7]
                                withDictionary:@{
                                    @"x_shift" : @(-3),
                                    @"y_shift" : @(10),
                                    @"position" : @(VFCurveNearTop),
                                    @"position_end" : @(VFCurveNearHead),

                                    @"cps" : @[ @{@"x" : @(0), @"y" : @(20)}, @{@"x" : @(40), @"y" : @(80)} ]
                                }];

      [curve1 draw:ctx];

      ok(YES, @"Top Curve");

    };
}
@end
