//
//  TickContextTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TickContextTests.h"
#import "VexFlowTestHelpers.h"
#import "Mocks.h"

@implementation TickContextTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Current Tick Test"  func:@selector(currentTick)];
    [self runTest:@"Tracking Test"  func:@selector(tracking)];
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

- (void)currentTick
{
    VFTickContext* tc = [[VFTickContext alloc] init];
    assertThatFloat(tc.currentTick.floatValue, describedAs(@"New tick context has no ticks", equalToFloat(0), nil));
}

- (void)tracking
{
    /*
    Vex.Flow.Test.TickContext.tracking = function() {
        function createTickable() {
            return new Vex.Flow.Test.MockTickable(Vex.Flow.Test.TIME4_4);
        }

        NSUInteger R = kRESOLUTION;
        NSUInteger BEAT = 1 * R / 4;

        var tickables = @[
                         createTickable().setTicks(BEAT).setWidth(10),
                         createTickable().setTicks(BEAT * 2).setWidth(20),
                         createTickable().setTicks(BEAT).setWidth(30)
                         ];

        VFTickContext *tc = [[VFTickContext alloc]init];
        tc.padding = 0;

        [tc addTickable:tickables[0]];
        assertThatUnsignedInteger(tc.maxTicks.floatValue, equalToUnsignedInteger(BEAT));

        [tc addTickable:tickables[1]];
        assertThatUnsignedInteger(tc.maxTicks.floatValue, equalToUnsignedInteger(BEAT * 2));

        [tc addTickable:tickables[2]];
        assertThatUnsignedInteger(tc.maxTicks.floatValue, equalToUnsignedInteger(BEAT * 2));

        assertThatUnsignedInteger(tc.width, equalToUnsignedInteger(0));
        [tc preFormat];
        assertThatUnsignedInteger(tc.width, equalToUnsignedInteger(30));
    }
    */

    MockTickable* (^createTickable)() = ^MockTickable*()
    {
        return [[MockTickable alloc] initWithTimeType:VFTime4_4];
    };

    NSUInteger R = kRESOLUTION;
    NSUInteger BEAT = 1 * R / 4;

    NSArray* tickables = @[
        createTickable(),
        createTickable(),
        createTickable(),
    ];

    [((id<VFTickableDelegate>)tickables[0]) setTicks:Rational(BEAT, 1)];
    ((id<VFTickableDelegate>)tickables[0]).width = 10;

    //.setTicks(BEAT * 2).setWidth(20),
    [((id<VFTickableDelegate>)tickables[1]) setTicks:Rational(BEAT * 2, 1)];
    ((id<VFTickableDelegate>)tickables[1]).width = 20;

    // .setTicks(BEAT).setWidth(30)
    [((id<VFTickableDelegate>)tickables[2]) setTicks:Rational(BEAT, 1)];
    ((id<VFTickableDelegate>)tickables[2]).width = 30;

    VFTickContext* tc = [[VFTickContext alloc] init];
    tc.padding = 0;

    [tc addTickable:tickables[0]];
    assertThatUnsignedInteger(tc.maxTicks.floatValue, equalToUnsignedInteger(BEAT));

    [tc addTickable:tickables[1]];
    assertThatUnsignedInteger(tc.maxTicks.floatValue, equalToUnsignedInteger(BEAT * 2));

    [tc addTickable:tickables[2]];
    assertThatUnsignedInteger(tc.maxTicks.floatValue, equalToUnsignedInteger(BEAT * 2));

    assertThatUnsignedInteger(tc.width, equalToUnsignedInteger(0));
    [tc preFormat];
    assertThatUnsignedInteger(tc.width, equalToUnsignedInteger(30));
}

@end
