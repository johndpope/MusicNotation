//
//  PedalMarkingTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "PedalMarkingTests.h"
#import "VexFlowTestHelpers.h"

@implementation PedalMarkingTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple Pedal" func:@selector(simpleText:)];
    [self runTest:@"Simple Pedal" func:@selector(simpleBracket:)];
    [self runTest:@"Simple Pedal" func:@selector(simpleMixed:)];
    [self runTest:@"Release and Depress on Same Note"

             func:@selector(releaseDepressOnSameNoteBracketed:)];
    [self runTest:@"Release and Depress on Same Note"

             func:@selector(releaseDepressOnSameNoteMixed:)];
    [self runTest:@"Custom Text" func:@selector(customText:)];
    [self runTest:@"Custom Text" func:@selector(customTextMixed:)];
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

//    [VFFont setFont:@" 10pt Arial"];

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h)
    // withParent:parent];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

- (void)simpleText:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(550, 200)
    // withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        // CGContextRef ctx = context.CGContext;
        // TODO: customize formatting
        // [[self class] background:bounds];
        expect(@"0");
        VFStaff* staff0 = [[VFStaff staffWithRect:CGRectMake(10, 10, 250, 0)] addTrebleGlyph];
        VFStaff* staff1 = [VFStaff staffWithRect:CGRectMake(260, 10, 250, 0)];
        [staff0 draw:ctx];
        [staff1 draw:ctx];

        NSArray* notes0 = [@[
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(-1) }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        NSArray* notes1 = [@[
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice0 setStrict:NO];
        VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice1 setStrict:NO];
        [voice0 addTickables:notes0];
        [voice1 addTickables:notes1];

        [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff0];
        [[[VFFormatter formatter] joinVoices:@[ voice1 ]] formatToStaff:@[ voice1 ] staff:staff1];

        VFPedalMarking* pedal = [VFPedalMarking pedalMarkingWithNotes:@[ notes0[0], notes0[2], notes0[3], notes1[3] ]];

        pedal.style = VFPedalMarkingText;

        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff0];
        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff1];
        [pedal draw:ctx];
    };
}

- (void)simpleBracket:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(550, 200)
    // withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        // CGContextRef ctx = context.CGContext;
        // TODO: customize formatting
        // [[self class] background:bounds];
        expect(@"0");
        VFStaff* staff0 = [[VFStaff staffWithRect:CGRectMake(10, 10, 250, 0)] addTrebleGlyph];
        VFStaff* staff1 = [VFStaff staffWithRect:CGRectMake(260, 10, 250, 0)];
        [staff0 draw:ctx];
        [staff1 draw:ctx];

        NSArray* notes0 = [@[
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(-1) }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        NSArray* notes1 = [@[
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice0 setStrict:NO];
        VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice1 setStrict:NO];
        [voice0 addTickables:notes0];
        [voice1 addTickables:notes1];

        [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff0];
        [[[VFFormatter formatter] joinVoices:@[ voice1 ]] formatToStaff:@[ voice1 ] staff:staff1];

        VFPedalMarking* pedal = [VFPedalMarking pedalMarkingWithNotes:@[ notes0[0], notes0[2], notes0[3], notes1[3] ]];

        pedal.style = VFPedalMarkingBracket;

        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff0];
        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff1];
        [pedal draw:ctx];
    };
}

- (void)simpleMixed:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(550, 200)
    // withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        // CGContextRef ctx = context.CGContext;
        // TODO: customize formatting
        // [[self class] background:bounds];
        expect(@"0");
        VFStaff* staff0 = [[VFStaff staffWithRect:CGRectMake(10, 10, 250, 0)] addTrebleGlyph];
        VFStaff* staff1 = [VFStaff staffWithRect:CGRectMake(260, 10, 250, 0)];
        [staff0 draw:ctx];
        [staff1 draw:ctx];
        NSArray* notes0 = [@[
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(-1) }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        NSArray* notes1 = [@[
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice0 setStrict:NO];
        VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice1 setStrict:NO];
        [voice0 addTickables:notes0];
        [voice1 addTickables:notes1];

        [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff0];
        [[[VFFormatter formatter] joinVoices:@[ voice1 ]] formatToStaff:@[ voice1 ] staff:staff1];

        VFPedalMarking* pedal = [VFPedalMarking pedalMarkingWithNotes:@[ notes0[0], notes0[2], notes0[3], notes1[3] ]];

        pedal.style = VFPedalMarkingMixed;

        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff0];
        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff1];
        [pedal draw:ctx];
    };
}

- (void)releaseDepressOnSameNoteBracketed:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(550, 200)
    // withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        // CGContextRef ctx = context.CGContext;
        // TODO: customize formatting
        // [[self class] background:bounds];
        expect(@"0");
        VFStaff* staff0 = [[VFStaff staffWithRect:CGRectMake(10, 10, 250, 0)] addTrebleGlyph];
        VFStaff* staff1 = [VFStaff staffWithRect:CGRectMake(260, 10, 250, 0)];
        [staff0 draw:ctx];
        [staff1 draw:ctx];

        NSArray* notes0 = [@[
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(-1) }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        NSArray* notes1 = [@[
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice0 setStrict:NO];
        VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice1 setStrict:NO];
        [voice0 addTickables:notes0];
        [voice1 addTickables:notes1];

        [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff0];
        [[[VFFormatter formatter] joinVoices:@[ voice1 ]] formatToStaff:@[ voice1 ] staff:staff1];

        VFPedalMarking* pedal = [VFPedalMarking
            pedalMarkingWithNotes:@[ notes0[0], notes0[3], notes0[3], notes1[1], notes1[1], notes1[3] ]];

        pedal.style = VFPedalMarkingBracket;

        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff0];
        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff1];
        [pedal draw:ctx];
    };
}

- (void)releaseDepressOnSameNoteMixed:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(550, 200)
    // withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        // CGContextRef ctx = context.CGContext;
        // TODO: customize formatting
        //      // [[self class] background:bounds];
        expect(@"0");
        VFStaff* staff0 = [[VFStaff staffWithRect:CGRectMake(10, 10, 250, 0)] addTrebleGlyph];
        VFStaff* staff1 = [VFStaff staffWithRect:CGRectMake(260, 10, 250, 0)];
        [staff0 draw:ctx];
        [staff1 draw:ctx];

        NSArray* notes0 = [@[
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(-1) }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        NSArray* notes1 = [@[
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice0 setStrict:NO];
        VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice1 setStrict:NO];
        [voice0 addTickables:notes0];
        [voice1 addTickables:notes1];

        [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff0];
        [[[VFFormatter formatter] joinVoices:@[ voice1 ]] formatToStaff:@[ voice1 ] staff:staff1];

        VFPedalMarking* pedal = [VFPedalMarking
            pedalMarkingWithNotes:@[ notes0[0], notes0[3], notes0[3], notes1[1], notes1[1], notes1[3] ]];

        pedal.style = VFPedalMarkingMixed;

        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff0];
        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff1];
        [pedal draw:ctx];
    };
}

- (void)customText:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(550, 200)
    // withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        // CGContextRef ctx = context.CGContext;
        // TODO: customize formatting
        // [[self class] background:bounds];
        expect(@"0");
        VFStaff* staff0 = [[VFStaff staffWithRect:CGRectMake(10, 10, 250, 0)] addTrebleGlyph];
        VFStaff* staff1 = [VFStaff staffWithRect:CGRectMake(260, 10, 250, 0)];
        [staff0 draw:ctx];
        [staff1 draw:ctx];

        NSArray* notes0 = [@[
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(-1) }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        NSArray* notes1 = [@[
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice0 setStrict:NO];
        VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice1 setStrict:NO];
        [voice0 addTickables:notes0];
        [voice1 addTickables:notes1];

        [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff0];
        [[[VFFormatter formatter] joinVoices:@[ voice1 ]] formatToStaff:@[ voice1 ] staff:staff1];

        VFPedalMarking* pedal = [VFPedalMarking pedalMarkingWithNotes:@[ notes0[0], notes1[3] ]];

        pedal.style = VFPedalMarkingText;

        [pedal setCustomTextDepress:@"una corda" release:@"tre corda"];

        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff0];
        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff1];
        [pedal draw:ctx];
    };
}

- (void)customTextMixed:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(550, 200)
    // withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        // CGContextRef ctx = context.CGContext;
        // TODO: customize formatting
        // [[self class] background:bounds];
        expect(@"0");
        VFStaff* staff0 = [[VFStaff staffWithRect:CGRectMake(10, 10, 250, 0)] addTrebleGlyph];
        VFStaff* staff1 = [VFStaff staffWithRect:CGRectMake(260, 10, 250, 0)];
        [staff0 draw:ctx];
        [staff1 draw:ctx];

        NSArray* notes0 = [@[
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(1) },
            @{ @"keys" : @[ @"b/4" ],
               @"duration" : @"4",
               @"stem_direction" : @(-1) }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        NSArray* notes1 = [@[
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" },
            @{ @"keys" : @[ @"c/4" ],
               @"duration" : @"4" }
        ] oct_map:^VFStaffNote*(NSDictionary* spec) {
          return newNote(spec);
        }];

        VFVoice* voice0 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice0 setStrict:NO];
        VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice1 setStrict:NO];
        [voice0 addTickables:notes0];
        [voice1 addTickables:notes1];

        [[[VFFormatter formatter] joinVoices:@[ voice0 ]] formatToStaff:@[ voice0 ] staff:staff0];
        [[[VFFormatter formatter] joinVoices:@[ voice1 ]] formatToStaff:@[ voice1 ] staff:staff1];

        VFPedalMarking* pedal = [VFPedalMarking pedalMarkingWithNotes:@[ notes0[0], notes1[3] ]];
        pedal.style = VFPedalMarkingMixed;

        [pedal setCustomText:@"Sost. Ped."];

        [voice0 draw:ctx dirtyRect:CGRectZero toStaff:staff0];
        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff1];
        [pedal draw:ctx];
    };
}

@end
