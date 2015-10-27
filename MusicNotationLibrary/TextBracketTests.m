//
//  TextBracketTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TextBracketTests.h"
#import "VexFlowTestHelpers.h"

@implementation TextBracketTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple TextBracket"  func:@selector(simple0:)];
    [self runTest:@"TextBracket Styles"  func:@selector(simple1:)];
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
     setContext(ctx).draw();s

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

- (void)simple0:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TextBracket.simple0 = function(options, contextBuilder) {
        expect(0);

        options.contextBuilder = contextBuilder;
        var ctx = new options.contextBuilder(options.canvas_sel, 650, 200);
        ctx.scale(1, 1); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.font = " 10pt Arial";
        //ctx.translate(0.5, 0.5);
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 40, 550).addTrebleGlyph();
        staff draw:ctx];

        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     @{ @"keys" : @[ @"c/4"], @"duration" : @"4"},
                     @{ @"keys" : @[ @"c/4"], @"duration" : @"4"},
                     @{ @"keys" : @[ @"c/4"], @"duration" : @"4"},
                     @{ @"keys" : @[ @"c/4"], @"duration" : @"4"}
                     ].map(newNote);

        VFVoice *voice = [VFVoice voiceWithTimeSignature:VFTime4_4] setStrict:NO];
        [voice addTickables:notes];

        var octave_top = new Vex.Flow.TextBracket({
        start: notes[0],
        stop: notes[3],
        text: "15",
        superscript: "va",
        position: 1
        });

        var octave_bottom = new Vex.Flow.TextBracket({
        start: notes[0],
        stop: notes[3],
        text: "8",
        superscript: "vb",
        position: -1
        });

        octave_bottom.setLine(3);

        [VFFormatter formatter] joinVoices:@[voice] formatToStaff([voice], staff);
        [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

        octave_top draw:ctx];
        octave_bottom draw:ctx];
    };
     */
}

- (void)simple1:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TextBracket.simple1 = function(options, contextBuilder) {
        expect(0);

        options.contextBuilder = contextBuilder;
        var ctx = new options.contextBuilder(options.canvas_sel, 650, 200);
        ctx.scale(1, 1); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
        ctx.font = " 10pt Arial";
        //ctx.translate(0.5, 0.5);
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 40, 550).addTrebleGlyph();
        staff draw:ctx];

        function newNote(note_struct) { return [[[VFStaffNote alloc]initWithDictionary:(note_struct); }

        NSArray *notes = @[
                     @{ @"keys" : @[ @"c/4"], @"duration" : @"4"},
                     @{ @"keys" : @[ @"c/4"], @"duration" : @"4"},
                     @{ @"keys" : @[ @"c/4"], @"duration" : @"4"},
                     @{ @"keys" : @[ @"c/4"], @"duration" : @"4"},
                     @{ @"keys" : @[ @"c/4"], @"duration" : @"4"}
                     ].map(newNote);

        VFVoice *voice = [VFVoice voiceWithTimeSignature:VFTime4_4] setStrict:NO];
        [voice addTickables:notes];

        var octave_top0 = new Vex.Flow.TextBracket({
        start: notes[0],
        stop: notes[1],
        text: "Cool notes",
        superscript: "",
        position: 1
        });

        var octave_bottom0 = new Vex.Flow.TextBracket({
        start: notes[2],
        stop: notes[4],
        text: "Not cool notes",
        superscript: " super uncool",
        position: -1
        });

        octave_bottom0->_renderOptions setbracket_height = 40;
        octave_bottom0.setLine(4);

        var octave_top1 = new Vex.Flow.TextBracket({
        start: notes[2],
        stop: notes[4],
        text: "Testing",
        superscript: "superscript",
        position: 1
        });

        var octave_bottom1 = new Vex.Flow.TextBracket({
        start: notes[0],
        stop: notes[1],
        text: "8",
        superscript: "vb",
        position: -1
        });

        octave_top1->_renderOptions setline_width = 2;
        octave_top1->_renderOptions setshow_bracket = NO;
        octave_bottom1.setDashed(YES, [2, 2]);
        octave_top1.setFont({
        weight: "",
        family: "Arial",
        size: 15
        });

        octave_bottom1.font.size = 30;
        octave_bottom1.setDashed(NO);
        octave_bottom1->_renderOptions setunderline_superscript = NO;

        octave_bottom1.setLine(3);

        [VFFormatter formatter] joinVoices:@[voice] formatToStaff([voice], staff);
        [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

        octave_top0 draw:ctx];
        octave_bottom0 draw:ctx];

        octave_top1 draw:ctx];
        octave_bottom1 draw:ctx];
    };
    */
}

@end
