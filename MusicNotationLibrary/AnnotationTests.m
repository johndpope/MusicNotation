//
//  AnnotationTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "AnnotationTests.h"
#import "VexFlowTestHelpers.h"

@implementation AnnotationTests

static NSUInteger testFontSize;

- (void)start   //:(VFTestView*)parent;
{
    testFontSize = 12;
//    [super start:parent];
//    id targetClass = [self class];

    [self runTest:@"Simple Annotation"  func:@selector(simple:withTitle:)];
    [self runTest:@"Standard Notation Annotation"
           
             func:@selector(standard:withTitle:)
        ];
    [self runTest:@"Harmonics"  func:@selector(harmonic:withTitle:)];
    [self runTest:@"Fingerpicking"  func:@selector(picking:withTitle:)];
    [self runTest:@"Bottom Annotation"  func:@selector(bottom:withTitle:)];
    [self runTest:@"Test Justification Annotation Stem Up"
           
             func:@selector(justificationStemUp:withTitle:)
        ];
    [self runTest:@"Test Justification Annotation Stem Down"
           
             func:@selector(justificationStemDown:withTitle:)
        ];
    [self runTest:@"TabNote Annotations"  func:@selector(tabNotes:withTitle:)];
}




- (ViewStaffStruct*)setupContextWithSize:(VFUIntSize*)size withParent:(TestCollectionItemView*)parent withTitle:(NSString*)title
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

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h) withParent:parent withTitle:title];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

- (void)simple:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(500, 240) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      //      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFTabStaff* staff = [[VFTabStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addTabGlyph];
      [staff draw:ctx];

      VFTabNote* (^newNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* tab_struct)
      {
          return [[VFTabNote alloc] initWithDictionary:tab_struct];
      };
      VFBend* (^newBend)(NSString*) = ^VFBend*(NSString* text)
      {
          return [[VFBend alloc] initWithText:text];
      };
      VFAnnotation* (^newAnnotation)(NSString*) = ^VFAnnotation*(NSString* text)
      {
          return [VFAnnotation annotationWithText:text];
      };

      NSArray* notes = @[
          [newNote(@{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(4), @"fret" : @(9)} ],
              @"duration" : @"h"
          }) addModifier:newAnnotation(@"T")
                  atIndex:0],
          [[newNote(
              @{ @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)} ],
                 @"duration" : @"h" }) addModifier:newAnnotation(@"T")
                                           atIndex:0] addModifier:newBend(@"Full")
                                                          atIndex:0],
      ];

      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staff withNotes:notes withJustifyWidth:200];

      ok(YES, @"Simple Annotation");
    };
}

- (void)standard:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(500, 240) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      //      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addClefWithName:@"treble"];
      [staff draw:ctx];

      VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* tab_struct)
      {
          return [[VFStaffNote alloc] initWithDictionary:tab_struct];
      };
      VFAnnotation* (^newAnnotation)(NSString*) = ^VFAnnotation*(NSString* text)
      {
          VFAnnotation* ret = [VFAnnotation annotationWithText:text];
          //          VFFont* font = [VFFont fontWithName:@"Times" size:testFontSize];
          //          font.italic = YES;
          //          [ret setFont:font];
          return ret;
      };

      NSArray* notes = @[
          [newNote(
              @{ @"keys" : @[ @"c/4", @"e/4" ],
                 @"duration" : @"h" }) addAnnotation:newAnnotation(@"quiet")
                                             atIndex:0],
          [newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"c/5" ],
                 @"duration" : @"h" }) addAnnotation:newAnnotation(@"Allegro")
                                             atIndex:2]
      ];

      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staff withNotes:notes withJustifyWidth:200];

      ok(YES, @"Standard Notation Annotation");
    };
}

- (void)harmonic:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFTabNote* (^newNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* tab_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:tab_struct];
    };
    VFAnnotation* (^newAnnotation)(NSString*) = ^VFAnnotation*(NSString* text)
    {
        return [VFAnnotation annotationWithText:text];
    };

//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(500, 240) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      //      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFTabStaff* staff = [[VFTabStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addTabGlyph];
      [staff draw:ctx];

      NSArray* notes = @[
          [newNote(@{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(12)}, @{@"str" : @(3), @"fret" : @(12)} ],
              @"duration" : @"h"
          }) addModifier:newAnnotation(@"Harm.")
                  atIndex:0],
          [[newNote(
              @{ @"positions" : @[ @{@"str" : @(2), @"fret" : @(9)} ],
                 @"duration" : @"h" })
              addModifier:[newAnnotation(@"(8va)") setFontName:@"Times" withSize:testFontSize withStyle:@"italic"]]
              addModifier:newAnnotation(@"A.H.")
                  atIndex:0],
      ];

      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staff withNotes:notes withJustifyWidth:200];

      ok(YES, @"Simple Annotation");
    };
}

- (void)picking:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFTabNote* (^newNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* tab_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:tab_struct];
    };
    VFAnnotation* (^newAnnotation)(NSString*) = ^VFAnnotation*(NSString* text)
    {
        VFAnnotation* ret = [VFAnnotation annotationWithText:text];
        //        VFFont* font = [VFFont fontWithName:@"Times" size:testFontSize];
        //        font.italic = YES;
        //        [ret setFont:font];
        return ret;
    };

//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(500, 240) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      //      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFTabStaff* staff = [[VFTabStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addTabGlyph];
      [staff draw:ctx];
      NSArray* notes = @[
          [newNote(@{
              @"positions" : @[
                  @{@"str" : @(1), @"fret" : @(0)},
                  @{@"str" : @(2), @"fret" : @(1)},
                  @{@"str" : @(3), @"fret" : @(2)},
                  @{@"str" : @(4), @"fret" : @(2)},
                  @{@"str" : @(5), @"fret" : @(0)}
              ],
              @"duration" : @"h"
          }) addModifier:[[[VFVibrato alloc] init] setVibratoWidth:40]],
          [newNote(
              @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(9)} ],
                 @"duration" : @"8" }) addModifier:newAnnotation(@"p")
                                           atIndex:0],
          [newNote(
              @{ @"positions" : @[ @{@"str" : @(3), @"fret" : @(9)} ],
                 @"duration" : @"8" }) addModifier:newAnnotation(@"i")
                                           atIndex:0],
          [newNote(
              @{ @"positions" : @[ @{@"str" : @(2), @"fret" : @(9)} ],
                 @"duration" : @"8" }) addModifier:newAnnotation(@"m")
                                           atIndex:0],
          [newNote(
              @{ @"positions" : @[ @{@"str" : @(1), @"fret" : @(9)} ],
                 @"duration" : @"8" }) addModifier:newAnnotation(@"a")
                                           atIndex:0],
      ];

      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staff withNotes:notes withJustifyWidth:200];

      ok(YES, @"Fingerpicking");
    };
}

- (void)bottom:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* tab_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:tab_struct];
    };
    VFAnnotation* (^newAnnotation)(NSString*) = ^VFAnnotation*(NSString* text)
    {
        VFAnnotation* ret = [VFAnnotation annotationWithText:text];
        VFFont* font = [VFFont fontWithName:@"Times" size:testFontSize];
        //        font.italic = YES;
        [ret setVerticalJustification:VFVerticalJustifyBOTTOM];
        [ret setFont:font];
        return ret;
    };

//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(500, 240) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      //      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)] addClefWithName:@"treble"];
      [staff draw:ctx];

      NSArray* notes = @[
          [newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"duration" : @"w" }) addAnnotation:newAnnotation(@"F")
                                             atIndex:0],
          [newNote(
              @{ @"keys" : @[ @"a/4" ],
                 @"duration" : @"w" }) addAnnotation:newAnnotation(@"A")
                                             atIndex:0],
          [newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"duration" : @"w" }) addAnnotation:newAnnotation(@"C")
                                             atIndex:0],
          [newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"duration" : @"w" }) addAnnotation:newAnnotation(@"E")
                                             atIndex:0],
      ];

      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staff withNotes:notes withJustifyWidth:100];

      ok(YES, @"Bottom Annotation");
    };
}

- (void)justificationStemUp:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* tab_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:tab_struct];
    };
    VFAnnotation* (^newAnnotation)(NSString*, float, float) =
        ^VFAnnotation*(NSString* text, float hJustifcation, float vJustifcation)
    {
        VFAnnotation* ret = [VFAnnotation annotationWithText:text];
        //        VFFont* font = [VFFont fontWithName:@"Arial" size:testFontSize];
        //        font.italic = YES;
        //        [ret setFont:font];
        return ret;
    };

//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(650, 950) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      //      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      NSMutableArray* notes = nil;

      for(NSUInteger v = 1; v <= 4; ++v)
      {
          VFStaff* staff =
              [[VFStaff staffWithRect:CGRectMake(10, (v - 1) * 150 + 40, 400, 0)] addClefWithName:@"treble"];
          [staff draw:ctx];

          notes = [NSMutableArray arrayWithCapacity:4];

          [notes push:[newNote(
                          @{ @"keys" : @[ @"c/3" ],
                             @"duration" : @"q" }) addAnnotation:newAnnotation(@"Text", 1, v)
                                                         atIndex:0]];
          [notes push:[newNote(
                          @{ @"keys" : @[ @"c/4" ],
                             @"duration" : @"q" }) addAnnotation:newAnnotation(@"Text", 2, v)
                                                         atIndex:0]];
          [notes push:[newNote(
                          @{ @"keys" : @[ @"c/5" ],
                             @"duration" : @"q" }) addAnnotation:newAnnotation(@"Text", 3, v)
                                                         atIndex:0]];
          [notes push:[newNote(
                          @{ @"keys" : @[ @"c/6" ],
                             @"duration" : @"q" }) addAnnotation:newAnnotation(@"Text", 4, v)
                                                         atIndex:0]];

          [VFFormatter formatAndDrawWithContext:ctx
                                      dirtyRect:CGRectZero
                                        toStaff:staff
                                      withNotes:notes
                               withJustifyWidth:100];
      }

      ok(YES, @"Test Justification Annotation");
    };
}

- (void)justificationStemDown:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* tab_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:tab_struct];
    };
    VFAnnotation* (^newAnnotation)(NSString*, float, float) =
        ^VFAnnotation*(NSString* text, float hJustifcation, float vJustifcation)
    {
        VFAnnotation* ret = [VFAnnotation annotationWithText:text];
        //        VFFont* font = [VFFont fontWithName:@"Arial" size:testFontSize];
        //        font.italic = YES;
        //        [ret setFont:font];
        return ret;
    };

//    ViewStaffStruct* c =
//        [[self class] setupContextWithSize:VFUIntSizeMake(650, 1000) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      //      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      NSMutableArray* notes = nil;

      for(NSUInteger v = 1; v <= 4; ++v)
      {
          VFStaff* staff =
              [[VFStaff staffWithRect:CGRectMake(10, (v - 1) * 150 + 40, 400, 0)] addClefWithName:@"treble"];
          [staff draw:ctx];

          notes = [NSMutableArray arrayWithCapacity:4];

          [notes push:[newNote(
                          @{ @"keys" : @[ @"c/3" ],
                             @"duration" : @"q",
                             @"stem_direction" : @(-1) }) addAnnotation:newAnnotation(@"Text", 1, v)
                                                                atIndex:0]];
          [notes push:[newNote(
                          @{ @"keys" : @[ @"c/4" ],
                             @"duration" : @"q",
                             @"stem_direction" : @(-1) }) addAnnotation:newAnnotation(@"Text", 2, v)
                                                                atIndex:0]];
          [notes push:[newNote(
                          @{ @"keys" : @[ @"c/5" ],
                             @"duration" : @"q",
                             @"stem_direction" : @(-1) }) addAnnotation:newAnnotation(@"Text", 3, v)
                                                                atIndex:0]];
          [notes push:[newNote(
                          @{ @"keys" : @[ @"c/6" ],
                             @"duration" : @"q",
                             @"stem_direction" : @(-1) }) addAnnotation:newAnnotation(@"Text", 4, v)
                                                                atIndex:0]];

          [VFFormatter formatAndDrawWithContext:ctx
                                      dirtyRect:CGRectZero
                                        toStaff:staff
                                      withNotes:notes
                               withJustifyWidth:100];
      }

      ok(YES, @"Test Justification Annotation");
    };
}

- (void)tabNotes:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFAnnotation* (^newAnnotation)(NSString*) = ^VFAnnotation*(NSString* text)
    {
        return [VFAnnotation annotationWithText:text];
    };

//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(600, 200) withParent:parent withTitle:title];
//    TestCollectionItemView* test = c.view;
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();

      //      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFTabStaff* staff = [VFTabStaff staffWithRect:CGRectMake(10, 10, 550, 0)];

      [staff draw:ctx];

      NSArray* specs = @[
          @{
              @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(3), @"fret" : @(5)} ],
              @"duration" : @"8"
          },
          @{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(3), @"fret" : @(5)} ],
              @"duration" : @"8"
          }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* tab_struct) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:tab_struct];
        [tabNote->_renderOptions setDraw_stem:YES];
        return tabNote;
      }];

      NSArray* notes2 = [specs oct_map:^VFTabNote*(NSDictionary* tab_struct) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:tab_struct];
        [tabNote->_renderOptions setDraw_stem:YES];
        [tabNote setStemDirection:VFStemDirectionDown];
        return tabNote;
      }];

      NSArray* notes3 = [specs oct_map:^VFTabNote*(NSDictionary* tab_struct) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:tab_struct];
        return tabNote;
      }];

      [notes[0] addModifier:[[newAnnotation(@"Text") setJustification:1] setVerticalJustification:1] atIndex:0];   // U
      [notes[1] addModifier:[[newAnnotation(@"Text") setJustification:2] setVerticalJustification:2] atIndex:0];   // D
      [notes[2] addModifier:[[newAnnotation(@"Text") setJustification:3] setVerticalJustification:3] atIndex:0];   // U
      [notes[3] addModifier:[[newAnnotation(@"Text") setJustification:4] setVerticalJustification:4] atIndex:0];   // D

      [notes2[0] addModifier:[[newAnnotation(@"Text") setJustification:3] setVerticalJustification:1] atIndex:0];   // U
      [notes2[1] addModifier:[[newAnnotation(@"Text") setJustification:3] setVerticalJustification:2] atIndex:0];   // D
      [notes2[2] addModifier:[[newAnnotation(@"Text") setJustification:3] setVerticalJustification:3] atIndex:0];   // U
      [notes2[3] addModifier:[[newAnnotation(@"Text") setJustification:3] setVerticalJustification:4] atIndex:0];   // D

      [notes3[0] addModifier:[newAnnotation(@"Text") setVerticalJustification:1] atIndex:0];   // U
      [notes3[1] addModifier:[newAnnotation(@"Text") setVerticalJustification:2] atIndex:0];   // D
      [notes3[2] addModifier:[newAnnotation(@"Text") setVerticalJustification:3] atIndex:0];   // U
      [notes3[3] addModifier:[newAnnotation(@"Text") setVerticalJustification:4] atIndex:0];   // D

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];
      [voice addTickables:notes2];
      [voice addTickables:notes3];

      //        VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"TabNotes successfully drawn");
    };
}

@end
