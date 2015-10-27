//
//  TupletTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TupletTests.h"
#import "VexFlowTestHelpers.h"

@implementation TupletTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple Tuplet"  func:@selector(simple:)];
    [self runTest:@"Beamed Tuplet"  func:@selector(beamed:)];
    [self runTest:@"Ratioed Tuplet"  func:@selector(ratio:)];
    [self runTest:@"Bottom Tuplet"  func:@selector(bottom:)];
    [self runTest:@"Bottom Ratioed Tuplet"  func:@selector(bottom_ratio:)];
    [self runTest:@"Awkward Tuplet"  func:@selector(awkward:)];
    [self runTest:@"Complex Tuplet"  func:@selector(complex:)];
    [self runTest:@"Mixed Stem Direction Tuplet"  func:@selector(mixedTop:)];
    [self runTest:@"Mixed Stem Direction Bottom Tuplet"
           
             func:@selector(mixedBottom:)
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
- (void)setupContext
{
    /*
    Vex.Flow.Test.Tuplet.setupContext = function(options, x, y) {
        var ctx = new options.contextBuilder(options.canvas_sel, x || 450, y || 140);

        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.font = " 10pt Arial";
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, x || 350).addTrebleGlyph().
        setContext(ctx).draw();

        return {context: ctx, staff: staff};
    }
     */
}

- (void)simple:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Tuplet.simple = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.Beam.setupContext(options);
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"8"})
                     ];

        VFTuplet* tuplet1 = [[VFTuplet alloc]initWithNotes:[notes slice:[@0, 3));
        VFTuplet* tuplet2 = [[VFTuplet alloc]initWithNotes:[notes slice:[@3, 6));

        // 3/4 time
        var voice = new Vex.Flow.Voice({
            num_beats: 3, beat_value: 4, resolution: kRESOLUTION });

        voice.setStrict(YES);
        [voice addTickables:notes];

        c.staff addTimeSignatureWithName:@"3/4");
        c.staff.draw(c.context);

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);

        voice.draw(c.context, c.staff);

        tuplet1.setContext(c.context).draw();
        tuplet2.setContext(c.context).draw();

        ok(YES, @"Simple Test");
    }
     */
}

- (void)beamed:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Tuplet.beamed = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.Beam.setupContext(options);
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"8"})
                     ];

        var beam1 = [VFBeam beamWithNotes:notes.slice(0, 3));
        var beam2 = [VFBeam beamWithNotes:notes.slice(3, 10));

        VFTuplet* tuplet1 = [[VFTuplet alloc]initWithNotes:[notes slice:[@0, 3));
        VFTuplet* tuplet2 = [[VFTuplet alloc]initWithNotes:[notes slice:[@3, 10));

        // 3/8 time
        var voice = new Vex.Flow.Voice({
            num_beats: 3, beat_value: 8, resolution: kRESOLUTION });

        voice.setStrict(YES);
        [voice addTickables:notes];
        c.staff addTimeSignatureWithName:@"3/8");
        c.staff.draw(c.context);

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);

        voice.draw(c.context, c.staff);

        tuplet1.setContext(c.context).draw();
        tuplet2.setContext(c.context).draw();

        beam1.setContext(c.context).draw();
        beam2.setContext(c.context).draw();

        ok(YES, @"Beamed Test");
    }
     */
}

- (void)ratio:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Tuplet.ratio = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.Beam.setupContext(options);
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"e/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"8"})
                     ];

        var beam = [VFBeam beamWithNotes:notes.slice(3, 6));

        VFTuplet* tuplet1 = [[VFTuplet alloc]initWithNotes:[notes slice:[@0, 3));
        VFTuplet* tuplet2 = [[VFTuplet alloc]initWithNotes:[notes slice:[@3, 6), {beats_occupied: 4});

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];

        voice.setStrict(YES);
        [voice addTickables:notes];
        c.staff addTimeSignatureWithName:@"4/4");
        c.staff.draw(c.context);

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);

        voice.draw(c.context, c.staff);

        beam.setContext(c.context).draw();

        tuplet1.setRatioed(YES).setContext(c.context).draw();
        tuplet2.setRatioed(YES).setContext(c.context).draw();

        ok(YES, @"Ratioed Test");
    }
     */
}

- (void)bottom:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Tuplet.bottom = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.Beam.setupContext(options, 350, 160);
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(-1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"c/4"], @"stem_direction" : @(-1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(-1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"d/5"], @"stem_direction" : @(-1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"g/3"], @"stem_direction" : @(-1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(-1), @"duration" : @"8"})
                     ];

        var beam = [VFBeam beamWithNotes:notes.slice(3, 6));

        VFTuplet* tuplet1 = [[VFTuplet alloc]initWithNotes:[notes slice:[@0, 3));
        VFTuplet* tuplet2 = [[VFTuplet alloc]initWithNotes:[notes slice:[@3, 6));

        tuplet1 setTupletLocation:Vex.Flow.Tuplet.LOCATION_BOTTOM);
        tuplet2 setTupletLocation:Vex.Flow.Tuplet.LOCATION_BOTTOM);

        var voice = new Vex.Flow.Voice({
            num_beats: 3, beat_value: 4, resolution: kRESOLUTION });

        voice.setStrict(YES);
        [voice addTickables:notes];
        c.staff addTimeSignatureWithName:@"3/4");
        c.staff.draw(c.context);

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);

        voice.draw(c.context, c.staff);

        beam.setContext(c.context).draw();

        tuplet1.setContext(c.context).draw();
        tuplet2.setContext(c.context).draw();

        ok(YES, @"Bottom Test");
    }
     */
}

- (void)bottom_ratio:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Tuplet.bottom_ratio = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.Beam.setupContext(options, 350, 160);
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(-1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"c/4"], @"stem_direction" : @(-1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"d/4"], @"stem_direction" : @(-1), @"duration" : @"q"}),
                     newNote(@{ @"keys" : @[@"d/5"], @"stem_direction" : @(-1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"g/5"], @"stem_direction" : @(-1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(-1), @"duration" : @"8"})
                     ];

        var beam = [VFBeam beamWithNotes:notes.slice(3, 6));

        VFTuplet* tuplet1 = [[VFTuplet alloc]initWithNotes:[notes slice:[@0, 3));
        VFTuplet* tuplet2 = [[VFTuplet alloc]initWithNotes:[notes slice:[@3, 6));

        tuplet2.setBeatsOccupied(1);
        tuplet1 setTupletLocation:Vex.Flow.Tuplet.LOCATION_BOTTOM);
        tuplet2 setTupletLocation:Vex.Flow.Tuplet.LOCATION_BOTTOM);

        var voice = new Vex.Flow.Voice({
            num_beats: 5, beat_value: 8, resolution: kRESOLUTION });

        voice.setStrict(YES);
        [voice addTickables:notes];
        c.staff addTimeSignatureWithName:@"5/8");
        c.staff.draw(c.context);

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);

        voice.draw(c.context, c.staff);

        beam.setContext(c.context).draw();

        tuplet1.setRatioed(YES).setContext(c.context).draw();
        tuplet2.setRatioed(YES).setContext(c.context).draw();

        ok(YES, @"Bottom Ratioed Test");
    }
     */
}

- (void)awkward:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Tuplet.awkward = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.Beam.setupContext(options);
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"e/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"c/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                     newNote(@{ @"keys" : @[@"c/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"d/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                     newNote(@{ @"keys" : @[@"e/4"], @"stem_direction" : @(1), @"duration" : @"8"})
                     ];

        var beam = [VFBeam beamWithNotes:notes.slice(0, 11));

        VFTuplet* tuplet1 = [[VFTuplet alloc]initWithNotes:[notes slice:[@0, 11));
        VFTuplet* tuplet2 = [[VFTuplet alloc]initWithNotes:[notes slice:[@11, 14));
        tuplet1.setBeatsOccupied(142);

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];

        voice setStrict:NO];
        [voice addTickables:notes];

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);

        voice.draw(c.context, c.staff);

        beam.setContext(c.context).draw();
        tuplet1.setRatioed(YES).setContext(c.context).draw();
        tuplet2.setRatioed(YES).setBracketed(YES).setContext(c.context).draw();

        ok(YES, @"Awkward Test");
    }
     */
}

- (void)complex:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Tuplet.complex = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.Tuplet.setupContext(options, 600);
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes1 = [
                      newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(1), @"duration" : @"8d"}) addDotToAll],
                      newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                      newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                      newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                      newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(1), @"duration" : @"16r"}),
                      newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"32"}),
                      newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(1), @"duration" : @"32"}),
                      newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"32"}),
                      newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(1), @"duration" : @"32"}),
                      newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"16"}),
                      newNote(@{ @"keys" : @[@"f/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                      newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                      newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                      newNote(@{ @"keys" : @[@"g/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                      newNote(@{ @"keys" : @[@"b/4"], @"stem_direction" : @(1), @"duration" : @"8"}),
                      newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"8"})
                      ];
        NSArray *notes2 = [
                      newNote(@{ @"keys" : @[@"c/4"], @"stem_direction" : @(-1), @"duration" : @"4" }),
                      newNote(@{ @"keys" : @[@"c/4"], @"stem_direction" : @(-1), @"duration" : @"4" }),
                      newNote(@{ @"keys" : @[@"c/4"], @"stem_direction" : @(-1), @"duration" : @"4" }),
                      newNote(@{ @"keys" : @[@"c/4"], @"stem_direction" : @(-1), @"duration" : @"4" })
                      ];

        var voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        var voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];

        var beam1 = [VFBeam beamWithNotes:notes1.slice(0, 3));
        var beam2 = [VFBeam beamWithNotes:notes1.slice(5, 9));
        var beam3 = [VFBeam beamWithNotes:notes1.slice(11, 16));

        VFTuplet* tuplet1 = new Vex.Flow.Tuplet(notes1.slice(0, 3));
        VFTuplet* tuplet2 = new Vex.Flow.Tuplet(notes1.slice(3, 11),
                                          {num_notes: 7, beats_occupied: 4});
        VFTuplet* tuplet3 = new Vex.Flow.Tuplet(notes1.slice(11, 16), {beats_occupied: 4});

        voice1.setStrict(YES);
        voice1.addTickables(notes1);
        voice2.setStrict(YES)
        voice2.addTickables(notes2);
        c.staff addTimeSignatureWithName:@"4/4");
        c.staff.draw(c.context);

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice1, voice2]).
        format([voice1, voice2], c.staff.getNoteEndX() - c.staff.getNoteStartX() - 50);

        voice1.draw(c.context, c.staff);
        voice2.draw(c.context, c.staff);

        tuplet1.setContext(c.context).draw();
        tuplet2.setContext(c.context).draw();
        tuplet3.setContext(c.context).draw();

        beam1.setContext(c.context).draw();
        beam2.setContext(c.context).draw();
        beam3.setContext(c.context).draw();

        ok(YES, @"Complex Test");
    }
     */
}

- (void)mixedTop:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Tuplet.mixedTop = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.Beam.setupContext(options);
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"c/6"], @"stem_direction" : @(-1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"f/5"], @"stem_direction" : @(1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(-1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"c/6"], @"stem_direction" : @(-1), @"duration" : @"4"})
                     ];

        VFTuplet* tuplet1 = [[VFTuplet alloc]initWithNotes:[notes slice:[@0, 2), {beats_occupied : 3});
        VFTuplet* tuplet2 = [[VFTuplet alloc]initWithNotes:[notes slice:[@2, 4), {beats_occupied : 3});
        VFTuplet* tuplet3 = [[VFTuplet alloc]initWithNotes:[notes slice:[@4, 6), {beats_occupied : 3});

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];

        voice setStrict:NO];
        [voice addTickables:notes];

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);

        voice.draw(c.context, c.staff);

        tuplet1.setContext(c.context).draw();
        tuplet2.setContext(c.context).draw();
        tuplet3.setContext(c.context).draw();

        ok(YES, @"Mixed Stem Direction Tuplet");
    }
     */
}

- (void)mixedBottom:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Tuplet.mixedBottom = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.Beam.setupContext(options);
        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     newNote(@{ @"keys" : @[@"f/3"], @"stem_direction" : @(1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"a/5"], @"stem_direction" : @(-1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"f/3"], @"stem_direction" : @(1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"a/4"], @"stem_direction" : @(-1), @"duration" : @"4"}),
                     newNote(@{ @"keys" : @[@"c/4"], @"stem_direction" : @(-1), @"duration" : @"4"})
                     ];

        VFTuplet* tuplet1 = [[VFTuplet alloc]initWithNotes:[notes slice:[@0, 2), {beats_occupied : 3});
        VFTuplet* tuplet2 = [[VFTuplet alloc]initWithNotes:[notes slice:[@2, 4), {beats_occupied : 3});
        VFTuplet* tuplet3 = [[VFTuplet alloc]initWithNotes:[notes slice:[@4, 6), {beats_occupied : 3});

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];

        voice setStrict:NO];
        [voice addTickables:notes];

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);

        voice.draw(c.context, c.staff);

        tuplet1 setTupletLocation:Vex.Flow.Tuplet.LOCATION_BOTTOM);
        tuplet2 setTupletLocation:Vex.Flow.Tuplet.LOCATION_BOTTOM);
        tuplet3 setTupletLocation:Vex.Flow.Tuplet.LOCATION_BOTTOM);

        tuplet1.setContext(c.context).draw();
        tuplet2.setContext(c.context).draw();
        tuplet3.setContext(c.context).draw();

        ok(YES, @"Mixed Stem Direction Bottom Tuplet");
    }
    */
}

@end
