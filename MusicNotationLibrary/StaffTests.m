//
//  StaffTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Complete

#import "StaffTests.h"
#import "VexFlowTestHelpers.h"
#import "VFVex.h"

@implementation StaffTests

- (void)start
{
    [super start];

    [self runTest:@"Staff Draw Test" func:@selector(draw:)];
    [self runTest:@"Vertical Bar Test" func:@selector(drawVerticalBar:)];
    [self runTest:@"Multiple staff Barline Test" func:@selector(drawMultipleMeasures:)];
//    [self runTest:@"Multiple staff Repeats Test" func:@selector(drawRepeats:)];
//    [self runTest:@"Multiple staffs Volta Test Test" func:@selector(drawVoltaTest:)];
//    [self runTest:@"Tempo Test" func:@selector(drawTempo:)];
//    [self runTest:@"Single Line Configuration Test"
//             func:@selector(configureSingleLine:)];
//    [self runTest:@"Batch Line Configuration Test"
//             func:@selector(configureAllLines:)];
//    [self runTest:@"staff Text  Test" func:@selector(drawStaffText:)];
//    [self runTest:@"Multiple Line staff Text Test"
//             func:@selector(drawStaffTextMultiLine:)];
}

static float w = 700;

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
    // withParent:parent withTitle:title];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

- (TestTuple*)draw:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    //    float w = parent.bounds.size.width;
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, 150)
    // withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();

        VFStaff* staff = [VFStaff staffWithRect:CGRectMake(20, 0, w - 40, 0)];
        // CGContextRef ctx = context.CGContext;

    [ret.staves addObject:staff];
    ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
        [staff draw:ctx];
        [staff drawBoundingBox:ctx];

        assertThatFloat([staff getYForNoteWithLine:0], describedAs(@"getYForNote(0) = 100", equalToFloat(100), nil));
        assertThatFloat([staff getYForLine:5], describedAs(@"getYForNote(5) = 99", equalToFloat(99), nil));
        assertThatFloat([staff getYForLine:0], describedAs(@"getYForNote(0) = 49 - Top Line", equalToFloat(49), nil));
        assertThatFloat([staff getYForLine:4],
                        describedAs(@"getYForNote(4) = 89 - Bottom Line", equalToFloat(89), nil));
    };
    return ret;
}

- (TestTuple*)drawVerticalBar:(TestCollectionItemView*)parent
{
    TestTuple* ret = [TestTuple testTuple];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, 120)
    // withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();
        VFStaff* staff = [VFStaff staffWithRect:CGRectMake(20, 0, w - 40, 0)];
        // CGContextRef ctx = context.CGContext;
    
    [ret.staves addObject:staff];
        ret.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
        [staff draw:ctx];

        [staff drawVerticalBar:ctx x:50];
        [staff drawVerticalBar:ctx x:150];
        [staff drawVertical:ctx x:250 isDouble:YES];
        [staff drawVertical:ctx x:300];
    };
    return ret;
}

- (TestTuple*)drawMultipleMeasures:(TestCollectionItemView*)parent
{
        TestTuple* ret = [TestTuple testTuple];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(750, 200)
    // withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    VFStaff* staffBar1;
    //    VFVoice* voice;
    //    test.loadBlock = ^(CGRect rect) {
    //
    //    };
    //
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();
        // CGContextRef ctx = context.CGContext;

        // bar 1
        VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 0, 250, 0)];
        staffBar1.begBarType = VFBarLineRepeatBegin;
        staffBar1.endBarType = VFBarLineDouble;
        [staffBar1 setSectionWithSection:@"A" atY:0];
        [staffBar1 addClefWithName:@"treble"];
        [staffBar1 addTrebleGlyph];
        //              [staffBar1 format];

//        [staffBar1 draw:ctx];

        NSArray* notesBar1 = [@[
            [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q"],
            [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"q"],
            [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"qr"],
            [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"q"],
        ] mutableCopy];

              VFVoice* voice = [VFVoice voiceWithNumBeats:4 beatValue:4 resolution:kRESOLUTION];
            VFFormatter* formatter =
              [voice addTickables:notesBar1];
    [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ]
                                               withJustifyWidth:staffBar1.width];
    
    [ret.staves addObject:staffBar1];
    [ret.voices addObject:voice];
    [ret.formatters addObject:formatter];

        // Helper function to justify and draw a 4/4 voice

//        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];
        // TODO: withJustifyWidth is making things too wide


        //      [voice draw:ctx dirtyRect:CGRectZero toStaff:staffBar1];


        // bar 2 - juxtaposing second bar next to first bar
        VFStaff* staffBar2 =
            [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x + 10, staffBar1.y, 300, 0)];
        [staffBar2 setSectionWithSection:@"B" atY:0];
        staffBar2.endBarType = VFBarLineEnd;
//        [staffBar2 draw:ctx];

        NSMutableArray* notesBar2_part1 = [@[
            [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"g/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"e/4" ] andDuration:@"8"],
        ] mutableCopy];

        NSMutableArray* notesBar2_part2 = [@[
            [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"g/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"e/4" ] andDuration:@"8"],
        ] mutableCopy];

        // create the beams for 8th notes in 2nd measure
        VFBeam* beam1 = [VFBeam beamWithNotes:notesBar2_part1];
        VFBeam* beam2 = [VFBeam beamWithNotes:notesBar2_part2];
    
    [ret.beams addObjectsFromArray:@[beam1, beam2]];
    
        NSArray* notesBar2 = [notesBar2_part1 arrayByAddingObjectsFromArray:notesBar2_part2];

        // Helper function to justify and draw a 4/4 voice
//        VFFormatter* formatter2 =
//        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];

    VFVoice* voice2 = [VFVoice voiceWithNumBeats:4 beatValue:4 resolution:kRESOLUTION];
    VFFormatter* formatter2 =
    [voice addTickables:notesBar2];
    [[[VFFormatter formatter] joinVoices:@[ voice2 ]] formatWith:@[ voice2 ]
                                               withJustifyWidth:staffBar2.width];
    
    [ret.staves addObject:staffBar2];
    [ret.voices addObject:voice2];
    [ret.formatters addObject:formatter2];
    
        // Render beams
//        [beam1 draw:ctx];
//        [beam2 draw:ctx];
//    };
        return ret;
}

/*
- (TestTuple*)drawRepeats:(TestCollectionItemView*)parent
{
        TestTuple* ret = [TestTuple testTuple];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(850, 200)
    // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();

        // bar 1
        VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 0, 250, 0)];
        staffBar1.begBarType = VFBarLineRepeatBegin;
        staffBar1.endBarType = VFBarLineDouble;
        [staffBar1 setSectionWithSection:@"A" atY:0];
        [staffBar1 addClefWithName:@"treble"];
        // CGContextRef ctx = context.CGContext;
        [staffBar1 draw:ctx];

        NSArray* notesBar1 = @[
            [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q"],
            [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"q"],
            [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"qr"],
            [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"q"],
        ];

        //      [VFGlyph setDebugMode:YES];

        // Helper function to justify and draw a 4/4 voice
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

        // bar 2 - juxtaposing second bar next to first bar
        VFStaff* staffBar2 = [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 250, 0)];
        [staffBar2 setSectionWithSection:@"B" atY:0];
        staffBar2.endBarType = VFBarLineEnd;
        //      staffBar2.graphicsContext = ctx;
        [staffBar2 draw:ctx];

        NSArray* notesBar2_part1 = @[
            [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"g/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"e/4" ] andDuration:@"8"],
        ];

        NSArray* notesBar2_part2 = @[
            [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"g/4" ] andDuration:@"8"],
            [VFStaffNote noteWithKeys:@[ @"e/4" ] andDuration:@"8"],
        ];

        [notesBar2_part2[0] addAccidental:[VFAccidental accidentalWithType:@"#"] atIndex:0];
        [notesBar2_part2[1] addAccidental:[VFAccidental accidentalWithType:@"#"] atIndex:0];
        [notesBar2_part2[3] addAccidental:[VFAccidental accidentalWithType:@"b"] atIndex:0];

        // create the beams for 8th notes in 2nd measure
        VFBeam* beam1 = [VFBeam beamWithNotes:notesBar2_part1];
        VFBeam* beam2 = [VFBeam beamWithNotes:notesBar2_part2];
        NSArray* notesBar2 = [notesBar2_part1 arrayByAddingObjectsFromArray:notesBar2_part2];

        // Helper function to justify and draw a 4/4 voice
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];

        // Render beams
        [beam1 draw:ctx];
        [beam2 draw:ctx];

        // bar 3 - juxtaposing third bar next to second bar
        VFStaff* staffBar3 = [VFStaff staffWithRect:CGRectMake(staffBar2.width + staffBar2.x, staffBar2.y, 50, 0)];
        //      staffBar3.graphicsContext = ctx;
        [staffBar3 draw:ctx];

        NSArray* notesBar3 = @[ [VFStaffNote noteWithKeys:@[ @"d/5" ] andDuration:@"wr"] ];

        // Helper function to justify and draw a 4/4 voice
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar3 withNotes:notesBar3];

        // bar 4 - juxtaposing third bar next to third bar
        VFStaff* staffBar4 = [VFStaff staffWithRect:CGRectMake(staffBar3.width + staffBar3.x, staffBar3.y,
                                                               250 - [staffBar1 getModifierXShift], 0)];

        staffBar4.begBarType = VFBarLineRepeatBegin;
        staffBar4.endBarType = VFBarLineRepeatEnd;
        //      staffBar4.graphicsContext = ctx;
        [staffBar4 draw:ctx];

        NSArray* notesBar4 = @[
            [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q"],
            [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"q"],
            [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"qr"],
            [VFStaffNote noteWithKeys:@[ @"c/4", @"e/4", @"g/4" ] andDuration:@"q"],
        ];

        // Helper function to justify and draw a 4/4 voice
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar4 withNotes:notesBar4];
//    };
        return ret;
}

- (TestTuple*)drawVoltaTest:(TestCollectionItemView*)parent
{
        TestTuple* ret = [TestTuple testTuple];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(750, 200)
    // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();

        // bar 1
        VFStaff* mm1 = [VFStaff staffWithRect:CGRectMake(10, 10, 125, 0)];
        // CGContextRef ctx = context.CGContext;
        //      mm1.graphicsContext = ctx;
        mm1.begBarType = VFBarLineRepeatBegin;
        [mm1 setRepetitionTypeLeft:VFRepSegnoLeft atY:-18];   //.repetitionTypeLeft = VFRepSegnoLeft
        mm1.clefType = VFClefTreble;
        mm1.keySignature =
            [VFKeySignature keySignatureWithKey:@"A"];   // TODO: allow setting keysignature using nsstring
        mm1.measure = 1;
        [mm1 setSectionWithSection:@"A" atY:0];   // TODO: rename to more concise
        [mm1 draw:ctx];
        NSArray* notesmm1 = @[ [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"w"] ];

        // Helper function to justify and draw a 4/4 voice
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:mm1 withNotes:notesmm1];

        // bar 2 - juxtapose second measure
        VFStaff* mm2 = [VFStaff staffWithRect:CGRectMake(mm1.width + mm1.x, mm1.y, 60, 0)];
        //      mm2.graphicsContext = ctx;
        mm2.measure = 2;
        [mm2 draw:ctx];
        NSArray* notesmm2 = @[ [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"w"] ];
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:mm2 withNotes:notesmm2];

        // bar 3 - juxtapose third measure
        VFStaff* mm3 = [VFStaff staffWithRect:CGRectMake(mm2.width + mm2.x, mm1.y, 60, 0)];
        //      mm3.graphicsContext = ctx;
        [mm3 setVoltaType:VFVoltaBegin withNumber:@"1." atY:-5];
        mm3.measure = 3;
        [mm3 draw:ctx];
        NSArray* notesmm3 = @[ [VFStaffNote noteWithKeys:@[ @"e/4" ] andDuration:@"w"] ];
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:mm3 withNotes:notesmm3];

        // bar 4 - juxtapose fourth measure
        VFStaff* mm4 = [VFStaff staffWithRect:CGRectMake(mm3.width + mm3.x, mm1.y, 60, 0)];
        //      mm4.graphicsContext = ctx;
        [mm4 setVoltaType:VFVoltaMid withNumber:@"" atY:-5];
        mm4.measure = 4;
        [mm4 draw:ctx];
        NSArray* notesmm4 = @[ [VFStaffNote noteWithKeys:@[ @"f/4" ] andDuration:@"w"] ];
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:mm4 withNotes:notesmm4];

        // bar 5 - juxtapose fifth measure
        VFStaff* mm5 = [VFStaff staffWithRect:CGRectMake(mm4.width + mm4.x, mm1.y, 60, 0)];
        //      mm5.graphicsContext = ctx;
        mm5.endBarType = VFBarLineRepeatEnd;
        [mm5 setVoltaType:VFVoltaEnd withNumber:@"" atY:-5];
        mm5.measure = 5;
        [mm5 draw:ctx];
        NSArray* notesmm5 = @[ [VFStaffNote noteWithKeys:@[ @"g/4" ] andDuration:@"w"] ];
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:mm5 withNotes:notesmm5];

        // bar 6 - juxtapose sixth measure
        VFStaff* mm6 = [VFStaff staffWithRect:CGRectMake(mm5.width + mm5.x, mm1.y, 60, 0)];
        //      mm6.graphicsContext = ctx;
        [mm6 setVoltaType:VFVoltaBeginEnd withNumber:@"2." atY:-5];
        mm6.endBarType = VFBarLineDouble;
        mm6.measure = 6;
        [mm6 draw:ctx];
        NSArray* notesmm6 = @[ [VFStaffNote noteWithKeys:@[ @"a/5" ] andDuration:@"w"] ];
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:mm6 withNotes:notesmm6];

        // bar 7 - juxtapose seventh measure
        VFStaff* mm7 = [VFStaff staffWithRect:CGRectMake(mm6.width + mm6.x, mm1.y, 60, 0)];
        //      mm7.graphicsContext = ctx;
        mm7.measure = 7;
        [mm7 setSectionWithSection:@"8" atY:0];
        [mm7 draw:ctx];
        NSArray* notesmm7 = @[ [VFStaffNote noteWithKeys:@[ @"b/5" ] andDuration:@"w"] ];
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:mm7 withNotes:notesmm7];

        // bar 8 - juxtapose eighth measure
        VFStaff* mm8 = [VFStaff staffWithRect:CGRectMake(mm7.width + mm7.x, mm1.y, 60, 0)];
        //      mm8.graphicsContext = ctx;
        mm8.endBarType = VFBarLineDouble;
        [mm8 setRepetitionTypeRight:VFRepDSALCoda atY:25];
        mm8.measure = 8;
        [mm8 draw:ctx];
        NSArray* notesmm8 = @[ [VFStaffNote noteWithKeys:@[ @"c/5" ] andDuration:@"w"] ];
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:mm8 withNotes:notesmm8];

        // bar 9 - juxtapose ninth measure
        VFStaff* mm9 = [VFStaff staffWithRect:CGRectMake(mm8.width + mm8.x + 20, mm1.y, 125, 0)];
        //      mm9.graphicsContext = ctx;
        mm9.begBarType = VFBarLineRepeatEnd;
        [mm9 setRepetitionTypeLeft:VFRepCodaLeft atY:25];
        [mm9 addClefWithName:@"treble"];   //.clefType = VFClefTreble;
        mm9.keySignature = [VFKeySignature keySignatureWithKey:@"A"];
        [mm9 draw:ctx];
        mm9.measure = 9;
        NSArray* notesmm9 = @[ [VFStaffNote noteWithKeys:@[ @"d/5" ] andDuration:@"w"] ];

        // Helper function to justify and draw a 4/4 voice
        [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:mm9 withNotes:notesmm9];
//    };
    ret;
}

- (TestTuple*)drawTempo:(TestCollectionItemView*)parent
{
        TestTuple* ret = [TestTuple testTuple];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(725, 250)
    // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();
        // CGContextRef ctx = context.CGContext;

        float padding = 10;
        __block float x = 0;
        float y = 50;

        void (^drawTempostaffBar)(CGContextRef, float, NSDictionary*, float, NSArray*);
        drawTempostaffBar = ^(CGContextRef ctx, float width, NSDictionary* tempoDict, float tempo_y, NSArray* notes) {
          VFStaff* staffBar = [VFStaff staffWithRect:CGRectMake(padding + x, y, width, 0)];
          //        staffBar.graphicsContext = ctx;

          if(x == 0)
          {
              [staffBar addClefWithName:@"treble"];
          }

          [staffBar setTempoWithTempo:[[TempoOptionsStruct alloc] initWithDictionary:tempoDict] atY:tempo_y];
          [staffBar draw:ctx];

          NSArray* notesBar = notes != nil ? notes : @[
              [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q"],
              [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"q"],
              [VFStaffNote noteWithKeys:@[ @"b/4" ] andDuration:@"q"],
              [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q"]
          ];
          [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar withNotes:notesBar];
          x += width;
        };

        drawTempostaffBar(ctx, 120, @{ @"duration" : @"q", @"dots" : @1, @"bpm" : @(80) }, 0, nil);
        drawTempostaffBar(ctx, 100, @{ @"duration" : @"8", @"dots" : @2, @"bpm" : @(90) }, 0, nil);
        drawTempostaffBar(ctx, 100, @{ @"duration" : @"16", @"dots" : @1, @"bpm" : @(96) }, 0, nil);
        drawTempostaffBar(ctx, 100, @{ @"duration" : @"32", @"bpm" : @(70) }, 0, nil);
        drawTempostaffBar(ctx, 250,
                          @{ @"name" : @"Andante",
                             @"note" : @"8",
                             @"bpm" : @(120) },
                          -20, @[
                              [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"g/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"e/5" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"g/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"e/4" ] andDuration:@"8"]
                          ]);

        x = 0;
        y += 150;

        drawTempostaffBar(ctx, 120, @{ @"duration" : @"w", @"bpm" : @(80) }, 0, nil);
        drawTempostaffBar(ctx, 100, @{ @"duration" : @"h", @"bpm" : @(90) }, 0, nil);
        drawTempostaffBar(ctx, 100, @{ @"duration" : @"q", @"bpm" : @(96) }, 0, nil);
        drawTempostaffBar(ctx, 100, @{ @"duration" : @"8", @"bpm" : @(70) }, 0, nil);
        drawTempostaffBar(ctx, 250,
                          @{ @"name" : @"Andante grazioso" }, 0, @[
                              [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"g/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"e/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"d/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"g/4" ] andDuration:@"8"],
                              [VFStaffNote noteWithKeys:@[ @"e/4" ] andDuration:@"8"]
                          ]);
        // ok(YES, @"all pass");
//    };
    return ret;
}

- (TestTuple*)configureSingleLine:(TestCollectionItemView*)parent
{
        TestTuple* ret = [TestTuple testTuple];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 120)
    // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();

        VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];
        // CGContextRef ctx = context.CGContext;

        [staff setConfigForLine:0 withConfig:@{ @"visible" : @(YES) }];
        [staff setConfigForLine:1 withConfig:@{ @"visible" : @(NO) }];
        [staff setConfigForLine:2 withConfig:@{ @"visible" : @(YES) }];
        [staff setConfigForLine:3 withConfig:@{ @"visible" : @(NO) }];
        [staff setConfigForLine:4 withConfig:@{ @"visible" : @(YES) }];

        NSArray* config = [staff getConfigForLines];
        [staff draw:ctx];
        assertThatBool([[config[0] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 0", isTrue(), nil));
        assertThatBool([[config[1] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 1", isFalse(), nil));
        assertThatBool([[config[2] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 2", isTrue(), nil));
        assertThatBool([[config[3] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 3", isFalse(), nil));
        assertThatBool([[config[4] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 4", isTrue(), nil));

        // ok(YES, @"all pass");
//    };
    return ret;
}

- (TestTuple*)configureAllLines:(TestCollectionItemView*)parent
{
        TestTuple* ret = [TestTuple testTuple];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 120)
    // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();

        VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];
        // CGContextRef ctx = context.CGContext;

        [staff setConfigForLines:@[
            @{ @"visible" : @(NO) },
            @{},
            @{ @"visible" : @(NO) },
            @{ @"visible" : @(YES) },
            @{ @"visible" : @(NO) },
        ]];

        NSArray* config = [staff getConfigForLines];

        [staff draw:ctx];
        assertThatBool([[config[0] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 0", isFalse(), nil));
        assertThatBool([[config[1] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 1", isTrue(), nil));
        assertThatBool([[config[2] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 2", isFalse(), nil));
        assertThatBool([[config[3] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 3", isTrue(), nil));
        assertThatBool([[config[4] objectForKey:@"visible"] boolValue],
                       describedAs(@"getLinesConfiguration() - Line 4", isFalse(), nil));

        // ok(YES, @"all pass");
//    };
        return ret;
}

- (TestTuple*)drawStaffText:(TestCollectionItemView*)parent
{
        TestTuple* ret = [TestTuple testTuple];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(900, 140)
    // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();

        VFStaff* staff = [VFStaff staffWithRect:CGRectMake(300, 10, 300, 0)];
        // CGContextRef ctx = context.CGContext;

        [staff setTextWithText:@"Violin" atPosition:VFPositionLeft];
        [staff setTextWithText:@"Right Text" atPosition:VFPositionRight];
        [staff setTextWithText:@"Above Text" atPosition:VFPositionAbove];
        [staff setTextWithText:@"Below Text" atPosition:VFPositionBelow];

        //[staff draw:ctx];
//        [staff draw:ctx];

        // ok(YES, @"all pass");
//    };
    ret.staff = staff;
    return ret;
}

- (TestTuple*)drawStaffTextMultiLine:(TestCollectionItemView*)parent
{
        TestTuple* ret = [TestTuple testTuple];
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(900, 200)
    // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
//    {
//        CGContextRef ctx = VFGraphicsContext();

        VFStaff* staff = [VFStaff staffWithRect:CGRectMake(300, 40, 300, 0)];
        // CGContextRef ctx = context.CGContext;

        [staff setTextWithText:@"Violin" atPosition:VFPositionLeft withOptions:@{ @"shift_y" : @(-10) }];
        [staff setTextWithText:@"2nd line" atPosition:VFPositionLeft withOptions:@{ @"shift_y" : @(10) }];
        [staff setTextWithText:@"Right Text" atPosition:VFPositionRight withOptions:@{ @"shift_y" : @(-10) }];
        [staff setTextWithText:@"2nd line" atPosition:VFPositionRight withOptions:@{ @"shift_y" : @(10) }];
        [staff setTextWithText:@"Above Text" atPosition:VFPositionAbove withOptions:@{ @"shift_y" : @(-10) }];
        [staff setTextWithText:@"2nd line" atPosition:VFPositionAbove withOptions:@{ @"shift_y" : @(10) }];
        [staff setTextWithText:@"Left Text Below"
                    atPosition:VFPositionBelow
                   withOptions:@{
                       @"shift_y" : @(-10),
                       @"justification" : @(VFShiftLeft)
                   }];
        [staff setTextWithText:@"Right Text Below"
                    atPosition:VFPositionBelow
                   withOptions:@{
                       @"shift_y" : @(10),
                       @"justification" : @(VFShiftRight)
                   }];

        //[staff draw:ctx];
    ret.staff = staff;
    
         ok(YES, @"all pass");
//    };
    return ret;
}
*/
@end
