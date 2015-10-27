//
//  StaffTieTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "StaffTieTests.h"
#import "VexFlowTestHelpers.h"

@implementation StaffTieTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple StaffTie"  func:@selector(simple:)];
    [self runTest:@"Chord StaffTie"  func:@selector(chord:)];
    [self runTest:@"Stem Up StaffTie"  func:@selector(stemUp:)];
    [self runTest:@"No End Note"  func:@selector(noEndNote:)];
    [self runTest:@"No Start Note"  func:@selector(noStartNote:)];
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

- (void)tieNotes:(NSArray*)notes
     withIndices:(NSArray*)indices
           staff:(VFStaff*)staff
         context:(CGContextRef)ctx
       dirtyRect:(CGRect)dirtyRect
{
    /*
    Vex.Flow.Test.StaffTie.tieNotes = function(notes, indices, staff, ctx) {
        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice addTickables:notes];

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:250];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

        var tie = [VFStaff staffWithRect:CGRectMakeTie({
        first_note: notes[0],
        last_note: notes[1],
        first_indices: indices,
        last_indices: indices,
        });

        tie.setContext(ctx);
        tie.draw();
    }
     */

    VFVoice* voice = [[VFVoice voiceWithTimeSignature:VFTime4_4] addTickables:notes];
    // VFFormatter* formatter =
    [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:250];
    [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

    VFStaffTie* tie = [[VFStaffTie alloc] initWithDictionary:@{
        @"first_note" : notes[0],
        @"last_note" : notes[1],
        @"first_indices" : indices,
        @"last_indices" : indices,
    }];
    [tie draw:ctx];
}

- (void)drawTie:(NSArray*)notes withIndices:(NSArray*)indices options:(NSDictionary*)options context:(CGContextRef)ctx dirtyRect:(CGRect)dirtyRect
{
    /*
    Vex.Flow.Test.StaffTie.drawTie = function(notes, indices, options) {
        var ctx = new options.contextBuilder(options.canvas_sel, 350, 140);

        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350) draw:ctx];

        Vex.Flow.Test.StaffTie.tieNotes(notes, indices, staff, ctx);
    }
     */

    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
    [staff draw:ctx];
    [[self class] tieNotes:notes withIndices:indices staff:staff context:ctx dirtyRect:CGRectZero];
}

- (void)simple:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.StaffTie.simple = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }
        function newAcc(type) { return new Vex.Flow.Accidental(type); }

        Vex.Flow.Test.StaffTie.drawTie([
                                        newNote(@{ @"keys" : @[@"c/4", @"e/4", @"a/4"], @"stem_direction" : @(-1),
    @"duration" : @"h"}).
                                        addAccidental(0, newAcc(@"b")).
                                        addAccidental(1, newAcc(@"#")),
                                        newNote(@{ @"keys" : @[@"d/4", @"e/4", @"f/4"], @"stem_direction" : @(-1),
    @"duration" : @"h"})
                                        ], [0, 1], options);
        ok(YES, @"Simple Test");
    }
     */

    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      [[self class] drawTie:@[
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"h" }) addAccidental:newAcc(@"b")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],
          newNote(
              @{ @"keys" : @[ @"d/4", @"e/4", @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"h" }),
      ] withIndices:@[ @0, @1 ]
                    options:nil
                    context:ctx dirtyRect:CGRectZero];
      ok(YES, @"Simple Test");
    };
}

- (void)chord:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.StaffTie.chord = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }
        function newAcc(type) { return new Vex.Flow.Accidental(type); }

        Vex.Flow.Test.StaffTie.drawTie([
                                        newNote(@{ @"keys" : @[@"d/4", @"e/4", @"f/4"], @"stem_direction" : @(-1),
    @"duration" : @"h"}),
                                        newNote(@{ @"keys" : @[@"c/4", @"f/4", @"a/4"], @"stem_direction" : @(-1),
    @"duration" : @"h"}).
                                        addAccidental(0, newAcc(@"n")).
                                        addAccidental(1, newAcc(@"#")),
                                        ], [0, 1, 2], options);
        ok(YES, @"Chord test");
    }
     */
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      [[self class] drawTie:@[
          newNote(
              @{ @"keys" : @[ @"d/4", @"e/4", @"f/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"h" }),
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"f/4", @"a/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"h" }) addAccidental:newAcc(@"n")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],
      ] withIndices:@[ @0, @1, @2 ]
                    options:nil
                    context:ctx dirtyRect:CGRectZero];
      ok(YES, @"Chord test");
    };
}

- (void)stemUp:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.StaffTie.stemUp = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }
        function newAcc(type) { return new Vex.Flow.Accidental(type); }

        Vex.Flow.Test.StaffTie.drawTie([
                                        newNote(@{ @"keys" : @[@"d/4", @"e/4", @"f/4"], @"stem_direction" : @(1),
    @"duration" : @"h"}),
                                        newNote(@{ @"keys" : @[@"c/4", @"f/4", @"a/4"], @"stem_direction" : @(1),
    @"duration" : @"h"}).
                                        addAccidental(0, newAcc(@"n")).
                                        addAccidental(1, newAcc(@"#")),
                                        ], [0, 1, 2], options);
        ok(YES, @"Stem up test");
    }
     */
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      [[self class] drawTie:@[
          newNote(
              @{ @"keys" : @[ @"d/4", @"e/4", @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"h" }),
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"f/4", @"a/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"h" }) addAccidental:newAcc(@"n")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],
      ] withIndices:@[ @0, @1, @2 ]
                    options:nil
                    context:ctx dirtyRect:CGRectZero];
      ok(YES, @"Stem up test");
    };
}

- (void)noEndNote:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.StaffTie.noEndNote = function(options, contextBuilder) {
        var ctx = contextBuilder(options.canvas_sel, 350, 140);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.font = "10pt Arial";
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350) draw:ctx];

        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }
        function newAcc(type) { return new Vex.Flow.Accidental(type); }

        notes = [
                 newNote(@{ @"keys" : @[@"c/4", @"e/4", @"a/4"], @"stem_direction" : @(-1), @"duration" : @"h"}).
                 addAccidental(0, newAcc(@"b")).
                 addAccidental(1, newAcc(@"#")),
                 newNote(@{ @"keys" : @[@"d/4", @"e/4", @"f/4"], @"stem_direction" : @(-1), @"duration" : @"h"})
                 ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice addTickables:notes];

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:250];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

        var tie = [VFStaff staffWithRect:CGRectMakeTie({
        first_note: notes[1],
        last_note: null,
        first_indices: [2],
        last_indices: [2]
        }, "slow.") draw:ctx];

        ok(YES, @"No end note");
    }
     */

    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)] addTrebleGlyph];
      [staff draw:ctx];
      NSArray* notes = @[
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"h" }) addAccidental:newAcc(@"b")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],
          newNote(
              @{ @"keys" : @[ @"c/4", @"f/4", @"a/4" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"h" }),
      ];
      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];

      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:250];
      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      VFStaffTie* tie = [[VFStaffTie alloc] initWithDictionary:@{
          @"first_note" : notes[1],
          @"last_note" : [NSNull null],
          @"first_indices" : @[ @2 ],
          @"last_indices" : @[ @2 ],
      } andText:@"H"];
      [tie draw:ctx];

      ok(YES, @"No end note");
    };
}

- (void)noStartNote:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.StaffTie.noStartNote = function(options, contextBuilder) {
        var ctx = contextBuilder(options.canvas_sel, 350, 140);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.font = "10pt Arial";
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350).addTrebleGlyph().
        setContext(ctx).draw();

        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }
        function newAcc(type) { return new Vex.Flow.Accidental(type); }

        notes = [
                 newNote(@{ @"keys" : @[@"c/4", @"e/4", @"a/4"], @"stem_direction" : @(-1), @"duration" : @"h"}).
                 addAccidental(0, newAcc(@"b")).
                 addAccidental(1, newAcc(@"#")),
                 newNote(@{ @"keys" : @[@"d/4", @"e/4", @"f/4"], @"stem_direction" : @(-1), @"duration" : @"h"})
                 ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice addTickables:notes];

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:250];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

        var tie = [VFStaff staffWithRect:CGRectMakeTie({
        first_note: null,
        last_note: notes[0],
        first_indices: [2],
        last_indices: [2],
        }, "H") draw:ctx];

        ok(YES, @"No end note");
    }
    */

    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)] addTrebleGlyph];
      [staff draw:ctx];
      NSArray* notes = @[
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"h" }) addAccidental:newAcc(@"n")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],
          newNote(
              @{ @"keys" : @[ @"d/4", @"e/4", @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"m" }),
      ];
      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];

      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:250];
      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      VFStaffTie* tie = [[VFStaffTie alloc] initWithDictionary:@{
          @"first_note" : [NSNull null],
          @"last_note" : notes[0],
          @"first_indices" : @[ @2 ],
          @"last_indices" : @[ @2 ],
      } andText:@"H"];
      [tie draw:ctx];

      ok(YES, @"No end note");
    };
}
@end
