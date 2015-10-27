//
//  NoteHeadTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "NoteHeadTests.h"
#import "VexFlowTestHelpers.h"
#import "VFNoteHead.h"

@implementation NoteHeadTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Basic"  func:@selector(basic:)];
    [self runTest:@"Bounding Boxes"  func:@selector(basicBoundingBox:)];
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

/*
Vex.Flow.Test.NoteHead.setupContext = function(options, x, y) {

    var ctx = new options.contextBuilder(options.canvas_sel, x || 450, y || 140);
    ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
    ctx.font = " 10pt Arial";
    VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, x || 450).addTrebleGlyph();

    return {context: ctx, staff: staff};
};
 */
//+ (void)setupContext:(NSView *)parent {
//    VFTestView *test = [VFTestView createCanvasTest:CGSizeMake(450, 140) withParent:parent];
//    // [parent addSubview:test];
//    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, NSGraphicsContext *context) {
//
//        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(300, 10, 300, 0)];
//         // CGContextRef ctx = context.CGContext;
//        
//
//
//    };
//}

- (void)basic:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(450, 250) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(300, 10, 300, 0)];
       // CGContextRef ctx = context.CGContext;
      
      [staff addTrebleGlyph];

      VFFormatter* formatter = [VFFormatter formatter];
      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:VFModeSoft];
      VFNoteHead* note_head1 = [VFNoteHead noteHeadWithOptionsDict:@{ @"duration" : @"4", @"line" : @3 }];
      VFNoteHead* note_head2 = [VFNoteHead noteHeadWithOptionsDict:@{ @"duration" : @"2", @"line" : @2.5 }];
      VFNoteHead* note_head3 = [VFNoteHead noteHeadWithOptionsDict:@{ @"duration" : @"1", @"line" : @0 }];

      [voice addTickables:@[ note_head1, note_head2, note_head3 ]];
      [formatter joinVoices:@[ voice ]];
      [formatter formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      VFLogInfo(@"Basic NoteHead test");
    };
}

- (void)basicBoundingBox:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(350, 250) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 0, 250, 0)];
       // CGContextRef ctx = context.CGContext;
      
      [staff draw:ctx];

      VFFormatter* formatter = [VFFormatter formatter];
      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:VFModeSoft];
      VFNoteHead* note_head1 = [VFNoteHead noteHeadWithOptionsDict:@{ @"duration" : @"4", @"line" : @3 }];
      VFNoteHead* note_head2 = [VFNoteHead noteHeadWithOptionsDict:@{ @"duration" : @"2", @"line" : @2.5 }];
      VFNoteHead* note_head3 = [VFNoteHead noteHeadWithOptionsDict:@{ @"duration" : @"1", @"line" : @0 }];

      [voice addTickables:@[ note_head1, note_head2, note_head3 ]];
      [formatter joinVoices:@[ voice ]];
      [formatter formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      [note_head1.boundingBox draw:ctx];
      [note_head2.boundingBox draw:ctx];
      [note_head3.boundingBox draw:ctx];

      VFLogInfo(@"NoteHead Bounding Boxes");
    };
}

@end
