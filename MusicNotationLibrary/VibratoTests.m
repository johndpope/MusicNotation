//
//  VibratoTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "VibratoTests.h"
#import "VexFlowTestHelpers.h"

@implementation VibratoTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple Vibrato"  func:@selector(simple:)];
    [self runTest:@"Harsh Vibrato"  func:@selector(harsh:)];
    [self runTest:@"Vibrato with Bend"  func:@selector(withBend:)];
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

- (void)simple:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFVibrato* (^newVibrato)() = ^VFVibrato*()
    {
        return [[VFVibrato alloc] init];
    };
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(500, 140) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFTabStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addTabGlyph];
      [staff draw:ctx];
      NSArray* notes = @[
          [newNote(@{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(4), @"fret" : @(9)} ],
              @"duration" : @"h"
          }) addModifier:newVibrato()
                  atIndex:0],
          [newNote(
              @{ @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)} ],
                 @"duration" : @"h" }) addModifier:newVibrato()
                                           atIndex:0],
      ];

        [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staff withNotes:notes];

      ok(YES, @"Simple Vibrato");
    };
}

- (void)harsh:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFVibrato* (^newVibrato)() = ^VFVibrato*()
    {
        return [[VFVibrato alloc] init];
    };
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(500, 240) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFTabStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addTabGlyph];
      [staff draw:ctx];

      NSArray* notes = @[
          [newNote(@{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(4), @"fret" : @(9)} ],
              @"duration" : @"h"
          }) addModifier:[newVibrato() setHarsh:YES]
                  atIndex:0],
          [newNote(
              @{ @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)} ],
                 @"duration" : @"h" }) addModifier:[newVibrato() setHarsh:YES]
                                           atIndex:0],
      ];
        [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staff withNotes:notes];
      ok(YES, @"Harsh Vibrato");
    };
}

- (void)withBend:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFBend* (^newBend)(NSString*, BOOL) = ^VFBend*(NSString* text, BOOL release)
    {
        return [[VFBend alloc] initWithText:text release:release phrase:nil];
    };
    VFVibrato* (^newVibrato)() = ^VFVibrato*()
    {
        return [[VFVibrato alloc] init];
    };
//    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(500, 240) withParent:parent];
//    TestCollectionItemView* test = c.view;
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
//      [VFTestView background:bounds];
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFTabStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addTabGlyph];
      [staff draw:ctx];
      NSArray* notes = @[
          [[[newNote(@{
              @"positions" : @[ @{@"str" : @(2), @"fret" : @(9)}, @{@"str" : @(3), @"fret" : @(9)} ],
              @"duration" : @"q"
          }) addModifier:newBend(@"1/2", YES)
                  atIndex:0] addModifier:newBend(@"1/2", YES)
                                 atIndex:1] addModifier:newVibrato()
                                                atIndex:0],
          [[newNote(
              @{ @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)} ],
                 @"duration" : @"q" }) addModifier:newBend(@"Full", NO)
                                           atIndex:0] addModifier:[newVibrato() setVibratoWidth:60]
                                                          atIndex:0],
          [newNote(
              @{ @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)} ],
                 @"duration" : @"h" }) addModifier:[[newVibrato() setVibratoWidth:120] setHarsh:YES]
                                           atIndex:0]
      ];

        [VFFormatter formatAndDrawWithContext:ctx
                                    dirtyRect:CGRectZero toStaff:staff withNotes:notes];
      ok(YES, @"Vibrato with Bend");

    };
}

@end
