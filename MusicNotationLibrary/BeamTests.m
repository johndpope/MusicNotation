//
//  BeamTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "BeamTests.h"
#import "VexFlowTestHelpers.h"
#import "NSArray+JSAdditions.h"

@implementation BeamTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple Beam"  func:@selector(simple:)];
    [self runTest:@"Multi Beam"  func:@selector(multi:)];
    [self runTest:@"Sixteenth Beam"  func:@selector(sixteenth:)];
    [self runTest:@"Slopey Beam"  func:@selector(slopey:)];
    [self runTest:@"Auto-stemmed Beam"  func:@selector(autoStem:)];
    [self runTest:@"Mixed Beam 1"  func:@selector(mixed:)];
    [self runTest:@"Mixed Beam 2"  func:@selector(mixed2:)];
    [self runTest:@"Dotted Beam"  func:@selector(dotted:)];
    [self runTest:@"Close Trade-offs Beam"  func:@selector(tradeoffs:)];
    [self runTest:@"Insane Beam"  func:@selector(insane:)];
    [self runTest:@"Lengthy Beam"  func:@selector(lengthy:)];
    [self runTest:@"Outlier Beam"  func:@selector(outlier:)];
    [self runTest:@"Break Secondary Beams"  func:@selector(breakSecondaryBeams:)];
    [self runTest:@"TabNote Beams Up"  func:@selector(tabBeamsUp:)];
    [self runTest:@"TabNote Beams Down"  func:@selector(tabBeamsDown:)];
    [self runTest:@"TabNote Auto Create Beams"  func:@selector(autoTabBeams:)];
    [self runTest:@"TabNote Beams Auto Stem"  func:@selector(tabBeamsAutoStem:)];
    [self runTest:@"Complex Beams with Annotations"
           
             func:@selector(complexWithAnnotation:)
        ];
    [self runTest:@"Complex Beams with Articulations"
           
             func:@selector(complexWithArticulation:)
        ];
}




- (ViewStaffStruct*)setupContextWithSize:(VFUIntSize*)size withParent:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Beam.setupContext = function(options, x, y) {
        var ctx = new options.contextBuilder(options.canvas_sel, x || 450, y || 140);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.font = " 10pt Arial";
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, x || 450) addTrebleGlyph] draw:ctx]

        return {context: ctx, staff: staff};
    }
     */
    NSUInteger w = size.width;
    NSUInteger h = size.height;

    w = w != 0 ? w : 450;
    h = h != 0 ? h : 140;

    [VFFont setFont:@" 10pt Arial"];

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h) withParent:parent];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

- (void)beamNotes:(NSArray*)notes staff:(VFStaff*)staff context:(CGContextRef)ctx dirtyRect:(CGRect)dirtyRect
{
    /*
     Vex.Flow.Test.Beam.beamNotes = function(notes, staff, ctx) {
     VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
     [voice addTickables:notes];

     VFFormatter *formatter = [[[VFFormatter formatter] joinVoices:@[voice]
     formatWith:@[voice] withJustifyWidth:300];
     VFBeam *beam = [VFBeam beamWithNotes:[notes slice:[@(1) : notes.count]]];

     [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
     beam draw:ctx];
     }
     */

    VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
    [voice addTickables:notes];
    [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];
    VFBeam* beam = [VFBeam beamWithNotes:[notes slice:[@1:notes.count]]];
    [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
    [beam draw:ctx];
}

- (void)simple:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      [self beamNotes:@[
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
                 @"stem_direction" : @1,
                 @"duration" : @"h" }) addAccidental:newAcc(@"b")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
                 @"stem_direction" : @1,
                 @"duration" : @"8" }) addAccidental:newAcc(@"b")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],
          newNote(
              @{ @"keys" : @[ @"d/4", @"f/4", @"a/4" ],
                 @"stem_direction" : @1,
                 @"duration" : @"8" }),
          [[newNote(
              @{ @"keys" : @[ @"e/4", @"g/4", @"b/4" ],
                 @"stem_direction" : @1,
                 @"duration" : @"8" }) addAccidental:newAcc(@"bb")
                                             atIndex:0] addAccidental:newAcc(@"##")
                                                              atIndex:1],
          newNote(
              @{ @"keys" : @[ @"f/4", @"a/4", @"c/5" ],
                 @"stem_direction" : @1,
                 @"duration" : @"8" }),
      ] staff:c.staff
                   context:ctx dirtyRect:CGRectZero];
      ok(YES, @"Simple Test");
    };
}

- (void)multi:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice2 ]] formatWith:@[ voice, voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];

      VFBeam* beam2_1 = [VFBeam beamWithNotes:[notes2 slice:[@0:4]]];
      VFBeam* beam2_2 = [VFBeam beamWithNotes:[notes2 slice:[@4:8]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      [beam2_1 draw:ctx];
      [beam2_2 draw:ctx];

      ok(YES, @"Multi Test");
    };
}

- (void)sixteenth:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

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
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"h" })
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
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"h" })
      ];
      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];

      //      VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice2 ]] formatWith:@[ voice, voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];

      VFBeam* beam2_1 = [VFBeam beamWithNotes:[notes2 slice:[@0:4]]];
      VFBeam* beam2_2 = [VFBeam beamWithNotes:[notes2 slice:[@4:8]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      [beam2_1 draw:ctx];
      [beam2_2 draw:ctx];

      ok(YES, @"Sixteenth Test");
    };
}

- (void)breakSecondaryBeams:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(600, 0) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

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
              @{ @"keys" : @[ @"c/5" ],
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
                 @"duration" : @"16" })
      ];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:NO];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice2 setStrict:NO];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice, voice ] withJustifyWidth:500];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:6]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@6:12]]];

      [beam1_1 breakSecondaryAt:@[ @1, @3 ]];
      [beam1_2 breakSecondaryAt:@[ @2 ]];

      VFBeam* beam2_1 = [VFBeam beamWithNotes:[notes2 slice:[@0:12]]];
      VFBeam* beam2_2 = [VFBeam beamWithNotes:[notes2 slice:[@12:18]]];

      [beam2_1 breakSecondaryAt:@[ @3, @7, @11 ]];
      [beam2_2 breakSecondaryAt:@[ @3 ]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      [beam2_1 draw:ctx];
      [beam2_2 draw:ctx];

      ok(YES, @"Breaking Secondary Beams Test");
    };
}

- (void)slopey:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
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
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/3" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];

      //      VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      ok(YES, @"Slopey Test");
    };
}

- (void)autoStem:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
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

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"a/4" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:NO];
      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];

      VFBeam* beam1 = [VFBeam beamWithNotes:[notes slice:[@0:2]]];
      beam1.autoStem = YES;
      VFBeam* beam2 = [VFBeam beamWithNotes:[notes slice:[@2:4]]];
      beam2.autoStem = YES;
      VFBeam* beam3 = [VFBeam beamWithNotes:[notes slice:[@4:6]]];
      beam3.autoStem = YES;
      VFBeam* beam4 = [VFBeam beamWithNotes:[notes slice:[@6:8]]];
      beam4.autoStem = YES;
      VFBeam* beam5 = [VFBeam beamWithNotes:[notes slice:[@8:10]]];
      beam5.autoStem = YES;
      VFBeam* beam6 = [VFBeam beamWithNotes:[notes slice:[@10:12]]];
      beam6.autoStem = YES;

      assertThatInteger(beam1.stemDirection, equalToInteger(VFStemDirectionUp));
      assertThatInteger(beam2.stemDirection, equalToInteger(VFStemDirectionUp));
      assertThatInteger(beam3.stemDirection, equalToInteger(VFStemDirectionUp));
      assertThatInteger(beam4.stemDirection, equalToInteger(VFStemDirectionUp));
      assertThatInteger(beam5.stemDirection, equalToInteger(VFStemDirectionDown));
      assertThatInteger(beam6.stemDirection, equalToInteger(VFStemDirectionDown));

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam1 draw:ctx];
      [beam2 draw:ctx];
      [beam3 draw:ctx];
      [beam4 draw:ctx];
      [beam5 draw:ctx];
      [beam6 draw:ctx];

      ok(YES, @"AutoStem Beam Test");
    };
}

- (void)mixed:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
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
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
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
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),

          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),

          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:NO];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice2 setStrict:NO];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice2 ]] formatWith:@[ voice, voice ] withJustifyWidth:390];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];

      VFBeam* beam2_1 = [VFBeam beamWithNotes:[notes2 slice:[@0:4]]];
      VFBeam* beam2_2 = [VFBeam beamWithNotes:[notes2 slice:[@4:8]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      [beam2_1 draw:ctx];
      [beam2_2 draw:ctx];

      ok(YES, @"Multi Test");
    };
}

- (void)mixed2:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"64" }),

          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"128" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"32" }),

          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"64" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"128" })
      ];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"64" }),

          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"128" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),

          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"64" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"128" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:NO];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice2 setStrict:NO];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice2 ]] formatWith:@[ voice, voice ] withJustifyWidth:390];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:12]]];

      VFBeam* beam2_1 = [VFBeam beamWithNotes:[notes2 slice:[@0:12]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam2_1 draw:ctx];

      ok(YES, @"Multi Test");
    };
}

- (void)dotted:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          [newNote(
              @{ @"keys" : @[ @"b/3" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8d" }) addDotToAll],
          newNote(
              @{ @"keys" : @[ @"a/3" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"a/3" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),

          [newNote(
              @{ @"keys" : @[ @"b/3" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8d" }) addDotToAll],
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/3" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),

          [newNote(
              @{ @"keys" : @[ @"a/3" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8d" }) addDotToAll],
          newNote(
              @{ @"keys" : @[ @"a/3" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" }),
          [newNote(
              @{ @"keys" : @[ @"b/3" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8d" }) addDotToAll],
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"16" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      //        [voice setMode:VFModeSoft];
      voice.mode = VFModeSoft;
      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:390];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];
      VFBeam* beam1_3 = [VFBeam beamWithNotes:[notes slice:[@8:12]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];
      [beam1_3 draw:ctx];

      ok(YES, @"Dotted Test");
    };
}

- (void)tradeoffs:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"a/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"a/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;
      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      ok(YES, @"Close Trade-offs Test");
    };
}

- (void)insane:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"a/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"b/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;
      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:7]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      ok(YES, @"Insane Test");
    };
}

- (void)lengthy:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"a/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;
      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];

      ok(YES, @"Lengthy Test");
    };
}

- (void)outlier:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"g/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;
      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:300];
      VFBeam* beam1_1 = [VFBeam beamWithNotes:[notes slice:[@0:4]]];
      VFBeam* beam1_2 = [VFBeam beamWithNotes:[notes slice:[@4:8]]];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
      [beam1_1 draw:ctx];
      [beam1_2 draw:ctx];

      ok(YES, @"Outlier Test");
    };
}

- (void)tabBeamsUp:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 550, 0)];

      [staff draw:ctx];

      NSArray* specs = @[
          @{
              @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
              @"duration" : @"4"
          },
          @{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"16"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"32"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"64"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"128"
          },
          @{ @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)} ],
             @"duration" : @"8" },
          @{ @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)} ],
             @"duration" : @"8" },
          @{ @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)} ],
             @"duration" : @"8" },
          @{ @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)} ],
             @"duration" : @"8" }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* noteSpec) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:noteSpec];
        [tabNote->_renderOptions setDrawStem:YES];
        return tabNote;
      }];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      VFBeam* beam1 = [VFBeam beamWithNotes:[notes slice:[@1:7]]];
      VFBeam* beam2 = [VFBeam beamWithNotes:[notes slice:[@8:11]]];

      VFTuplet* tuplet = [[VFTuplet alloc] initWithNotes:[notes slice:[@8:11]]];
      tuplet.ratioed = YES;

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam1 draw:ctx];
      [beam2 draw:ctx];

      [tuplet draw:ctx];

      ok(YES, @"All objects have been drawn");
    };
}

- (void)tabBeamsDown:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(850, 300) withParent:parent];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 550, 0) optionsDict:@{ @"num_lines" : @(10) }];

      [staff draw:ctx];

      NSArray* specs = @[
          @{
              @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
              @"duration" : @"4"
          },
          @{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
              @"duration" : @"8dd"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"16"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"32"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"64"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"128"
          },
          @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)} ],
             @"duration" : @"8" },
          @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)} ],
             @"duration" : @"8" },
          @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)} ],
             @"duration" : @"8" },
          @{ @"positions" : @[ @{@"str" : @(7), @"fret" : @(6)} ],
             @"duration" : @"8" },
          @{ @"positions" : @[ @{@"str" : @(7), @"fret" : @(6)} ],
             @"duration" : @"8" },
          @{ @"positions" : @[ @{@"str" : @(10), @"fret" : @(6)} ],
             @"duration" : @"8" },
          @{ @"positions" : @[ @{@"str" : @(10), @"fret" : @(6)} ],
             @"duration" : @"8" }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* noteSpec) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:noteSpec];
        [tabNote->_renderOptions setDrawStem:YES];
        tabNote.stemDirection = -1;
        [tabNote->_renderOptions setDraw_dots:YES];
        return tabNote;
      }];

      [notes[1] addDot];
      [notes[1] addDot];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      VFBeam* beam1 = [VFBeam beamWithNotes:[notes slice:[@1:7]]];
      VFBeam* beam2 = [VFBeam beamWithNotes:[notes slice:[@8:11]]];

      VFTuplet* tuplet = [[VFTuplet alloc] initWithNotes:[notes slice:[@8:11]]];
      VFTuplet* tuplet2 = [[VFTuplet alloc] initWithNotes:[notes slice:[@11:14]]];
      [tuplet setTupletLocation:-1];
      [tuplet2 setTupletLocation:-1];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam1 draw:ctx];
      [beam2 draw:ctx];
      [tuplet draw:ctx];
      [tuplet2 draw:ctx];

      ok(YES, @"All objects have been drawn");
    };
}

- (void)autoTabBeams:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 300) withParent:parent];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFTabStaff staffWithRect:CGRectMake(10, 10, 550, 0) optionsDict:@{ @"num_lines" : @(6) }];
      [staff draw:ctx];
      NSArray* specs = @[
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"16"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"16"
          },
          @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)} ],
             @"duration" : @"32" },
          @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)} ],
             @"duration" : @"32" },
          @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)} ],
             @"duration" : @"32" },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"32" },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"16" },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"16" },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"16" },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"16" }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* noteSpec) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:noteSpec];
        [tabNote->_renderOptions setDrawStem:YES];
        [tabNote->_renderOptions setDraw_dots:YES];
        return tabNote;
      }];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      NSArray* beams = [VFBeam applyAndGetBeams:voice direction:-1 groups:nil];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
        [beam draw:ctx];
      }];

      ok(YES, @"All objects have been drawn");
    };
}

// This tests makes sure the auto_stem functionality is works.
// TabNote stems within a beam group should end up normalized
- (void)tabBeamsAutoStem:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 300) withParent:parent];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 550, 0) optionsDict:@{ @"num_lines" : @(6) }];

      [staff draw:ctx];

      NSArray* specs = @[
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"8",
              @"stem_direction" : @(-1)
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"8",
              @"stem_direction" : @(1)
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
              @"duration" : @"16",
              @"stem_direction" : @(1)
          },
          @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)} ],
             @"duration" : @"32",
             @"stem_direction" : @(1) },
          @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)} ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)} ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"16",
             @"stem_direction" : @(1) },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"16",
             @"stem_direction" : @(1) },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"16",
             @"stem_direction" : @(1) },
          @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
             @"duration" : @"16",
             @"stem_direction" : @(-1) }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* noteSpec) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:noteSpec];
        [tabNote->_renderOptions setDrawStem:YES];
        [tabNote->_renderOptions setDraw_dots:YES];
        return tabNote;
      }];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      NSArray* beams = @[
          [VFBeam beamWithNotes:[notes slice:[@0:8]] autoStem:YES],    // Stems should format down
          [VFBeam beamWithNotes:[notes slice:[@8:12]] autoStem:YES],   // Stems should format up
      ];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
        [beam draw:ctx];
      }];

      ok(YES, @"All objects have been drawn");
    };
}

- (void)complexWithAnnotation:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(500, 200) withParent:parent];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 40, 400, 0)];
      [staff addClefWithName:@"treble"];

      [staff draw:ctx];
      NSArray* notes = @[
          @{ @"keys" : @[ @"e/4" ],
             @"duration" : @"128",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"d/4" ],
             @"duration" : @"16",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"e/4" ],
             @"duration" : @"8",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"g/4", @"c/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"c/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"c/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"c/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(1) }
      ];

      NSArray* notes2 = @[
          @{ @"keys" : @[ @"e/5" ],
             @"duration" : @"128",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"d/5" ],
             @"duration" : @"16",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"e/5" ],
             @"duration" : @"8",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"g/5", @"c/5" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"c/5" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"c/5" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"c/5" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) }
      ];

      notes = [notes oct_map:^VFStaffNote*(NSDictionary* spec) {
        return
            [newNote(spec) addModifier:[[VFAnnotation annotationWithText:@"1"] setVerticalJustification:1] atIndex:0];
      }];

      notes2 = [notes2 oct_map:^VFStaffNote*(NSDictionary* spec) {
        return
            [newNote(spec) addModifier:[[VFAnnotation annotationWithText:@"1"] setVerticalJustification:3] atIndex:0];
      }];

      VFBeam* beam = [VFBeam beamWithNotes:notes];
      VFBeam* beam2 = [VFBeam beamWithNotes:notes2];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;
      [voice addTickables:notes];
      [voice addTickables:notes2];

      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];
      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam draw:ctx];
      [beam2 draw:ctx];

      ok(YES, @"Complex beam annotations");
    };
}

- (void)complexWithArticulation:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(500, 200) withParent:parent];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 400, 0)];
      [staff addClefWithName:@"treble"];
      [staff draw:ctx];
      NSArray* notes = @[
          @{ @"keys" : @[ @"e/4" ],
             @"duration" : @"128",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"d/4" ],
             @"duration" : @"16",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"e/4" ],
             @"duration" : @"8",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"g/4", @"c/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"c/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"c/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(1) },
          @{ @"keys" : @[ @"c/4" ],
             @"duration" : @"32",
             @"stem_direction" : @(1) }
      ];

      NSArray* notes2 = @[
          @{ @"keys" : @[ @"e/5" ],
             @"duration" : @"128",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"d/5" ],
             @"duration" : @"16",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"e/5" ],
             @"duration" : @"8",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"g/5", @"c/5" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"c/5" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"c/5" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"c/5" ],
             @"duration" : @"32",
             @"stem_direction" : @(-1) }
      ];

      notes = [notes oct_map:^VFStaffNote*(NSDictionary* spec) {
        VFArticulationType t = [VFEnum typeArticulationTypeForString:@"am"];
        return [newNote(spec) addModifier:[[[VFArticulation alloc] initWithType:t] setPosition:3] atIndex:0];
      }];

      notes2 = [notes2 oct_map:^VFStaffNote*(NSDictionary* spec) {
        VFArticulationType t = [VFEnum typeArticulationTypeForString:@"a>"];
        return [newNote(spec) addModifier:[[[VFArticulation alloc] initWithType:t] setPosition:4] atIndex:0];
      }];

      VFBeam* beam = [VFBeam beamWithNotes:notes];
      VFBeam* beam2 = [VFBeam beamWithNotes:notes2];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;
      [voice addTickables:notes];
      [voice addTickables:notes2];

      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];
      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam draw:ctx];
      [beam2 draw:ctx];

      ok(YES, @"Complex beam articulations");
    };
}

@end
