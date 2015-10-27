//
//  TabStaffTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TabStaffTests.h"
#import "VexFlowTestHelpers.h"

@implementation TabStaffTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"TabStaff Draw Test"  func:@selector(draw:)];
    ;
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
    Vex.Flow.Test.TabStaff.draw = function(options, contextBuilder) {
        var ctx = new contextBuilder(options.canvas_sel,
                                     400, 160);

        VFStaff *staff = new Vex.Flow.TabStaff(10, 10, 300);
        staff.setNumLines(6);

        [staff draw:ctx];

        equal(staff.getYForNote(0), 127, "getYForNote(0)");
        equal(staff.getYForLine(5), 126, "getYForLine(5)");
        equal(staff.getYForLine(0), 61, "getYForLine(0) - Top Line");
        equal(staff.getYForLine(4), 113, "getYForLine(4) - Bottom Line");

        ok(YES, @"all pass");
    }
     */
}

- (void)drawVerticalBar:(TestCollectionItemView*)parent
{
    /*
    Vex.Flow.Test.TabStaff.drawVerticalBar = function(options, contextBuilder) {
        var ctx = new contextBuilder(options.canvas_sel,
                                     400, 160);

        VFStaff *staff = new Vex.Flow.TabStaff(10, 10, 300);
        staff.setNumLines(6);

        staff.drawVerticalBar(50, YES);
        staff.drawVerticalBar(100, YES);
        staff.drawVerticalBar(150, NO);
        staff setEndBarType:Vex.Flow.Barline.type.END);
        [staff draw:ctx];

        ok(YES, @"all pass");
    }
    */
}

@end
