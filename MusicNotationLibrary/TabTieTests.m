//
//  TabTieTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TabTieTests.h"
#import "VexFlowTestHelpers.h"

@implementation TabTieTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple TabTie"  func:@selector(simple:)];

    [self runTest:@"Hammerons"  func:@selector(simpleHammeron:)];

    [self runTest:@"Pulloffs"  func:@selector(simplePulloff:)];

    [self runTest:@"Tapping"  func:@selector(tap:)];

    [self runTest:@"Continuous"  func:@selector(continuous:)];
}




- (void)draw:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 150) withParent:parent];
    // [parent addSubview:test];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();

      // VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];

      // ok(YES, @"all pass");
    };
}

- (void)tieNotes
{
    /*
    Vex.Flow.Test.TabTie.tieNotes = function(notes, indices, staff, ctx, text) {
        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice addTickables:notes];

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:100);
        [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

        var tie = new Vex.Flow.TabTie({
        first_note: notes[0],
        last_note: notes[1],
        first_indices: indices,
        last_indices: indices,
        }, text || "Annotation");

        tie.setContext(ctx);
        tie.draw();
    }
     */
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
    Vex.Flow.Test.TabTie.setupContext = function(options, x, y) {
        var ctx = options.contextBuilder(options.canvas_sel, x || 350, y || 160);
        ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.setFont(@"Arial"  func:@selector(size, "");
        VFStaff *staff = new Vex.Flow.TabStaff(10, 10, x || 350).addTabGlyph().
        setContext(ctx).draw();

        return {context: ctx, staff: staff};
    }
     */
}

- (void)drawTie
{
    /*
    Vex.Flow.Test.TabTie.drawTie = function(notes, indices, options, text) {
        var c = Vex.Flow.Test.TabTie.setupContext(options);
        Vex.Flow.Test.TabTie.tieNotes(notes, indices, c.staff, c.context, text);
    }
     */
}

- (void)simple:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabTie.simple = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        function newNote(tab_struct) { return new Vex.Flow.TabNote(tab_struct); }

        Vex.Flow.Test.TabTie.drawTie([
                                      newNote({ positions: [{str:4, fret:4}], @"duration" : @"h"}),
                                      newNote({ positions: [{str:4, fret:6}], @"duration" : @"h"})
                                      ], [0], options);

        ok(YES, @"Simple Test");
    }
     */
}

- (void)tap:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabTie.tap = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        function newNote(tab_struct) { return new Vex.Flow.TabNote(tab_struct); }

        Vex.Flow.Test.TabTie.drawTie([
                                      newNote({ positions: [{str:4, fret:12}], @"duration" : @"h"}).
                                      addModifier(new Vex.Flow.Annotation(@"T"), 0),
                                      newNote({ positions: [{str:4, fret:10}], @"duration" : @"h"})
                                      ], [0], options, "P");

        ok(YES, @"Tapping Test");
    }
     */
}

- (void)multiTest:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabTie.multiTest = function(options, factory) {
        var c = Vex.Flow.Test.TabTie.setupContext(options, 440, 140);
        function newNote(tab_struct) { return new Vex.Flow.TabNote(tab_struct); }

        NSArray *notes = @[
                     newNote({ positions: [{str:4, fret:4}], @"duration" : @"8"}),
                     newNote({ positions: [{str:4, fret:4}], @"duration" : @"8"}),
                     newNote({ positions: [{str:4, fret:4}, {str:5, fret:4}], @"duration" : @"8"}),
                     newNote({ positions: [{str:4, fret:6}, {str:5, fret:6}], @"duration" : @"8"}),
                     newNote({ positions: [{str:2, fret:14}], @"duration" : @"8"}),
                     newNote({ positions: [{str:2, fret:16}], @"duration" : @"8"}),
                     newNote({ positions: [{str:2, fret:14}, {str:3, fret:14}], @"duration" : @"8"}),
                     newNote({ positions: [{str:2, fret:16}, {str:3, fret:16}], @"duration" : @"8"})
                     ];

        VFVoice *voice = [VFVoice voiceWithTimeSignature:VFTime4_4] addTickables:notes];
        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);
        voice.draw(c.context, c.staff);

        factory({
        first_note: notes[0],
        last_note: notes[1],
        first_indices: [0],
        last_indices: [0],
        }).setContext(c.context).draw();

        ok(YES, @"Single note");

        factory({
        first_note: notes[2],
        last_note: notes[3],
        first_indices: [0, 1],
        last_indices: [0, 1],
        }).setContext(c.context).draw();

        ok(YES, @"Chord");

        factory({
        first_note: notes[4],
        last_note: notes[5],
        first_indices: [0],
        last_indices: [0],
        }).setContext(c.context).draw();

        ok(YES, @"Single note high-fret");

        factory({
        first_note: notes[6],
        last_note: notes[7],
        first_indices: [0, 1],
        last_indices: [0, 1],
        }).setContext(c.context).draw();

        ok(YES, @"Chord high-fret");
    }
     */
}

- (void)simpleHammeron:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabTie.simpleHammeron = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        Vex.Flow.Test.TabTie.multiTest(options, Vex.Flow.TabTie.createHammeron);
    }
     */
}

- (void)simplePulloff:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabTie.simplePulloff = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        Vex.Flow.Test.TabTie.multiTest(options, Vex.Flow.TabTie.createPulloff);
    }
     */
}

- (void)continuous:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabTie.continuous = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.TabTie.setupContext(options, 440, 140);
        function newNote(tab_struct) { return new Vex.Flow.TabNote(tab_struct); }

        NSArray *notes = @[
                     newNote({ positions: [{str:4, fret:4}], @"duration" : @"q"}),
                     newNote({ positions: [{str:4, fret:5}], @"duration" : @"q"}),
                     newNote({ positions: [{str:4, fret:6}], @"duration" : @"h"})
                     ];

        VFVoice *voice = [VFVoice voiceWithTimeSignature:VFTime4_4] addTickables:notes];
        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:300);
        voice.draw(c.context, c.staff);

        Vex.Flow.TabTie.createHammeron({
        first_note: notes[0],
        last_note: notes[1],
        first_indices: [0],
        last_indices: [0],
        }).setContext(c.context).draw();

        Vex.Flow.TabTie.createPulloff({
        first_note: notes[1],
        last_note: notes[2],
        first_indices: [0],
        last_indices: [0],
        }).setContext(c.context).draw();
        ok(YES, @"Continuous Hammeron");
    }
    */
}

@end
