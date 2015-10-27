//
//  TabSlideTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TabSlideTests.h"
#import "VexFlowTestHelpers.h"

@implementation TabSlideTests

/**
 *

Vex.Flow.Test.TabSlide = {}

Vex.Flow.Test.TabSlide.Start = function() {
    module(@"TabSlide");
    [self runTest:@"Simple TabSlide"  func:@selector(simple:)];
    [self runTest:@"Slide Up"  func:@selector(slideUp:)];
    [self runTest:@"Slide Down"  func:@selector(slideDown:)];
}
 */
- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple TabSlide"  func:@selector(simple:)];
    [self runTest:@"Slide Up"  func:@selector(slideUp:)];
    [self runTest:@"Slide Down"  func:@selector(slideDown:)];
}




- (void)tieNotes:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabSlide.tieNotes = function(notes, indices, staff, ctx) {
        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice addTickables:notes];

        VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
        formatWith:@[voice] withJustifyWidth:100);
        [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

        var tie = new Vex.Flow.TabSlide({
        first_note: notes[0],
        last_note: notes[1],
        first_indices: indices,
        last_indices: indices,
        }, Vex.Flow.TabSlide.SLIDE_UP);

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
    Vex.Flow.Test.TabSlide.setupContext = function(options, x, y) {
        var ctx = options.contextBuilder(options.canvas_sel, 350, 140);
        ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.font = "10pt Arial";
        VFStaff *staff = new Vex.Flow.TabStaff(10, 10, x || 350).addTabGlyph().
        setContext(ctx).draw();

        return {context: ctx, staff: staff};
    }

     */
}

- (void)simple:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabSlide.simple = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        var c = Vex.Flow.Test.TabSlide.setupContext(options);
        function newNote(tab_struct) { return new Vex.Flow.TabNote(tab_struct); }

        Vex.Flow.Test.TabSlide.tieNotes([
                                         newNote({ positions: [{str:4, fret:4}], @"duration" : @"h"}),
                                         newNote({ positions: [{str:4, fret:6}], @"duration" : @"h"})
                                         ], [0], c.staff, c.context);
        ok(YES, @"Simple Test");
    }
     */
}

- (void)multiTest:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabSlide.multiTest = function(options, factory) {
        var c = Vex.Flow.Test.TabSlide.setupContext(options, 440, 100);
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

- (void)slideUp:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabSlide.slideUp = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        Vex.Flow.Test.TabSlide.multiTest(options, Vex.Flow.TabSlide.createSlideUp);
    }
     */
}

- (void)slideDown:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabSlide.slideDown = function(options, contextBuilder) {
        options.contextBuilder = contextBuilder;
        Vex.Flow.Test.TabSlide.multiTest(options, Vex.Flow.TabSlide.createSlideDown);
    }

    */
}

@end
