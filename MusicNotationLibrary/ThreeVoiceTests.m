///
//  ThreeVoiceTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "ThreeVoiceTests.h"
#import "VexFlowTestHelpers.h"

@implementation ThreeVoiceTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Three Voices - #1"  func:@selector(threevoices:)];
    [self runTest:@"Three Voices - #2 Complex"  func:@selector(threevoices2:)];
    [self runTest:@"Three Voices - #3"  func:@selector(threevoices3:)];
    [self runTest:@"Auto Adjust Rest Positions - Two Voices"
           
             func:@selector(autoresttwovoices:)
        ];
    [self runTest:@"Auto Adjust Rest Positions - Three Voices #1"
           
             func:@selector(autorestthreevoices:)
        ];
    [self runTest:@"Auto Adjust Rest Positions - Three Voices #2"
           
             func:@selector(autorestthreevoices2:)
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

- (void)threevoices:(TestCollectionItemView*)parent
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

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(50, 10, 500, 0)] addTrebleGlyph];

      [staff draw:ctx];

      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"h" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"h" }),
      ];
      [notes[0] addModifier:newFinger(@"0", VFPositionLeft) atIndex:0];

      NSArray* notes1 = @[
          newNote(
              @{ @"keys" : @[ @"d/5", @"a/4", @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5", @"a/4", @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5", @"a/4", @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5", @"a/4", @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
      ];
      [[[[notes1[0] addAccidental:newAcc(@"#") atIndex:2] addModifier:newFinger(@"0", VFPositionLeft) atIndex:0]
          addModifier:newFinger(@"2", VFPositionLeft)
              atIndex:1] addModifier:newFinger(@"4", VFPositionRight)
                             atIndex:2];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),

          newNote(
              @{ @"keys" : @[ @"f/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"a/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];
      [voice1 addTickables:notes1];
      [voice2 addTickables:notes2];
      NSArray* beams = [VFBeam applyAndGetBeams:voice direction:VFStemDirectionUp groups:nil];
      NSArray* beams1 = [VFBeam applyAndGetBeams:voice1 direction:VFStemDirectionDown groups:nil];
      NSArray* beams2 = [VFBeam applyAndGetBeams:voice2 direction:VFStemDirectionDown groups:nil];

      // Set option to position rests near the notes in each voice
      //      VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice1, voice2 ]] formatWith:@[ voice, voice1, voice2 ]
                                                                 withJustifyWidth:400];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      for(NSUInteger i = 0; i < beams.count; i++)
      {
          [beams[i] draw:ctx];
      }
      for(NSUInteger i = 0; i < beams1.count; i++)
      {
          [beams1[i] draw:ctx];
      }
      for(NSUInteger i = 0; i < beams2.count; i++)
      {
          [beams2[i] draw:ctx];
      }

      ok(YES, @"Three Voices - Test #1");

    };
}

- (void)threevoices2:(TestCollectionItemView*)parent
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

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(50, 10, 500, 0)] addTrebleGlyph];

      [staff draw:ctx];

      //        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(50, 10, 500, 0) addTrebleGlyph];

      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"a/4", @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"h" }),
      ];
      [[notes[0] addModifier:newFinger(@"2", VFPositionLeft) atIndex:0] addModifier:newFinger(@"0", VFPositionAbove)
                                                                            atIndex:1];
      //    addModifier(1, newFinger(@"0", VFPositionLeft).
      //    setOffsetY(-6));

      NSArray* notes1 = @[
          newNote(
              @{ @"keys" : @[ @"d/5", @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"b/4", @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/5", @"a/4", @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5", @"a/4", @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5", @"a/4", @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
      ];
      [[[notes1[0] addAccidental:newAcc(@"#") atIndex:1] addModifier:newFinger(@"0", VFPositionLeft) atIndex:0]
          addModifier:newFinger(@"4", VFPositionLeft)
              atIndex:1];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"b/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),

          newNote(
              @{ @"keys" : @[ @"f/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"a/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];
      [voice1 addTickables:notes1];
      [voice2 addTickables:notes2];
      NSArray* beams = [VFBeam applyAndGetBeams:voice direction:VFStemDirectionUp groups:nil];
      NSArray* beams1 = [VFBeam applyAndGetBeams:voice1 direction:VFStemDirectionDown groups:nil];
      NSArray* beams2 = [VFBeam applyAndGetBeams:voice2 direction:VFStemDirectionDown groups:nil];

      // Set option to position rests near the notes in each voice
      //      VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice1, voice2 ]] formatWith:@[ voice, voice1, voice2 ]
                                                                 withJustifyWidth:400];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      for(NSUInteger i = 0; i < beams.count; i++)
      {
          [beams[i] draw:ctx];
      }
      for(NSUInteger i = 0; i < beams1.count; i++)
      {
          [beams1[i] draw:ctx];
      }
      for(NSUInteger i = 0; i < beams2.count; i++)
      {
          [beams2[i] draw:ctx];
      }
      ok(YES, @"Three Voices - Test #2 Complex");
    };
}

- (void)threevoices3:(TestCollectionItemView*)parent
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

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(50, 10, 500, 0)] addTrebleGlyph];

      [staff draw:ctx];

      //        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(50, 10, 500, 0) addTrebleGlyph];

      [staff addTimeSignatureWithName:@"4/4"];
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"e/5", @"g/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/5", @"g/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"h" }),
      ];
      [[notes[0] addModifier:newFinger(@"0", VFPositionLeft) atIndex:0] addModifier:newFinger(@"0", VFPositionLeft)
                                                                            atIndex:1];

      NSArray* notes1 = @[
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8r" }),

          [newNote(
              @{ @"keys" : @[ @"a/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"qd" }) addDotToAll],
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
      ];
      [[notes1[0] addAccidental:newAcc(@"#") atIndex:0] addModifier:newFinger(@"1", VFPositionLeft) atIndex:1];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"b/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),

          newNote(
              @{ @"keys" : @[ @"a/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
      ];
      [notes2[0] addModifier:newFinger(@"3", VFPositionLeft) atIndex:0];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];
      [voice1 addTickables:notes1];
      [voice2 addTickables:notes2];

      // TODO: what is groups, inspect the following method carefully
      NSArray* beam = [VFBeam applyAndGetBeams:voice direction:VFStemDirectionUp groups:nil];
      NSArray* beam1 = [VFBeam applyAndGetBeams:voice1 direction:VFStemDirectionDown groups:nil];
      NSArray* beam2 = [VFBeam applyAndGetBeams:voice2 direction:VFStemDirectionDown groups:nil];

      // Set option to position rests near the notes in each voice
      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice1, voice2 ]] formatWith:@[ voice, voice1, voice2 ]
                                                                 withJustifyWidth:400];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];

      for(NSUInteger i = 0; i < beam.count; i++)
      {
          [beam[i] draw:ctx];
      }
      for(NSUInteger i = 0; i < beam1.count; i++)
      {
          [beam1[i] draw:ctx];
      }
      for(NSUInteger i = 0; i < beam2.count; i++)
      {
          [beam2[i] draw:ctx];
      }

      ok(YES, @"Three Voices - Test #3");

    };
}

- (void)autoresttwovoices:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    //    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    //    {
    //        return [VFAccidental accidentalWithType:type];
    //    };
    //    VFFretHandFinger* (^newFinger)(NSString*, VFPositionType) = ^VFFretHandFinger*(NSString* num, VFPositionType
    //    pos)
    //    {
    //        VFFretHandFinger* ret = [[VFFretHandFinger alloc] init];
    //        ret.position = pos;
    //        ret.finger = num;
    //        return ret;
    //    };
    NSDictionary* (^getNotes)(NSString*) = ^NSDictionary*(NSString* text)
    {
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8r" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),

            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8r" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),

            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8r" }),
            newNote(
                @{ @"keys" : @[ @"d/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),

            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"q" }),
        ];

        NSArray* notes1 = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),

            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"f/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),

            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"stem_direction" : @(1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(1),
                   @"duration" : @"16" }),

            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"duration" : @"q" }),
        ];

        NSArray* textNote = @[
            [[VFTextNote alloc] initWithDictionary:@{
                @"text" : text,
                @"line" : @(-1),
                @"duration" : @"w",
                @"smooth" : @(YES)
            }],
        ];

        return @{ @"notes" : notes, @"notes1" : notes1, @"textNote" : textNote };
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(900, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(50, 20, 400, 0)];

      [staff draw:ctx];

      NSDictionary* n = getNotes(@"Default Rest Positions");
      //        n[@@"textnote"][0]; //.setContext(c);
      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:n[@"notes"]];
      [voice1 addTickables:n[@"notes1"]];
      [voice2 addTickables:n[@"textNote"]];

      NSArray* beam = [VFBeam applyAndGetBeams:voice direction:VFStemDirectionUp groups:nil];
      NSArray* beam1 = [VFBeam applyAndGetBeams:voice1 direction:VFStemDirectionDown groups:nil];

      // Set option to position rests near the notes in each voice
      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice1, voice2 ]] formatWith:@[ voice, voice1, voice2 ]
                                                                 withJustifyWidth:350
                                                                       andOptions:@{
                                                                           @"align_rests" : @NO
                                                                       }];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      for(NSUInteger i = 0; i < beam.count; i++)
      {
          [beam[i] draw:ctx];
      }
      for(NSUInteger i = 0; i < beam1.count; i++)
      {
          [beam1[i] draw:ctx];
      }

      // Draw After rest adjustment
      staff = [VFStaff staffWithRect:CGRectMake(staff.width + staff.x, staff.y, 400, 0)];

      [staff draw:ctx];

      n = getNotes(@"Rests Repositioned To Avoid Collisions");
      //      n.textnote[0].setContext(c);
      voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:n[@"notes"]];
      [voice1 addTickables:n[@"notes1"]];
      [voice2 addTickables:n[@"textNote"]];
      beam = [VFBeam applyAndGetBeams:voice direction:VFStemDirectionUp groups:nil];
      beam1 = [VFBeam applyAndGetBeams:voice1 direction:VFStemDirectionDown groups:nil];

      // Set option to position rests near the notes in each voice
      [[[VFFormatter formatter] joinVoices:@[ voice, voice1, voice2 ]] formatWith:@[ voice, voice1, voice2 ]
                                                                 withJustifyWidth:350
                                                                       andOptions:@{
                                                                           @"align_rests" : @NO
                                                                       }];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      for(NSUInteger i = 0; i < beam.count; i++)
      {
          [beam[i] draw:ctx];
      }
      for(NSUInteger i = 0; i < beam1.count; i++)
      {
          [beam1[i] draw:ctx];
      }

      ok(YES, @"Auto Adjust Rests - Two Voices");
    };
}

- (void)autorestthreevoices:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    //    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    //    {
    //        return [VFAccidental accidentalWithType:type];
    //    };
    //    VFFretHandFinger* (^newFinger)(NSString*, VFPositionType) = ^VFFretHandFinger*(NSString* num, VFPositionType
    //    pos)
    //    {
    //        VFFretHandFinger* ret = [[VFFretHandFinger alloc] init];
    //        ret.position = pos;
    //        ret.finger = num;
    //        return ret;
    //    };
    NSDictionary* (^getNotes)(NSString*) = ^NSDictionary*(NSString* text)
    {
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"q" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"q" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"q" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"q" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"qr" }),
        ];

        NSArray* notes1 = @[
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
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
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"q" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"q" }),
        ];

        NSArray* notes2 = @[
            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"f/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"q" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"q" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"q" }),
            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"qr" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"q" }),
        ];

        NSArray* textNote = @[
            [[VFTextNote alloc] initWithDictionary:@{
                @"text" : text,
                @"duration" : @"w",
                @"line" : @(-1),
                @"smooth" : @(YES)
            }],
            [[VFTextNote alloc] initWithDictionary:@{
                @"text" : @"",
                @"duration" : @"w",
                @"line" : @(-1),
                @"smooth" : @(YES)
            }],
        ];

        return @{ @"notes" : notes, @"notes1" : notes1, @"notes2" : notes2, @"textNote" : textNote };
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(850, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(50, 20, 400, 0)] addTrebleGlyph];

      [staff draw:ctx];

      NSDictionary* n = getNotes(@"Default Rest Positions");
      //       n.textnote[0].setContext(c);
      //       n.textnote[1].setContext(c);
      VFVoice* voice = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(8),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      VFVoice* voice1 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(8),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      VFVoice* voice2 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(8),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      VFVoice* voice3 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(8),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      [voice addTickables:n[@"notes"]];
      [voice1 addTickables:n[@"notes1"]];
      [voice2 addTickables:n[@"notes2"]];
      [voice3 addTickables:n[@"textNote"]];

      // Set option to position rests near the notes in each voice

      //      VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice1, voice2, voice3 ]]
                formatWith:@[ voice, voice1, voice2, voice3 ]
          withJustifyWidth:350
                andOptions:@{
                    @"align_rests" : @NO
                }];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice3 draw:ctx dirtyRect:CGRectZero toStaff:staff];

      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(staff.width + staff.x, staff.y, 350, 0)];

      [staff2 draw:ctx];

      n = getNotes(@"Rests Repositioned To Avoid Collisions");
      //       n.textnote[0].setContext(c);
      //       n.textnote[1].setContext(c);
      voice = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(8),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      voice1 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(8),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      voice2 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(8),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      voice3 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(8),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      [voice addTickables:n[@"notes"]];
      [voice1 addTickables:n[@"notes1"]];
      [voice2 addTickables:n[@"notes2"]];
      [voice3 addTickables:n[@"textNote"]];

      // Set option to position rests near the notes in each voice
      //       Vex.Debug = YES;
      //      VFFormatter* formatter2 =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice1, voice2, voice3 ]]
                formatWith:@[ voice, voice1, voice2, voice3 ]
          withJustifyWidth:350
                andOptions:@{
                    @"align_rests" : @YES
                }];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff2];
      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff2];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff2];
      [voice3 draw:ctx dirtyRect:CGRectZero toStaff:staff2];

      ok(YES, @"Auto Adjust Rests - three Voices #1");

    };
}

- (void)autorestthreevoices2:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    //    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    //    {
    //        return [VFAccidental accidentalWithType:type];
    //    };
    //    VFFretHandFinger* (^newFinger)(NSString*, VFPositionType) = ^VFFretHandFinger*(NSString* num, VFPositionType
    //    pos)
    //    {
    //        VFFretHandFinger* ret = [[VFFretHandFinger alloc] init];
    //        ret.position = pos;
    //        ret.finger = num;
    //        return ret;
    //    };

    NSDictionary* (^getNotes)(NSString*) = ^NSDictionary*(NSString* text)
    {
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"16r" }),
        ];

        NSArray* notes1 = @[
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
        ];

        NSArray* notes2 = @[
            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"f/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"stem_direction" : @(-1),
                   @"duration" : @"16" }),
        ];

        VFTextNote* textNote = [[VFTextNote alloc] initWithDictionary:@{
            @"text" : text,
            @"duration" : @"h",
            @"line" : @(-1),
            @"smooth" : @(YES)
        }];

        return @{ @"notes" : notes, @"notes1" : notes1, @"notes2" : notes2, @"textnote" : textNote };
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(950, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(50, 20, 450, 0)] addTrebleGlyph];
      [staff draw:ctx];

      NSDictionary* n = getNotes(@"Default Rest Positions");
      //       n.textnote[0].setContext(c);
      VFVoice* voice = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(2),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      VFVoice* voice1 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(2),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      VFVoice* voice2 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(2),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      VFVoice* voice3 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(2),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      [voice addTickables:n[@"notes"]];
      [voice1 addTickables:n[@"notes1"]];
      [voice2 addTickables:n[@"notes2"]];
      [voice3 addTickables:n[@"textNote"]];

      // Set option to position rests near the notes in each voice

      //             VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice1, voice2, voice3 ]]
                formatWith:@[ voice, voice1, voice2, voice3 ]
          withJustifyWidth:400
                andOptions:@{
                    @"align_rests" : @NO
                }];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice3 draw:ctx dirtyRect:CGRectZero toStaff:staff];

      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(staff.width + staff.x, staff.y, 425, 0)];
      [staff2 draw:ctx];

      n = getNotes(@"Rests Repositioned To Avoid Collisions");
      //             n.textnote[0].setContext(c);
      voice = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(2),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      voice1 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(2),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      voice2 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(2),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      voice3 = [[VFVoice alloc] initWithDictionary:@{
          @"num_beats" : @(2),
          @"beat_value" : @(4),
          @"resolution" : @(kRESOLUTION)
      }];
      [voice addTickables:n[@"notes"]];
      [voice1 addTickables:n[@"notes1"]];
      [voice2 addTickables:n[@"notes2"]];
      [voice3 addTickables:n[@"textNote"]];

      // Set option to position rests near the notes in each voice
      //             Vex.Debug = YES;
      //             VFFormatter *formatter2 =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice1, voice2, voice3 ]]
                formatWith:@[ voice, voice1, voice2, voice3 ]
          withJustifyWidth:400
                andOptions:@{
                    @"align_rests" : @YES
                }];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff2];
      [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff2];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff2];
      [voice3 draw:ctx dirtyRect:CGRectZero toStaff:staff2];

      ok(YES, @"Auto Adjust Rests - three Voices #2");
    };
}

@end
