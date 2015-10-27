//
//  StaffConnectorTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "StaffConnectorTests.h"
#import "VexFlowTestHelpers.h"

@implementation StaffConnectorTests

// TODO: is staff_LINE_THICKNESS a constant inside of vfstaff?
static NSUInteger staff_LINE_THICKNESS;

- (void)start   //:(VFTestView*)parent;
{
    staff_LINE_THICKNESS = 1;

//    [super start:parent];
//    id targetClass = [self class];

    [self runTest:@"StaffConnector Single Draw Test"
           
             func:@selector(drawSingle:withTitle:)
        ];
    [self runTest:@"StaffConnector Single Draw Test, 1px Staff Line Thickness"
           
             func:@selector(drawSingle1pxBarlines:withTitle:)
        ];
    [self runTest:@"StaffConnector Single Both Sides Test"
           
             func:@selector(drawSingleBoth:withTitle:)
        ];
    [self runTest:@"StaffConnector Double Draw Test"
           
             func:@selector(drawDouble:withTitle:)
        ];
    [self runTest:@"StaffConnector Bold Double Line Left Draw Test"
           
             func:@selector(drawRepeatBegin:withTitle:)
        ];
    [self runTest:@"StaffConnector Bold Double Line Right Draw Test"
           
             func:@selector(drawRepeatEnd:withTitle:)
        ];
    [self runTest:@"StaffConnector Thin Double Line Right Draw Test"
           
             func:@selector(drawThinDouble:withTitle:)
        ];

    [self runTest:@"StaffConnector Bold Double Lines Overlapping Draw Test"
           
             func:@selector(drawRepeatAdjacent:withTitle:)
        ];

    [self runTest:@"StaffConnector Bold Double Lines Offset Draw Test"
           
             func:@selector(drawRepeatOffset:withTitle:)
        ];

    [self runTest:@"StaffConnector Bold Double Lines Offset Draw Test 2"
           
             func:@selector(drawRepeatOffset2:withTitle:)
        ];

    [self runTest:@"StaffConnector Brace Draw Test"
           
             func:@selector(drawBrace:withTitle:)
        ];

    [self runTest:@"StaffConnector Brace Wide Draw Test"
           
             func:@selector(drawBraceWide:withTitle:)
        ];

    [self runTest:@"StaffConnector Bracket Draw Test"
           
             func:@selector(drawBracket:withTitle:)
        ];

    [self runTest:@"StaffConnector Combined Draw Test"
           
             func:@selector(drawCombined:withTitle:)
        ];
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

- (void)drawSingle:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 300, 0)];

      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [connector setType:VFStaffConnectorSingle];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [connector draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawSingle1pxBarlines:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      staff_LINE_THICKNESS = 1;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 300, 0)];

      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [connector setType:VFStaffConnectorSingle];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [connector draw:ctx];
      staff_LINE_THICKNESS = 2;

      ok(YES, @"all pass");
    };
}

- (void)drawSingleBoth:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 300, 0)];

      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [connector setType:VFStaffConnectorSingleLeft];

      VFStaffConnector* connector2 = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [connector2 setType:VFStaffConnectorSingleRight];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [connector draw:ctx];
      [connector2 draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawDouble:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 300, 0)];

      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* line = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [connector setType:VFStaffConnectorDouble];

      [line setType:VFStaffConnectorSingle];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [connector draw:ctx];
      [line draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawBrace:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(450, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(100, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(100, 120, 300, 0)];

      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* line = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [connector setType:VFStaffConnectorBrace];

      [connector setText:@"Piano"];
      [line setType:VFStaffConnectorSingle];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [connector draw:ctx];
      [line draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawBraceWide:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 400) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 20, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 240, 300, 0)];

      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* line = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [connector setType:VFStaffConnectorBrace];

      [line setType:VFStaffConnectorSingle];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [connector draw:ctx];
      [line draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawBracket:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 300, 0)];

      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* line = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [connector setType:VFStaffConnectorBracket];

      [line setType:VFStaffConnectorSingle];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [connector draw:ctx];
      [line draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawRepeatBegin:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 300, 0)];

      [staff setBegBarType:VFBarLineRepeatBegin];
      [staff2 setBegBarType:VFBarLineRepeatBegin];

      VFStaffConnector* line = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [line setType:VFStaffConnectorBoldDoubleLeft];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [line draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawRepeatEnd:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 300, 0)];

      [staff setEndBarType:VFBarLineRepeatEnd];
      [staff2 setEndBarType:VFBarLineRepeatEnd];

      VFStaffConnector* line = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [line setType:VFStaffConnectorBoldDoubleRight];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [line draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawThinDouble:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 300, 0)];

      [staff setEndBarType:VFBarLineDouble];
      [staff2 setEndBarType:VFBarLineDouble];

      VFStaffConnector* line = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      [line setType:VFStaffConnectorThinDouble];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [line draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawRepeatAdjacent:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 150, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 150, 0)];
      VFStaff* staff3 = [VFStaff staffWithRect:CGRectMake(175, 10, 150, 0)];
      VFStaff* staff4 = [VFStaff staffWithRect:CGRectMake(175, 120, 150, 0)];

      [staff setEndBarType:VFBarLineRepeatEnd];
      [staff2 setEndBarType:VFBarLineRepeatEnd];
      [staff3 setEndBarType:VFBarLineEnd];
      [staff4 setEndBarType:VFBarLineEnd];

      [staff setBegBarType:VFBarLineRepeatBegin];
      [staff2 setBegBarType:VFBarLineRepeatBegin];
      [staff3 setBegBarType:VFBarLineRepeatBegin];
      [staff4 setBegBarType:VFBarLineRepeatBegin];
      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* connector2 = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* connector3 = [VFStaffConnector staffConnectorWithTopStaff:staff3 andBottomStaff:staff4];
      VFStaffConnector* connector4 = [VFStaffConnector staffConnectorWithTopStaff:staff3 andBottomStaff:staff4];

      [connector setType:VFStaffConnectorBoldDoubleLeft];
      [connector2 setType:VFStaffConnectorBoldDoubleRight];
      [connector3 setType:VFStaffConnectorBoldDoubleLeft];
      [connector4 setType:VFStaffConnectorBoldDoubleRight];
      [staff draw:ctx];
      [staff2 draw:ctx];
      [staff3 draw:ctx];
      [staff4 draw:ctx];
      [connector draw:ctx];
      [connector2 draw:ctx];
      [connector3 draw:ctx];
      [connector4 draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawRepeatOffset2:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 150, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 150, 0)];
      VFStaff* staff3 = [VFStaff staffWithRect:CGRectMake(175, 10, 150, 0)];
      VFStaff* staff4 = [VFStaff staffWithRect:CGRectMake(175, 120, 150, 0)];

      [staff addClefWithName:@"treble"];
      [staff2 addClefWithName:@"bass"];

      [staff3 addClefWithName:@"alto"];
      [staff4 addClefWithName:@"treble"];

      [staff addTimeSignatureWithName:@"4/4"];
      [staff2 addTimeSignatureWithName:@"4/4"];

      [staff3 addTimeSignatureWithName:@"6/8"];
      [staff4 addTimeSignatureWithName:@"6/8"];

      [staff setEndBarType:VFBarLineRepeatEnd];
      [staff2 setEndBarType:VFBarLineRepeatEnd];
      [staff3 setEndBarType:VFBarLineEnd];
      [staff4 setEndBarType:VFBarLineEnd];

      [staff setBegBarType:VFBarLineRepeatBegin];
      [staff2 setBegBarType:VFBarLineRepeatBegin];
      [staff3 setBegBarType:VFBarLineRepeatBegin];
      [staff4 setBegBarType:VFBarLineRepeatBegin];
      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* connector2 = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* connector3 = [VFStaffConnector staffConnectorWithTopStaff:staff3 andBottomStaff:staff4];
      VFStaffConnector* connector4 = [VFStaffConnector staffConnectorWithTopStaff:staff3 andBottomStaff:staff4];
      VFStaffConnector* connector5 = [VFStaffConnector staffConnectorWithTopStaff:staff3 andBottomStaff:staff4];

      [connector setType:VFStaffConnectorBoldDoubleLeft];
      [connector2 setType:VFStaffConnectorBoldDoubleRight];
      [connector3 setType:VFStaffConnectorBoldDoubleLeft];
      [connector4 setType:VFStaffConnectorBoldDoubleRight];
      [connector5 setType:VFStaffConnectorSingleLeft];

      [connector setX_shift:[staff getModifierXShift]];
      [connector3 setX_shift:[staff3 getModifierXShift]];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [staff3 draw:ctx];
      [staff4 draw:ctx];
      [connector draw:ctx];
      [connector2 draw:ctx];
      [connector3 draw:ctx];
      [connector4 draw:ctx];
      [connector5 draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawRepeatOffset:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 300) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(25, 10, 150, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(25, 120, 150, 0)];
      VFStaff* staff3 = [VFStaff staffWithRect:CGRectMake(175, 10, 150, 0)];
      VFStaff* staff4 = [VFStaff staffWithRect:CGRectMake(175, 120, 150, 0)];

      [staff addClefWithName:@"bass"];
      [staff2 addClefWithName:@"alto"];

      [staff3 addClefWithName:@"treble"];
      [staff4 addClefWithName:@"tenor"];

      [staff3 addKeySignature:@"Ab"];
      [staff4 addKeySignature:@"Ab"];

      [staff addTimeSignatureWithName:@"4/4"];
      [staff2 addTimeSignatureWithName:@"4/4"];

      [staff3 addTimeSignatureWithName:@"6/8"];
      [staff4 addTimeSignatureWithName:@"6/8"];

      [staff setEndBarType:VFBarLineRepeatEnd];
      [staff2 setEndBarType:VFBarLineRepeatEnd];
      [staff3 setEndBarType:VFBarLineEnd];
      [staff4 setEndBarType:VFBarLineEnd];

      [staff setBegBarType:VFBarLineRepeatBegin];
      [staff2 setBegBarType:VFBarLineRepeatBegin];
      [staff3 setBegBarType:VFBarLineRepeatBegin];
      [staff4 setBegBarType:VFBarLineRepeatBegin];
      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* connector2 = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff2];
      VFStaffConnector* connector3 = [VFStaffConnector staffConnectorWithTopStaff:staff3 andBottomStaff:staff4];
      VFStaffConnector* connector4 = [VFStaffConnector staffConnectorWithTopStaff:staff3 andBottomStaff:staff4];
      VFStaffConnector* connector5 = [VFStaffConnector staffConnectorWithTopStaff:staff3 andBottomStaff:staff4];

      [connector setType:VFStaffConnectorBoldDoubleLeft];
      [connector2 setType:VFStaffConnectorBoldDoubleRight];
      [connector3 setType:VFStaffConnectorBoldDoubleLeft];
      [connector4 setType:VFStaffConnectorBoldDoubleRight];
      [connector5 setType:VFStaffConnectorSingleLeft];

      [connector setX_shift:[staff getModifierXShift]];
      [connector3 setX_shift:[staff3 getModifierXShift]];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [staff3 draw:ctx];
      [staff4 draw:ctx];
      [connector draw:ctx];
      [connector2 draw:ctx];
      [connector3 draw:ctx];
      [connector4 draw:ctx];
      [connector5 draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)drawCombined:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(550, 700) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(150, 10, 300, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(150, 100, 300, 0)];
      VFStaff* staff3 = [VFStaff staffWithRect:CGRectMake(150, 190, 300, 0)];
      VFStaff* staff4 = [VFStaff staffWithRect:CGRectMake(150, 280, 300, 0)];
      VFStaff* staff5 = [VFStaff staffWithRect:CGRectMake(150, 370, 300, 0)];
      VFStaff* staff6 = [VFStaff staffWithRect:CGRectMake(150, 460, 300, 0)];
      VFStaff* staff7 = [VFStaff staffWithRect:CGRectMake(150, 560, 300, 0)];
      [staff setTextWithText:@"Violin" atPosition:VFPositionLeft];

      VFStaffConnector* conn_single = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:staff7];
      VFStaffConnector* conn_double = [VFStaffConnector staffConnectorWithTopStaff:staff2 andBottomStaff:staff3];
      VFStaffConnector* conn_bracket = [VFStaffConnector staffConnectorWithTopStaff:staff4 andBottomStaff:staff5];
      VFStaffConnector* conn_brace = [VFStaffConnector staffConnectorWithTopStaff:staff6 andBottomStaff:staff7];
      [conn_single setType:VFStaffConnectorSingle];
      [conn_double setType:VFStaffConnectorDouble];
      [conn_bracket setType:VFStaffConnectorBracket];
      [conn_brace setType:VFStaffConnectorBrace];
      [conn_double setText:@"Piano"];
      [conn_bracket setText:@"Celesta"];
      [conn_brace setText:@"Harpsichord"];

      [VFStaffConnector setDebugMode:YES];

      [staff draw:ctx];
      [staff2 draw:ctx];
      [staff3 draw:ctx];
      [staff4 draw:ctx];
      [staff5 draw:ctx];
      [staff6 draw:ctx];
      [staff7 draw:ctx];
      [conn_single draw:ctx];
      [conn_double draw:ctx];
      [conn_bracket draw:ctx];
      [conn_brace draw:ctx];

      ok(YES, @"all pass");
    };
}

@end
