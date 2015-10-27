//
//  PercussionTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "PercussionTests.h"
#import "VexFlowTestHelpers.h"
#import "NSArray+JSAdditions.h"

@implementation PercussionTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Percussion Clef"  func:@selector(draw:)];

    [self runTest:@"Percussion Notes"  func:@selector(drawNotes:withTitle:)];

    [self runTest:@"Percussion Basic0"  func:@selector(drawBasic0:withTitle:)];
    [self runTest:@"Percussion Basic1"  func:@selector(drawBasic1:withTitle:)];
    [self runTest:@"Percussion Basic2"  func:@selector(drawBasic2:withTitle:)];

    [self runTest:@"Percussion Snare0"  func:@selector(drawSnare0:withTitle:)];
    [self runTest:@"Percussion Snare1"  func:@selector(drawSnare1:withTitle:)];
    [self runTest:@"Percussion Snare2"  func:@selector(drawSnare2:withTitle:)];
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

- (void)runBoth
{
    /*
    Vex.Flow.Test.Percussion.runBoth = function(title, func) {
        Vex.Flow.Test.runTests(title, func);

    }
     */
}

- (void)newModifier
{
    /*
    Vex.Flow.Test.Percussion.newModifier = function(s) {
        return new Vex.Flow.Annotation(s).setFont(@"Arial", 12)
        .setVerticalJustification(Vex.Flow.Annotation.VerticalJustify.BOTTOM);
    }
     */
}

- (void)newArticulation
{
    /*
    Vex.Flow.Test.Percussion.newArticulation = function(s) {
        return new Vex.Flow.Articulation(s).setPosition(VFPositionAbove);
    }
     */
}

- (void)newTremolo
{
    /*
    Vex.Flow.Test.Percussion.newTremolo = function(s) {
        return new Vex.Flow.Tremolo(s);
    }
     */
}

- (void)draw:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    /*
    Vex.Flow.Test.Percussion.draw = function(options, contextBuilder) {
        var ctx = new contextBuilder(options.canvas_sel, 400, 120);

        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300);
        staff addClefWithName:@"percussion");

        [staff draw:ctx];

        ok(YES, @"");
    }
     */
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 120) withParent:parent withTitle:title];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];
      [staff setBegBarType:VFBarLineRepeatBegin];
      [staff setEndBarType:VFBarLineSingle];
      [staff addClefWithName:@"percussion"];
      [staff draw:ctx];

      ok(YES, @"");
    };
}

- (void)showNote
{
    /*
    Vex.Flow.Test.Percussion.showNote = function(note_struct, staff, ctx, x) {
        var note = [[VFStaffNote alloc]initWithDictionary:(note_struct);
        VFTickContext *tickContext = [[VFTickContext alloc]init];
        [tickContext addTickable:note] preFormat].x = x).setPixelsUsed(20);
        note.staff = staff;
        [note draw:ctx]
        return note;
    }
     */
}

- (void)drawNotes:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    /*
    Vex.Flow.Test.Percussion.drawNotes = function(options, contextBuilder) {
        NSArray *notes = @[
                     @{ @"keys" : @[@"g/5/d0"], @"duration" : @"q"},
                     @{ @"keys" : @[@"g/5/d1"], @"duration" : @"q"},
                     @{ @"keys" : @[@"g/5/d2"], @"duration" : @"q"},
                     @{ @"keys" : @[@"g/5/d3"], @"duration" : @"q"},
                     @{ @"keys" : @[@"x/"], @"duration" : @"w"},

                     @{ @"keys" : @[@"g/5/t0"], @"duration" : @"w"},
                     @{ @"keys" : @[@"g/5/t1"], @"duration" : @"q"},
                     @{ @"keys" : @[@"g/5/t2"], @"duration" : @"q"},
                     @{ @"keys" : @[@"g/5/t3"], @"duration" : @"q"},
                     @{ @"keys" : @[@"x/"], @"duration" : @"w"},

                     @{ @"keys" : @[@"g/5/x0"], @"duration" : @"w"},
                     @{ @"keys" : @[@"g/5/x1"], @"duration" : @"q"},
                     @{ @"keys" : @[@"g/5/x2"], @"duration" : @"q"},
                     @{ @"keys" : @[@"g/5/x3"], @"duration" : @"q"}
                     ];
        expect(notes.length * 4);

        var ctx = new contextBuilder(options.canvas_sel,
                                     notes.length * 25 + 100, 240);

        // Draw two staffs, one with up-stems and one with down-stems.
        for (var h = 0; h < 2; ++h) {
            VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10 + h * 120, notes.length * 25 + 75);
            staff addClefWithName:@"percussion");

            [staff draw:ctx];

            var showNote = Vex.Flow.Test.Percussion.showNote;

            for (var i = 0; i < notes.length; ++i) {
                var note = notes[i];
                note.stem_direction = (h == 0 ? -1 : 1);
                VFStaff *staffNote = showNote(note, staff, ctx, (i + 1) * 25);

                ok(staffNote.getX() > 0, "Note " + i + " has X value");
                ok(staffNote.getYs().length > 0, "Note " + i + " has Y values");
            }
        }
    }
     */
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 120) withParent:parent withTitle:title];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 280, 0)];
      [staff addClefWithName:@"percussion"];
      [staff draw:ctx];

      //        NSUInteger i = notes.count * 4;
      //        expect(i);

      ok(YES, @"");
    };
}

- (void)drawBasic0:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    /*
    Vex.Flow.Test.Percussion.drawBasic0 = function(options, contextBuilder) {
        var ctx = contextBuilder(options.canvas_sel, 500, 120);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.setFont(@"Arial", 15, "");
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 420);
        staff addClefWithName:@"percussion");

        [staff draw:ctx];

        NSArray* notesUp = @[
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" })
                   ];
        VFBeam* beamUp = [VFBeam beamWithNotes:notesUp.slice(0,8));
        VFVoice* voiceUp = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
            resolution: kRESOLUTION });
        voiceUp.addTickables(notesUp);

        notesDown = [
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/4"], @"duration" : @"8",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/4"], @"duration" : @"8",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5", @"d/4/x2"], @"duration" : @"q",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/4"], @"duration" : @"8",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/4"], @"duration" : @"8",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5", @"d/4/x2"], @"duration" : @"q",
            stem_direction: -1 })
                     ];
        VFBeam* beamDown1 = [VFBeam beamWithNotes:notesDown.slice(0,2));
        VFBeam* beamDown2 = [VFBeam beamWithNotes:notesDown.slice(3,6));
        VFVoice* voiceDown = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
            resolution: kRESOLUTION });
        voiceDown.addTickables(notesDown);

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voiceUp, voiceDown]).
        formatToStaff([voiceUp, voiceDown], staff);

        voiceUp.draw(ctx, staff);
        voiceDown.draw(ctx, staff);

        [beamUp draw:ctx];
        beamDown1 draw:ctx];
        beamDown2 draw:ctx];

        ok(YES, @"");
    }
     */
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(500, 120) withParent:parent withTitle:title];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 420, 0)];
      [staff addClefWithName:@"percussion"];
      [staff draw:ctx];

      //      NSArray* notesUp = @[
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"g/5/x2" ],
      //              @"duration" : @"8"
      //          }],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"g/5/x2" ],
      //              @"duration" : @"8"
      //          }],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"g/5/x2" ],
      //              @"duration" : @"8"
      //          }],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"g/5/x2" ],
      //              @"duration" : @"8"
      //          }],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"g/5/x2" ],
      //              @"duration" : @"8"
      //          }],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"g/5/x2" ],
      //              @"duration" : @"8"
      //          }],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"g/5/x2" ],
      //              @"duration" : @"8"
      //          }],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"g/5/x2" ],
      //              @"duration" : @"8"
      //          }]
      //      ];

      ok(YES, @"");
    };
}

- (void)drawBasic1:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    /*
    Vex.Flow.Test.Percussion.drawBasic1 = function(options, contextBuilder) {
        var ctx = contextBuilder(options.canvas_sel, 500, 120);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.setFont(@"Arial", 15, "");
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 420);
        staff addClefWithName:@"percussion");

        [staff draw:ctx];

        NSArray* notesUp = @[
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/5/x2"], @"duration" : @"q" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/5/x2"], @"duration" : @"q" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/5/x2"], @"duration" : @"q" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/5/x2"], @"duration" : @"q" })
                   ];
        VFVoice* voiceUp = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
            resolution: kRESOLUTION });
        voiceUp.addTickables(notesUp);

        notesDown = [
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/4"], @"duration" : @"q",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5", @"d/4/x2"], @"duration" : @"q",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/4"], @"duration" : @"q",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5", @"d/4/x2"], @"duration" : @"q",
            stem_direction: -1 })
                     ];
        VFVoice* voiceDown = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
            resolution: kRESOLUTION });
        voiceDown.addTickables(notesDown);

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voiceUp, voiceDown]).
        formatToStaff([voiceUp, voiceDown], staff);

        voiceUp.draw(ctx, staff);
        voiceDown.draw(ctx, staff);

        ok(YES, @"");
    }
     */
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(500, 120) withParent:parent withTitle:title];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 420, 0)];
      [staff addClefWithName:@"percussion"];
      [staff draw:ctx];

      ok(YES, @"");
    };
}

- (void)drawBasic2:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    /*
    Vex.Flow.Test.Percussion.drawBasic2 = function(options, contextBuilder) {
        var ctx = contextBuilder(options.canvas_sel, 500, 120);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.setFont(@"Arial", 15, "");
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 420);
        staff addClefWithName:@"percussion");

        [staff draw:ctx];

        NSArray* notesUp = @[
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"a/5/x3"], @"duration" : @"8" }).
                   addModifier(0, (new Vex.Flow.Annotation(@"<")).setFont()),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" }),
                   [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"8" })
                   ];
        VFBeam* beamUp = [VFBeam beamWithNotes:notesUp.slice(1,8));
        VFVoice* voiceUp = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
            resolution: kRESOLUTION });
        voiceUp.addTickables(notesUp);

        notesDown = [
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/4"], @"duration" : @"8",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/4"], @"duration" : @"8",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5", @"d/4/x2"], @"duration" : @"q",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"f/4"], @"duration" : @"q",
            stem_direction: -1 }),
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5", @"d/4/x2"], @"duration" : @"8d",
            stem_direction: -1 }) addDotToAll],
                     [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"16",
            stem_direction: -1 })
                     ];
        VFBeam* beamDown1 = [VFBeam beamWithNotes:notesDown.slice(0,2));
        VFBeam* beamDown2 = [VFBeam beamWithNotes:notesDown.slice(4,6));
        VFVoice* voiceDown = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
            resolution: kRESOLUTION });
        voiceDown.addTickables(notesDown);

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voiceUp, voiceDown]).
        formatToStaff([voiceUp, voiceDown], staff);

        voiceUp.draw(ctx, staff);
        voiceDown.draw(ctx, staff);

        [beamUp draw:ctx];
        beamDown1 draw:ctx];
        beamDown2 draw:ctx];

        ok(YES, @"");
    }
     */

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(500, 120) withParent:parent withTitle:title];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 420, 0)];
      [staff addClefWithName:@"percussion"];
      [staff draw:ctx];

      ok(YES, @"");
    };
}

- (void)drawSnare0:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    /*
    Vex.Flow.Test.Percussion.drawSnare0 = function(options, contextBuilder) {
        var ctx = contextBuilder(options.canvas_sel, 600, 120);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.setFont(@"Arial", 15, "");

        x = 10;
        y = 10;
        w = 280;

        {
            VFStaff *staff = [VFStaff staffWithRect:CGRectMake(x, y, w);
            staff setBegBarType:Vex.Flow.Barline.type.REPEAT_BEGIN);
            staff setEndBarType:Vex.Flow.Barline.type.SINGLE);
            staff addClefWithName:@"percussion");

            [staff draw:ctx];

            NSArray* notesDown = @[
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addArticulation(0  func:@selector(newArticulation(@"a>")).
                         addModifier(0  func:@selector(newModifier(@"L")),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addModifier(0  func:@selector(newModifier(@"R")),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addModifier(0  func:@selector(newModifier(@"L")),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addModifier(0  func:@selector(newModifier(@"L"))
                         ];
            VFVoice* voiceDown = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
                resolution: kRESOLUTION });
            voiceDown.addTickables(notesDown);

            VFFormatter *formatter = [VFFormatter formatter]
            joinVoices([voiceDown]).formatToStaff([voiceDown], staff);

            voiceDown.draw(ctx, staff);

            x += staff.width;
        }

        {
            VFStaff *staff = [VFStaff staffWithRect:CGRectMake(x, y, w);
            staff setBegBarType:Vex.Flow.Barline.type.NONE);
            staff setEndBarType:Vex.Flow.Barline.type.REPEAT_END);

            [staff draw:ctx];

            NSArray* notesDown = @[
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addArticulation(0  func:@selector(newArticulation(@"a>")).
                         addModifier(0  func:@selector(newModifier(@"R")),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addModifier(0  func:@selector(newModifier(@"L")),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addModifier(0  func:@selector(newModifier(@"R")),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addModifier(0  func:@selector(newModifier(@"R"))
                         ];
            VFVoice* voiceDown = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
                resolution: kRESOLUTION });
            voiceDown.addTickables(notesDown);

            VFFormatter *formatter = [VFFormatter formatter]
            joinVoices([voiceDown]).formatToStaff([voiceDown], staff);

            voiceDown.draw(ctx, staff);

            x += staff.width;
        }

        ok(YES, @"");
    }
     */
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 120) withParent:parent withTitle:title];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 280, 0)];
      [staff setBegBarType:VFBarLineRepeatBegin];
      [staff setEndBarType:VFBarLineSingle];
      [staff addClefWithName:@"percussion"];
      [staff draw:ctx];

      ok(YES, @"");
    };
}

- (void)drawSnare1:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    /*
    Vex.Flow.Test.Percussion.drawSnare1 = function(options, contextBuilder) {
        var ctx = contextBuilder(options.canvas_sel, 600, 120);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.setFont(@"Arial", 15, "");

        x = 10;
        y = 10;
        w = 280;

        {
            VFStaff *staff = [VFStaff staffWithRect:CGRectMake(x, y, w);
            staff setBegBarType:Vex.Flow.Barline.type.REPEAT_BEGIN);
            staff setEndBarType:Vex.Flow.Barline.type.SINGLE);
            staff addClefWithName:@"percussion");

            [staff draw:ctx];

            NSArray* notesDown = @[
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"q",
                stem_direction: -1 }).
                         addArticulation(0  func:@selector(newArticulation(@"ah")),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"q",
                stem_direction: -1 }),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"g/5/x2"], @"duration" : @"q",
                stem_direction: -1 }).
                         addArticulation(0  func:@selector(newArticulation(@"ah")),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"a/5/x3"], @"duration" : @"q",
                stem_direction: -1 }).
                         addArticulation(0  func:@selector(newArticulation(@"a,")),
                         ];
            VFVoice* voiceDown = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
                resolution: kRESOLUTION });
            voiceDown.addTickables(notesDown);

            VFFormatter *formatter = [VFFormatter formatter]
            joinVoices([voiceDown]).formatToStaff([voiceDown], staff);

            voiceDown.draw(ctx, staff);

            x += staff.width;
        }

        ok(YES, @"");
    }
     */
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 120) withParent:parent withTitle:title];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 280, 0)];
      [staff setBegBarType:VFBarLineRepeatBegin];
      [staff setEndBarType:VFBarLineSingle];
      [staff addClefWithName:@"percussion"];
      [staff draw:ctx];

      ok(YES, @"");
    };
}

- (void)drawSnare2:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    /*
    Vex.Flow.Test.Percussion.drawSnare2 = function(options, contextBuilder) {
        var ctx = contextBuilder(options.canvas_sel, 600, 120);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.setFont(@"Arial", 15, "");

        x = 10;
        y = 10;
        w = 280;

        {
            VFStaff *staff = [VFStaff staffWithRect:CGRectMake(x, y, w);
            staff setBegBarType:Vex.Flow.Barline.type.REPEAT_BEGIN);
            staff setEndBarType:Vex.Flow.Barline.type.SINGLE);
            staff addClefWithName:@"percussion");

            [staff draw:ctx];

            NSArray* notesDown = @[
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addArticulation(0  func:@selector(newTremolo(0)),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addArticulation(0  func:@selector(newTremolo(1)),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addArticulation(0  func:@selector(newTremolo(3)),
                         [[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/5"], @"duration" : @"q",
                stem_direction: -1 }).
                         addArticulation(0  func:@selector(newTremolo(5)),
                         ];
            VFVoice* voiceDown = new Vex.Flow.Voice({ num_beats: 4, beat_value: 4,
                resolution: kRESOLUTION });
            voiceDown.addTickables(notesDown);

            VFFormatter *formatter = [VFFormatter formatter]
            joinVoices([voiceDown]).formatToStaff([voiceDown], staff);

            voiceDown.draw(ctx, staff);

            x += staff.width;
        }

        ok(YES, @"");
    }
    */
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 120) withParent:parent withTitle:title];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 280, 0)];
      [staff setBegBarType:VFBarLineRepeatBegin];
      [staff setEndBarType:VFBarLineSingle];
      [staff addClefWithName:@"percussion"];
      [staff draw:ctx];

      ok(YES, @"");
    };
}

@end
