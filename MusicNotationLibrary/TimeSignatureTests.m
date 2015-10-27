//
//  TimeSignatureTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TimeSignatureTests.h"
#import "VexFlowTestHelpers.h"

@implementation TimeSignatureTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Time Signature Parser"  func:@selector(parser)];
    [self runTest:@"Basic Time Signatures"  func:@selector(basic:withTitle:)];

    [self runTest:@"Big Signature Test"  func:@selector(big:withTitle:)];

    [self runTest:@"Time Signature multiple staffs alignment test"
           
             func:@selector(multiStaff:withTitle:)
        ];

    //    [self runTest:@"Time Signature Change Test"  func:@selector(timeSigNote:withTitle:)
    //   ];
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

- (void)catchError:(NSString*)spec
{
    /*
    Vex.Flow.Test.TimeSignature.catchError = function(ts, spec) {
        try {
            [VFTimeSignature parseTimeSpec:spec);
        } catch (e) {
            equal(e.code, "BadTimeSignature", e.message);
        }
    }
     */
    [VFLog logNotYetImplementedForClass:[self class] andSelector:_cmd];
}

- (void)parser
{
    expect(@"6");

    // Invalid time signatures
    [[self class] catchError:@"asdf"];
    [[self class] catchError:@"123/"];
    [[self class] catchError:@"/10"];
    [[self class] catchError:@"/"];
    [[self class] catchError:@"4567"];
    [[self class] catchError:@"C+"];

    //    [VFTimeSignature parseTimeSpec:@"4/4"];
    //    [VFTimeSignature parseTimeSpec:@"10/12"];
    //    [VFTimeSignature parseTimeSpec:@"1/8"];
    //    [VFTimeSignature parseTimeSpec:@"1234567890/1234567890"];
    //    [VFTimeSignature parseTimeSpec:@"C"];
    //    [VFTimeSignature parseTimeSpec:@"C|"];

    ok(YES, @"all pass");
}

- (void)basic:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 500, 0)];
      [staff addTimeSignatureWithName:@"2/2"];
      [staff addTimeSignatureWithName:@"3/4"];
      [staff addTimeSignatureWithName:@"4/4"];
      [staff addTimeSignatureWithName:@"6/8"];
      [staff addClefWithName:@"treble"];
      [staff addTimeSignatureWithName:@"C"];
      [staff addTimeSignatureWithName:@"C|"];

      [staff addEndTimeSignatureWithName:@"2/2"];
      [staff addEndTimeSignatureWithName:@"3/4"];
      [staff addEndTimeSignatureWithName:@"4/4"];
      [staff addEndClefWithName:@"treble"];
      [staff addEndTimeSignatureWithName:@"6/8"];
      [staff addEndTimeSignatureWithName:@"C"];
      [staff addEndTimeSignatureWithName:@"C|"];

      [staff draw:ctx];

      ok(YES, @"all pass");

    };
}

- (void)big:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 120) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];

      [staff addTimeSignatureWithName:@"12/8"];
      [staff addTimeSignatureWithName:@"7/16"];
      [staff addTimeSignatureWithName:@"1234567/890"];
      [staff addTimeSignatureWithName:@"987/654321"];

      [staff draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)multiStaff:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 350) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(15, 0, 300, 0)];

      for(NSUInteger i = 0; i < 5; i++)
      {
          if(i == 2)
              continue;
          [staff setConfigForLine:i withConfig:@{ @"visible" : @(NO) }];
      }

      [staff addClefWithName:@"percussion"];
      // passing the custom padding as second parameter (in pixels)
      [staff addTimeSignatureWithName:@"4/4" padding:25];
      [staff draw:ctx];

      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(15, 110, 300, 0)];
      [staff2 addClefWithName:@"treble"];
      [staff2 addTimeSignatureWithName:@"4/4"];
      [staff2 draw:ctx];

      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [connector setType:VFStaffConnectorSingle];
      [connector draw:ctx];

      VFStaff* staff3 = [VFStaff staffWithRect:CGRectMake(15, 220, 300, 0)];
      [staff3 addClefWithName:@"bass"];
      [staff3 addTimeSignatureWithName:@"4/4"];
      [staff3 draw:ctx];

      VFStaffConnector* connector2 = [VFStaffConnector staffConnectorWithTopStaff:staff2 andBottomStaff:staff3];
      [connector2 setType:VFStaffConnectorSingle];
      [connector2 draw:ctx];

      VFStaffConnector* connector3 = [VFStaffConnector staffConnectorWithTopStaff:staff2 andBottomStaff:staff3];
      [connector3 setType:VFStaffConnectorBrace];
      [connector3 draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)timeSigNote:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(900, 200) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 800, 0)];
      [[[staff addClefWithName:@"treble"] addTimeSignatureWithName:@"C|"] draw:ctx];

      //      NSArray* notes = @[
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"c/4" ],
      //              @"duration" : @"q",
      //              @"clefName" : @"treble"
      //          }],
      //
      //          [VFTimeSigNote timeSignatureWithType:VFTime3_4],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"d/4" ],
      //              @"duration" : @"q",
      //              @"clefName" : @"alto"
      //          }],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"b/3" ],
      //              @"duration" : @"qr",
      //              @"clefName" : @"alto"
      //          }],
      //
      //          [VFTimeSignature timeSignatureWithType:VFTimeC],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"c/3", @"e/3", @"g/3" ],
      //              @"duration" : @"q",
      //              @"clefName" : @"bass"
      //          }],
      //
      //          [VFTimeSignature timeSignatureWithType:VFTime9_8],
      //          [[VFStaffNote alloc] initWithDictionary:@{
      //              @"keys" : @[ @"c/4" ],
      //              @"duration" : @"q",
      //              @"clefName" : @"treble"
      //          }]
      //      ];
      //
      //      VFVoice* voice = [VFVoice voiceWithNumBeats:4 beatValue:4 resolution:kRESOLUTION];
      //      voice.mode = VFModeSoft;
      //      [voice addTickables:notes];
      //
      //      // VFFormatter* formatter =
      //      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:800];
      //
      //      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      ok(YES, @"all pass");
    };
}

@end
