//
//  StaffNoteTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "StaffNoteTests.h"
#import "VexFlowTestHelpers.h"
//#import <XCTest/XCTest.h>
//#import <Specta/Specta.h>
//#import <Expecta/Expecta.h>

#import "VFStaffNote.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunused-variable"
#pragma clang diagnostic ignored "-Wconversion"

@implementation StaffNoteTests

- (void)start
{
    [super start];

    //    [self runTest:@"Tick" func:@selector(ticks)];
    //    [self runTest:@"Tick" func:@selector(ticksNewApi)];
    //    [self runTest:@"Stem" func:@selector(stem)];
    //    [self runTest:@"Automatic" func:@selector(autoStem)];
    //    [self runTest:@"Staffline" func:@selector(staffLine)];
    //    [self runTest:@"Width" func:@selector(width)];
    //    [self runTest:@"TickContext" func:@selector(tickContext)];
    //    [self runTest:@"StaffNote Draw - Treble"
    //             func:@selector(draw:options:)
    //            frame:CGRectMake(0, 0, 800, 180)
    //           params:@{
    //               @"clef" : @"treble",
    //               @"octaveShift" : @(0),
    //               @"restKey" : @"r/4"
    //           }];

    //    [self runTest:@"StaffNote BoundingBoxes - Treble"
    //             func:@selector(drawBoundingBoxes:options:)
    //            frame:CGRectMake(0, 0, 800, 180)
    //           params:@{
    //               @"clef" : @"treble",
    //               @"octaveShift" : @(0),
    //               @"restKey" : @"r/4"
    //           }];
    //
    //    [self runTest:@"StaffNote Draw - Alto"
    //             func:@selector(draw:options:)
    //            frame:CGRectMake(0, 0, 800, 180)
    //           params:@{
    //               @"clef" : @"alto",
    //               @"octaveShift" : @(-1),
    //               @"restKey" : @"r/4"
    //           }];
    //
    //    [self runTest:@"StaffNote Draw - Tenor"
    //             func:@selector(draw:options:)
    //            frame:CGRectMake(0, 0, 800, 180)
    //           params:@{
    //               @"clef" : @"tenor",
    //               @"octaveShift" : @(-1),
    //               @"restKey" : @"r/3"
    //           }];
    //
    //    [self runTest:@"StaffNote Draw - Bass"
    //             func:@selector(draw:options:)
    //            frame:CGRectMake(0, 0, 800, 180)
    //           params:@{
    //               @"clef" : @"bass",
    //               @"octaveShift" : @(-2),
    //               @"restKey" : @"r/3"
    //           }];

    //    [self runTest:@"StaffNote Draw - Harmonic And Muted"
    //             func:@selector(drawHarmonicAndMuted:)
    //            frame:CGRectMake(0, 0, 800, 180)];
    //
    //    [self runTest:@"StaffNote Draw - Slash" func:@selector(drawSlash:) frame:CGRectMake(0, 0, 800, 180)];
    //
    //    [self runTest:@"Displacements" func:@selector(drawDisplacements:) frame:CGRectMake(0, 0, 800, 180)];
    //
    /// broken test
    //            [self runTest:@"StaffNote Draw - Bass" func:@selector(drawBass:) frame:CGRectMake(0, 0, 800, 180)];

    [self runTest:@"StaffNote Draw - Key Styles" func:@selector(drawKeyStyles:) frame:CGRectMake(0, 0, 800, 180)];
    //    [self runTest:@"StaffNote Draw - StaffNote Styles"
    //             func:@selector(drawNoteStyles:)
    //            frame:CGRectMake(0, 0, 800, 180)];
    //
    //    [self runTest:@"Flag and Dot Placement - Stem Up"
    //             func:@selector(drawDotsAndFlagsStemUp:)
    //            frame:CGRectMake(0, 0, 700, 180)];
    //
    //    [self runTest:@"Flag and Dots Placement - Stem Down"
    //             func:@selector(drawDotsAndFlagsStemDown:)
    //            frame:CGRectMake(0, 0, 700, 180)];
    //
    //    /// one of the beams is broken
    //    [self runTest:@"Beam and Dot Placement - Stem Up"
    //             func:@selector(drawDotsAndBeamsUp:)
    //            frame:CGRectMake(0, 0, 700, 180)];
    //
    //    [self runTest:@"Beam and Dot Placement - Stem Down"
    //             func:@selector(drawDotsAndBeamsDown:)
    //            frame:CGRectMake(0, 0, 500, 180)];
    //    [self runTest:@"Center Aligned Note" func:@selector(drawCenterAlignedRest:) frame:CGRectMake(0, 0, 500, 150)];
    //    [self runTest:@"Center Aligned Note with Articulation"
    //             func:@selector(drawCenterAlignedRestFermata:)
    //            frame:CGRectMake(0, 0, 500, 150)];
    //    [self runTest:@"Center Aligned Note with Annotation"
    //             func:@selector(drawCenterAlignedRestAnnotation:)
    //            frame:CGRectMake(0, 0, 500, 150)];
    //    [self runTest:@"Center Aligned Note - Multi Voice"
    //             func:@selector(drawCenterAlignedMultiVoice:)
    //            frame:CGRectMake(0, 0, 500, 150)];
    //    [self runTest:@"Center Aligned Note with Multiple Modifiers"
    //             func:@selector(drawCenterAlignedNoteMultiModifiers:)
    //            frame:CGRectMake(0, 0, 500, 150)];
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

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h)
    // withParent:parent];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

// TODO: move comments to NSLog

- (void)ticks
{
    VFLogInfo(@"");
    float BEAT = 1 * kRESOLUTION / 4;

    VFStaffNote* note;

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"1/2"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 8));   //, @"Breve note has 8 beats");
    assertThat(note.noteNHMRSString, is(@"n"));                       //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"w"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 4));   //, @"Whole note has 4 beats");
    assertThat(note.noteNHMRSString, is(@"n"));                       //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"q"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT));   //, @"Quarter note has 1 beats");
    assertThat(note.noteNHMRSString, is(@"n"));                   //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"hd"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3));   //, @"Dotted half note has 3 beats");
    assertThat(note.noteNHMRSString, is(@"n"));                       //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"hdd"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.5));   //, @"Double-dotted half note has 3.5 beats");
    assertThat(note.noteNHMRSString, is(@"n"));                         //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"hddd"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.75));   //, @"Triple-dotted half note has 3.75
                                                                         //    beats");
    assertThat(note.noteNHMRSString, is(@"n"));                          //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"hdr"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3));   //, @"Dotted half rest has 3 beats");
    assertThat(note.noteNHMRSString, is(@"r"));                       //, @"Note type is 'r' for rest");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"hddr"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.5));   //, @"Double-dotted half rest has 3.5 beats");
    assertThat(note.noteNHMRSString, is(@"r"));                         //, @"Note type is 'r' for rest");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"hdddr"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.75));   //, @"Triple-dotted half rest has 3.75
                                                                         //    beats");
    assertThat(note.noteNHMRSString, is(@"r"));                          //, @"Note type is 'r' for rest");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"qdh"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 1.5));   //,
    //          @"Dotted harmonic quarter note has 1.5 beats");
    assertThat(note.noteNHMRSString, is(@"h"));   //, @"Note type is 'h' for harmonic note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"qddh"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 1.75));   //,
    //          @"Double-dotted harmonic quarter note has 1.75 beats");
    assertThat(note.noteNHMRSString, is(@"h"));   //, @"Note type is 'h' for harmonic note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"qdddh"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 1.875));   //,
    //          @"Triple-dotted harmonic quarter note has 1.875 beats");
    assertThat(note.noteNHMRSString, is(@"h"));   //, @"Note type is 'h' for harmonic note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"8dm"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 0.75));   //, @"Dotted muted 8th note has 0.75 beats");
    assertThat(note.noteNHMRSString, is(@"m"));                          //, @"Note type is 'm' for muted note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"8ddm"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 0.875));   //,
    //          @"Double-dotted muted 8th note has 0.875 beats");
    assertThat(note.noteNHMRSString, is(@"m"));   //, @"Note type is 'm' for muted note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"8dddm"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 0.9375));   //,
    //          @"Triple-dotted muted 8th note has 0.9375 beats");
    assertThat(note.noteNHMRSString, is(@"m"));   //, @"Note type is 'm' for muted note");

    //    @try
    //    {
    //        note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"8.7dddm"];
    //        //        [NSException raise:@"" format:@""];
    //    }
    //    @catch(NSException* exception)
    //    {
    //        assertThat(exception.reason,
    //                   is(@"BadArguments"));   //, @"Invalid note duration '8.7' throws BadArguments exception"));
    //    }
    //
    //    @try
    //    {
    //        note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"2Z"];
    //        //        [NSException raise:@"" format:@""];
    //    }
    //    @catch(NSException* exception)
    //    {
    //        assertThat(exception.reason,
    //                   is(@"BadArguments"));   //, @"Invalid note type 'Z' throws BadArguments exception");
    //    }
    //
    //    @try
    //    {
    //        note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"2dddZ"];
    //        //        [NSException raise:@"" format:@""];
    //    }
    //    @catch(NSException* exception)
    //    {
    //        assertThat(exception.reason,
    //                   is(@"BadArguments"));   //, @"Invalid note type 'Z' for dotted note throws BadArguments
    //                                           //                   exception");
    //    }
}

- (void)ticksNewApi
{
    VFLogInfo(@"");
    float BEAT = 1 * kRESOLUTION / 4;

    VFStaffNote* note;
    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"1"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 4));   //, @"Whole note has 4 beats");
    assertThat(note.noteNHMRSString, is(@"n"));                       //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"4"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT));   //, @"Quarter note has 1 beats");
    assertThat(note.noteNHMRSString, is(@"n"));                   //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"2" dots:1];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3));   //, @"Dotted half note has 3 beats");
    assertThat(note.noteNHMRSString, is(@"n"));                       //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"hdd" dots:2];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.5));   //, @"Double-dotted half note has 3.5 beats");
    assertThat(note.noteNHMRSString, is(@"n"));                         //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"hddd" dots:3];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.75));   //, @"Triple-dotted half note has 3.75
                                                                         //    beats ");
    assertThat(note.noteNHMRSString, is(@"n"));                          //, @"Note type is 'n' for normal note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"2" dots:1 type:@"r"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3));   //, @"Dotted half rest has 3 beats");
    assertThat(note.noteNHMRSString, is(@"r"));                       //, @"Note type is 'r' for rest");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"2" dots:2 type:@"r"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.5));   //, @"Double-dotted half rest has 3.5 beats");
    assertThat(note.noteNHMRSString, is(@"r"));                         //, @"Note type is 'r' for rest");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"2" dots:3 type:@"r"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.75));   //, @"Triple-dotted half rest has 3.75
                                                                         //    beats ");
    assertThat(note.noteNHMRSString, is(@"r"));                          //, @"Note type is 'r' for rest");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"4" dots:1 type:@"h"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 1.5));   //,
    //          @"Dotted harmonic quarter note has 1.5 beats");
    assertThat(note.noteNHMRSString, is(@"h"));   //, @"Note type is 'h' for harmonic note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"4" dots:2 type:@"h"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 1.75));   //,
    //          @"Double-dotted harmonic quarter note has 1.75 beats");
    assertThat(note.noteNHMRSString, is(@"h"));   //, @"Note type is 'h' for harmonic note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"4" dots:3 type:@"h"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 1.875));   //,
    //          @"Triple-dotted harmonic quarter note has 1.875 beats");
    assertThat(note.noteNHMRSString, is(@"h"));   //, @"Note type is 'h' for harmonic note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"8" dots:1 type:@"m"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 0.75));   //, @"Dotted muted 8th note has 0.75 beats");
    assertThat(note.noteNHMRSString, is(@"m"));                          //, @"Note type is 'm' for muted note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"8" dots:2 type:@"m"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 0.875));   //,
    //          @"Double-dotted muted 8th note has 0.875 beats");
    assertThat(note.noteNHMRSString, is(@"m"));   //, @"Note type is 'm' for muted note");

    note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"8" dots:3 type:@"m"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 0.9375));   //,
    //          @"Triple-dotted muted 8th note has 0.9375 beats");
    assertThat(note.noteNHMRSString, is(@"m"));   //, @"Note type is 'm' for muted note");

    note = [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"1s"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 4));   //; //, @"Whole note has 4 beats");
    assertThat(note.noteNHMRSString, is(@"s"));                       //, @"Note type is 's' for slash note");

    note = [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"4s"];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT));   //, @"Quarter note has 1 beats");
    assertThat(note.noteNHMRSString, is(@"s"));                   //, @"Note type is 's' for slash note");

    note = [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"2s" dots:1];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3));   //, @"Dotted half note has 3 beats");
    assertThat(note.noteNHMRSString, is(@"s"));                       //, @"Note type is 's' for slash note");

    note = [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"2s" dots:2];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.5));   //, @"Double-dotted half note has 3.5 beats");
    assertThat(note.noteNHMRSString, is(@"s"));                         //, @"Note type is 's' for slash note");

    note = [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"2s" dots:3];
    assertThatFloat(note.ticks.floatValue, equalToFloat(BEAT * 3.75));   //,
    //          @"Triple-dotted half note has 3.75 beats");
    assertThat(note.noteNHMRSString, is(@"s"));   //, @"Note type is 's' for slash note");

    //    @try
    //    {
    //        note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"8.7"];
    //        [NSException raise:@"" format:@""];
    //    }
    //    @catch(NSException* exception)
    //    {
    //        assertThat(exception.reason, is(@"BadArguments"));   //,
    //        //              @"Invalid note duration '8.7' throws BadArguments exception");
    //    }
    //
    //    @try
    //    {
    //        note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"8" dots:@"three"];
    //        [NSException raise:@"" format:@""];
    //    }
    //    @catch(NSException* exception)
    //    {
    //        assertThat(exception.reason,
    //                   is(@"BadArguments"));   //, @"Invalid note type 'Z' throws BadArguments exception");
    //    }
    //
    //    @try
    //    {
    //        note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"2" dots:@"Z"];
    //        [NSException raise:@"" format:@""];
    //    }
    //    @catch(NSException* exception)
    //    {
    //        assertThat(exception.reason, is(@"BadArguments"));   //,
    //        //              @"Invalid note type 'Z' for dotted note throws BadArguments exception");
    //    }
}

- (void)stem
{
    VFLogInfo(@"");
    VFStaffNote* note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"w"];
    assertThatInt(note.stemDirection, equalToInt(VFStemDirectionUp));   //, @"Default note has UP stem");
}

- (void)autoStem
{
    VFLogInfo(@"");
    VFStaffNote* note = [VFStaffNote noteWithKeys:@[ @"c/5", @"e/5", @"g/5" ] andDuration:@"8" autoStem:YES];
    assertThatInt(note.stemDirection, equalToInt(VFStemDirectionDown));   //, @"Stem must be down");

    note = [VFStaffNote noteWithKeys:@[ @"c/5", @"e/4", @"g/4" ] andDuration:@"8" autoStem:YES];
    assertThatInt(note.stemDirection, equalToInt(VFStemDirectionUp));   //, @"Stem must be up");

    note = [VFStaffNote noteWithKeys:@[ @"c/5" ] andDuration:@"8" autoStem:YES];
    assertThatInt(note.stemDirection, equalToInt(VFStemDirectionUp));   //, @"Stem must be up");

    note = [VFStaffNote noteWithKeys:@[ @"a/4", @"e/5", @"g/5" ] andDuration:@"8" autoStem:YES];
    assertThatInt(note.stemDirection, equalToInt(VFStemDirectionDown));   //, @"Stem must be down");

    note = [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"8" autoStem:YES];
    assertThatInt(note.stemDirection, equalToInt(VFStemDirectionUp));   //, @"Stem must be up");
}

- (void)staffLine
{
    VFLogInfo(@"");
    VFStaffNote* note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"w"];

    NSArray* props = note.keyProps;
    assertThatFloat(((KeyProperty*)props[0]).line, equalToFloat(0.f));
    NSLog(@"C/4 on line 0");

    assertThatFloat(((KeyProperty*)props[1]).line, equalToFloat(1.f));
    NSLog(@"E/4 on line 1");

    assertThatFloat(((KeyProperty*)props[2]).line, equalToFloat(2.5f));
    NSLog(@"A/4 on line 2.5");

    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];
    note.staff = staff;

    NSArray* ys = note.ys;
    assertThatUnsignedInt(ys.count, equalToUnsignedInt(3));
    NSLog(@"Chord should be rendered on three lines");
    assertThatFloat([ys[0] floatValue], equalToFloat(100.f));
    NSLog(@"Line for C/4");
    assertThatFloat([ys[1] floatValue], equalToFloat(90.f));
    NSLog(@"Line for E/4");
    assertThatFloat([ys[2] floatValue], equalToFloat(75.f));
    NSLog(@"Line for A/4");
}

/*

    try {
        id width = note.getWidth();
    } catch (e) {
        equal(e.code, @"UnformattedNote",
              @"Unformatted note should have no width");
    }
}
 */

- (void)width
{
    VFLogInfo(@"");
    VFStaffNote* note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"w"];

    @try
    {
        float width = note.width;
    }
    @catch(NSException* e)
    {
        assertThat(e.reason, is(@"UnformattedNote"));
        NSLog(@"Unformatted note should have no width");
    }
}

- (void)tickContext
{
    VFLogInfo(@"");
    VFStaffNote* note = [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"w"];
    VFTickContext* tickContext = [[VFTickContext alloc] init];
    [tickContext addTickable:note];
    [tickContext preFormat];
    tickContext.x = 10;
    tickContext.padding = 0;
    assertThatFloat(tickContext.width, equalToFloat(75.f));
}

//- (VFStaffNote*)showNote:(NSDictionary*)noteStruct onStaff:(VFStaff*)staff withContext:(CGContextRef)ctx atX:(float)x
//{
//    VFLogInfo(@"");
//    VFStaffNote* ret = [[VFStaffNote alloc] initWithDictionary:noteStruct];
//    VFTickContext* tickContext = [[VFTickContext alloc] init];
//    [[tickContext addTickable:ret] preFormat];
//    tickContext.x = x;
//    tickContext.pixelsUsed = 20;
//    ret.staff = staff;
//    [ret draw:ctx];
//    //    if(drawBoundingBox)
//    //    {
//    //        [note.boundingBox draw:ctx];
//    //    }
//    return ret;
//}
//
//- (VFStaffNote*)showNote:(NSDictionary*)noteStruct
//                 onStaff:(VFStaff*)staff
//             withContext:(CGContextRef)ctx
//                     atX:(float)x
//         withBoundingBox:(BOOL)drawBoundingBox
//{
//    VFLogInfo(@"");
//    VFStaffNote* ret = [[VFStaffNote alloc] initWithDictionary:noteStruct];
//    VFTickContext* tickContext = [[VFTickContext alloc] init];
//    [[tickContext addTickable:ret] preFormat];
//    tickContext.x = x;
//    tickContext.pixelsUsed = 20;
//    ret.staff = staff;
//    [ret draw:ctx];
//    if(drawBoundingBox)
//    {
//        [ret.boundingBox draw:ctx];
//    }
//    return ret;
//}

- (TestTuple*)draw:(TestCollectionItemView*)parent options:(NSDictionary*)options
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    //    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGRectMake(0, 0,
    //    700, 180)];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 180)
    // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {

    //        CGContextRef ctx = VFGraphicsContext();

    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 30, 750, 0)];

    NSString* clefName = (options[@"clef"] != nil ? options[@"clef"] : @"treble");

    NSString* restKey = options[@"restKey"];
    NSUInteger octaveShift = [options[@"octaveShift"] integerValue];

    VFClef* clef = [VFClef clefWithName:clefName];
    //      staff.clef = clef;
    [staff addClef:clef];

    // CGContextRef ctx = context.CGContext;

    staff.clef = clef;
    //        [staff draw:ctx];

    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];

      NSMutableArray* lowerKeys = [@[ @"c/", @"e/", @"a/" ] mutableCopy];
      NSMutableArray* higherKeys = [@[ @"c/", @"e/", @"a/" ] mutableCopy];
      for(int k = 0; k < lowerKeys.count; ++k)
      {
          lowerKeys[k] = [NSString stringWithFormat:@"%@%lu", lowerKeys[k], (4 + octaveShift)];
          higherKeys[k] = [NSString stringWithFormat:@"%@%lu", higherKeys[k], (5 + octaveShift)];
      }

      NSArray* restKeys = @[ restKey ];

      NSArray* notes = @[
          @{ @"clef" : clef,
             @"keys" : higherKeys,
             @"duration" : @"1/2" },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"w" },
          @{ @"clef" : clef,
             @"keys" : higherKeys,
             @"duration" : @"h" },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"q" },
          @{ @"clef" : clef,
             @"keys" : higherKeys,
             @"duration" : @"8" },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"16" },
          @{ @"clef" : clef,
             @"keys" : higherKeys,
             @"duration" : @"32" },
          @{ @"clef" : clef,
             @"keys" : higherKeys,
             @"duration" : @"64" },
          @{ @"clef" : clef,
             @"keys" : higherKeys,
             @"duration" : @"128" },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"1/2",
             @"stem_direction" : @(-1) },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"w",
             @"stem_direction" : @(-1) },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"h",
             @"stem_direction" : @(-1) },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"q",
             @"stem_direction" : @(-1) },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"8",
             @"stem_direction" : @(-1) },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"16",
             @"stem_direction" : @(-1) },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"32",
             @"stem_direction" : @(-1) },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"64",
             @"stem_direction" : @(-1) },
          @{ @"clef" : clef,
             @"keys" : lowerKeys,
             @"duration" : @"128",
             @"stem_direction" : @(-1) },

          @{ @"clef" : clef,
             @"keys" : restKeys,
             @"duration" : @"1/2r" },
          @{ @"clef" : clef,
             @"keys" : restKeys,
             @"duration" : @"wr" },
          @{ @"clef" : clef,
             @"keys" : restKeys,
             @"duration" : @"hr" },
          @{ @"clef" : clef,
             @"keys" : restKeys,
             @"duration" : @"qr" },
          @{ @"clef" : clef,
             @"keys" : restKeys,
             @"duration" : @"8r" },
          @{ @"clef" : clef,
             @"keys" : restKeys,
             @"duration" : @"16r" },
          @{ @"clef" : clef,
             @"keys" : restKeys,
             @"duration" : @"32r" },
          @{ @"clef" : clef,
             @"keys" : restKeys,
             @"duration" : @"64r" },
          @{ @"clef" : clef,
             @"keys" : restKeys,
             @"duration" : @"128r" },
          @{ @"keys" : @[ @"x/4" ],
             @"duration" : @"h" }
      ];

      //      expect(notes.count * 2);   // TODO: does nothing right now

      for(int i = 0; i < notes.count; ++i)
      {
          NSDictionary* note = notes[i];
          VFStaffNote* staffNote = [parent showNote:note onStaff:staff withContext:ctx atX:(i + 1) * 25];
          staffNote.staff = staff;

          NSString* descriptionX = [NSString stringWithFormat:@"Note %i has X value", i];
          assertThatInteger(staffNote.x, greaterThan(@(0.f)));
          VFLogInfo(@"%@", descriptionX);
          NSString* descriptionYs = [NSString stringWithFormat:@"Note %i has Y values", i];
          assertThatInteger(staffNote.ys.count, greaterThan(@(0)));
          VFLogInfo(@"%@", descriptionYs);
      }
    };

    return ret;
}

- (TestTuple*)drawBoundingBoxes:(TestCollectionItemView*)parent options:(NSDictionary*)options
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    //    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGRectMake(0, 0,
    //    700, 180)];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(700, 180)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {

    CGContextRef ctx = VFGraphicsContext();

    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 30, 750, 0)];

    NSString* clefName = (options[@"clef"] != nil ? options[@"clef"] : @"treble");

    NSString* restKey = options[@"restKey"];
    NSUInteger octaveShift = [options[@"octaveShift"] integerValue];

    VFClef* clef = [VFClef clefWithName:clefName];
    staff.clef = clef;

    // CGContextRef ctx = context.CGContext;

    staff.clef = clef;
    [staff draw:ctx];

    NSMutableArray* lowerKeys = [@[ @"c/", @"e/", @"a/" ] mutableCopy];
    NSMutableArray* higherKeys = [@[ @"c/", @"e/", @"a/" ] mutableCopy];
    for(int k = 0; k < lowerKeys.count; ++k)
    {
        lowerKeys[k] = [NSString stringWithFormat:@"%@%lu", lowerKeys[k], (4 + octaveShift)];
        higherKeys[k] = [NSString stringWithFormat:@"%@%lu", higherKeys[k], (5 + octaveShift)];
    }

    NSArray* restKeys = @[ restKey ];

    NSArray* notes = @[
        @{ @"clef" : clef,
           @"keys" : higherKeys,
           @"duration" : @"1/2" },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"w" },
        @{ @"clef" : clef,
           @"keys" : higherKeys,
           @"duration" : @"h" },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"q" },
        @{ @"clef" : clef,
           @"keys" : higherKeys,
           @"duration" : @"8" },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"16" },
        @{ @"clef" : clef,
           @"keys" : higherKeys,
           @"duration" : @"32" },
        @{ @"clef" : clef,
           @"keys" : higherKeys,
           @"duration" : @"64" },
        @{ @"clef" : clef,
           @"keys" : higherKeys,
           @"duration" : @"128" },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"1/2",
           @"stem_direction" : @(-1) },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"w",
           @"stem_direction" : @(-1) },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"h",
           @"stem_direction" : @(-1) },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"q",
           @"stem_direction" : @(-1) },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"8",
           @"stem_direction" : @(-1) },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"16",
           @"stem_direction" : @(-1) },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"32",
           @"stem_direction" : @(-1) },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"64",
           @"stem_direction" : @(-1) },
        @{ @"clef" : clef,
           @"keys" : lowerKeys,
           @"duration" : @"128",
           @"stem_direction" : @(-1) },

        @{ @"clef" : clef,
           @"keys" : restKeys,
           @"duration" : @"1/2r" },
        @{ @"clef" : clef,
           @"keys" : restKeys,
           @"duration" : @"wr" },
        @{ @"clef" : clef,
           @"keys" : restKeys,
           @"duration" : @"hr" },
        @{ @"clef" : clef,
           @"keys" : restKeys,
           @"duration" : @"qr" },
        @{ @"clef" : clef,
           @"keys" : restKeys,
           @"duration" : @"8r" },
        @{ @"clef" : clef,
           @"keys" : restKeys,
           @"duration" : @"16r" },
        @{ @"clef" : clef,
           @"keys" : restKeys,
           @"duration" : @"32r" },
        @{ @"clef" : clef,
           @"keys" : restKeys,
           @"duration" : @"64r" },
        @{ @"clef" : clef,
           @"keys" : restKeys,
           @"duration" : @"128r" },
        @{ @"keys" : @[ @"x/4" ],
           @"duration" : @"h" }
    ];

    //      expect(notes.count * 2);   // TODO: does nothing right now
    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];
      for(int i = 0; i < notes.count; ++i)
      {
          NSDictionary* note = [notes objectAtIndex:i];

          VFStaffNote* staffNote =
              [parent showNote:note onStaff:staff withContext:ctx atX:(i + 1) * 25 withBoundingBox:YES];

          NSString* descriptionX = [NSString stringWithFormat:@"Note %i has X value", i];
          assertThatInteger(staffNote.x, greaterThan(@(0.f)));
          VFLogInfo(@"%@", descriptionX);
          NSString* descriptionYs = [NSString stringWithFormat:@"Note %i has Y values", i];
          assertThatInteger(staffNote.ys.count, greaterThan(@(0)));
          VFLogInfo(@"%@", descriptionYs);
      }
    };
    return ret;
}

- (TestTuple*)drawBass:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    //    expect(40);
    //    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGRectMake(0, 0,
    //    600, 280)];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 280)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {

    CGContextRef ctx = VFGraphicsContext();

    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 650, 0)];
    //    VFStaff *staff2 = [VFStaff staffWithRect:CGRectMake(10, 150, 650, 0)];
    NSString* clefName = @"bass";
    VFClef* clef = [VFClef clefWithName:clefName];
    // CGContextRef ctx = context.CGContext;

    staff.clef = clef;
    [staff draw:ctx];

    NSArray* notes = @[
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/3", @"e/3", @"a/3" ],
           @"duration" : @"1/2" },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/2", @"e/2", @"a/2" ],
           @"duration" : @"w" },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/3", @"e/3", @"a/3" ],
           @"duration" : @"h" },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/2", @"e/2", @"a/2" ],
           @"duration" : @"q" },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/3", @"e/3", @"a/3" ],
           @"duration" : @"8" },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/2", @"e/2", @"a/2" ],
           @"duration" : @"16" },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/3", @"e/3", @"a/3" ],
           @"duration" : @"32" },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/2", @"e/2", @"a/2" ],
           @"duration" : @"h",
           @"stem_direction" : @(-1) },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/2", @"e/2", @"a/2" ],
           @"duration" : @"q",
           @"stem_direction" : @(-1) },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/2", @"e/2", @"a/2" ],
           @"duration" : @"8",
           @"stem_direction" : @(-1) },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/2", @"e/2", @"a/2" ],
           @"duration" : @"16",
           @"stem_direction" : @(-1) },
        @{ @"clef" : @"bass",
           @"keys" : @[ @"c/2", @"e/2", @"a/2" ],
           @"duration" : @"32",
           @"stem_direction" : @(-1) },

        @{ @"keys" : @[ @"r/4" ],
           @"duration" : @"1/2r" },
        @{ @"keys" : @[ @"r/4" ],
           @"duration" : @"wr" },
        @{ @"keys" : @[ @"r/4" ],
           @"duration" : @"hr" },
        @{ @"keys" : @[ @"r/4" ],
           @"duration" : @"qr" },
        @{ @"keys" : @[ @"r/4" ],
           @"duration" : @"8r" },
        @{ @"keys" : @[ @"r/4" ],
           @"duration" : @"16r" },
        @{ @"keys" : @[ @"r/4" ],
           @"duration" : @"32r" },
        @{ @"keys" : @[ @"x/4" ],
           @"duration" : @"h" }
    ];

    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];
      for(int i = 0; i < notes.count; ++i)
      {
          NSDictionary* note = notes[i];
          VFStaffNote* staffNote = [parent showNote:note onStaff:staff withContext:ctx atX:(i + 1)];
          staffNote.staff = staff;
          assertThatInteger(staffNote.x, greaterThan(@(0.f)));
          VFLogInfo(@"Note %i %@", i, @" has X value");
          assertThatInteger(staffNote.ys.count, greaterThan(@(0)));
          VFLogInfo(@"Note %i %@", i, @" has Y values");
      }
    };
    return ret;
}

- (TestTuple*)drawDisplacements:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    //    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGRectMake(0, 0,
    //    700, 140)];
    //    ctx.scale(0.9, 0.9); ctx.fillStyle = @"#221"; ctx.strokeStyle = @"#221";
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(700, 140)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {

    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 650, 0)];
    // CGContextRef ctx = context.CGContext;

    //    [staff draw:ctx];

    NSArray* notes = @[
        @{ @"keys" : @[ @"g/3", @"a/3", @"c/4", @"d/4", @"e/4" ],
           @"duration" : @"1/2" },
        @{ @"keys" : @[ @"g/3", @"a/3", @"c/4", @"d/4", @"e/4" ],
           @"duration" : @"w" },
        @{ @"keys" : @[ @"d/4", @"e/4", @"f/4" ],
           @"duration" : @"h" },
        @{ @"keys" : @[ @"f/4", @"g/4", @"a/4", @"b/4" ],
           @"duration" : @"q" },
        @{ @"keys" : @[ @"e/3", @"b/3", @"c/4", @"e/4", @"f/4", @"g/5", @"a/5" ],
           @"duration" : @"8" },
        @{ @"keys" : @[ @"a/3", @"c/4", @"e/4", @"g/4", @"a/4", @"b/4" ],
           @"duration" : @"16" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"32" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4", @"a/4" ],
           @"duration" : @"64" },
        @{ @"keys" : @[ @"g/3", @"c/4", @"d/4", @"e/4" ],
           @"duration" : @"h",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"d/4", @"e/4", @"f/4" ],
           @"duration" : @"q",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"f/4", @"g/4", @"a/4", @"b/4" ],
           @"duration" : @"8",
           @"stem_direction" : @(-1) },
        @{
            @"keys" : @[ @"c/4", @"d/4", @"e/4", @"f/4", @"g/4", @"a/4" ],
            @"duration" : @"16",
            @"stem_direction" : @(-1)
        },
        @{
            @"keys" : @[ @"b/3", @"c/4", @"e/4", @"a/4", @"b/5", @"c/6", @"e/6" ],
            @"duration" : @"32",
            @"stem_direction" : @(-1)
        },
        @{
            @"keys" : @[ @"b/3", @"c/4", @"e/4", @"a/4", @"b/5", @"c/6", @"e/6", @"e/6" ],
            @"duration" : @"64",
            @"stem_direction" : @(-1)
        }
    ];
    //      expect(notes.count * 2);
    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];
      for(int i = 0; i < notes.count; ++i)
      {
          NSDictionary* note = notes[i];
          VFStaffNote* staffNote = [parent showNote:note onStaff:staff withContext:ctx atX:(i + 1) * 45];
          // showNote(note, Staff, ctx, (i + 1) * 45);
          staffNote.staff = staff;
          assertThatInteger(staffNote.x, greaterThan(@(0.f)));
          VFLogInfo(@"Note %i %@", i, @" has X value");
          assertThatInteger(staffNote.ys.count, greaterThan(@(0)));
          VFLogInfo(@"Note %i %@", i, @" has Y values");
      }
    };
    return ret;
}

- (TestTuple*)drawHarmonicAndMuted:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(300, 180)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 280, 0)];
    // CGContextRef ctx = context.CGContext;

    //        [staff draw:ctx];

    NSArray* notes = @[
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"1/2h" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"wh" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"hh" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"qh" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"8h" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"16h" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"32h" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"64h" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"128h" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"1/2h",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"wh",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"hh",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"qh",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"8h",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"16h",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"32h",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"64h",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"128h",
           @"stem_direction" : @(-1) },

        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"1/2m" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"wm" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"hm" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"qm" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"8m" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"16m" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"32m" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"64m" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"128m" },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"1/2m",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"wm",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"hm",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"qm",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"8m",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"16m",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"32m",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"64m",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
           @"duration" : @"128m",
           @"stem_direction" : @(-1) }
    ];
    //      expect(notes.count * 2);
    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];
      for(int i = 0; i < notes.count; ++i)
      {
          NSDictionary* note = notes[i];
          //        VFStaffNote *staffNote = showNote(note, Staff, ctx, (i + 1) * 25);
          VFStaffNote* staffNote = [parent showNote:note onStaff:staff withContext:ctx atX:(i + 1) * 25];
          staffNote.staff = staff;
          assertThatInteger(staffNote.x, greaterThan(@(0.f)));
          VFLogInfo(@"Note %i %@", i, @" has X value");
          assertThatInteger(staffNote.ys.count, greaterThan(@(0)));
          VFLogInfo(@"Note %i %@", i, @" has Y values");
      }
    };
    return ret;
}

- (TestTuple*)drawSlash:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(700, 180)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 650, 0)];
    // CGContextRef ctx = context.CGContext;

    //        [staff draw:ctx];

    NSArray* notes = @[
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"1/2s",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"ws",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"hs",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"qs",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"8s",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"16s",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"32s",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"64s",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"128s",
           @"stem_direction" : @(-1) },

        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"1/2s",
           @"stem_direction" : @(1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"ws",
           @"stem_direction" : @(1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"hs",
           @"stem_direction" : @(1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"qs",
           @"stem_direction" : @(1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"8s",
           @"stem_direction" : @(1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"16s",
           @"stem_direction" : @(1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"32s",
           @"stem_direction" : @(1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"64s",
           @"stem_direction" : @(1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"128s",
           @"stem_direction" : @(1) },

        // Beam
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"8s",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"8s",
           @"stem_direction" : @(-1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"8s",
           @"stem_direction" : @(1) },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"8s",
           @"stem_direction" : @(1) }
    ];

    //    id Staff_notes = notes.map(function(note) {return new Vex.Flow.StaffNote(note)});
    NSArray* Staff_notes = [notes oct_map:^VFStaffNote*(NSDictionary* d) {
      VFStaffNote* ret = [[VFStaffNote alloc] initWithDictionary:d];
      ret.staff = staff;
      return ret;
    }];

    VFBeam* beam1 = [VFBeam beamWithNotes:@[ Staff_notes[16], Staff_notes[17] ]];
    VFBeam* beam2 = [VFBeam beamWithNotes:@[ Staff_notes[18], Staff_notes[19] ]];

    //    Vex.Flow.Formatter.FormatAndDraw(ctx, Staff, Staff_notes, NO);
    VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
    voice.mode = VFModeSoft;

    [voice addTickables:Staff_notes];

    VFFormatter* formatter =
        //        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staff withNotes:Staff_notes];
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

    // TODO: this needs to be set up as a block for drawing
    //        [beam1 draw:ctx];
    //        [beam2 draw:ctx];

    ok(YES, @"Slash Note Heads");
    //    };
    [ret.voices addObject:voice];
    //    ret.voice2 = voice1;
    [ret.formatters addObject:formatter];
    [ret.staves addObject:staff];
    [ret.beams addObjectsFromArray:@[ beam1, beam2 ]];
    return ret;
}

- (TestTuple*)drawKeyStyles:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(300, 280)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(50, 50, 100, 0)];
    // CGContextRef ctx = context.CGContext;
    //        [staff draw:ctx];
    NSDictionary* note_struct = @{ @"keys" : @[ @"g/4", @"bb/4", @"d/5" ], @"duration" : @"q" };
    VFStaffNote* note = [[VFStaffNote alloc] initWithDictionary:note_struct];
    [note addAccidental:[VFAccidental accidentalWithType:@"b"] atIndex:1];
    note.styleBlock = ^(CGContextRef ctx) {
      //(1, {shadowBlur:15, shadowColor:'blue', fillStyle:'blue'});
      ////https://developer.apple.com/library/ios/documentation/GraphicsImaging/Conceptual/drawingwithquartz2d/dq_shadows/dq_shadows.html#//apple_ref/doc/uid/TP30001066-CH208-TPXREF101
      CGSize myShadowOffset = CGSizeMake(1, 1);   // 2
      CGFloat myColorValues[] = {0, 0, 1, .6};    // 3
      CGColorRef myColor;                         // 4
      CGColorSpaceRef myColorSpace;               // 5

      //                  CGContextSaveGState(ctx);// 6

      CGContextSetShadow(ctx, myShadowOffset, 15);   // <--- 3rd arg is blur value
      // Your drawing code here// 8
      CGContextSetRGBFillColor(ctx, 0, 0, 1, 1);
      CGContextSetRGBStrokeColor(ctx, 0, 0, 1, 1);
      //                  CGContextFillRect (ctx, CGRectMake (wd/3 + 75, ht/2 , wd/4, ht/4));
      //
      myColorSpace = CGColorSpaceCreateDeviceRGB();                   // 9
      myColor = CGColorCreate(myColorSpace, myColorValues);           // 10
      CGContextSetShadowWithColor(ctx, myShadowOffset, 15, myColor);   // 11
      // Your drawing code here// 12
      //                  CGContextSetRGBFillColor (ctx, 0, 0, 1, 1);
      //                  CGContextFillRect (ctx, CGRectMake (wd/3-75,ht/2-100,wd/4,ht/4));

      CGColorRelease(myColor);             // 13
      CGColorSpaceRelease(myColorSpace);   // 14
                                           //
                                           //                  CGContextRestoreGState(ctx);
    };

    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//      [staff draw:ctx];
      VFTickContext* tickContext = [[VFTickContext alloc] init];
      [[tickContext addTickable:note] preFormat];
      tickContext.x = 25;
      tickContext.pixelsUsed = 20;
      note.staff = staff;
      [note draw:ctx];

      ok(note.x > 0, @"Note has X value");
      ok(note.ys.count > 0, @"Note has Y values");
    };
    return ret;
}

- (TestTuple*)drawNoteStyles:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(300, 280)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 0, 100, 0)];
    // CGContextRef ctx = context.CGContext;
    //        [staff draw:ctx];

    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];
      NSDictionary* note_struct = @{ @"keys" : @[ @"g/4", @"bb/4", @"d/5" ], @"duration" : @"q" };
      VFStaffNote* note = [[VFStaffNote alloc] initWithDictionary:note_struct];
      [note addAccidental:[VFAccidental accidentalWithType:@"b"] atIndex:1];
      note.styleBlock = ^(CGContextRef ctx) {
        // note.setStyle(@{shadowBlur:15, shadowColor:'blue', fillStyle:'blue', strokeStyle:'blue'});
      };
      VFTickContext* tickContext = [[VFTickContext alloc] init];
      [[tickContext addTickable:note] preFormat];
      tickContext.x = 25;
      tickContext.pixelsUsed = 20;
      note.staff = staff;
      [note draw:ctx];

      ok(note.x > 0, @"Note has X value");
      ok(note.ys.count > 0, @"Note has Y values");
    };
    return ret;
}

+ (VFStaffNote*)renderNote:(TestCollectionItemView*)parent
                      note:(VFStaffNote*)note
                     staff:(VFStaff*)staff
               withContext:(CGContextRef)ctx
                       atX:(float)x
{
    VFLogInfo(@"");
    VFModifierContext* mc = [VFModifierContext modifierContext];
    [note addToModifierContext:mc];
    VFTickContext* tickContext = [[VFTickContext alloc] init];
    [[tickContext addTickable:note] preFormat];
    tickContext.x = x;
    tickContext.pixelsUsed = 65;
    note.staff = staff;
    [note draw:ctx];
    return note;
}

- (TestTuple*)drawDotsAndFlagsStemUp:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 150)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 975, 0)];
    // CGContextRef ctx = context.CGContext;

    //        [staff draw:ctx];

    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* dict)
    {
        return [[VFStaffNote alloc] initWithDictionary:dict];
    };

    VFDot* (^newAcc)(NSString*) = ^VFDot*(NSString* type)
    {
        return [VFDot dotWithType:type];
    };

    NSArray* notes = @[
        [newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) }) addDotToAll],
        [newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"8",
               @"stem_direction" : @(1) }) addDotToAll],
        [newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"16",
               @"stem_direction" : @(1) }) addDotToAll],
        [newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"32",
               @"stem_direction" : @(1) }) addDotToAll],
        [newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"64",
               @"stem_direction" : @(1) }) addDotToAll],
        [[newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"128",
               @"stem_direction" : @(1) }) addDotToAll] addDotToAll],
        [newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) }) addDotToAll],
        [newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"8",
               @"stem_direction" : @(1) }) addDotToAll],
        [newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"16",
               @"stem_direction" : @(1) }) addDotToAll],
        [newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"32" }) addDotToAll],
        [newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"64",
               @"stem_direction" : @(1) }) addDotToAll],
        [[newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"128",
               @"stem_direction" : @(1) }) addDotToAll] addDotToAll]
    ];

    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];
      [notes foreach:^(VFStaffNote* note, NSUInteger i, BOOL* stop) {
        [[self class] renderNote:parent note:note staff:staff withContext:ctx atX:(i + 1) * 50];
      }];
    };
    return ret;
}

- (TestTuple*)drawDotsAndFlagsStemDown:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 150)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 975, 0)];
    // CGContextRef ctx = context.CGContext;

    //        [staff draw:ctx];

    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* dict)
    {
        return [[VFStaffNote alloc] initWithDictionary:dict];
    };

    VFDot* (^newAcc)(NSString*) = ^VFDot*(NSString* type)
    {
        return [VFDot dotWithType:type];
    };

    NSArray* notes = @[
        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"4",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"8",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"16",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"32",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"64",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"128",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"4",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"8",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"16",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"32",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"64",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"128",
               @"stem_direction" : @(-1) }) addDotToAll]
    ];

    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];
      [notes foreach:^(VFStaffNote* note, NSUInteger i, BOOL* stop) {
        [[self class] renderNote:parent note:note staff:staff withContext:ctx atX:(i + 1) * 50];
      }];
      ok(YES, @"Full Dot");
    };
    return ret;
}

- (TestTuple*)drawDotsAndBeamsUp:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 150)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 975, 0)];
    // CGContextRef ctx = context.CGContext;

    //        [staff draw:ctx];

    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* dict)
    {
        return [[VFStaffNote alloc] initWithDictionary:dict];
    };

    VFDot* (^newAcc)(NSString*) = ^VFDot*(NSString* type)
    {
        return [VFDot dotWithType:type];
    };

    NSArray* notes = @[
        [newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"8",
               @"stem_direction" : @(1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"16",
               @"stem_direction" : @(1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"32",
               @"stem_direction" : @(1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"64",
               @"stem_direction" : @(1) }) addDotToAll],

        [[newNote(
            @{ @"keys" : @[ @"f/4" ],
               @"duration" : @"128",
               @"stem_direction" : @(1) }) addDotToAll] addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"8",
               @"stem_direction" : @(1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"16",
               @"stem_direction" : @(1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"32" }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"64",
               @"stem_direction" : @(1) }) addDotToAll],

        [[newNote(
            @{ @"keys" : @[ @"g/4" ],
               @"duration" : @"128",
               @"stem_direction" : @(1) }) addDotToAll] addDotToAll]
    ];

    VFBeam* beam = [VFBeam beamWithNotes:notes];
    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];
      [notes foreach:^(VFStaffNote* note, NSUInteger i, BOOL* stop) {
        [[self class] renderNote:parent note:note staff:staff withContext:ctx atX:(i + 1) * 50];
      }];
    };
    //    [beam draw:ctx];

    ok(YES, @"Full Dot");
    //    };
    [ret.beams addObject:beam];
    return ret;
}

- (TestTuple*)drawDotsAndBeamsDown:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");

    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* dict)
    {
        return [[VFStaffNote alloc] initWithDictionary:dict];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 160)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 975, 0)];
    // CGContextRef ctx = context.CGContext;

    //        [staff draw:ctx];

    NSArray* notes = @[

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"8",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"16",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"32",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"64",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"e/5" ],
               @"duration" : @"128",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"8",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"16",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"32",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"64",
               @"stem_direction" : @(-1) }) addDotToAll],

        [newNote(
            @{ @"keys" : @[ @"d/5" ],
               @"duration" : @"128",
               @"stem_direction" : @(-1) }) addDotToAll]
    ];

    id beam = [VFBeam beamWithNotes:notes];

    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
      [staff draw:ctx];
      [notes foreach:^(VFStaffNote* note, NSUInteger i, BOOL* stop) {
        [[self class] renderNote:parent note:note staff:staff withContext:ctx atX:(i + 1) * 25];
      }];
    };
    //        [beam draw:ctx];

    ok(YES, @"Full Dot");
    //    };

    [ret.beams addObject:beam];
    return ret;
}

- (TestTuple*)drawCenterAlignedRest:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* dict)
    {
        return [[VFStaffNote alloc] initWithDictionary:dict];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 160)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
    // CGContextRef ctx = context.CGContext;

    [staff addClefWithName:@"treble"];
    [staff addTimeSignatureWithName:@"4/4"];

    //        [staff draw:ctx];
    NSArray* notes0 = [@[
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"1r",
           @"align_center" : @(YES) }
    ] oct_map:^VFStaffNote*(NSDictionary* note_struct) {
      return newNote(note_struct);
    }];

    VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
    [voice0 setStrict:NO];
    [voice0 addTickables:notes0];
    VFFormatter* formatter = [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff];
    //        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff];

    ok(YES, @"");
    //    };
    [ret.voices addObject:voice0];
    [ret.formatters addObject:formatter];
    [ret.staves addObject:staff];
    return ret;
}

- (TestTuple*)drawCenterAlignedRestFermata:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* dict)
    {
        return [[VFStaffNote alloc] initWithDictionary:dict];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 160)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
    // CGContextRef ctx = context.CGContext;

    [staff addClefWithName:@"treble"];
    [staff addTimeSignatureWithName:@"4/4"];

    //        [staff draw:ctx];
    NSArray* notes0 = [@[
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"1r",
           @"align_center" : @(YES) }
    ] oct_map:^VFStaffNote*(NSDictionary* note_struct) {
      return newNote(note_struct);
    }];

    [notes0[0] addArticulation:[[VFArticulation alloc] initWithCode:@"a@a"] atIndex:0];

    VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
    [voice0 setStrict:NO];
    [voice0 addTickables:notes0];

    VFFormatter* formatter = [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff];
    //        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff];

    ok(YES, @"");
    //    };
    [ret.voices addObject:voice0];
    [ret.formatters addObject:formatter];
    [ret.staves addObject:staff];
    return ret;
}

- (TestTuple*)drawCenterAlignedRestAnnotation:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* dict)
    {
        return [[VFStaffNote alloc] initWithDictionary:dict];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 160)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
    // CGContextRef ctx = context.CGContext;

    [staff addClefWithName:@"treble"];
    [staff addTimeSignatureWithName:@"4/4"];

    //        [staff draw:ctx];
    NSArray* notes0 = [@[
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"1r",
           @"align_center" : @(YES) }
    ] oct_map:^VFStaffNote*(NSDictionary* note_struct) {
      return newNote(note_struct);
    }];

    // TODO: setPosition is not hooked up to anything
    [notes0[0] addAnnotation:[[VFAnnotation annotationWithText:@"Whole measure rest"] setPosition:VFPositionAbove]
                     atIndex:0];

    VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
    [voice0 setStrict:NO];
    [voice0 addTickables:notes0];

    VFFormatter* formatter = [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff];
    //        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff];

    ok(YES, @"");
    //    };
    [ret.voices addObject:voice0];
    [ret.formatters addObject:formatter];
    [ret.staves addObject:staff];
    return ret;
}

- (TestTuple*)drawCenterAlignedNoteMultiModifiers:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* dict)
    {
        return [[VFStaffNote alloc] initWithDictionary:dict];
    };
    VFFretHandFinger* (^newFinger)(NSString*, VFPositionType) =
        ^VFFretHandFinger*(NSString* num, VFPositionType position)
    {
        return [[VFFretHandFinger alloc] initWithFingerNumber:num andPosition:position];
    };
    VFStringNumber* (^newStringNumber)(NSString*, VFPositionType) =
        ^VFStringNumber*(NSString* num, VFPositionType position)
    {
        VFStringNumber* ret = [[VFStringNumber alloc] initWithString:num];
        [ret setPosition:position];
        return ret;
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 160)
    // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    //    {
    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
    // CGContextRef ctx = context.CGContext;

    [staff addClefWithName:@"treble"];
    [staff addTimeSignatureWithName:@"4/4"];

    //        [staff draw:ctx];
    NSArray* notes0 = [@[
        @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
           @"duration" : @"4",
           @"align_center" : @(YES) }
    ] oct_map:^VFStaffNote*(NSDictionary* note_struct) {
      return newNote(note_struct);
    }];

    [[[[[[[[notes0[0] addAnnotation:[[VFAnnotation annotationWithText:@"Test"] setPosition:VFPositionAbove] atIndex:0]
        addStroke:[VFStroke strokeWithType:VFStrokeBrushUp]
          atIndex:0] addAccidental:[VFAccidental accidentalWithType:@"#"]
                           atIndex:1] addModifier:newFinger(@"3", VFPositionLeft)
                                          atIndex:0] addModifier:newFinger(@"2", VFPositionLeft)
                                                         atIndex:2] addModifier:newFinger(@"1", VFPositionRight)
                                                                        atIndex:1]
        addModifier:newStringNumber(@"4", VFPositionBelow)
            atIndex:2] addDotToAll];

    VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
    [voice0 setStrict:NO];
    [voice0 addTickables:notes0];

    VFFormatter* formatter = [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff];
    //        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff];

    ok(YES, @"");
    //    };
    [ret.voices addObject:voice0];
    [ret.formatters addObject:formatter];
    [ret.staves addObject:staff];
    return ret;
}

- (TestTuple*)drawCenterAlignedMultiVoice:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    VFLogInfo(@"");
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* dict)
    {
        return [[VFStaffNote alloc] initWithDictionary:dict];
    };
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 160)
    // withParent:parent];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {

    //        CGContextRef ctx = VFGraphicsContext();
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
    // CGContextRef ctx = context.CGContext;
    [staff addClefWithName:@"treble"];
    [staff addTimeSignatureWithName:@"3/8"];
    //        [staff draw:ctx];

    // Create custom duration
    Rational* custom_duration = Rational(3, 8);

    NSArray* notes0 = [@[
        @{
            @"keys" : @[ @"c/4" ],
            @"duration" : @"1r",
            @"align_center" : @(YES),
            @"duration_override" : custom_duration
        }
    ] oct_map:^VFStaffNote*(NSDictionary* note_struct) {
      return newNote(note_struct);
    }];

    NSArray* notes1 = [@[
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"8" },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"8" },
        @{ @"keys" : @[ @"b/4" ],
           @"duration" : @"8" },
    ] oct_map:^VFStaffNote*(NSDictionary* note_struct) {
      return newNote(note_struct);
    }];

    [notes1[1] addAccidental:[VFAccidental accidentalWithType:@"#"] atIndex:0];

    NSDictionary* TIME3_8 = @{ @"num_beats" : @3, @"beat_value" : @8, @"resolution" : @(kRESOLUTION) };

    VFBeam* beam = [VFBeam beamWithNotes:notes1];

    VFVoice* voice0 = [[VFVoice alloc] initWithTimeDict:TIME3_8];
    [voice0 setStrict:NO];
    [voice0 addTickables:notes0];

    VFVoice* voice1 = [[VFVoice alloc] initWithTimeDict:TIME3_8];
    [voice1 setStrict:NO];
    [voice1 addTickables:notes1];

    VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice0, voice1 ]] formatToStaff:@[ voice0, voice1 ] staff:staff];

    //        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff];
    //        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff];

    //        [beam draw:ctx];

    ok(YES, @"");

    [ret.voices addObjectsFromArray:@[ voice0, voice1 ]];
    [ret.formatters addObject:formatter];
    [ret.staves addObject:staff];
    [ret.beams addObject:beam];
    return ret;
}

@end

#pragma clang diagnostic pop