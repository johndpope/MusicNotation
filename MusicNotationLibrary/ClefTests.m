//
//  ClefTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Complete

#import "ClefTests.h"
#import "VexFlowTestHelpers.h"

// TODO: add test for moveable c

@implementation ClefTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];

    //      [VFGlyph setDebugMode:YES];

    [self runTest:@"Clef Test" func:@selector(draw:withTitle:)];
    [self runTest:@"Clef End Test" func:@selector(drawEnd:withTitle:)];
    [self runTest:@"Small Clef Test" func:@selector(drawSmall:withTitle:)];
    [self runTest:@"Small Clef End Test" func:@selector(drawSmallEnd:withTitle:)];
    [self runTest:@"Clef Change Test" func:@selector(drawClefChange:withTitle:)];
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

- (void)draw:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 130) withParent:parent withTitle:title];
//    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 700, 0)];

      [staff addClefWithName:@"treble"];
      [staff addClefWithName:@"treble" size:@"default" annotation:@"8va"];
      [staff addClefWithName:@"treble" size:@"default" annotation:@"8vb"];
      [staff addClefWithName:@"alto"];
      [staff addClefWithName:@"tenor"];
      [staff addClefWithName:@"soprano"];
      [staff addClefWithName:@"bass"];
      [staff addClefWithName:@"bass" size:@"default" annotation:@"8vb"];
      [staff addClefWithName:@"mezzo-soprano"];
      [staff addClefWithName:@"baritone-c"];
      [staff addClefWithName:@"baritone-f"];
      [staff addClefWithName:@"subbass"];
      [staff addClefWithName:@"percussion"];
      [staff addClefWithName:@"french"];

      [staff addEndClefWithName:@"treble"];

       // CGContextRef ctx = context.CGContext;

      [staff draw:ctx];
      // ok(YES, @"all pass");
    };
}

- (void)drawEnd:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 120) withParent:parent withTitle:title];
//    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 700, 0)];

      [staff addClefWithName:@"bass"];

      [staff addEndClefWithName:@"treble"];
      [staff addEndClefWithName:@"treble" size:@"default" annotation:@"8va"];
      [staff addEndClefWithName:@"treble" size:@"default" annotation:@"8vb"];
      [staff addEndClefWithName:@"alto"];
      [staff addEndClefWithName:@"tenor"];
      [staff addEndClefWithName:@"soprano"];
      [staff addEndClefWithName:@"bass"];
      [staff addEndClefWithName:@"bass" size:@"default" annotation:@"8vb"];
      [staff addEndClefWithName:@"mezzo-soprano"];
      [staff addEndClefWithName:@"baritone-c"];
      [staff addEndClefWithName:@"baritone-f"];
      [staff addEndClefWithName:@"subbass"];
      [staff addEndClefWithName:@"percussion"];
      [staff addEndClefWithName:@"french"];

       // CGContextRef ctx = context.CGContext;

      [staff draw:ctx];
      // ok(YES, @"all pass");
    };
}

- (void)drawSmall:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 120) withParent:parent withTitle:title];
//    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 700, 0)];

      [staff addClefWithName:@"treble" size:@"small"];
      [staff addClefWithName:@"treble" size:@"small" annotation:@"8va"];
      [staff addClefWithName:@"treble" size:@"small" annotation:@"8vb"];
      [staff addClefWithName:@"alto" size:@"small"];
      [staff addClefWithName:@"tenor" size:@"small"];
      [staff addClefWithName:@"soprano" size:@"small"];
      [staff addClefWithName:@"bass" size:@"small"];
      [staff addClefWithName:@"bass" size:@"small" annotation:@"8vb"];
      [staff addClefWithName:@"mezzo-soprano" size:@"small"];
      [staff addClefWithName:@"baritone-c" size:@"small"];
      [staff addClefWithName:@"baritone-f" size:@"small"];
      [staff addClefWithName:@"subbass" size:@"small"];
      [staff addClefWithName:@"percussion" size:@"small"];
      [staff addClefWithName:@"french" size:@"small"];

      [staff addEndClefWithName:@"treble" size:@"small"];

       // CGContextRef ctx = context.CGContext;

      [staff draw:ctx];
      // ok(YES, @"all pass");
    };
}

- (void)drawSmallEnd:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 120) withParent:parent withTitle:title];
//    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 700, 0)];

      [staff addClefWithName:@"bass" size:@"small"];

      [staff addEndClefWithName:@"treble" size:@"small"];
      [staff addEndClefWithName:@"treble" size:@"small" annotation:@"8va"];
      [staff addEndClefWithName:@"treble" size:@"small" annotation:@"8vb"];
      [staff addEndClefWithName:@"alto" size:@"small"];
      [staff addEndClefWithName:@"tenor" size:@"small"];
      [staff addEndClefWithName:@"soprano" size:@"small"];
      [staff addEndClefWithName:@"bass" size:@"small"];
      [staff addEndClefWithName:@"bass" size:@"small" annotation:@"8vb"];
      [staff addEndClefWithName:@"mezzo-soprano" size:@"small"];
      [staff addEndClefWithName:@"baritone-c" size:@"small"];
      [staff addEndClefWithName:@"baritone-f" size:@"small"];
      [staff addEndClefWithName:@"subbass" size:@"small"];
      [staff addEndClefWithName:@"percussion" size:@"small"];
      [staff addEndClefWithName:@"french" size:@"small"];

       // CGContextRef ctx = context.CGContext;

      [staff draw:ctx];
      // ok(YES, @"all pass");
    };
}

- (void)drawClefChange:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(800, 180) withParent:parent withTitle:title];
//    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 700, 0)];
      [staff addClefWithName:@"treble"];
       // CGContextRef ctx = context.CGContext;

      [staff draw:ctx];

      NSArray* notes = @[
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"treble"],
          [VFClefNote clefNoteWithClef:@"alto" size:@"small"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"alto"],
          [VFClefNote clefNoteWithClef:@"tenor" size:@"small"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"tenor"],
          [VFClefNote clefNoteWithClef:@"soprano" size:@"small"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"soprano"],
          [VFClefNote clefNoteWithClef:@"bass" size:@"small"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"bass"],
          [VFClefNote clefNoteWithClef:@"mezzo-soprano" size:@"small"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"mezzo-soprano"],
          [VFClefNote clefNoteWithClef:@"baritone-c" size:@"small"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"baritone-c"],
          [VFClefNote clefNoteWithClef:@"baritone-f" size:@"small"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"baritone-f"],
          [VFClefNote clefNoteWithClef:@"subbass" size:@"small"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"subbass"],
          [VFClefNote clefNoteWithClef:@"french" size:@"small"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"french"],
          [VFClefNote clefNoteWithClef:@"treble" size:@"small" annotation:@"8vb"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"treble" octaveShift:-1],
          [VFClefNote clefNoteWithClef:@"treble" size:@"small" annotation:@"8va"],
          [VFStaffNote noteWithKeys:@[ @"c/4" ] andDuration:@"q" andClef:@"treble" octaveShift:1],
      ];

      VFVoice* voice = [VFVoice voiceWithNumBeats:12 beatValue:4 resolution:kRESOLUTION];
      [voice addTickables:notes];
      VFFormatter* formatter = [[VFFormatter alloc] init];
      [formatter joinVoices:@[ voice ]];
      //        [formatter formatWith:@[voice] withJustifyWidth:500 andOptions:nil];
      [formatter formatWith:@[ voice ] withJustifyWidth:650];
      [voice draw:ctx dirtyRect:parent.frame toStaff:staff];

      // ok(YES, @"all pass");
    };
}

@end
