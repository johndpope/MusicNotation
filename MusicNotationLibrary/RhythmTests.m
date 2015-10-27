//
//  RhythmTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "RhythmTests.h"
#import "VexFlowTestHelpers.h"
#import "StaffNoteTests.h"
#import "NSArray+OCTotallyLazy.h"

@implementation RhythmTests

static NSUInteger _testFontSize;

- (void)start   //:(VFTestView*)parent;
{
    _testFontSize = 12;   // TODO: determine a reasonable value for this
//    [super start:parent];
//    id targetClass = [self class];

    [self runTest:@"Rhythm Draw - slash notes"  func:@selector(drawBasic:)];
    [self runTest:@"Rhythm Draw - beamed slash notes"
           
             func:@selector(drawBeamedSlashNotes:)
        ];
    [self runTest:@"Rhythm Draw - beamed slash notes, some rests"
           
             func:@selector(drawSlashAndBeamAndRests:)
        ];
    [self runTest:@"Rhythm Draw - 16th note rhythm with scratches"
           
             func:@selector(drawSixteenthWithScratches:)
        ];
    [self runTest:@"Rhythm Draw - 32nd note rhythm with scratches"
           
             func:@selector(drawThirtySecondWithScratches:)
        ];
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

// TODO: "drawSlash:" not being tested
- (void)drawSlash:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
      [staff draw:ctx];

      NSArray* notes = @[
          @{ @"keys" : @[ @"b/4" ],
             @"duration" : @"ws",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"b/4" ],
             @"duration" : @"hs",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"b/4" ],
             @"duration" : @"qs",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"b/4" ],
             @"duration" : @"8s",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"b/4" ],
             @"duration" : @"16s",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"b/4" ],
             @"duration" : @"32s",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"b/4" ],
             @"duration" : @"64s",
             @"stem_direction" : @(-1) },
      ];

      expect(@"%lu", notes.count * 2);

      [notes foreach:^(NSDictionary* note, NSUInteger i, BOOL* stop) {

        VFStaffNote* staffNote = [parent showNote:note onStaff:staff withContext:ctx atX:(((float)i) + 1.f) * 25];

        BOOL success = staffNote.x > 0;
        NSString* message = [NSString stringWithFormat:@"Note %lu has X value", i];
        ok(success, message);
        success = staffNote.ys.count > 0;
        message = [NSString stringWithFormat:@"Note %lu has Y values", i];
        ok(success, message);
      }];
    };
}

- (void)drawBasic:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 10, 150, 0)];
      [staffBar1 setBegBarType:VFBarLineDouble];
      [staffBar1 setEndBarType:VFBarLineSingle];
      [staffBar1 addClefWithName:@"treble"];
      [staffBar1 addTimeSignatureWithName:@"4/4"];
      [staffBar1 addKeySignature:@"C"];
      [staffBar1 draw:ctx];

      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"1s",
              @"stem_direction" : @(-1)
          }]
      ];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

      // bar 2 - juxtaposing second bar next to first bar
      VFStaff* staffBar2 = [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 120, 0)];
      [staffBar2 setBegBarType:VFBarLineSingle];
      [staffBar2 setEndBarType:VFBarLineSingle];
      [staffBar2 draw:ctx];

      // bar 2
      NSArray* notesBar2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"2s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"2s",
              @"stem_direction" : @(-1)
          }]
      ];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];

      // bar 3 - juxtaposing second bar next to first bar
      VFStaff* staffBar3 = [VFStaff staffWithRect:CGRectMake(staffBar2.width + staffBar2.x, staffBar2.y, 170, 0)];
      [staffBar3 draw:ctx];

      // bar 3
      NSArray* notesBar3 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"4s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"4s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"4s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"4s",
              @"stem_direction" : @(-1)
          }],
      ];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar3 withNotes:notesBar3];

      // bar 4 - juxtaposing second bar next to first bar
      VFStaff* staffBar4 = [VFStaff staffWithRect:CGRectMake(staffBar3.width + staffBar3.x, staffBar3.y, 200, 0)];
      [staffBar4 draw:ctx];

      // bar 4
      NSArray* notesBar4 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],

      ];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar4 withNotes:notesBar4];
      expect(@"%d ", 0);

    };
}

- (void)drawBeamedSlashNotes:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 300, 0)];
      [staffBar1 setBegBarType:VFBarLineDouble];
      [staffBar1 setEndBarType:VFBarLineSingle];
      [staffBar1 addClefWithName:@"treble"];
      [staffBar1 addTimeSignatureWithName:@"4/4"];
      [staffBar1 addKeySignature:@"C"];
      [staffBar1 draw:ctx];

      // bar 4
      NSArray* notesBar1_part1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }]
      ];

      NSArray* notesBar1_part2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],

      ];

      // create the beams for 8th notes in 2nd measure
      VFBeam* beam1 = [[VFBeam alloc] initWithNotes:notesBar1_part1];
      VFBeam* beam2 = [[VFBeam alloc] initWithNotes:notesBar1_part2];
      NSArray* notesBar1 = [notesBar1_part1 concat:notesBar1_part2];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

      // Render beams
      [beam1 draw:ctx];
      [beam2 draw:ctx];

      expect(@"%d ", 0);

    };
}

- (void)drawSlashAndBeamAndRests:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 300, 0)];
      [staffBar1 setBegBarType:VFBarLineDouble];
      [staffBar1 setEndBarType:VFBarLineSingle];
      [staffBar1 addClefWithName:@"treble"];
      [staffBar1 addTimeSignatureWithName:@"4/4"];
      [staffBar1 addKeySignature:@"F"];
      [staffBar1 draw:ctx];

      // bar 1
      NSArray* notesBar1_part1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }]
      ];

      [notesBar1_part1[0]
          addModifier:[[VFAnnotation annotationWithText:@"C7"] setFontName:@"Times" withSize:_testFontSize + 2]
              atIndex:0];

      NSArray* notesBar1_part2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8r",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8r",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8r",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"8s",
              @"stem_direction" : @(-1)
          }]

      ];

      // create the beams for 8th notes in 2nd measure
      VFBeam* beam1 = [[VFBeam alloc] initWithNotes:notesBar1_part1];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:[notesBar1_part1 concat:notesBar1_part2]];

      // Render beams
      [beam1 draw:ctx];

      // bar 2 - juxtaposing second bar next to first bar
      VFStaff* staffBar2 = [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 220, 0)];
      [staffBar2 draw:ctx];

      NSArray* notesBar2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"1s",
              @"stem_direction" : @(-1)
          }]
      ];

      [notesBar2[0] addModifier:[[VFAnnotation annotationWithText:@"F"] setFontName:@"Times" withSize:_testFontSize + 2]
                        atIndex:0];
      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];

      expect(@"%d ", 0);

    };
}

- (void)drawSixteenthWithScratches:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;

      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 300, 0)];
      [staffBar1 setBegBarType:VFBarLineDouble];
      [staffBar1 setEndBarType:VFBarLineSingle];
      [staffBar1 addClefWithName:@"treble"];
      [staffBar1 addTimeSignatureWithName:@"4/4"];
      [staffBar1 addKeySignature:@"F"];
      [staffBar1 draw:ctx];

      // bar 1
      NSArray* notesBar1_part1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16m",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16s",
              @"stem_direction" : @(-1)
          }]
      ];

      NSArray* notesBar1_part2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16m",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16s",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16r",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16s",
              @"stem_direction" : @(-1)
          }]

      ];

      [notesBar1_part1[0]
          addModifier:[[VFAnnotation annotationWithText:@"C7"] setFontName:@"Times" withSize:_testFontSize + 3]
              atIndex:0];

      // create the beams for 8th notes in 2nd measure
      VFBeam* beam1 = [[VFBeam alloc] initWithNotes:notesBar1_part1];
      VFBeam* beam2 = [[VFBeam alloc] initWithNotes:notesBar1_part2];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:[notesBar1_part1 concat:notesBar1_part2]];

      // Render beams
      [beam1 draw:ctx];
      [beam2 draw:ctx];

      expect(@"%d ", 0);

    };
}

- (void)drawThirtySecondWithScratches:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 300, 0)];
      [staffBar1 setBegBarType:VFBarLineDouble];
      [staffBar1 setEndBarType:VFBarLineSingle];
      [staffBar1 addClefWithName:@"treble"];
      [staffBar1 addTimeSignatureWithName:@"4/4"];
      [staffBar1 addKeySignature:@"F"];
      [staffBar1 draw:ctx];

      // bar 1
      NSArray* notesBar1_part1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"32s",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"32s",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"32m",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"32s",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"32m",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"32s",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"32r",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"32s",
              @"stem_direction" : @(1)
          }]

      ];

      [notesBar1_part1[0]
          addModifier:[[VFAnnotation annotationWithText:@"C7"] setFontName:@"Times" withSize:_testFontSize + 3]
              atIndex:0];

      // create the beams for 8th notes in 2nd measure
      VFBeam* beam1 = [[VFBeam alloc] initWithNotes:notesBar1_part1];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1_part1];

      // Render beams
      [beam1 draw:ctx];

      expect(@"%d ", 0);

    };
}

@end
