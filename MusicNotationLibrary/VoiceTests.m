//
//  VoiceTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "VoiceTests.h"
#import "VexFlowTestHelpers.h"
#import "Mocks.h"

@implementation VoiceTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Strict Test"  func:@selector(strict)];
    [self runTest:@"Ignore Test"  func:@selector(ignore)];
    [self runTest:@"Full Voice Mode Test"  func:@selector(full:withTitle:)];
}




//- (ViewStaffStruct*)setupContextWithSize:(VFUIntSize*)size withParent:(VFTestView*)parent
//{
//    /*
//     Vex.Flow.Test.ThreeVoices.setupContext = function(options, x, y) {
//     Vex.Flow.Test.resizeCanvas(options.canvas_sel, x || 350, y || 150);
//     var ctx = Vex.getCanvasContext(options.canvas_sel);
//     ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
//     ctx.font = " 10pt Arial";
//     VFStaff *staff = [VFStaff staffWithRect:CGRectMake(10, 30, x || 350, 0) addTrebleGlyph].
//     setContext(ctx).draw();
//
//     return {context: ctx, staff: staff};
//     }
//     */
//    NSUInteger w = size.width;
//    NSUInteger h = size.height;
//
//    w = w != 0 ? w : 350;
//    h = h != 0 ? h : 150;
//
//    [VFFont setFont:@" 10pt Arial"];
//
//    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h) withParent:parent];
//    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
//    return [ViewStaffStruct contextWithStaff:staff andView:nil];
//}

- (void)strict
{
    MockTickable* (^createTickable)() = ^MockTickable*()
    {
        return [MockTickable mockTickableWithTimeType:VFTime4_4];
    };

    NSUInteger R = kRESOLUTION;
    Rational* BEAT = Rational1(1 * R / 4);

    NSArray* tickables =
        @[ [createTickable() setTicks:BEAT], [createTickable() setTicks:BEAT], [createTickable() setTicks:BEAT] ];

    VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
    assertThatFloat(voice.totalTicks.floatValue,
                    describedAs(@"4/4 Voice has 4 beats", equalToFloat([BEAT mult:4].floatValue), nil));
    assertThatFloat(voice.ticksUsed.floatValue,
                    describedAs(@"No beats in voice", equalToFloat([BEAT mult:0].floatValue), nil));
    [voice addTickables:tickables];
    assertThatFloat(voice.ticksUsed.floatValue,
                    describedAs(@"Three beats in voice", equalToFloat([BEAT mult:3].floatValue), nil));
    [voice addTickable:[createTickable() setTicks:BEAT]];
    assertThatFloat(voice.ticksUsed.floatValue,
                    describedAs(@"Four beats in voice", equalToFloat([BEAT mult:4].floatValue), nil));
    assertThatBool(voice.isComplete, describedAs(@"Voice is complete", isTrue(), nil));

    /*
    try {
        voice addTickable:createTickable() setTicks:BEAT]);
    } catch (e) {
        equal(e.code, "BadArgument", "Too many ticks exception");
    }
     */

    //        assertThatFloat([note getTicks].floatValue, equalToFloat(BEAT * 3.5));
    assertThatFloat(voice.smallestTickCount.floatValue,
                    describedAs(@"Smallest tick count is BEAT", equalToFloat(BEAT.floatValue), nil));
}

- (void)ignore
{
    MockTickable* (^createTickable)() = ^MockTickable*()
    {
        return [MockTickable mockTickableWithTimeType:VFTime4_4];
    };

    NSUInteger R = kRESOLUTION;
    Rational* BEAT = Rational(1 * R / 4, 1);

    NSArray* tickables = @[
        [createTickable() setTicks:BEAT],
        [createTickable() setTicks:BEAT],
        [[createTickable() setTicks:BEAT] setIgnoreTicks:YES],
        [createTickable() setTicks:BEAT],
        [[createTickable() setTicks:BEAT] setIgnoreTicks:YES],
        [createTickable() setTicks:BEAT]
    ];

    VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
    [voice addTickables:tickables];

    ok(YES, @"all pass");
}

- (void)full:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(550, 200) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 50, 500, 0)];
      [[[staff addClefWithName:@"treble"] addTimeSignatureWithName:@"4/4"] setEndBarType:VFBarLineEnd];
      [staff draw:ctx];

      NSArray* notes = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4" ],
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"d/4" ],
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"b/4" ],
              @"duration" : @"qr"
          }]
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeFull;
      [voice addTickables:notes];

      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:500];
      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice.boundingBox draw:ctx];

      /*
      try {
          voice addTickable:
          [[[VFStaffNote alloc]initWithDictionary:@{ @"keys" : @[@"c/4"], @"duration" : @"h" })
            );
        } catch (e) {
            equal(e.code, "BadArgument", "Too many ticks exception");
        }
       */

    };
}

@end
