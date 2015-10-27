//
//  BendTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "BendTests.h"
#import "VexFlowTestHelpers.h"

@implementation BendTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];

    [self runTest:@"Double Bends"  func:@selector(doubleBends:)];
    [self runTest:@"Reverse Bends"  func:@selector(reverseBends:)];
    [self runTest:@"Bend Phrase"  func:@selector(bendPhrase:)];
    [self runTest:@"Double Bends With Release"
           
             func:@selector(doubleBendWithRelease:)
        ];
    [self runTest:@"Whako Bend"  func:@selector(whackBends:)];
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

- (void)doubleBends:(TestCollectionItemView*)parent
{
    VFTabNote* (^newNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* tab_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:tab_struct];
    };
    VFBend* (^newBend)(NSString*) = ^VFBend*(NSString* text)
    {
        return [[VFBend alloc] initWithText:text];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(500, 240) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 450, 0)];

      [staff draw:ctx];

      NSArray* notes = @[
          [[newNote(@{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(4), @"fret" : @(9)} ],
              @"duration" : @"q"
          }) addModifier:newBend(@"Full")
                  atIndex:0] addModifier:newBend(@"1/2")
                                 atIndex:1],

          [[newNote(@{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(5)}, @{@"str" : @(3), @"fret" : @(5)} ],
              @"duration" : @"q"
          }) addModifier:newBend(@"1/4")
                  atIndex:0] addModifier:newBend(@"1/4")
                                 atIndex:1],

          newNote(
              @{ @"positions" : @[ @{@"str" : @(4), @"fret" : @(7)} ],
                 @"duration" : @"h" })
      ];

      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staff withNotes:notes];

      ok(YES, @"Double Bends");
    };
}

- (void)doubleBendWithRelease:(TestCollectionItemView*)parent
{
    VFTabNote* (^newNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* tab_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:tab_struct];
    };
    VFBend* (^newBend)(NSString*, BOOL) = ^VFBend*(NSString* text, BOOL release)
    {
        return [[VFBend alloc] initWithText:text release:release phrase:nil];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(500, 240) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 550, 0)];

      [staff draw:ctx];

      NSArray* notes = @[
          [[newNote(@{
              @"positions" : @[ @{@"str" : @(1), @"fret" : @(10)}, @{@"str" : @(4), @"fret" : @(9)} ],
              @"duration" : @"q"
          }) addModifier:newBend(@"1/2", YES)
                  atIndex:0] addModifier:newBend(@"Full", YES)
                                 atIndex:1],

          [[[newNote(@{
              @"positions" : @[
                  @{@"str" : @(2), @"fret" : @(5)},
                  @{@"str" : @(3), @"fret" : @(5)},
                  @{@"str" : @(4), @"fret" : @(5)}
              ],
              @"duration" : @"q"
          }) addModifier:newBend(@"1/4", YES)
                  atIndex:0] addModifier:newBend(@"Monstrous", YES)
                                 atIndex:1] addModifier:newBend(@"1/4", YES)
                                                atIndex:2],

          newNote(
              @{ @"positions" : @[ @{@"str" : @(4), @"fret" : @(7)} ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"positions" : @[ @{@"str" : @(4), @"fret" : @(7)} ],
                 @"duration" : @"q" })
      ];

      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staff withNotes:notes];
      ok(YES, @"Bend Release");
    };
}

- (void)reverseBends:(TestCollectionItemView*)parent
{
    VFTabNote* (^newNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* tab_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:tab_struct];
    };
    VFBend* (^newBend)(NSString*) = ^VFBend*(NSString* text)
    {
        return [[VFBend alloc] initWithText:text];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(500, 240) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 450, 0)];

      [staff draw:ctx];

      NSArray* notes = @[
          [[newNote(
              @{ @"positions" : @[ @{@"str" : @2, @"fret" : @10}, @{@"str" : @4, @"fret" : @9} ],
                 @"duration" : @"w" }) addModifier:newBend(@"Full")
                                           atIndex:1] addModifier:newBend(@"1/2")
                                                          atIndex:0],
          [[newNote(@{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(5)}, @{@"str" : @(3), @"fret" : @(5)} ],
              @"duration" : @"w"
          }) addModifier:newBend(@"1/4")
                  atIndex:1] addModifier:newBend(@"1/4")
                                 atIndex:0],

          newNote(
              @{ @"positions" : @[ @{@"str" : @(4), @"fret" : @(7)} ],
                 @"duration" : @"w" })

      ];

      for(NSUInteger i = 0; i < notes.count; ++i)
      {
          VFTabNote* note = notes[i];
          VFModifierContext* mc = [VFModifierContext modifierContext];
          [note addToModifierContext:mc];

          VFTickContext* tickContext = [[VFTickContext alloc] init];
          [[tickContext addTickable:note] preFormat];
          tickContext.x = 75 * i;
          [tickContext setPixelsUsed:95];

          note.staff = staff;
          [note draw:ctx];

          NSString* success = [NSString stringWithFormat:@"Bend %lu", (unsigned long)i];
          ok(YES, success);
      }
    };
}

- (void)bendPhrase:(TestCollectionItemView*)parent
{
    VFTabNote* (^newNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* tab_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:tab_struct];
    };
    VFBend* (^newBend)(NSArray*) = ^VFBend*(NSArray* phrase)
    {
        return [[VFBend alloc] initWithText:nil release:NO phrase:phrase];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(500, 240) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 450, 0)];

      [staff draw:ctx];

      NSArray* phrase1 = @[
          [VFBendStruct bendStructWithType:VFBendUP andText:@"Full"],
          @{ @"type" : @(VFBendDOWN),
             @"text" : @"Monstrous" },
          @{ @"type" : @(VFBendUP),
             @"text" : @"1/2" },
          @{ @"type" : @(VFBendDOWN),
             @"text" : @"" }
      ];
      VFBend* bend1 = newBend(phrase1);
      //      bend1.graphicsContext = ctx;

      NSArray* notes = @[
          [newNote(
              @{ @"positions" : @[ @{@"str" : @2, @"fret" : @10} ],
                 @"duration" : @"w" }) addModifier:bend1
                                           atIndex:0],
      ];

      for(NSUInteger i = 0; i < notes.count; ++i)
      {
          VFTabNote* note = notes[i];
          VFModifierContext* mc = [VFModifierContext modifierContext];
          [note addToModifierContext:mc];

          VFTickContext* tickContext = [[VFTickContext alloc] init];
          [[tickContext addTickable:note] preFormat];
          tickContext.x = 75 * i;
          [tickContext setPixelsUsed:95];

          note.staff = staff;
          [note draw:ctx];

          NSString* success = [NSString stringWithFormat:@"Bend %lu", (unsigned long)i];
          ok(YES, success);
      }
    };
}

- (void)whackBends:(TestCollectionItemView*)parent
{
    VFTabNote* (^newNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* tab_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:tab_struct];
    };
    VFBend* (^newBend)(NSArray*) = ^VFBend*(NSArray* phrase)
    {
        return [[VFBend alloc] initWithPhrase:phrase];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(650, 240) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 650, 0)];

      [staff draw:ctx];

      NSArray* phrase1 = @[
          @{ @"type" : @(VFBendUP),
             @"text" : @"Full" },
          @{ @"type" : @(VFBendDOWN),
             @"text" : @"" },
          @{ @"type" : @(VFBendUP),
             @"text" : @"1/2" },
          @{ @"type" : @(VFBendDOWN),
             @"text" : @"" }
      ];

      NSArray* phrase2 = @[
          @{ @"type" : @(VFBendUP),
             @"text" : @"Full" },
          @{ @"type" : @(VFBendUP),
             @"text" : @"Full" },
          @{ @"type" : @(VFBendUP),
             @"text" : @"1/2" },
          @{ @"type" : @(VFBendDOWN),
             @"text" : @"" },
          @{ @"type" : @(VFBendDOWN),
             @"text" : @"Full" },
          @{ @"type" : @(VFBendDOWN),
             @"text" : @"Full" },
          @{ @"type" : @(VFBendUP),
             @"text" : @"1/2" },
          @{ @"type" : @(VFBendDOWN),
             @"text" : @"" }
      ];

      NSArray* notes = @[
          [[newNote(@{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(3), @"fret" : @(9)} ],
              @"duration" : @"q"
          }) addModifier:newBend(phrase1)
                  atIndex:0] addModifier:newBend(phrase2)
                                 atIndex:1]
      ];

      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staff withNotes:notes];
      ok(YES, @"Whako Release");
    };
}

@end
