//
//  ModifierTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "ModifierTests.h"
#import "VexFlowTestHelpers.h"

@implementation ModifierTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Modifier Width Test"  func:@selector(width)];
    [self runTest:@"Modifier Management"  func:@selector(management)];
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

- (void)width
{
    VFModifierContext* mc = [VFModifierContext modifierContext];
    assertThatFloat(mc.width, describedAs(@"New modifier context has no width", equalToFloat(0), nil));
}

- (void)management
{
    VFModifierContext* mc = [VFModifierContext modifierContext];
    VFModifier* modifier1 = [[VFModifier alloc] init];
    VFModifier* modifier2 = [[VFModifier alloc] init];
    [mc addModifier:modifier1];
    [mc addModifier:modifier2];

    NSArray* accidentals = [mc getModifiersForType:@"none"];

    assertThatUnsignedInteger(accidentals.count, describedAs(@"Added two modifiers", equalToUnsignedInteger(2), nil));
}

@end
