//
//  ArticulationTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "ArticulationTests.h"
#import "VexFlowTestHelpers.h"
#import "NSArray+JSAdditions.h"

@implementation ArticulationTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];

    [self runTest:@"Articulation - Staccato/Staccatissimo" @"a." @"av"
             func:@selector(drawArticulations:params:withTitle:)
           params:@[ @"a.", @"av" ]];
    [self runTest:@"Articulation - Accent/Tenuto" @"a>" @"a-"
             func:@selector(drawArticulations:params:withTitle:)
           params:@[ @"a>", @"a-" ]];
    [self runTest:@"Articulation - Marcato/L.H. Pizzicato" @"a^" @"a+"
             func:@selector(drawArticulations:params:withTitle:)
           params:@[ @"a^", @"a+" ]];
    [self runTest:@"Articulation - Snap Pizzicato/Fermata" @"ao" @"ao"
             func:@selector(drawArticulations:params:withTitle:)
           params:@[ @"ao", @"ao" ]];
    [self runTest:@"Articulation - Up-stroke/Down-Stroke" @"a|" @"am"
             func:@selector(drawArticulations:params:withTitle:)
           params:@[ @"a|", @"am" ]];
    [self runTest:@"Articulation - Fermata Above/Below" @"a@a" @"a@u"
             func:@selector(drawFermata:params:withTitle:)
           params:@[ @"a@a", @"a@u" ]];
    [self runTest:@"Articulation - Inline/Multiple" @"a." @"a."
             func:@selector(drawArticulations2:params:withTitle:)
           params:@[ @"a.", @"a." ]];
    [self runTest:@"TabNote Articulation" @"a." @"a."
             func:@selector(tabNotes:params:withTitle:)
           params:@[ @"a.", @"a." ]];
}



- (ViewStaffStruct*)setupContextWithSize:(VFUIntSize*)size withParent:(TestCollectionItemView*)parent withTitle:(NSString*)title
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

    // VFTestView* test = self.currentCell;   // VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h)
                                           // withParent:parent withTitle:title];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

- (void)drawArticulations:(TestCollectionItemView*)parent params:(NSArray*)params withTitle:(NSString*)title
{
    NSString* sym1 = params[0];
    NSString* sym2 = params[1];

    VFArticulation* (^newArticulation)(NSString*) = ^VFArticulation*(NSString* symbol)
    {
        VFArticulationType type = [VFEnum typeArticulationTypeForString:symbol];
        return [[VFArticulation alloc] initWithType:type];
    };

//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(625, 195) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
      // CGContextRef ctx = context.CGContext;
      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 125, 0)];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/3" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }]
      ];
      [notesBar1[0] addArticulation:[newArticulation(sym1) setPosition:4] atIndex:0];
      [notesBar1[1] addArticulation:[newArticulation(sym1) setPosition:4] atIndex:0];
      [notesBar1[2] addArticulation:[newArticulation(sym1) setPosition:3] atIndex:0];
      [notesBar1[3] addArticulation:[newArticulation(sym1) setPosition:3] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

      // bar 2 - juxtaposing second bar next to first bar
      VFStaff* staffBar2 = [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 125, 0)];
      [staffBar2 setEndBarType:VFBarLineDouble];
      [staffBar2 draw:ctx];

      NSArray* notesBar2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
      ];
      [notesBar2[0] addArticulation:[newArticulation(sym1) setPosition:3] atIndex:0];
      [notesBar2[1] addArticulation:[newArticulation(sym1) setPosition:3] atIndex:0];
      [notesBar2[2] addArticulation:[newArticulation(sym1) setPosition:4] atIndex:0];
      [notesBar2[3] addArticulation:[newArticulation(sym1) setPosition:4] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];

      // bar 3 - juxtaposing second bar next to first bar
      VFStaff* staffBar3 = [VFStaff staffWithRect:CGRectMake(staffBar2.width + staffBar2.x, staffBar2.y, 125, 0)];
      [staffBar3 draw:ctx];

      NSArray* notesBar3 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
      ];
      [notesBar3[0] addArticulation:[newArticulation(sym2) setPosition:4] atIndex:0];
      [notesBar3[1] addArticulation:[newArticulation(sym2) setPosition:4] atIndex:0];
      [notesBar3[2] addArticulation:[newArticulation(sym2) setPosition:3] atIndex:0];
      [notesBar3[3] addArticulation:[newArticulation(sym2) setPosition:3] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar3 withNotes:notesBar3];

      // bar 4 - juxtaposing second bar next to first bar
      VFStaff* staffBar4 = [VFStaff staffWithRect:CGRectMake(staffBar3.width + staffBar3.x, staffBar3.y, 125, 0)];
      [staffBar4 setEndBarType:VFBarLineEnd];
      [staffBar4 draw:ctx];

      NSArray* notesBar4 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
      ];
      [notesBar4[0] addArticulation:[newArticulation(sym2) setPosition:3] atIndex:0];
      [notesBar4[1] addArticulation:[newArticulation(sym2) setPosition:3] atIndex:0];
      [notesBar4[2] addArticulation:[newArticulation(sym2) setPosition:4] atIndex:0];
      [notesBar4[3] addArticulation:[newArticulation(sym2) setPosition:4] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar4 withNotes:notesBar4];

    };
}

- (void)drawFermata:(TestCollectionItemView*)parent params:(NSArray*)params withTitle:(NSString*)title
{
    NSString* sym1 = params[0];
    NSString* sym2 = params[1];

    VFArticulation* (^newArticulation)(NSString*) = ^VFArticulation*(NSString* symbol)
    {
        VFArticulationType type = [VFEnum typeArticulationTypeForString:symbol];
        return [[VFArticulation alloc] initWithType:type];
    };
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(400, 200) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
//
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
      // CGContextRef ctx = context.CGContext;
      expect(@"0");

      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(50, 30, 150, 0)];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
      ];

      [notesBar1[0] addArticulation:[newArticulation(sym1) setPosition:3] atIndex:0];
      [notesBar1[1] addArticulation:[newArticulation(sym1) setPosition:3] atIndex:0];
      [notesBar1[2] addArticulation:[newArticulation(sym2) setPosition:4] atIndex:0];
      [notesBar1[3] addArticulation:[newArticulation(sym2) setPosition:4] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

      // bar 2 - juxtaposing second bar next to first bar
      VFStaff* staffBar2 = [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 150, 0)];
      [staffBar2 setEndBarType:VFBarLineDouble];
      [staffBar2 draw:ctx];

      NSArray* notesBar2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
      ];
      [notesBar2[0] addArticulation:[newArticulation(sym1) setPosition:3] atIndex:0];
      [notesBar2[1] addArticulation:[newArticulation(sym1) setPosition:3] atIndex:0];
      [notesBar2[2] addArticulation:[newArticulation(sym2) setPosition:4] atIndex:0];
      [notesBar2[3] addArticulation:[newArticulation(sym2) setPosition:4] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];
    };
}

- (void)drawArticulations2:(TestCollectionItemView*)parent params:(NSArray*)params withTitle:(NSString*)title
{
    VFArticulation* (^newArticulation)(NSString*) = ^VFArticulation*(NSString* symbol)
    {
        VFArticulationType type = [VFEnum typeArticulationTypeForString:symbol];
        return [[VFArticulation alloc] initWithType:type];
    };
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(725, 200) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
      // CGContextRef ctx = context.CGContext;

      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 250, 0)];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"d/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"e/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"g/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"d/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"e/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"g/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/6" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"d/6" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
      ];

      for(NSUInteger i = 0; i < 16; i++)
      {
          [notesBar1[i] addArticulation:[newArticulation(@"a.") setPosition:4] atIndex:0];
          [notesBar1[i] addArticulation:[newArticulation(@"a>") setPosition:4] atIndex:0];

          if(i == 15)
          {
              [notesBar1[i] addArticulation:[newArticulation(@"a@u") setPosition:4]];
          }
      }

      VFBeam* beam1 = [VFBeam beamWithNotes:[notesBar1 slice:[@0:8]]];
      VFBeam* beam2 = [VFBeam beamWithNotes:[notesBar1 slice:[@8:16]]];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];
      [beam1 draw:ctx];
      [beam2 draw:ctx];

      // bar 2 - juxtaposing second bar next to first bar
      VFStaff* staffBar2 = [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 250, 0)];
      [staffBar2 draw:ctx];
      NSArray* notesBar2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/3" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"g/3" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/3" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/3" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"d/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"e/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"g/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"d/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"e/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"g/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }],
      ];
      for(NSUInteger i = 0; i < 16; i++)
      {
          [notesBar2[i] addArticulation:[newArticulation(@"a-") setPosition:3]];
          [notesBar2[i] addArticulation:[newArticulation(@"a^") setPosition:3]];

          if(i == 15)
          {
              [notesBar2[i] addArticulation:[newArticulation(@"a@u") setPosition:4]];
          }
      }

      VFBeam* beam3 = [VFBeam beamWithNotes:[notesBar2 slice:[@0:8]]];
      VFBeam* beam4 = [VFBeam beamWithNotes:[notesBar2 slice:[@8:16]]];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];
      [beam3 draw:ctx];
      [beam4 draw:ctx];

      // bar 3 - juxtaposing second bar next to first bar
      VFStaff* staffBar3 = [VFStaff staffWithRect:CGRectMake(staffBar2.width + staffBar2.x, staffBar2.y, 75, 0)];
      [staffBar3 draw:ctx];

      NSArray* notesBar3 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4" ],
              @"duration" : @"w",
              @"stem_direction" : @(1)
          }],
      ];
      [notesBar3[0] addArticulation:[newArticulation(@"a-") setPosition:3] atIndex:0];
      [notesBar3[0] addArticulation:[newArticulation(@"a>") setPosition:3] atIndex:0];
      [notesBar3[0] addArticulation:[newArticulation(@"a@a") setPosition:3] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar3 withNotes:notesBar3];
      // bar 4 - juxtaposing second bar next to first bar
      VFStaff* staffBar4 = [VFStaff staffWithRect:CGRectMake(staffBar3.width + staffBar3.x, staffBar3.y, 125, 0)];
      [staffBar4 setEndBarType:VFBarLineEnd];
      [staffBar4 draw:ctx];

      NSArray* notesBar4 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }],
      ];
      for(NSUInteger i = 0; i < 4; i++)
      {
          NSUInteger position1 = 3;
          NSUInteger position2 = 4;
          if(i > 1)
          {
              position1 = 4;
              position2 = 3;
          }
          [notesBar4[i] addArticulation:[newArticulation(@"a-") setPosition:position1]];
      }

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar4 withNotes:notesBar4];

    };
}

- (void)tabNotes:(TestCollectionItemView*)parent params:(NSArray*)params withTitle:(NSString*)title
{
    VFArticulation* (^newArticulation)(NSString*) = ^VFArticulation*(NSString* symbol)
    {
        VFArticulationType type = [VFEnum typeArticulationTypeForString:symbol];
        return [[VFArticulation alloc] initWithType:type];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(600, 200) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
//
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
      // CGContextRef ctx = context.CGContext;
      VFTabStaff* staff = [VFTabStaff staffWithRect:CGRectMake(10, 10, 550, 0)];

      [staff draw:ctx];

      NSArray* specs = @[
          @{
              @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(3), @"fret" : @(5)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(3), @"fret" : @(5)} ],
              @"duration" : @"8"
          }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* tab_struct) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:tab_struct];
        [tabNote->_renderOptions setDraw_stem:YES];
        return tabNote;
      }];

      NSArray* notes2 = [specs oct_map:^VFTabNote*(NSDictionary* tab_struct) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:tab_struct];
        [tabNote->_renderOptions setDraw_stem:YES];
        [tabNote setStemDirection:-1];
        return tabNote;
      }];

      NSArray* notes3 = [specs oct_map:^VFTabNote*(NSDictionary* tab_struct) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:tab_struct];
        return tabNote;
      }];

      [notes[0] addModifier:[newArticulation(@"a>") setPosition:3] atIndex:0];   // U
      [notes[1] addModifier:[newArticulation(@"a>") setPosition:4] atIndex:0];   // D
      [notes[2] addModifier:[newArticulation(@"a.") setPosition:3] atIndex:0];   // U
      [notes[3] addModifier:[newArticulation(@"a.") setPosition:4] atIndex:0];   // D

      [notes2[0] addModifier:[newArticulation(@"a>") setPosition:3] atIndex:0];
      [notes2[1] addModifier:[newArticulation(@"a>") setPosition:4] atIndex:0];
      [notes2[2] addModifier:[newArticulation(@"a.") setPosition:3] atIndex:0];
      [notes2[3] addModifier:[newArticulation(@"a.") setPosition:4] atIndex:0];

      [notes3[0] addModifier:[newArticulation(@"a>") setPosition:3] atIndex:0];
      [notes3[1] addModifier:[newArticulation(@"a>") setPosition:4] atIndex:0];
      [notes3[2] addModifier:[newArticulation(@"a.") setPosition:3] atIndex:0];
      [notes3[3] addModifier:[newArticulation(@"a.") setPosition:4] atIndex:0];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];
      [voice addTickables:notes2];
      [voice addTickables:notes3];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"TabNotes successfully drawn");
    };
}

@end
