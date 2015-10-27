//
//  RestsTest.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "RestsTest.h"
#import "VexFlowTestHelpers.h"
#import "OCTotallyLazy.h"
#import "NSArray+JSAdditions.h"

@implementation RestsTest

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Rests - Dotted"  func:@selector(basic:)];
    [self runTest:@"Auto Align Rests - Beamed Notes Stems Up"
           
             func:@selector(beamsUp:)
        ];
    [self runTest:@"Auto Align Rests - Beamed Notes Stems Down"
           
             func:@selector(beamsDown:)
        ];
    [self runTest:@"Auto Align Rests - Tuplets Stems Up"  func:@selector(tuplets:)];
    [self runTest:@"Auto Align Rests - Tuplets Stems Down"
           
             func:@selector(tupletsDown:)
        ];
    [self runTest:@"Auto Align Rests - Single Voice (Default)"
           
             func:@selector(staffRests:)
        ];
    [self runTest:@"Auto Align Rests - Single Voice (Align All)"
           
             func:@selector(staffRestsAll:)
        ];
    [self runTest:@"Auto Align Rests - Multi Voice"  func:@selector(multi:)];
}




- (void)draw:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 150) withParent:parent];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
//        CGContextRef ctx = VFGraphicsContext();

      // VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];

      // ok(YES, @"all pass");
    };
}

// TODO: does this belong in superclass?
- (ViewStaffStruct*)setupContextWithSize:(VFUIntSize*)size withParent:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Rests.setupContext = function(options, contextBuilder, x, y) {
        var ctx = new contextBuilder(options.canvas_sel, x || 350, y || 150);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.font = " 10pt Arial";
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 30, x || 350).addTrebleGlyph().
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

- (void)basic:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(700, 0) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = c.staff;
      [staff draw:ctx];

      NSArray* notes = @[
          [newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"wr" }) addDotToAll],
          [newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"hr" }) addDotToAll],
          [newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"qr" }) addDotToAll],
          [newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8r" }) addDotToAll],
          [newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16r" }) addDotToAll],
          [newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"32r" }) addDotToAll],
          [newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"64r" }) addDotToAll]
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];

      [voice setStrict:NO];
      [voice addTickables:notes];
      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staff withNotes:notes];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"Dotted Rest Test");
    };
}

- (void)beamsUp:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(600, 160) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = c.staff;
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"b/4", @"d/5", @"a/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"b/4", @"d/5", @"a/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),

      ];

      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFBeam* beam1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];

      VFBeam* beam2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];
      VFBeam* beam3 = [VFBeam beamWithNotes:[notes slice:[@8:12]]];

      [voice1 setStrict:NO];
      [voice1 addTickables:notes];
      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staff withNotes:notes];

      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];

      [beam1 draw:ctx];
      [beam2 draw:ctx];
      [beam3 draw:ctx];

      ok(YES, @"Auto Align Rests - Beams Up Test");
    };
}

- (void)beamsDown:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(600, 160) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = c.staff;
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"b/4", @"d/5", @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"b/4", @"d/5", @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),

      ];

      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];

      VFBeam* beam1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];
      VFBeam* beam3 = [VFBeam beamWithNotes:[notes slice:[@8:12]]];

      [voice1 setStrict:NO];
      [voice1 addTickables:notes];
      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staff withNotes:notes];

      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];

      [beam1 draw:ctx];
      [beam2 draw:ctx];
      [beam3 draw:ctx];

      ok(YES, @"Auto Align Rests - Beams Down Test");
    };
}

- (void)tuplets:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(600, 160) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = c.staff;
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"qr" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"b/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"qr" }),
      ];

      VFTuplet* tuplet1 = [[VFTuplet alloc] initWithNotes:[notes slice:[@0:3]]];
      VFTuplet* tuplet2 = [[VFTuplet alloc] initWithNotes:[notes slice:[@3:6]]];
      VFTuplet* tuplet3 = [[VFTuplet alloc] initWithNotes:[notes slice:[@6:9]]];
      VFTuplet* tuplet4 = [[VFTuplet alloc] initWithNotes:[notes slice:[@9:12]]];
      [tuplet1 setTupletLocation:VFTupletLocationTop];
      [tuplet2 setTupletLocation:VFTupletLocationTop];
      [tuplet3 setTupletLocation:VFTupletLocationTop];
      [tuplet4 setTupletLocation:VFTupletLocationTop];

      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];

      [voice1 setStrict:NO];
      [voice1 addTickables:notes];
      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staff withNotes:notes];

      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];

      [tuplet1 draw:ctx];
      [tuplet2 draw:ctx];
      [tuplet3 draw:ctx];
      [tuplet4 draw:ctx];

      ok(YES, @"Auto Align Rests - Tuplets Stem Up Test");
    };
}

- (void)tupletsDown:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(600, 160) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = c.staff;
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
      ];

      VFBeam* beam1 = [VFBeam beamWithNotes:[notes slice:[@0:3]]];
      VFBeam* beam2 = [VFBeam beamWithNotes:[notes slice:[@3:6]]];
      VFBeam* beam3 = [VFBeam beamWithNotes:[notes slice:[@6:9]]];
      VFBeam* beam4 = [VFBeam beamWithNotes:[notes slice:[@9:12]]];

      VFTuplet* tuplet1 = [[VFTuplet alloc] initWithNotes:[notes slice:[@0:3]]];
      VFTuplet* tuplet2 = [[VFTuplet alloc] initWithNotes:[notes slice:[@3:6]]];
      VFTuplet* tuplet3 = [[VFTuplet alloc] initWithNotes:[notes slice:[@6:9]]];
      VFTuplet* tuplet4 = [[VFTuplet alloc] initWithNotes:[notes slice:[@9:12]]];
      [tuplet1 setTupletLocation:VFTupletLocationBottom];
      [tuplet2 setTupletLocation:VFTupletLocationBottom];
      [tuplet3 setTupletLocation:VFTupletLocationBottom];
      [tuplet4 setTupletLocation:VFTupletLocationBottom];

      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];

      [voice1 setStrict:NO];
      [voice1 addTickables:notes];
      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staff withNotes:notes];

      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];

      [tuplet1 draw:ctx];
      [tuplet2 draw:ctx];
      [tuplet3 draw:ctx];
      [tuplet4 draw:ctx];

      [beam1 draw:ctx];
      [beam2 draw:ctx];
      [beam3 draw:ctx];
      [beam4 draw:ctx];

      ok(YES, @"Auto Align Rests - Tuplets Stem Down Test");
    };
}

- (void)staffRests:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(600, 160) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = c.staff;
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"b/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),

          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"qr" }),
      ];

      VFBeam* beam1 = [VFBeam beamWithNotes:[notes slice:[@5:9]]];
      VFTuplet* tuplet = [[VFTuplet alloc] initWithNotes:[notes slice:[@9:12]]];
      [tuplet setTupletLocation:VFTupletLocationTop];

      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];

      [voice1 setStrict:NO];
      [voice1 addTickables:notes];
      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

        [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staff withNotes:notes];

      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [tuplet draw:ctx];
      [beam1 draw:ctx];

      ok(YES, @"Auto Align Rests - Default Test");
    };
}

- (void)staffRestsAll:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(600, 160) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = c.staff;
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"b/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),

          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"qr" }),
      ];

      VFBeam* beam1 = [VFBeam beamWithNotes:[notes slice:[@5:9]]];
      VFTuplet* tuplet = [[VFTuplet alloc] initWithNotes:[notes slice:[@9:12]]];
      [tuplet setTupletLocation:VFTupletLocationTop];

      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];

      [voice1 setStrict:NO];
      [voice1 addTickables:notes];
      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      // Set option to position rests near the notes in the voice
      [VFFormatter formatAndDrawWithContext:ctx
                                  dirtyRect:CGRectZero
                                    toStaff:staff
                                  withNotes:notes
                                 withParams:@{
                                     @"align_rests" : @(YES)
                                 }];

      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [tuplet draw:ctx];
      [beam1 draw:ctx];

      ok(YES, @"Auto Align Rests - Align All Test");
    };
}

- (void)multi:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];

    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(50, 10, 500, 0)] addTrebleGlyph];
      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"duration" : @"qr" }),
          newNote(
              @{ @"keys" : @[ @"c/4", @"d/4", @"a/4" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"duration" : @"qr" })
      ];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];

      // Set option to position rests near the notes in each voice
      //      VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice2 ]] formatWith:@[ voice, voice2 ]
                                                         withJustifyWidth:400
                                                               andOptions:@{
                                                                   @"align_rests" : @YES
                                                               }];

      VFBeam* beam2_1 = [VFBeam beamWithNotes:[notes2 slice:[@0:4]]];
      VFBeam* beam2_2 = [VFBeam beamWithNotes:[notes2 slice:[@4:8]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam2_1 draw:ctx];
      [beam2_2 draw:ctx];
      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"Strokes Test Multi Voice");

    };
}

@end
