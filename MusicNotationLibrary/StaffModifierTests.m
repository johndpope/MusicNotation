//
//  StaffModifierTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "StaffModifierTests.h"
#import "VexFlowTestHelpers.h"

@implementation StaffModifierTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Staff Draw Test"  func:@selector(draw:)];
    [self runTest:@"Vertical Bar Test"  func:@selector(drawVerticalBar:)];
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

- (void)draw:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Staff.draw = function(options, contextBuilder) {
        var ctx = new contextBuilder(options.canvas_sel, 400, 120);
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300);

        [staff draw:ctx];

        equal(staff.getYForNote(0), 100, "getYForNote(0)");
        equal(staff.getYForLine(5), 100, "getYForLine(5)");
        equal(staff.getYForLine(0), 50, "getYForLine(0) - Top Line");
        equal(staff.getYForLine(4), 90, "getYForLine(4) - Bottom Line");

        ok(YES, @"all pass");
    }
     */
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 150) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];
      [staff draw:ctx];
      assertThatFloat([staff getYForNoteWithLine:0], describedAs(@"getYForNote(0) = 100", equalToFloat(100), nil));
      assertThatFloat([staff getYForLine:5], describedAs(@"getYForNote(5) = 99", equalToFloat(99), nil));
      assertThatFloat([staff getYForLine:0], describedAs(@"getYForNote(0) = 49 - Top Line", equalToFloat(49), nil));
      assertThatFloat([staff getYForLine:4], describedAs(@"getYForNote(4) = 89 - Bottom Line", equalToFloat(89), nil));
      ok(YES, @"all pass");
    };
}

- (void)drawVerticalBar:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.Staff.drawVerticalBar = function(options, contextBuilder) {
        var ctx = contextBuilder(options.canvas_sel, 400, 120);
        VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300);

        [staff draw:ctx];
        [staff drawVerticalBar:(100);
        [staff drawVerticalBar:(150);
        [staff drawVerticalBar:(300);

        ok(YES, @"all pass");
    }
    */
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 150) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];
       // CGContextRef ctx = context.CGContext;
      [staff draw:ctx];
      [staff drawVerticalBar:ctx x:100];
      [staff drawVerticalBar:ctx x:150];
      [staff drawVerticalBar:ctx x:300];
      ok(YES, @"all pass");
    };
}
@end
