//
//  KeyClefTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "KeyClefTests.h"
#import "VexFlowTestHelpers.h"

@interface KeyClefTests ()
{
}

@end

@implementation KeyClefTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
//    [self runTest:@"Key Parser Test"  func:@selector(parser)];
    [self runTest:@"Major Key Clef Test"  func:@selector(majorKeys:withTitle:)];

    [self runTest:@"Minor Key Clef Test"  func:@selector(minorKeys:withTitle:)];

    [self runTest:@"Staff Helper"  func:@selector(staffHelper:withTitle:)];
}




static NSDictionary* _ClefKeySignature;

static NSArray* _MAJOR_KEYS;
+ (NSArray*)MAJOR_KEYS
{
    if(!_MAJOR_KEYS)
    {
        _MAJOR_KEYS =
            @[ @"C", @"F", @"Bb", @"Eb", @"Ab", @"Db", @"Gb", @"Cb", @"G", @"D", @"A", @"E", @"B", @"F#", @"C#" ];
    }
    return _MAJOR_KEYS;
}

static NSArray* _MINOR_KEYS;
+ (NSArray*)MINOR_KEYS
{
    if(!_MINOR_KEYS)
    {
        _MINOR_KEYS = @[
            @"Am",
            @"Dm",
            @"Gm",
            @"Cm",
            @"Fm",
            @"Bbm",
            @"Ebm",
            @"Abm",
            @"Em",
            @"Bm",
            @"F#m",
            @"C#m",
            @"G#m",
            @"D#m",
            @"A#m"
        ];
    }
    return _MINOR_KEYS;
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
    Vex.Flow.Test.ClefKeySignature.catchError = function(spec) {
        try {
            [VFKeySignature keySignatureWithKey:spec);
        } catch (e) {
            equal(e.code, "BadKeySignature", e.message);
        }
    }
     */
    [VFLog logNotYetImplementedForClass:[self class] andSelector:_cmd];
}

- (void)parser
{
    expect(@"11");
    [[self class] catchError:@"asdf"];
    [[self class] catchError:@"D!"];
    [[self class] catchError:@"E#"];
    [[self class] catchError:@"D#"];
    [[self class] catchError:@"#"];
    [[self class] catchError:@"b"];
    [[self class] catchError:@"Kb"];
    [[self class] catchError:@"Fb"];
    [[self class] catchError:@"Ab"];
    [[self class] catchError:@"Dbm"];
    [[self class] catchError:@"B#m"];

    [VFKeySignature keySignatureWithKey:@"B"];
    [VFKeySignature keySignatureWithKey:@"C"];
    [VFKeySignature keySignatureWithKey:@"Fm"];
    [VFKeySignature keySignatureWithKey:@"Ab"];
    [VFKeySignature keySignatureWithKey:@"Abm"];
    [VFKeySignature keySignatureWithKey:@"F#"];
    [VFKeySignature keySignatureWithKey:@"G#m"];

    ok(YES, @"all pass");
}

- (void)majorKeys:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(440, 400) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 370, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(10, 90, 370, 0)];
      VFStaff* staff3 = [VFStaff staffWithRect:CGRectMake(10, 170, 370, 0)];
      VFStaff* staff4 = [VFStaff staffWithRect:CGRectMake(10, 260, 370, 0)];
      [staff addClefWithName:@"treble"];
      [staff2 addClefWithName:@"bass"];
      [staff3 addClefWithName:@"alto"];
      [staff4 addClefWithName:@"tenor"];
      NSArray* keys = [self class].MAJOR_KEYS;

      for(NSUInteger n = 0; n < 8; ++n)
      {
          VFKeySignature* keySig = [VFKeySignature keySignatureWithKey:keys[n]];
          VFKeySignature* keySig2 = [VFKeySignature keySignatureWithKey:keys[n]];
          [keySig addToStaff:staff];
          [keySig2 addToStaff:staff2];
      }

      for(NSUInteger i = 8; i < keys.count; ++i)
      {
          VFKeySignature* keySig3 = [VFKeySignature keySignatureWithKey:keys[i]];
          VFKeySignature* keySig4 = [VFKeySignature keySignatureWithKey:keys[i]];
          [keySig3 addToStaff:staff3];
          [keySig4 addToStaff:staff4];
      }

      [staff draw:ctx];
      [staff2 draw:ctx];
      [staff3 draw:ctx];
      [staff4 draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)minorKeys:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(440, 400) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 370, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(10, 90, 370, 0)];
      VFStaff* staff3 = [VFStaff staffWithRect:CGRectMake(10, 170, 370, 0)];
      VFStaff* staff4 = [VFStaff staffWithRect:CGRectMake(10, 260, 370, 0)];
      [staff addClefWithName:@"treble"];
      [staff2 addClefWithName:@"bass"];
      [staff3 addClefWithName:@"alto"];
      [staff4 addClefWithName:@"tenor"];
      NSArray* keys = [self class].MINOR_KEYS;

      for(NSUInteger n = 0; n < 8; ++n)
      {
          VFKeySignature* keySig3 = [VFKeySignature keySignatureWithKey:keys[n]];
          VFKeySignature* keySig4 = [VFKeySignature keySignatureWithKey:keys[n]];
          [keySig3 addToStaff:staff3];
          [keySig4 addToStaff:staff4];
      }

      for(NSUInteger i = 8; i < keys.count; ++i)
      {
          VFKeySignature* keySig = [VFKeySignature keySignatureWithKey:keys[i]];
          VFKeySignature* keySig2 = [VFKeySignature keySignatureWithKey:keys[i]];
          [keySig addToStaff:staff];
          [keySig2 addToStaff:staff2];
      }

      [staff draw:ctx];
      [staff2 draw:ctx];
      [staff3 draw:ctx];
      [staff4 draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)staffHelper:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(440, 400) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 370, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(10, 90, 370, 0)];
      VFStaff* staff3 = [VFStaff staffWithRect:CGRectMake(10, 170, 370, 0)];
      VFStaff* staff4 = [VFStaff staffWithRect:CGRectMake(10, 260, 370, 0)];
      NSArray* keys = [self class].MAJOR_KEYS;

      [staff addClefWithName:@"treble"];
      [staff2 addClefWithName:@"bass"];
      [staff3 addClefWithName:@"alto"];
      [staff4 addClefWithName:@"tenor"];

      for(NSUInteger n = 0; n < 8; ++n)
      {
          [staff addKeySignature:keys[n]];
          [staff2 addKeySignature:keys[n]];
      }

      for(NSUInteger i = 8; i < keys.count; ++i)
      {
          [staff3 addKeySignature:keys[i]];
          [staff4 addKeySignature:keys[i]];
      }

      [staff draw:ctx];
      [staff2 draw:ctx];
      [staff3 draw:ctx];
      [staff4 draw:ctx];

      ok(YES, @"all pass");
    };
}

@end
