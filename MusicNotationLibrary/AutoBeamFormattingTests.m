//
//  AutoBeamFormattingTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "AutoBeamFormattingTests.h"
#import "VexFlowTestHelpers.h"
#import "NSArray+JSAdditions.h"
//#import <AppKit/AppKit.h>
//#import <ReactiveCocoa/ReactiveCocoa.h>

@interface AutoBeamFormattingTests ()
//@property (strong, nonatomic) NSMutableArray* formatterArray;   // VFFormatter* formatter;
//@property (strong, nonatomic) NSMutableArray* voiceArray;       // VFVoice* voice;
//@property (strong, nonatomic) NSMutableArray* staffArray;       // VFStaff* staff;
//@property (strong, nonatomic) NSMutableArray* beamsArray;       // NSArray* beams;
//@property (strong, atomic) NSMutableArray* testViewArray;       // VFTestView* testView;
//@property (strong, nonatomic) NSMutableArray* stuffArray;
@end

@implementation AutoBeamFormattingTests

- (void)start   //:(VFTestView*)parent;
{
    //}

    //- (void)start:(VFTestView*)parent;
    //{
    //    [super start:parent];
    //    id targetClass = [self class];

    //    _formatterArray = [NSMutableArray array];
    //    _voiceArray = [NSMutableArray array];
    //    _staffArray = [NSMutableArray array];
    //    _beamsArray = [NSMutableArray array];
    //    _testViewArray = [NSMutableArray array];
    //    _stuffArray = [NSMutableArray array];

    // id targetClass = [self class];

    [self runTest:@"Simple Auto Beaming" func:@selector(simpleAuto:withTitle:)];

    //    [self runTest:@"Even Group Stem Directions"
    //
    //             func:@selector(evenGroupStemDirections:withTitle:)
    //        ];
    //    [self runTest:@"Odd Group Stem Directions"
    //
    //             func:@selector(oddGroupStemDirections:withTitle:)
    //        ];
    //    [self runTest:@"Odd Beam Groups Auto Beaming"
    //
    //             func:@selector(oddBeamGroups:withTitle:)
    //        ];
    //    [self runTest:@"More Simple Auto Beaming 0"
    //
    //             func:@selector(moreSimple0:withTitle:)
    //        ];
    //    [self runTest:@"More Simple Auto Beaming 1"
    //
    //             func:@selector(moreSimple1:withTitle:)
    //        ];
    //    [self runTest:@"Beam Across All Rests"
    //
    //             func:@selector(beamAcrossAllRests:withTitle:)
    //        ];
    //    [self runTest:@"Beam Across All Rests with Stemlets"
    //
    //             func:@selector(beamAcrossAllRestsWithStemlets:withTitle:)
    //        ];
    //    [self runTest:@"Break Beams on Middle Rests Only"
    //
    //             func:@selector(beamAcrossMiddleRests:withTitle:)
    //        ];
    //    [self runTest:@"Break Beams on Rest"
    //
    //             func:@selector(breakBeamsOnRests:withTitle:)
    //        ];
    //    [self runTest:@"Maintain Stem Directions"
    //
    //             func:@selector(maintainStemDirections:withTitle:)
    //        ];
    //    [self runTest:@"Maintain Stem Directions - Beam Over Rests"
    //
    //             func:@selector(maintainStemDirectionsBeamAcrossRests:withTitle:)
    //        ];
    //    [self runTest:@"Beat group with unbeamable note - 2/2"
    //
    //             func:@selector(groupWithUnbeamableNote:withTitle:)
    //        ];
    //    [self runTest:@"Offset beat grouping - 6/8 "
    //
    //             func:@selector(groupWithUnbeamableNote1:withTitle:)
    //        ];
    //    [self runTest:@"Odd Time - Guessing Default Beam Groups"
    //
    //             func:@selector(autoOddBeamGroups:withTitle:)
    //        ];
    //    [self runTest:@"Custom Beam Groups"  func:@selector(customBeamGroups:withTitle:)
    //   ];
    //    [self runTest:@"Simple Tuplet Auto Beaming"
    //
    //             func:@selector(simpleTuplets:withTitle:)
    //        ];
    //    [self runTest:@"More Simple Tuplet Auto Beaming"
    //
    //             func:@selector(moreSimpleTuplets:withTitle:)
    //        ];
    //    [self runTest:@"More Automatic Beaming"  func:@selector(moreBeaming:withTitle:)
    //   ];
}

- (ViewStaffStruct*)setupContextWithSize:(VFUIntSize*)size
                              withParent:(TestCollectionItemView*)parent
                               withTitle:(NSString*)title
{
    /*
     Vex.Flow.Test.AutoBeamFormatting.setupContext = function(options, x, y) {
     var ctx = new options.contextBuilder(options.canvas_sel, x || 450, y || 140);
     ctx.scale(0.9, 0.9); ctx.fillStyle = "#221"; ctx.strokeStyle = "#221";
     ctx.font = " 10pt Arial";
     VFStaff *staff = [[VFStaff staffWithRect:CGRectMake(10, 40, x || 450).addTrebleGlyph().
     setContext(ctx) draw:ctx];

     return {context: ctx, staff: staff};
     }
     */

    NSUInteger w = size.width;
    NSUInteger h = size.height;

    w = w != 0 ? w : 450;
    h = h != 0 ? h : 140;

    [VFFont setFont:@" 10pt Arial"];

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w + 100, h +
    // 50) withParent:parent withTitle:title];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 40, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

//+ (VFStaffNote*)newNote:(NSDictionary*)note_struct
//{
//    /*
//    function newNote(note_struct) { return [[VFStaff staffWithRect:CGRectMakeNote(note_struct); }
//     */
//    return [[VFStaffNote alloc] initWithDictionary:note_struct];
//}

- (void)simpleAuto:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    ViewStaffStruct* c;
    c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;
    VFStaff* staff = c.staff;
    __block VFVoice* voice;
    __block VFFormatter* formatter;
    __block NSArray* beams;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
      {
          return [[VFStaffNote alloc] initWithDictionary:note_struct];
      };

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"c/5" ],
                 @"duration" : @"16" }),
          newNote(
              @{ @"keys" : @[ @"d/5" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/5" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"duration" : @"32" }),
          newNote(
              @{ @"keys" : @[ @"f/5" ],
                 @"duration" : @"32" })
      ];

      voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];

      // Takes a voice and returns it's auto beamsj
      beams = [VFBeam applyAndGetBeams:voice];

      formatter = [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

      //      [test setNeedsDisplay:YES];
    });

    id weakSelf = self;   //@weakify(staff);
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        id self = weakSelf;   //@strongify(staff);
        //      // test.backgroundColor = [VFColor randomBGColor:YES];
        // CGContextRef ctx = context.CGContext;
        [staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beaming Applicator Test");
    };
}

- (void)evenGroupStemDirections:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"f/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/5" ],
                   @"duration" : @"8" })
        ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice setStrict:NO];
        [voice addTickables:notes];

        // Takes a voice and returns it's auto beamsj
        NSArray* beams = [VFBeam applyAndGetBeams:voice];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        assertThatInteger([beams[0] stemDirection], equalToInteger(VFStemDirectionUp));
        assertThatInteger([beams[1] stemDirection], equalToInteger(VFStemDirectionUp));
        assertThatInteger([beams[2] stemDirection], equalToInteger(VFStemDirectionUp));
        assertThatInteger([beams[3] stemDirection], equalToInteger(VFStemDirectionUp));
        assertThatInteger([beams[4] stemDirection], equalToInteger(VFStemDirectionDown));
        assertThatInteger([beams[5] stemDirection], equalToInteger(VFStemDirectionDown));

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beaming Applicator Test");
    };
}

- (void)oddGroupStemDirections:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"f/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"e/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"8" })
        ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice setStrict:NO];
        [voice addTickables:notes];

        NSArray* groups = @[ Rational(3, 8) ];

        // Takes a voice and returns it's auto beamsj
        NSArray* beams = [VFBeam applyAndGetBeams:voice groups:groups];

        assertThatInteger([beams[0] stemDirection], describedAs(@"Notes are equa-distant from middle line",
                                                                equalToInteger(VFStemDirectionDown), nil));
        assertThatInteger([beams[1] stemDirection], equalToInteger(VFStemDirectionDown));
        assertThatInteger([beams[2] stemDirection], equalToInteger(VFStemDirectionUp));
        assertThatInteger([beams[3] stemDirection], describedAs(@"Notes are equadistant from middle line",
                                                                equalToInteger(VFStemDirectionDown), nil));

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beaming Applicator Test");
    };
}

- (void)oddBeamGroups:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"f/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"e/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"f/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"f/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"f/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"f/3" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"f/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"f/5" ],
                   @"duration" : @"16" })
        ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* groups = @[ Rational(2, 8), Rational(3, 8), Rational(1, 8) ];

        // Takes a voice and returns it's auto beamsj
        NSArray* beams = [VFBeam applyAndGetBeams:voice groups:groups];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)moreSimple0:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"8" })
        ];
        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams = [VFBeam applyAndGetBeams:voice];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)moreSimple1:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"c/4", @"e/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"16" })
        ];
        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams = [VFBeam applyAndGetBeams:voice];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)breakBeamsOnRests:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"g/4", @"e/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32r" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"16" })
        ];
        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams = [VFBeam generateBeams:notes withDictionary:@{ @"beam_rests" : @(NO) }];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)beamAcrossAllRestsWithStemlets:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"g/4", @"e/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32r" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"16" })
        ];
        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams =
            [VFBeam generateBeams:notes withDictionary:@{
                @"beam_rests" : @(YES),
                @"show_stemlets" : @(YES)
            }];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)beamAcrossAllRests:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"g/4", @"e/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32r" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"16" })
        ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams = [VFBeam generateBeams:notes withDictionary:@{ @"beam_rests" : @(YES) }];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)beamAcrossMiddleRests:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"g/4", @"e/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32r" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"a/4" ],
                   @"duration" : @"16" })
        ];
        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams =
            [VFBeam generateBeams:notes withDictionary:@{
                @"beam_rests" : @(YES),
                @"beam_middle_only" : @(YES)
            }];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

//+ (void)breakBeamsOnRests2:(NSView *)parent; {
///*
// Vex.Flow.Test.AutoBeamFormatting.breakBeamsOnRests = function(options, contextBuilder) {
//    options.contextBuilder = contextBuilder;
//    var c = Vex.Flow.Test.AutoBeamFormatting.setupContext(options);
//
//    NSArray *notes = @[
//                 newNote(@{ @"keys" : @[@"c/5"], @"duration" : @"16"}),
//                 newNote(@{ @"keys" : @[@"g/5"], @"duration" : @"16"}),
//                 newNote(@{ @"keys" : @[@"c/5"], @"duration" : @"16"}),
//                 newNote(@{ @"keys" : @[@"b/4"], @"duration" : @"16r"}),
//                 newNote(@{ @"keys" : @[@"b/4"], @"duration" : @"16r"}),
//                 newNote(@{ @"keys" : @[@"c/4", @"e/4", @"g/4"], @"duration" : @"16"}),
//                 newNote(@{ @"keys" : @[@"d/4"], @"duration" : @"16"}),
//                 newNote(@{ @"keys" : @[@"a/5"], @"duration" : @"16"}),
//                 newNote(@{ @"keys" : @[@"c/4"], @"duration" : @"16"}),
//                 newNote(@{ @"keys" : @[@"g/4"], @"duration" : @"16"}),
//                 newNote(@{ @"keys" : @[@"b/4"], @"duration" : @"16"}),
//                 newNote(@{ @"keys" : @[@"b/4"], @"duration" : @"16r"}),
//                 newNote(@{ @"keys" : @[@"g/4", @"e/4"], @"duration" : @"32"}),
//                 newNote(@{ @"keys" : @[@"b/4"], @"duration" : @"32r"}),
//                 newNote(@{ @"keys" : @[@"b/4"], @"duration" : @"32r"}),
//                 newNote(@{ @"keys" : @[@"a/4"], @"duration" : @"32"}),
//                 newNote(@{ @"keys" : @[@"a/4"], @"duration" : @"16r"}),
//                 newNote(@{ @"keys" : @[@"a/4"], @"duration" : @"16"})
//                 ];
//
//    VFVoice *voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
//    voice.mode = VFModeSoft;
//    [voice addTickables:notes];
//
//    NSArray* beams = Vex.Flow.Beam.generateBeams(notes, {
//    beam_rests: NO
//    });
//
//    VFFormatter *formatter = [VFFormatter formatter] joinVoices:@[voice]
//    formatTostaff([voice], c.staff);
//
//[c.staff draw:ctx];
//    [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];
//
//    beams.forEach(function(beam){
//        beam.setContext(c.context) draw:ctx];
//    });
//    ok(YES, @"Auto Beam Applicator Test");
//}
// */
//}

// Vex.Flow.Test.AutoBeamFormatting.breakBeamsOnRests = function(options, contextBuilder) {
//+ (void)breakBeamsOnRests2:(NSView *)parent; {
//
//}

- (void)maintainStemDirections:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(450, 200) withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" })
        ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams = [VFBeam generateBeams:notes
                                withDictionary:@{
                                    @"beam_rests" : @(NO),
                                    @"maintain_stem_directions" : @(YES)
                                }];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)maintainStemDirectionsBeamAcrossRests:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(450, 200) withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32",
                   @"stem_direction" : @(-1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"32" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16r" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" })
        ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams = [VFBeam generateBeams:notes
                                withDictionary:@{
                                    @"beam_rests" : @(YES),
                                    @"maintain_stem_directions" : @(YES)
                                }];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)groupWithUnbeamableNote:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(450, 200) withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;

        [c.staff addTimeSignatureWithName:@"2/2"];

        [c.staff draw:ctx];

        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"4",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16",
                   @"stem_direction" : @(1) }),
        ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams = [VFBeam generateBeams:notes
                                withDictionary:@{
                                    @"groups" : @[ Rational(2, 2) ],
                                    @"beam_rests" : @(NO),
                                    @"maintain_stem_directions" : @(YES)
                                }];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)groupWithUnbeamableNote1:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(450, 200) withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;

        [c.staff addTimeSignatureWithName:@"6/8"];

        [c.staff draw:ctx];

        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"4",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"4",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8",
                   @"stem_direction" : @(1) }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8",
                   @"stem_direction" : @(1) })
        ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice.mode = VFModeSoft;
        [voice addTickables:notes];

        NSArray* beams = [VFBeam generateBeams:notes
                                withDictionary:@{
                                    @"groups" : @[ Rational(3, 8) ],
                                    @"beam_rests" : @(NO),
                                    @"maintain_stem_directions" : @(YES)
                                }];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)autoOddBeamGroups:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    //    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(450, 400) withParent:parent
    //    withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;

        VFStaff* staff1 = [[VFStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addTrebleGlyph];
        [staff1 addTimeSignatureWithName:@"5/4"];

        VFStaff* staff2 = [[VFStaff staffWithRect:CGRectMake(10, 150, 450, 0)] addTrebleGlyph];
        [staff2 addTimeSignatureWithName:@"5/8"];

        VFStaff* staff3 = [[VFStaff staffWithRect:CGRectMake(10, 290, 450, 0)] addTrebleGlyph];
        [staff3 addTimeSignatureWithName:@"13/16"];

        NSArray* notes1 = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"8" })
        ];

        NSArray* notes2 = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" })
        ];

        NSArray* notes3 = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" })
        ];

        VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice1.mode = VFModeSoft;
        [voice1 addTickables:notes1];

        VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice2.mode = VFModeSoft;
        [voice2 addTickables:notes2];

        VFVoice* voice3 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice3.mode = VFModeSoft;
        [voice3 addTickables:notes3];

        [staff1 draw:ctx];
        [staff2 draw:ctx];
        [staff3 draw:ctx];

        //      NSArray* groups1316 = @[ Rational(3, 16), Rational(2, 16) ];

        NSArray* beams =
            [VFBeam applyAndGetBeams:voice1 groups:[VFBeam getDefaultBeamGroupsForTimeSignatureType:VFTime5_4]];
        NSArray* beams2 =
            [VFBeam applyAndGetBeams:voice2 groups:[VFBeam getDefaultBeamGroupsForTimeSignatureType:VFTime5_8]];
        NSArray* beams3 =
            [VFBeam applyAndGetBeams:voice3 groups:[VFBeam getDefaultBeamGroupsForTimeSignatureType:VFTime13_16]];

        VFFormatter* formatter1 = [VFFormatter formatter];
        [formatter1 formatToStaff:@[ voice1 ] staff:staff1];
        [formatter1 formatToStaff:@[ voice2 ] staff:staff2];
        [formatter1 formatToStaff:@[ voice3 ] staff:staff3];

        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff1];
        [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff2];
        [voice3 draw:ctx dirtyRect:CGRectZero toStaff:staff3];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];
        [beams2 foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];
        [beams3 foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)customBeamGroups:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    //    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeMake(450, 400) withParent:parent
    //    withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        VFStaff* staff1 = [[VFStaff staffWithRect:CGRectMake(10, 10, 450, 0)] addTrebleGlyph];
        [staff1 addTimeSignatureWithName:@"5/4"];

        VFStaff* staff2 = [[VFStaff staffWithRect:CGRectMake(10, 150, 450, 0)] addTrebleGlyph];
        [staff2 addTimeSignatureWithName:@"5/8"];

        VFStaff* staff3 = [[VFStaff staffWithRect:CGRectMake(10, 290, 450, 0)] addTrebleGlyph];
        [staff3 addTimeSignatureWithName:@"13/16"];

        NSArray* notes1 = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"8" })
        ];

        NSArray* notes2 = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"8" })
        ];

        NSArray* notes3 = @[
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"b/4" ],
                   @"duration" : @"16" })
        ];

        VFVoice* voice1 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice1.mode = VFModeSoft;
        [voice1 addTickables:notes1];

        VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice2.mode = VFModeSoft;
        [voice2 addTickables:notes2];

        VFVoice* voice3 = [VFVoice voiceWithTimeSignature:VFTime4_4];
        voice3.mode = VFModeSoft;
        [voice3 addTickables:notes3];

        [staff1 draw:ctx];
        [staff2 draw:ctx];
        [staff3 draw:ctx];

        NSArray* group1 = @[ Rational(5, 8) ];

        NSArray* group2 = @[ Rational(3, 8), Rational(2, 8) ];

        NSArray* group3 = @[ Rational(7, 16), Rational(2, 16), Rational(4, 16) ];

        NSArray* beams = [VFBeam applyAndGetBeams:voice1 groups:group1];
        NSArray* beams2 = [VFBeam applyAndGetBeams:voice2 groups:group2];
        NSArray* beams3 = [VFBeam applyAndGetBeams:voice3 groups:group3];

        VFFormatter* formatter1 = [VFFormatter formatter];
        [formatter1 formatToStaff:@[ voice1 ] staff:staff1];
        [formatter1 formatToStaff:@[ voice2 ] staff:staff2];
        [formatter1 formatToStaff:@[ voice3 ] staff:staff3];

        [voice1 draw:ctx dirtyRect:CGRectZero toStaff:staff1];
        [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff2];
        [voice3 draw:ctx dirtyRect:CGRectZero toStaff:staff3];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];
        [beams2 foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];
        [beams3 foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)simpleTuplets:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"c/5", @"e/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"d/5" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"8" })
        ];

        VFTuplet* triplet1 = [[VFTuplet alloc] initWithNotes:[notes slice:[@0:3]]];
        VFTuplet* quintuplet = [[VFTuplet alloc] initWithNotes:[notes slice:[@5:notes.count]]];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice setStrict:NO];
        [voice addTickables:notes];

        NSArray* beams = [VFBeam applyAndGetBeams:voice];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [c.staff draw:ctx];
        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        [triplet1 draw:ctx];
        [quintuplet draw:ctx];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)moreSimpleTuplets:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"d/4" ],
                   @"duration" : @"4" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"4" }),
            newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"4" }),
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5", @"e/5" ],
                   @"duration" : @"16" })
        ];

        VFTuplet* triplet1 = [[VFTuplet alloc] initWithNotes:[notes slice:[@0:3]]];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice setStrict:NO];
        [voice addTickables:notes];

        NSArray* beams = [VFBeam applyAndGetBeams:voice];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        [triplet1 draw:ctx];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

- (void)moreBeaming:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    ViewStaffStruct* c = [[self class] setupContextWithSize:VFUIntSizeZero() withParent:parent withTitle:title];
    //    TestCollectionItemView* test = c.view;

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
        //      [VFTestView background:bounds];
        // CGContextRef ctx = context.CGContext;
        NSArray* notes = @[
            newNote(
                @{ @"keys" : @[ @"c/4" ],
                   @"duration" : @"8" }),
            newNote(
                @{ @"keys" : @[ @"g/4" ],
                   @"duration" : @"4" }),
            [newNote(
                @{ @"keys" : @[ @"c/5" ],
                   @"duration" : @"8" }) addDotToAll],
            newNote(
                @{ @"keys" : @[ @"g/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"4" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"c/5", @"e/5" ],
                   @"duration" : @"16" }),
            newNote(
                @{ @"keys" : @[ @"a/5" ],
                   @"duration" : @"8" })
        ];

        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        [voice setStrict:NO];
        [voice addTickables:notes];

        NSArray* beams = [VFBeam applyAndGetBeams:voice];

        //      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:c.staff];

        [voice draw:ctx dirtyRect:CGRectZero toStaff:c.staff];

        [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
          [beam draw:ctx];
        }];

        ok(YES, @"Auto Beam Applicator Test");
    };
}

@end
