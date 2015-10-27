//
//  StringNumberTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "StringNumberTests.h"
#import "VexFlowTestHelpers.h"
#import "NSArray+JSAdditions.h"

@implementation StringNumberTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"String Number In Notation"
           
             func:@selector(drawMultipleMeasures:)
        ];

    [self runTest:@"Fret Hand Finger In Notation"
           
             func:@selector(drawFretHandFingers:)
        ];

    [self runTest:@"Multi Voice With Strokes, String & Finger Numbers"
           
             func:@selector(multi:)
        ];
    [self runTest:@"Complex Measure With String & Finger Numbers"
           
             func:@selector(drawAccidentals:)
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

- (void)drawMultipleMeasures:(TestCollectionItemView*)parent
{
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };
    VFStringNumber* (^newStringNumber)(NSString*, VFPositionType) = ^VFStringNumber*(NSString* nums, VFPositionType pos)
    {
        VFStringNumber* ret = [[VFStringNumber alloc] initWithString:nums];
        ret.position = pos;
        return ret;
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(750, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;

      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 50, 290, 0)];
      [staffBar1 setEndBarType:VFBarLineDouble];
      [[staffBar1 addClefWithName:@"treble"] draw:ctx];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }] addDotToAll],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5", @"e/5", @"g/5" ],
              @"stem_direction" : @(-1),
              @"duration" : @"8"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"f/4", @"g/4" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"f/4", @"g/4" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }],
      ];

      [[[notesBar1[0] addModifier:newStringNumber(@"5", VFPositionRight) atIndex:0]
          addModifier:newStringNumber(@"4", VFPositionLeft)
              atIndex:1] addModifier:newStringNumber(@"3", VFPositionRight)
                             atIndex:2];

      [[[[notesBar1[1] addAccidental:newAcc(@"#") atIndex:0] addModifier:newStringNumber(@"5", VFPositionBelow)
                                                                 atIndex:0] addAccidental:[newAcc(@"#") setAsCautionary]
                                                                                  atIndex:1]
          addModifier:[[newStringNumber(@"3", VFPositionAbove) setLastNote:notesBar1[3]] setLineEndType:VFLineEndDown]
              atIndex:2];

      [[[notesBar1[2] addModifier:newStringNumber(@"5", VFPositionLeft) atIndex:0]
          addModifier:newStringNumber(@"3", VFPositionLeft)
              atIndex:2] addAccidental:newAcc(@"#")
                               atIndex:1];

      [[[notesBar1[3]

          // Position string 5 below default
          addModifier:[newStringNumber(@"5", VFPositionRight) setOffsetY:7]
              atIndex:0]

          // Position string 4 below default
          addModifier:[newStringNumber(@"4", VFPositionRight) setOffsetY:6]
              atIndex:1]

          // Position string 3 above default
          addModifier:[newStringNumber(@"3", VFPositionRight) setOffsetY:-6]
              atIndex:2];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

      // bar 2 - juxtaposing second bar next to first bar
      VFStaff* staffBar2 = [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 300, 0)];
      [staffBar2 setEndBarType:VFBarLineDouble];
      [staffBar2 draw:ctx];

      NSArray* notesBar2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
              @"stem_direction" : @(1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5", @"e/5", @"g/5" ],
              @"stem_direction" : @(1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"f/4", @"g/4" ],
              @"stem_direction" : @(1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"f/4", @"g/4" ],
              @"stem_direction" : @(1),
              @"duration" : @"q"
          }],
      ];

      [[[notesBar2[0] addModifier:newStringNumber(@"5", VFPositionRight) atIndex:0]
          addModifier:newStringNumber(@"4", VFPositionLeft)
              atIndex:1] addModifier:newStringNumber(@"3", VFPositionRight)
                             atIndex:2];

      [[[[notesBar2[1] addAccidental:newAcc(@"#") atIndex:0] addModifier:newStringNumber(@"5", VFPositionBelow)
                                                                 atIndex:0] addAccidental:newAcc(@"#")
                                                                                  atIndex:1]
          addModifier:[[newStringNumber(@"3", VFPositionAbove) setLastNote:notesBar2[3]] setDashed:NO]
              atIndex:2];

      [[notesBar2[2] addModifier:newStringNumber(@"3", VFPositionLeft) atIndex:2] addAccidental:newAcc(@"#") atIndex:1];

      [[[notesBar2[3]

          // Position string 5 below default
          addModifier:[newStringNumber(@"5", VFPositionRight) setOffsetY:7]
              atIndex:0]

          // Position string 4 below default
          addModifier:[newStringNumber(@"4", VFPositionRight) setOffsetY:6]
              atIndex:1]

          // Position string 5 above default
          addModifier:[newStringNumber(@"3", VFPositionRight) setOffsetY:-6]
              atIndex:2];

      // Helper function to justify and draw a 4/4 voice
      //        Vex.Flow.Formatter.FormatAndDraw(ctx, staffBar2, notesBar2);
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];

      // bar 3 - juxtaposing third bar next to second bar
      VFStaff* staffBar3 = [VFStaff staffWithRect:CGRectMake(staffBar2.width + staffBar2.x, staffBar2.y, 150, 0)];
      [staffBar3 setEndBarType:VFBarLineEnd];
      [staffBar3 draw:ctx];

      NSArray* notesBar3 = @[
          [[[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4", @"a/4" ],
              @"duration" : @"w"
          }] addDotToAll],
      ];

      [[[[notesBar3[0] addModifier:newStringNumber(@"5", VFPositionBelow) atIndex:0]
          addModifier:newStringNumber(@"4", VFPositionRight)
              atIndex:1] addModifier:newStringNumber(@"3", VFPositionLeft)
                             atIndex:2] addModifier:newStringNumber(@"2", VFPositionAbove)
                                            atIndex:3];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar3 withNotes:notesBar3];

      ok(YES, @"String Number");
    };
}

- (void)drawFretHandFingers:(TestCollectionItemView*)parent
{
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };
    VFFretHandFinger* (^newFinger)(NSString*, VFPositionType) = ^VFFretHandFinger*(NSString* num, VFPositionType pos)
    {
        VFFretHandFinger* ret = [[VFFretHandFinger alloc] init];
        ret.position = pos;
        ret.finger = num;
        return ret;
    };
    VFStringNumber* (^newStringNumber)(NSString*, VFPositionType) = ^VFStringNumber*(NSString* nums, VFPositionType pos)
    {
        VFStringNumber* ret = [[VFStringNumber alloc] initWithString:nums];
        ret.position = pos;
        return ret;
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;

      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 50, 290, 0)];
      [staffBar1 setEndBarType:VFBarLineDouble];
      [[staffBar1 addClefWithName:@"treble"] draw:ctx];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5", @"e/5", @"g/5" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"f/4", @"g/4" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"f/4", @"g/4" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }],
      ];

      [[[notesBar1[0] addModifier:newFinger(@"3", VFPositionLeft) atIndex:0] addModifier:newFinger(@"2", VFPositionLeft)
                                                                                 atIndex:1]
          addModifier:newFinger(@"0", VFPositionLeft)
              atIndex:2];

      [[[[[notesBar1[1] addAccidental:newAcc(@"#") atIndex:0] addModifier:newFinger(@"3", VFPositionLeft) atIndex:0]
          addModifier:newFinger(@"2", VFPositionLeft)
              atIndex:1] addAccidental:newAcc(@"#")
                               atIndex:1] addModifier:newFinger(@"0", VFPositionLeft)
                                              atIndex:2];

      [[[[[notesBar1[2] addModifier:newFinger(@"3", VFPositionBelow) atIndex:0]
          addModifier:newFinger(@"4", VFPositionLeft)
              atIndex:1] addModifier:newStringNumber(@"4", VFPositionLeft)
                             atIndex:1] addModifier:newFinger(@"0", VFPositionAbove)
                                            atIndex:2] addAccidental:newAcc(@"#")
                                                             atIndex:1];

      [[[[[[notesBar1[3] addModifier:newFinger(@"3", VFPositionRight) atIndex:0]
          // Position string 5 below default
          addModifier:[newStringNumber(@"5", VFPositionRight) setOffsetY:7]
              atIndex:0] addModifier:newFinger(@"4", VFPositionRight)
                             atIndex:1]
          // Position String 4 below default
          addModifier:[newStringNumber(@"4", VFPositionRight) setOffsetY:6]
              atIndex:1]
          // Position finger 0 above default
          addModifier:[newFinger(@"0", VFPositionRight) setOffsetY:-5]
              atIndex:2]
          // Position string 3 above default
          addModifier:[newStringNumber(@"3", VFPositionRight) setOffsetY:-6]
              atIndex:2];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

      // bar 2 - juxtaposing second bar next to first bar
      VFStaff* staffBar2 = [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 300, 0)];
      [staffBar2 setEndBarType:VFBarLineEnd];
      [staffBar2 draw:ctx];

      NSArray* notesBar2 = @[
          [[[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
              @"stem_direction" : @(1),
              @"duration" : @"q"
          }] addDotToAll],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/5", @"e/5", @"g/5" ],
              @"stem_direction" : @(1),
              @"duration" : @"8"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"f/4", @"g/4" ],
              @"stem_direction" : @(1),
              @"duration" : @"8"
          }],
          [[[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"f/4", @"g/4" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }] addDotToAll],
      ];

      [[[[notesBar2[0] addModifier:newFinger(@"3", VFPositionRight) atIndex:0]
          addModifier:newFinger(@"2", VFPositionLeft)
              atIndex:1] addModifier:newStringNumber(@"4", VFPositionRight)
                             atIndex:1] addModifier:newFinger(@"0", VFPositionAbove)
                                            atIndex:2];

      [[[[[notesBar2[1] addAccidental:newAcc(@"#") atIndex:0] addModifier:newFinger(@"3", VFPositionRight) atIndex:0]
          addModifier:newFinger(@"2", VFPositionLeft)
              atIndex:1] addAccidental:newAcc(@"#")
                               atIndex:1] addModifier:newFinger(@"0", VFPositionLeft)
                                              atIndex:2];

      [[[[[notesBar2[2] addModifier:newFinger(@"3", VFPositionBelow) atIndex:0]
          addModifier:newFinger(@"2", VFPositionLeft)
              atIndex:1] addModifier:newStringNumber(@"4", VFPositionLeft)
                             atIndex:1]
          //  addModifier(2, newFinger(@"1", VFPositionAbove)).
          addModifier:newFinger(@"1", VFPositionRight)
              atIndex:2] addAccidental:newAcc(@"#")
                               atIndex:2];

      [[[[[[notesBar2[3] addModifier:newFinger(@"3", VFPositionRight) atIndex:0]
          // position string 5 below default
          addModifier:[newStringNumber(@"5", VFPositionRight) setOffsetY:7]
              atIndex:0]
          // position finger 4 below default
          addModifier:newFinger(@"4", VFPositionRight)
              atIndex:1]
          // position string 4 below default
          addModifier:[newStringNumber(@"4", VFPositionRight) setOffsetY:6]
              atIndex:1]
          // position finger 1 above default
          addModifier:[newFinger(@"1", VFPositionRight) setOffsetY:-6]
              atIndex:2]
          // position string 3 above default
          addModifier:[newStringNumber(@"3", VFPositionRight) setOffsetY:-6]
              atIndex:2];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];

      ok(YES, @"String Number");
    };
}

- (void)multi:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };
    VFFretHandFinger* (^newFinger)(NSString*, VFPositionType) = ^VFFretHandFinger*(NSString* num, VFPositionType pos)
    {
        VFFretHandFinger* ret = [[VFFretHandFinger alloc] init];
        ret.position = pos;
        ret.finger = num;
        return ret;
    };
    VFStringNumber* (^newStringNumber)(NSString*, VFPositionType) = ^VFStringNumber*(NSString* nums, VFPositionType pos)
    {
        VFStringNumber* ret = [[VFStringNumber alloc] initWithString:nums];
        ret.position = pos;
        return ret;
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(50, 10, 500, 0)];

      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/4", @"a/3", @"g/4" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"c/4", @"d/4", @"a/4" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"c/4", @"d/4", @"a/4" ],
                 @"duration" : @"q" })
      ];
      // Create the strokes
      VFStroke* stroke1 = [VFStroke strokeWithType:5];
      VFStroke* stroke2 = [VFStroke strokeWithType:6];
      VFStroke* stroke3 = [VFStroke strokeWithType:2];
      VFStroke* stroke4 = [VFStroke strokeWithType:1];
      [notes[0] addStroke:stroke1 atIndex:0];
      [notes[0] addModifier:newFinger(@"3", VFPositionLeft) atIndex:0];
      [notes[0] addModifier:newFinger(@"2", VFPositionLeft) atIndex:1];
      [notes[0] addModifier:newFinger(@"0", VFPositionLeft) atIndex:2];
      [notes[0] addModifier:newStringNumber(@"4", VFPositionLeft) atIndex:1];
      [notes[0] addModifier:newStringNumber(@"3", VFPositionAbove) atIndex:2];

      [notes[1] addStroke:stroke2 atIndex:0];
      [notes[1] addModifier:newStringNumber(@"4", VFPositionRight) atIndex:1];
      [notes[1] addModifier:newStringNumber(@"3", VFPositionAbove) atIndex:1];
      [notes[1] addAccidental:newAcc(@"#") atIndex:0];
      [notes[1] addAccidental:newAcc(@"#") atIndex:1];
      [notes[1] addAccidental:newAcc(@"#") atIndex:2];

      [notes[2] addStroke:stroke3 atIndex:0];
      [notes[2] addModifier:newFinger(@"3", VFPositionLeft) atIndex:0];
      [notes[2] addModifier:newFinger(@"0", VFPositionRight) atIndex:1];
      [notes[2] addModifier:newStringNumber(@"4", VFPositionRight) atIndex:1];
      [notes[2] addModifier:newFinger(@"1", VFPositionLeft) atIndex:2];
      [notes[2] addModifier:newStringNumber(@"3", VFPositionRight) atIndex:2];

      [notes[3] addStroke:stroke4 atIndex:0];
      [notes[3] addModifier:newStringNumber(@"3", VFPositionLeft) atIndex:2];
      [notes[3] addModifier:newStringNumber(@"4", VFPositionRight) atIndex:1];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" })
      ];

      [notes2[0] addModifier:newFinger(@"0", VFPositionLeft) atIndex:0];
      [notes2[0] addModifier:newStringNumber(@"6", VFPositionBelow) atIndex:0];
      [notes2[2] addAccidental:newAcc(@"#") atIndex:0];
      [notes2[4] addModifier:newFinger(@"0", VFPositionLeft) atIndex:0];
      // Position string number 6 beneath the strum arrow: left (15) and down (18)
      [notes2[4] addModifier:[[newStringNumber(@"6", VFPositionLeft) setOffsetX:15] setOffsetY:18] atIndex:0];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];

      //      VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice2 ]] formatWith:@[ voice, voice2 ] withJustifyWidth:400];

      VFBeam* beam2_1 = [VFBeam beamWithNotes:[notes2 slice:[@0:4]]];
      VFBeam* beam2_2 = [VFBeam beamWithNotes:[notes2 slice:[@4:8]]];

      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam2_1 draw:ctx];
      [beam2_2 draw:ctx];
      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"Strokes Test Multi Voice");
    };
}

- (void)drawAccidentals:(TestCollectionItemView*)parent
{
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };
    VFFretHandFinger* (^newFinger)(NSString*, VFPositionType) = ^VFFretHandFinger*(NSString* num, VFPositionType pos)
    {
        VFFretHandFinger* ret = [[VFFretHandFinger alloc] init];
        ret.position = pos;
        ret.finger = num;
        return ret;
    };
    VFStringNumber* (^newStringNumber)(NSString*, VFPositionType) = ^VFStringNumber*(NSString* nums, VFPositionType pos)
    {
        VFStringNumber* ret = [[VFStringNumber alloc] initWithString:nums];
        ret.position = pos;
        return ret;
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;

      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 50, 475, 0)];
      [staffBar1 setEndBarType:VFBarLineDouble];
      [[staffBar1 addClefWithName:@"treble"] draw:ctx];
      [staffBar1 draw:ctx];
      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4", @"c/5", @"e/5", @"g/5" ],
              @"stem_direction" : @(1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4", @"d/5", @"e/5", @"g/5" ],
              @"stem_direction" : @(1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4", @"d/5", @"e/5", @"g/5" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4", @"d/5", @"e/5", @"g/5" ],
              @"stem_direction" : @(-1),
              @"duration" : @"q"
          }],
      ];

      [[[[[[[[[
          [[[[[notesBar1[0] addModifier:newFinger(@"3", VFPositionLeft) atIndex:0] addAccidental:newAcc(@"#") atIndex:0]
              addModifier:newFinger(@"2", VFPositionLeft)
                  atIndex:1] addModifier:newStringNumber(@"2", VFPositionLeft)
                                 atIndex:1] addAccidental:newAcc(@"#")
                                                  atIndex:1] addModifier:newFinger(@"0", VFPositionLeft)
                                                                 atIndex:2] addAccidental:newAcc(@"#")
                                                                                  atIndex:2]
          addModifier:newFinger(@"3", VFPositionLeft)
              atIndex:3] addAccidental:newAcc(@"#")
                               atIndex:3] addModifier:newFinger(@"2", VFPositionRight)
                                              atIndex:4] addModifier:newStringNumber(@"3", VFPositionRight)
                                                             atIndex:4] addAccidental:newAcc(@"#")
                                                                              atIndex:4]
          addModifier:newFinger(@"0", VFPositionLeft)
              atIndex:5] addAccidental:newAcc(@"#")
                               atIndex:5];

      [[[[[[notesBar1[1] addAccidental:newAcc(@"#") atIndex:0] addAccidental:newAcc(@"#") atIndex:1]
          addAccidental:newAcc(@"#")
                atIndex:2] addAccidental:newAcc(@"#")
                                 atIndex:3] addAccidental:newAcc(@"#")
                                                  atIndex:4] addAccidental:newAcc(@"#")
                                                                   atIndex:5];

      [[[[[[[[[
          [[[[[notesBar1[2] addModifier:newFinger(@"3", VFPositionLeft) atIndex:0] addAccidental:newAcc(@"#") atIndex:0]
              addModifier:newFinger(@"2", VFPositionLeft)
                  atIndex:1] addModifier:newStringNumber(@"2", VFPositionLeft)
                                 atIndex:1] addAccidental:newAcc(@"#")
                                                  atIndex:1] addModifier:newFinger(@"0", VFPositionLeft)
                                                                 atIndex:2] addAccidental:newAcc(@"#")
                                                                                  atIndex:2]
          addModifier:newFinger(@"3", VFPositionLeft)
              atIndex:3] addAccidental:newAcc(@"#")
                               atIndex:3] addModifier:newFinger(@"2", VFPositionRight)
                                              atIndex:4] addModifier:newStringNumber(@"3", VFPositionRight)
                                                             atIndex:4] addAccidental:newAcc(@"#")
                                                                              atIndex:4]
          addModifier:newFinger(@"0", VFPositionLeft)
              atIndex:5] addAccidental:newAcc(@"#")
                               atIndex:5];

      [[[[[[notesBar1[3] addAccidental:newAcc(@"#") atIndex:0] addAccidental:newAcc(@"#") atIndex:1]
          addAccidental:newAcc(@"#")
                atIndex:2] addAccidental:newAcc(@"#")
                                 atIndex:3] addAccidental:newAcc(@"#")
                                                  atIndex:4] addAccidental:newAcc(@"#")
                                                                   atIndex:5];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

      ok(YES, @"String Number");
    };
}

@end
