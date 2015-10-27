//
//  OrnamentTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "OrnamentTests.h"
#import "VexFlowTestHelpers.h"

@implementation OrnamentTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Ornaments"  func:@selector(drawOrnaments:withTitle:)];

    [self runTest:@"Ornaments Vertically Shifted"
           
             func:@selector(drawOrnamentDisplaced:withTitle:)
        ];

    [self runTest:@"Ornaments - Delayed turns"
           
             func:@selector(drawOrnamentsDelayed:withTitle:)
        ];
    [self runTest:@"Stacked"  func:@selector(drawOrnamentsStacked:withTitle:)];
    [self runTest:@"With Upper/Lower Accidentals"
           
             func:@selector(drawOrnamentWithAccidentals:withTitle:)
        ];
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

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h) withParent:parent withTitle:title];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

- (void)drawOrnaments:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(750, 195) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 700, 0)];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }]
      ];
      [notesBar1[0] addModifier:[VFOrnament ornamentWithType:@"mordent"] atIndex:0];
      [notesBar1[1] addModifier:[VFOrnament ornamentWithType:@"mordent_inverted"] atIndex:0];
      [notesBar1[2] addModifier:[VFOrnament ornamentWithType:@"turn"] atIndex:0];
      [notesBar1[3] addModifier:[VFOrnament ornamentWithType:@"turn_inverted"] atIndex:0];
      [notesBar1[4] addModifier:[VFOrnament ornamentWithType:@"tr"] atIndex:0];
      [notesBar1[5] addModifier:[VFOrnament ornamentWithType:@"upprall"] atIndex:0];
      [notesBar1[6] addModifier:[VFOrnament ornamentWithType:@"downprall"] atIndex:0];
      [notesBar1[7] addModifier:[VFOrnament ornamentWithType:@"prallup"] atIndex:0];
      [notesBar1[8] addModifier:[VFOrnament ornamentWithType:@"pralldown"] atIndex:0];
      [notesBar1[9] addModifier:[VFOrnament ornamentWithType:@"upmordent"] atIndex:0];
      [notesBar1[10] addModifier:[VFOrnament ornamentWithType:@"downmordent"] atIndex:0];
      [notesBar1[11] addModifier:[VFOrnament ornamentWithType:@"lineprall"] atIndex:0];
      [notesBar1[12] addModifier:[VFOrnament ornamentWithType:@"prallprall"] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

    };
}
- (void)drawOrnamentDisplaced:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(750, 195) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 700, 0)];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"4",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"4",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"4",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"4",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"4",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"4",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/5" ],
              @"duration" : @"4",
              @"stem_direction" : @(-1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }]
      ];
      [notesBar1[0] addModifier:[VFOrnament ornamentWithType:@"mordent"] atIndex:0];
      [notesBar1[1] addModifier:[VFOrnament ornamentWithType:@"mordent_inverted"] atIndex:0];
      [notesBar1[2] addModifier:[VFOrnament ornamentWithType:@"turn"] atIndex:0];
      [notesBar1[3] addModifier:[VFOrnament ornamentWithType:@"turn_inverted"] atIndex:0];
      [notesBar1[4] addModifier:[VFOrnament ornamentWithType:@"tr"] atIndex:0];
      [notesBar1[5] addModifier:[VFOrnament ornamentWithType:@"upprall"] atIndex:0];
      [notesBar1[6] addModifier:[VFOrnament ornamentWithType:@"downprall"] atIndex:0];
      [notesBar1[7] addModifier:[VFOrnament ornamentWithType:@"prallup"] atIndex:0];
      [notesBar1[8] addModifier:[VFOrnament ornamentWithType:@"pralldown"] atIndex:0];
      [notesBar1[9] addModifier:[VFOrnament ornamentWithType:@"upmordent"] atIndex:0];
      [notesBar1[10] addModifier:[VFOrnament ornamentWithType:@"downmordent"] atIndex:0];
      [notesBar1[11] addModifier:[VFOrnament ornamentWithType:@"lineprall"] atIndex:0];
      [notesBar1[12] addModifier:[VFOrnament ornamentWithType:@"prallprall"] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];
    };
}

- (void)drawOrnamentsDelayed:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(550, 195) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 500, 0)];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }]
      ];

      [notesBar1[0] addModifier:[[VFOrnament ornamentWithType:@"turn"] setDelayed:YES] atIndex:0];
      [notesBar1[1] addModifier:[[VFOrnament ornamentWithType:@"turn_inverted"] setDelayed:YES] atIndex:0];
      [notesBar1[2] addModifier:[[VFOrnament ornamentWithType:@"turn_inverted"] setDelayed:YES] atIndex:0];
      [notesBar1[3] addModifier:[[VFOrnament ornamentWithType:@"turn"] setDelayed:YES] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];
    };
}

- (void)drawOrnamentsStacked:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(550, 195) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 30, 500, 0)];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }]
      ];
      [notesBar1[0] addModifier:[VFOrnament ornamentWithType:@"mordent"] atIndex:0];
      [notesBar1[1] addModifier:[VFOrnament ornamentWithType:@"turn_inverted"] atIndex:0];
      [notesBar1[2] addModifier:[VFOrnament ornamentWithType:@"turn"] atIndex:0];
      [notesBar1[3] addModifier:[VFOrnament ornamentWithType:@"turn_inverted"] atIndex:0];

      [notesBar1[0] addModifier:[VFOrnament ornamentWithType:@"turn"] atIndex:0];
      [notesBar1[1] addModifier:[VFOrnament ornamentWithType:@"prallup"] atIndex:0];
      [notesBar1[2] addModifier:[VFOrnament ornamentWithType:@"upmordent"] atIndex:0];
      [notesBar1[3] addModifier:[VFOrnament ornamentWithType:@"lineprall"] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];
    };
}

- (void)drawOrnamentWithAccidentals:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(650, 250) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 60, 600, 0)];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"f/4" ],
              @"duration" : @"4",
              @"stem_direction" : @(1)
          }]
      ];

      [notesBar1[0]
          addModifier:[[[VFOrnament ornamentWithType:@"mordent"] setUpperAccidental:@"#"] setLowerAccidental:@"#"]
              atIndex:0];
      [notesBar1[1]
          addModifier:[[[VFOrnament ornamentWithType:@"turn_inverted"] setLowerAccidental:@"b"] setUpperAccidental:@"b"]
              atIndex:0];
      [notesBar1[2]
          addModifier:[[[VFOrnament ornamentWithType:@"turn"] setUpperAccidental:@"##"] setLowerAccidental:@"##"]
              atIndex:0];
      [notesBar1[3] addModifier:[[[VFOrnament ornamentWithType:@"mordent_inverted"] setLowerAccidental:@"db"]
                                    setUpperAccidental:@"db"]
                        atIndex:0];
      [notesBar1[4] addModifier:[[[VFOrnament ornamentWithType:@"turn_inverted"] setUpperAccidental:@"++"]
                                    setLowerAccidental:@"++"]
                        atIndex:0];
      [notesBar1[5] addModifier:[[[VFOrnament ornamentWithType:@"tr"] setUpperAccidental:@"n"] setLowerAccidental:@"n"]
                        atIndex:0];
      [notesBar1[6]
          addModifier:[[[VFOrnament ornamentWithType:@"prallup"] setUpperAccidental:@"d"] setLowerAccidental:@"d"]
              atIndex:0];
      [notesBar1[7]
          addModifier:[[[VFOrnament ornamentWithType:@"lineprall"] setUpperAccidental:@"db"] setLowerAccidental:@"db"]
              atIndex:0];
      [notesBar1[8]
          addModifier:[[[VFOrnament ornamentWithType:@"upmordent"] setUpperAccidental:@"bbs"] setLowerAccidental:@"bbs"]
              atIndex:0];
      [notesBar1[9]
          addModifier:[[[VFOrnament ornamentWithType:@"prallprall"] setUpperAccidental:@"bb"] setLowerAccidental:@"bb"]
              atIndex:0];
      [notesBar1[10]
          addModifier:[[[VFOrnament ornamentWithType:@"turn_inverted"] setUpperAccidental:@"+"] setLowerAccidental:@"+"]
              atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];
    };
}

@end
