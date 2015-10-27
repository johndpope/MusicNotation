//
//  GraceNoteTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "GraceNoteTests.h"
#import "VexFlowTestHelpers.h"
#import "NSArray+JSAdditions.h"

@implementation GraceNoteTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Grace Note Basic"  func:@selector(basic:)];
    [self runTest:@"Grace Note Basic with Slurs"  func:@selector(basicSlurred:)];
    [self runTest:@"Grace Notes Multiple Voices"  func:@selector(multipleVoices:)];
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

- (void)helperWithCtxWidth:(NSUInteger)ctxWidth staffWidth:(NSUInteger)staffWidth
{
    /*
    Vex.Flow.Test.GraceNote.helper = function(options, contextBuilder, ctxWidth, staffWidth){
        var ctx = contextBuilder(options.canvas_sel, ctxWidth, 130);
        ctx.scale(1.0, 1.0); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10,
    staffWidth) addClefWithName:@"treble") draw:ctx];
        return {
        ctx: ctx,
        staff: staff,
        newNote: function newNote(note_struct) {
            return [[VFStaffNote alloc]initWithDictionary:(note_struct);
        }
        };
    };
     */
}

- (void)basic:(TestCollectionItemView*)parent
{
    VFGraceNote* (^createNote)(NSDictionary*) = ^VFGraceNote*(NSDictionary* note_struct)
    {
        return [[VFGraceNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(700, 650) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 700, 0)];
      VFStaffNote* note0 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"b/4" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
      VFStaffNote* note1 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"c/5" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
      VFStaffNote* note2 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"c/5", @"d/5" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
      VFStaffNote* note3 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"a/4" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
      VFStaffNote* note4 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"a/4" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
//      VFStaffNote* note5 = [[VFStaffNote alloc] initWithDictionary:@{
//          @"keys" : @[ @"a/4" ],
//          @"duration" : @"4",
//          @"auto_stem" : @(YES)
//      }];

      [note1 addAccidental:newAcc(@"#") atIndex:0];

      NSArray* gracenote_group0 = @[
          @{ @"keys" : @[ @"e/4" ],
             @"duration" : @"32" },
          @{ @"keys" : @[ @"f/4" ],
             @"duration" : @"32" },
          @{ @"keys" : @[ @"g/4" ],
             @"duration" : @"32" },
          @{ @"keys" : @[ @"a/4" ],
             @"duration" : @"32" }
      ];

      NSArray* gracenote_group1 = @[ @{ @"keys" : @[ @"b/4" ], @"duration" : @"8", @"slash" : @(NO) } ];

      NSArray* gracenote_group2 = @[ @{ @"keys" : @[ @"b/4" ], @"duration" : @"8", @"slash" : @(YES) } ];

      NSArray* gracenote_group3 = @[
          @{ @"keys" : @[ @"e/4" ],
             @"duration" : @"8" },
          @{ @"keys" : @[ @"f/4" ],
             @"duration" : @"16" },
          @{ @"keys" : @[ @"g/4", @"e/4" ],
             @"duration" : @"8" },
          @{ @"keys" : @[ @"a/4" ],
             @"duration" : @"32" },
          @{ @"keys" : @[ @"b/4" ],
             @"duration" : @"32" }
      ];

      NSArray* gracenote_group4 = @[
          @{ @"keys" : @[ @"g/4" ],
             @"duration" : @"8" },
          @{ @"keys" : @[ @"g/4" ],
             @"duration" : @"16" },
          @{ @"keys" : @[ @"g/4" ],
             @"duration" : @"16" }
      ];

      NSArray* gracenotes = [gracenote_group0 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes1 = [gracenote_group1 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes2 = [gracenote_group2 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes3 = [gracenote_group3 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes4 = [gracenote_group4 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];

      [gracenotes[1] addAccidental:newAcc(@"##") atIndex:0];
      [gracenotes3[3] addAccidental:newAcc(@"bb") atIndex:0];

      [gracenotes4[0] addDotToAll];

      [note0 addModifier:[[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes] beamNotes]];
      [note1 addModifier:[[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes1] beamNotes]];
      [note2 addModifier:[[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes2] beamNotes]];
      [note3 addModifier:[[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes3] beamNotes]];
      [note4 addModifier:[[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes4] beamNotes]];

      [VFFormatter formatAndDrawWithContext:ctx
                                  dirtyRect:CGRectZero
                                    toStaff:staff
                                  withNotes:@[ note0, note1, note2, note3, note4 ]
                           withJustifyWidth:0];
      ok(YES, @"GraceNoteBasic");

    };
}

- (void)basicSlurred:(TestCollectionItemView*)parent
{
    VFGraceNote* (^createNote)(NSDictionary*) = ^VFGraceNote*(NSDictionary* note_struct)
    {
        return [[VFGraceNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(700, 650) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 700, 0)];
      VFStaffNote* note0 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"b/4" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
      VFStaffNote* note1 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"c/5" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
      VFStaffNote* note2 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"c/5", @"d/5" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
      VFStaffNote* note3 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"a/4" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
      VFStaffNote* note4 = [[VFStaffNote alloc] initWithDictionary:@{
          @"keys" : @[ @"a/4" ],
          @"duration" : @"4",
          @"auto_stem" : @(YES)
      }];
//      VFStaffNote* note5 = [[VFStaffNote alloc] initWithDictionary:@{
//          @"keys" : @[ @"a/4" ],
//          @"duration" : @"4",
//          @"auto_stem" : @(YES)
//      }];

      [note1 addAccidental:newAcc(@"#") atIndex:0];

      NSArray* gracenote_group0 = @[
          @{ @"keys" : @[ @"e/4" ],
             @"duration" : @"32" },
          @{ @"keys" : @[ @"f/4" ],
             @"duration" : @"32" },
          @{ @"keys" : @[ @"g/4" ],
             @"duration" : @"32" },
          @{ @"keys" : @[ @"a/4" ],
             @"duration" : @"32" }
      ];

      NSArray* gracenote_group1 = @[ @{ @"keys" : @[ @"b/4" ], @"duration" : @"8", @"slash" : @(NO) } ];

      NSArray* gracenote_group2 = @[ @{ @"keys" : @[ @"b/4" ], @"duration" : @"8", @"slash" : @(YES) } ];

      NSArray* gracenote_group3 = @[
          @{ @"keys" : @[ @"e/4" ],
             @"duration" : @"8" },
          @{ @"keys" : @[ @"f/4" ],
             @"duration" : @"16" },
          @{ @"keys" : @[ @"g/4", @"e/4" ],
             @"duration" : @"8" },
          @{ @"keys" : @[ @"a/4" ],
             @"duration" : @"32" },
          @{ @"keys" : @[ @"b/4" ],
             @"duration" : @"32" }
      ];

      NSArray* gracenote_group4 = @[
          @{ @"keys" : @[ @"a/4" ],
             @"duration" : @"8" },
          @{ @"keys" : @[ @"a/4" ],
             @"duration" : @"16" },
          @{ @"keys" : @[ @"a/4" ],
             @"duration" : @"16" }
      ];

      NSArray* gracenotes = [gracenote_group0 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes1 = [gracenote_group1 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes2 = [gracenote_group2 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes3 = [gracenote_group3 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes4 = [gracenote_group4 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];

      [gracenotes[1] addAccidental:newAcc(@"#") atIndex:0];
      [gracenotes3[3] addAccidental:newAcc(@"b") atIndex:0];
      [gracenotes3[2] addAccidental:newAcc(@"n") atIndex:0];
      [gracenotes4[0] addDotToAll];

      [note0 addModifier:[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes state:YES] atIndex:0];
      [note1 addModifier:[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes1 state:YES] atIndex:0];
      [note2 addModifier:[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes2 state:YES] atIndex:0];
      [note3 addModifier:[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes3 state:YES] atIndex:0];
      [note4 addModifier:[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes4 state:YES] atIndex:0];

        [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero
                                    toStaff:staff
                                  withNotes:@[ note0, note1, note2, note3, note4 ]
                           withJustifyWidth:0];

    };
}

- (void)multipleVoices:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFGraceNote* (^createNote)(NSDictionary*) = ^VFGraceNote*(NSDictionary* note_struct)
    {
        return [[VFGraceNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(450, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addTrebleGlyph];
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" })
      ];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" })
      ];

      NSArray* gracenote_group0 = @[ @{ @"keys" : @[ @"b/4" ], @"duration" : @"8", @"slash" : @(YES) } ];

      NSArray* gracenote_group1 = @[ @{ @"keys" : @[ @"f/4" ], @"duration" : @"8", @"slash" : @(YES) } ];

      NSArray* gracenote_group2 = @[
          @{ @"keys" : @[ @"f/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"e/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) }
      ];

      NSArray* gracenotes1 = [gracenote_group0 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes2 = [gracenote_group1 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];
      NSArray* gracenotes3 = [gracenote_group2 oct_map:^VFGraceNote*(NSDictionary* noteDict) {
        return createNote(noteDict);
      }];

      [gracenotes2[0] setStemDirection:-1];
      [gracenotes2[0] addAccidental:newAcc(@"#") atIndex:0];

      [notes[3] addModifier:[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes1] atIndex:0];
      [notes2[1] addModifier:[[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes2] beamNotes] atIndex:0];
      [notes2[5] addModifier:[[[VFGraceNoteGroup alloc] initWithGraceNoteGroups:gracenotes3] beamNotes] atIndex:0];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:NO];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:NO];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];

      [[[VFFormatter formatter] joinVoices:@[ voice, voice2 ]] formatToStaff:@[ voice, voice2 ] staff:staff];

      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];

      VFBeam* beam2_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam2_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      [beam2_1 draw:ctx];
      [beam2_2 draw:ctx];
      ok(YES, @"Sixteenth Test");

    };
}

@end
