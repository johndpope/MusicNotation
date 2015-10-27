//
//  TuningTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TuningTests.h"
#import "VexFlowTestHelpers.h"

@implementation TuningTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Standard Tuning"  func:@selector(standard)];
    [self runTest:@"Return note for fret"  func:@selector(noteForFret)];
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

- (void)checkStandard:(VFTuning*)tuning
{
    /*
    Vex.Flow.Test.Tuning.checkStandard = function(tuning) {
        try {
            tuning.getValueForString(0);
        } catch (e) {
            equal(e.code, "BadArguments", "String 0");
        }

        try {
            tuning.getValueForString(9);
        } catch (e) {
            equal(e.code, "BadArguments", "String 7");
        }
    }
     */
    assertThatUnsignedInteger([tuning getValueForString:6],
                              describedAs(@"Low E string", equalToUnsignedInteger(40), nil));
    assertThatUnsignedInteger([tuning getValueForString:5], describedAs(@"A string", equalToUnsignedInteger(45), nil));
    assertThatUnsignedInteger([tuning getValueForString:4], describedAs(@"D string", equalToUnsignedInteger(50), nil));
    assertThatUnsignedInteger([tuning getValueForString:3], describedAs(@"G string", equalToUnsignedInteger(55), nil));
    assertThatUnsignedInteger([tuning getValueForString:2], describedAs(@"B string", equalToUnsignedInteger(59), nil));
    assertThatUnsignedInteger([tuning getValueForString:1],
                              describedAs(@"High E string", equalToUnsignedInteger(64), nil));
}

- (void)standard
{
    expect(@"16");
    VFTuning* tuning = [[VFTuning alloc] init];
    [[self class] checkStandard:tuning];

    // Test named tuning
    [tuning setTuning:@"standard"];
    [[self class] checkStandard:tuning];
}

- (void)noteForFret
{
    expect(@"8");

    VFTuning* tuning = [[VFTuning alloc] initWithTuningString:@"E/5,B/4,G/4,D/4,A/3,E/3"];

    /*
        try {
            tuning.getNoteForFret(-1, 1);
        } catch(e) {
            equal(e.code, "BadArguments", "Fret -1");
        }

        try {
            tuning.getNoteForFret(1, -1);
        } catch(e) {
            equal(e.code, "BadArguments", "String -1");
        }
    }
    */

    assertThatBool([[tuning getNoteForFret:0 andStringNum:1] isEqualToString:@"E/5"],
                   describedAs(@"High E string", isTrue(), nil));
    assertThatBool([[tuning getNoteForFret:5 andStringNum:1] isEqualToString:@"A/5"],
                   describedAs(@"High E string, fret 5", isTrue(), nil));
    assertThatBool([[tuning getNoteForFret:0 andStringNum:2] isEqualToString:@"B/4"],
                   describedAs(@"B string", isTrue(), nil));
    assertThatBool([[tuning getNoteForFret:0 andStringNum:3] isEqualToString:@"G/4"],
                   describedAs(@"G string", isTrue(), nil));
    assertThatBool([[tuning getNoteForFret:12 andStringNum:2] isEqualToString:@"B/5"],
                   describedAs(@"B string, fret 12", isTrue(), nil));
    assertThatBool([[tuning getNoteForFret:0 andStringNum:6] isEqualToString:@"E/3"],
                   describedAs(@"Low E string", isTrue(), nil));
}

@end
