//
//  KeySignatureTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "KeySignatureTests.h"
#import "VexFlowTestHelpers.h"

@implementation KeySignatureTests

// TODO: the following are identical to KeyClefTests.m
// perhaps move both to VFTables.m

static NSMutableDictionary* _KeySignature;

+ (NSDictionary*)KeySignature
{
    if(!_KeySignature)
    {
        _KeySignature = [NSMutableDictionary dictionary];
    }
    return _KeySignature;
}

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

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Key Parser Test"  func:@selector(parser)];
    [self runTest:@"Major Key Test"  func:@selector(majorKeys:withTitle:)];

    [self runTest:@"Minor Key Test"  func:@selector(minorKeys:withTitle:)];

    [self runTest:@"Staff Helper"  func:@selector(staffHelper:withTitle:)];
    [self runTest:@"Cancelled key test"  func:@selector(majorKeysCanceled:withTitle:)];
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
    Vex.Flow.Test.KeySignature.catchError = function(spec) {
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
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 240) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(10, 90, 350, 0)];

      NSArray* keys = [self class].MAJOR_KEYS;

      VFKeySignature* keySig = nil;
      for(NSUInteger i = 0; i < 8; ++i)
      {
          keySig = [VFKeySignature keySignatureWithKey:keys[i]];
          [keySig addToStaff:staff];
      }

      for(NSUInteger n = 8; n < keys.count; ++n)
      {
          keySig = [VFKeySignature keySignatureWithKey:keys[n]];
          [keySig addToStaff:staff2];
      }

      [staff draw:ctx];
      [staff2 draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)majorKeysCanceled:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(780, 500) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 750, 0)] addTrebleGlyph];
      VFStaff* staff2 = [[VFStaff staffWithRect:CGRectMake(10, 90, 750, 0)] addTrebleGlyph];
      VFStaff* staff3 = [[VFStaff staffWithRect:CGRectMake(10, 170, 750, 0)] addTrebleGlyph];
      VFStaff* staff4 = [[VFStaff staffWithRect:CGRectMake(10, 250, 750, 0)] addTrebleGlyph];
      NSArray* keys = [self class].MAJOR_KEYS;

      VFKeySignature* keySig = nil;
      NSUInteger i, n;
      for(i = 0; i < 8; ++i)
      {
          keySig = [VFKeySignature keySignatureWithKey:keys[i]];
          [keySig cancelKey:@"Cb"];

          keySig.padding = 18;
          [keySig addToStaff:staff];
      }

      for(n = 8; n < keys.count; ++n)
      {
          keySig = [VFKeySignature keySignatureWithKey:keys[n]];
          [keySig cancelKey:@"C#"];
          keySig.padding = 20;
          [keySig addToStaff:staff2];
      }

      for(i = 0; i < 8; ++i)
      {
          keySig = [VFKeySignature keySignatureWithKey:keys[i]];
          [keySig cancelKey:@"E"];

          keySig.padding = 18;
          [keySig addToStaff:staff3];
      }

      for(n = 8; n < keys.count; ++n)
      {
          keySig = [VFKeySignature keySignatureWithKey:keys[n]];
          [keySig cancelKey:@"Ab"];
          keySig.padding = 20;
          [keySig addToStaff:staff4];
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
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 240) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(10, 90, 350, 0)];
      NSArray* keys = [self class].MINOR_KEYS;

      VFKeySignature* keySig = nil;
      for(NSUInteger i = 0; i < 8; ++i)
      {
          keySig = [VFKeySignature keySignatureWithKey:keys[i]];
          [keySig addToStaff:staff];
      }

      for(NSUInteger n = 8; n < keys.count; ++n)
      {
          keySig = [VFKeySignature keySignatureWithKey:keys[n]];
          [keySig addToStaff:staff2];
      }

      [staff draw:ctx];
      [staff2 draw:ctx];

      ok(YES, @"all pass");
    };
}

- (void)staffHelper:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 240) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 350, 0)];
      VFStaff* staff2 = [VFStaff staffWithRect:CGRectMake(10, 90, 350, 0)];
      NSArray* keys = [self class].MAJOR_KEYS;

      for(NSUInteger i = 0; i < 8; ++i)
      {
          [staff addKeySignatureWithSpec:keys[i]];
      }

      for(NSUInteger n = 8; n < keys.count; ++n)
      {
          [staff2 addKeySignatureWithSpec:keys[n]];
      }

      [staff draw:ctx];
      [staff2 draw:ctx];

      ok(YES, @"all pass");
    };
}

@end
