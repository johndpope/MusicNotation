//
//  StrokesTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "StrokesTests.h"
#import "VexFlowTestHelpers.h"
#import "NSArray+JSAdditions.h"
#import "OCTotallyLazy.h"

@interface NotesTabNotesStruct : IAModelBase
@property (strong, nonatomic) NSArray* notes;
@property (strong, nonatomic) NSArray* tabs;
@end

@implementation NotesTabNotesStruct
@end

@implementation StrokesTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Strokes - Brush/Arpeggiate/Rasquedo"
           
             func:@selector(drawMultipleMeasures:)
        ];

    [self runTest:@"Strokes - Multi Voice"  func:@selector(multi:)];

    [self runTest:@"Strokes - Notation and Tab"  func:@selector(notesWithTab:)];
    [self runTest:@"Strokes - Multi-Voice Notation and Tab"
           
             func:@selector(multiNotationAndTab:)
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

- (void)drawMultipleMeasures:(TestCollectionItemView*)parent
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // bar 1
      VFStaff* staffBar1 = [VFStaff staffWithRect:CGRectMake(10, 50, 250, 0)];
      [staffBar1 setEndBarType:VFBarLineDouble];

      [staffBar1 draw:ctx];

      NSArray* notesBar1 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"a/3", @"e/4", @"a/4" ],
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
              @"duration" : @"q"
          }]
      ];
      [notesBar1[0] addStroke:[VFStroke strokeWithType:VFStrokeBrushDown] atIndex:1];
      [notesBar1[1] addStroke:[VFStroke strokeWithType:VFStrokeBrushUp] atIndex:2];
      [notesBar1[2] addStroke:[VFStroke strokeWithType:VFStrokeBrushDown] atIndex:1];
      [notesBar1[3] addStroke:[VFStroke strokeWithType:VFStrokeBrushUp] atIndex:2];
      [notesBar1[1] addAccidental:[VFAccidental accidentalWithType:@"#"] atIndex:1];
      [notesBar1[1] addAccidental:[VFAccidental accidentalWithType:@"#"] atIndex:2];
      [notesBar1[1] addAccidental:[VFAccidental accidentalWithType:@"#"] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

      // bar 2
      VFStaff* staffBar2 = [VFStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 300, 0)];
      [staffBar2 setEndBarType:VFBarLineDouble];

      [staffBar2 draw:ctx];
      NSArray* notesBar2 = @[
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"d/4", @"g/4" ],
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"d/4", @"g/4" ],
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"d/4", @"g/4" ],
              @"duration" : @"q"
          }],
          [[VFStaffNote alloc] initWithDictionary:@{
              @"keys" : @[ @"c/4", @"d/4", @"a/4" ],
              @"duration" : @"q"
          }]
      ];
      [notesBar2[0] addStroke:[VFStroke strokeWithType:VFStrokeRollDown] atIndex:3];
      [notesBar2[1] addStroke:[VFStroke strokeWithType:VFStrokeRollUp] atIndex:4];
      [notesBar2[2] addStroke:[VFStroke strokeWithType:VFStrokeRasquedoDown] atIndex:5];
      [notesBar2[3] addStroke:[VFStroke strokeWithType:VFStrokeRasquedoUp] atIndex:6];
      [notesBar2[3] addAccidental:[VFAccidental accidentalWithType:@"bb"] atIndex:0];
      [notesBar2[3] addAccidental:[VFAccidental accidentalWithType:@"bb"] atIndex:1];
      [notesBar2[3] addAccidental:[VFAccidental accidentalWithType:@"bb"] atIndex:2];

      // Helper function to justify and draw a 4/4 voice

      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];

      ok(YES, @"Brush/Roll/Rasquedo");
    };
}

- (void)multi:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(50, 10, 300, 0)];
      [staff draw:ctx];

      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"c/4", @"d/4", @"a/4" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"c/4", @"d/4", @"a/4" ],
                 @"duration" : @"q" })
      ];
      // Create the strokes
      VFStroke* stroke1 = [VFStroke strokeWithType:VFStrokeRasquedoDown];
      VFStroke* stroke2 = [VFStroke strokeWithType:VFStrokeRasquedoUp];
      VFStroke* stroke3 = [VFStroke strokeWithType:VFStrokeBrushUp];
      VFStroke* stroke4 = [VFStroke strokeWithType:VFStrokeBrushDown];
      [notes[0] addStroke:stroke1 atIndex:0];
      [notes[1] addStroke:stroke2 atIndex:0];
      [notes[2] addStroke:stroke3 atIndex:0];
      [notes[3] addStroke:stroke4 atIndex:0];

      [notes[1] addAccidental:[VFAccidental accidentalWithType:@"#"] atIndex:0];
      [notes[1] addAccidental:[VFAccidental accidentalWithType:@"#"] atIndex:2];

      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" }),
          newNote(
              @{ @"keys" : @[ @"e/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"8" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];

      //      VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice2 ]] formatWith:@[ voice, voice2 ] withJustifyWidth:275];

      VFBeam* beam2_1 = [VFBeam beamWithNotes:[notes2 slice:[@0:4]]];
      VFBeam* beam2_2 = [VFBeam beamWithNotes:[notes2 slice:[@4:8]]];

      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [beam2_1 draw:ctx];
      [beam2_2 draw:ctx];
      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"Strokes Test Multi Voice");
    };
}

- (void)multiNotationAndTab:(TestCollectionItemView*)parent
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFTabNote* (^newTabNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* note_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 275) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 400, 0)] addTrebleGlyph];
      [staff draw:ctx];
      VFTabStaff* tabStaff = [[VFTabStaff staffWithRect:CGRectMake(10, 125, 400, 0)] addTabGlyph];
      tabStaff.noteStartX = staff.noteStartX;
      [tabStaff draw:ctx];

      // notation upper voice notes
      NSArray* notes = @[
          newNote(
              @{ @"keys" : @[ @"g/4", @"b/4", @"e/5" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/4", @"b/4", @"e/5" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/4", @"b/4", @"e/5" ],
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/4", @"b/4", @"e/5" ],
                 @"duration" : @"q" })
      ];

      // tablature upper voice notes
      NSArray* notes3 = @[
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(3), @"fret" : @(0)},
                  @{@"str" : @(2), @"fret" : @(0)},
                  @{@"str" : @(1), @"fret" : @(1)}
              ],
              @"duration" : @"q"
          }),
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(3), @"fret" : @(0)},
                  @{@"str" : @(2), @"fret" : @(0)},
                  @{@"str" : @(1), @"fret" : @(1)}
              ],
              @"duration" : @"q"
          }),
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(3), @"fret" : @(0)},
                  @{@"str" : @(2), @"fret" : @(0)},
                  @{@"str" : @(1), @"fret" : @(1)}
              ],
              @"duration" : @"q"
          }),
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(3), @"fret" : @(0)},
                  @{@"str" : @(2), @"fret" : @(0)},
                  @{@"str" : @(1), @"fret" : @(1)}
              ],
              @"duration" : @"q"
          })
      ];

      // Create the strokes for notation
      VFStroke* stroke1 = [VFStroke strokeWithType:3 allVoices:NO];
      VFStroke* stroke2 = [VFStroke strokeWithType:VFStrokeRasquedoUp];
      VFStroke* stroke3 = [VFStroke strokeWithType:2 allVoices:NO];
      VFStroke* stroke4 = [VFStroke strokeWithType:VFStrokeBrushDown];
      // add strokes to notation
      [notes[0] addStroke:stroke1 atIndex:0];
      [notes[1] addStroke:stroke2 atIndex:0];
      [notes[2] addStroke:stroke3 atIndex:0];
      [notes[3] addStroke:stroke4 atIndex:0];

      // creae strokes for tab
      VFStroke* stroke5 = [VFStroke strokeWithType:3 allVoices:NO];
      VFStroke* stroke6 = [VFStroke strokeWithType:VFStrokeRasquedoUp];
      VFStroke* stroke7 = [VFStroke strokeWithType:2 allVoices:NO];
      VFStroke* stroke8 = [VFStroke strokeWithType:VFStrokeBrushDown];
      // add strokes to tab
      [notes3[0] addStroke:stroke5 atIndex:0];
      [notes3[1] addStroke:stroke6 atIndex:0];
      [notes3[2] addStroke:stroke7 atIndex:0];
      [notes3[3] addStroke:stroke8 atIndex:0];

      // notation lower voice notes
      NSArray* notes2 = @[
          newNote(
              @{ @"keys" : @[ @"g/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"g/3" ],
                 @"stem_direction" : @(-1),
                 @"duration" : @"q" })
      ];

      // tablature lower voice notes
      NSArray* notes4 = @[
          newTabNote(
              @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(3)} ],
                 @"duration" : @"q" }),
          newTabNote(
              @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(3)} ],
                 @"duration" : @"q" }),
          newTabNote(
              @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(3)} ],
                 @"duration" : @"q" }),
          newTabNote(
              @{ @"positions" : @[ @{@"str" : @(6), @"fret" : @(3)} ],
                 @"duration" : @"q" })
      ];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice2 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice3 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      VFVoice* voice4 = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice addTickables:notes];
      [voice2 addTickables:notes2];
      [voice4 addTickables:notes4];
      [voice3 addTickables:notes];

      //        VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice, voice2, voice3, voice4 ]]
                formatWith:@[ voice, voice2, voice3, voice4 ]
          withJustifyWidth:275];

      [voice2 draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [voice4 draw:ctx dirtyRect:CGRectZero toStaff:tabStaff];
      [voice3 draw:ctx dirtyRect:CGRectZero toStaff:tabStaff];

      ok(YES, @"Strokes Test Notation & Tab Multi Voice");
    };
}

- (void)drawTabStrokes:(TestCollectionItemView*)parent
{
    VFTabNote* (^newTabNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* note_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:note_struct];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();

      VFTabStaff* staffBar1 = [VFTabStaff staffWithRect:CGRectMake(10, 50, 250, 0)];
       // CGContextRef ctx = context.CGContext;

      [staffBar1 setEndBarType:VFBarLineDouble];
      [staffBar1 draw:ctx];

      NSArray* notesBar1 = @[
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(2), @"fret" : @(8)},
                  @{@"str" : @(3), @"fret" : @(9)},
                  @{@"str" : @(4), @"fret" : @(10)}
              ],
              @"duration" : @"q"
          }),
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(3), @"fret" : @(7)},
                  @{@"str" : @(4), @"fret" : @(8)},
                  @{@"str" : @(5), @"fret" : @(9)}
              ],
              @"duration" : @"q"
          }),
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(1), @"fret" : @(5)},
                  @{@"str" : @(2), @"fret" : @(6)},
                  @{@"str" : @(3), @"fret" : @(7)},
                  @{@"str" : @(4), @"fret" : @(7)},
                  @{@"str" : @(5), @"fret" : @(5)},
                  @{@"str" : @(6), @"fret" : @(5)}
              ],
              @"duration" : @"q"
          }),
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(4), @"fret" : @(3)},
                  @{@"str" : @(5), @"fret" : @(4)},
                  @{@"str" : @(6), @"fret" : @(5)}
              ],
              @"duration" : @"q"
          }),
      ];

      VFStroke* stroke1 = [VFStroke strokeWithType:VFStrokeBrushDown];
      VFStroke* stroke2 = [VFStroke strokeWithType:VFStrokeBrushUp];
      VFStroke* stroke3 = [VFStroke strokeWithType:VFStrokeRollDown];
      VFStroke* stroke4 = [VFStroke strokeWithType:VFStrokeRollUp];

      [notesBar1[0] addStroke:stroke1 atIndex:0];
      [notesBar1[1] addStroke:stroke2 atIndex:0];
      [notesBar1[2] addStroke:stroke4 atIndex:0];
      [notesBar1[3] addStroke:stroke3 atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar1 withNotes:notesBar1];

      // bar 2
      VFStaff* staffBar2 = [VFTabStaff staffWithRect:CGRectMake(staffBar1.width + staffBar1.x, staffBar1.y, 300, 0)];
      [staffBar2 setEndBarType:VFBarLineDouble];
      [staffBar2 draw:ctx];
      NSArray* notesBar2 = @[
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(2), @"fret" : @(7)},
                  @{@"str" : @(3), @"fret" : @(8)},
                  @{@"str" : @(4), @"fret" : @(9)}
              ],
              @"duration" : @"h"
          }),
          newTabNote(@{
              @"positions" : @[
                  @{@"str" : @(1), @"fret" : @(5)},
                  @{@"str" : @(2), @"fret" : @(6)},
                  @{@"str" : @(3), @"fret" : @(7)},
                  @{@"str" : @(4), @"fret" : @(7)},
                  @{@"str" : @(5), @"fret" : @(5)},
                  @{@"str" : @(6), @"fret" : @(5)}
              ],
              @"duration" : @"h"
          }),
      ];

      [notesBar2[0] addStroke:[VFStroke strokeWithType:VFStrokeRasquedoUp] atIndex:0];
      [notesBar2[1] addStroke:[VFStroke strokeWithType:VFStrokeRasquedoDown] atIndex:0];

      // Helper function to justify and draw a 4/4 voice
      [VFFormatter formatAndDrawWithContext:ctx dirtyRect:CGRectZero toStaff:staffBar2 withNotes:notesBar2];

      ok(YES, @"Strokes Tab test");
    };
}

+ (NotesTabNotesStruct*)getTabNotes
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFTabNote* (^newTabNote)(NSDictionary*) = ^VFTabNote*(NSDictionary* note_struct)
    {
        return [[VFTabNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };
    VFBend* (^newBend)(NSString*) = ^VFBend*(NSString* text)
    {
        return [[VFBend alloc] initWithText:text];
    };

    NSArray* notes1 = @[
        [[newNote(
            @{ @"keys" : @[ @"g/5", @"d/5", @"b/4" ],
               @"stem_direction" : @(-1),
               @"duration" : @"q" }) addAccidental:newAcc(@"b")
                                           atIndex:0] addAccidental:newAcc(@"b")
                                                            atIndex:0],
        newNote(
            @{ @"keys" : @[ @"c/5", @"d/5" ],
               @"stem_direction" : @(-1),
               @"duration" : @"q" }),
        newNote(
            @{ @"keys" : @[ @"b/3", @"e/4", @"a/4", @"d/5" ],
               @"stem_direction" : @(1),
               @"duration" : @"8" }),
        [newNote(@{
            @"keys" : @[ @"a/3", @"e/4", @"a/4", @"c/5", @"e/5", @"a/5" ],
            @"stem_direction" : @(1),
            @"duration" : @"8"
        }) addAccidental:newAcc(@"#")
                  atIndex:3],
        newNote(
            @{ @"keys" : @[ @"b/3", @"e/4", @"a/4", @"d/5" ],
               @"stem_direction" : @(1),
               @"duration" : @"8" }),
        [[newNote(@{
            @"keys" : @[ @"a/3", @"e/4", @"a/4", @"c/5", @"f/5", @"a/5" ],
            @"stem_direction" : @(1),
            @"duration" : @"8"
        }) addAccidental:newAcc(@"#")
                  atIndex:3] addAccidental:newAcc(@"#")
                                   atIndex:4],
    ];

    NSArray* tabs1 = @[
        [newTabNote(@{
            @"positions" : @[
                @{@"str" : @(1), @"fret" : @(3)},
                @{@"str" : @(2), @"fret" : @(2)},
                @{@"str" : @(3), @"fret" : @(3)}
            ],
            @"duration" : @"q"
        }) addModifier:newBend(@"Full")
                atIndex:0],
        [newTabNote(@{
            @"positions" : @[ @{@"str" : @(2), @"fret" : @(3)}, @{@"str" : @(3), @"fret" : @(5)} ],
            @"duration" : @"q"
        }) addModifier:newBend(@"Unison")
                atIndex:1],
        newTabNote(@{
            @"positions" : @[
                @{@"str" : @(3), @"fret" : @(7)},
                @{@"str" : @(4), @"fret" : @(7)},
                @{@"str" : @(5), @"fret" : @(7)},
                @{@"str" : @(6), @"fret" : @(7)},
            ],
            @"duration" : @"8"
        }),
        newTabNote(@{
            @"positions" : @[
                @{@"str" : @(1), @"fret" : @(5)},
                @{@"str" : @(2), @"fret" : @(5)},
                @{@"str" : @(3), @"fret" : @(6)},
                @{@"str" : @(4), @"fret" : @(7)},
                @{@"str" : @(5), @"fret" : @(7)},
                @{@"str" : @(6), @"fret" : @(5)}
            ],
            @"duration" : @"8"
        }),
        newTabNote(@{
            @"positions" : @[
                @{@"str" : @(3), @"fret" : @(7)},
                @{@"str" : @(4), @"fret" : @(7)},
                @{@"str" : @(5), @"fret" : @(7)},
                @{@"str" : @(6), @"fret" : @(7)},
            ],
            @"duration" : @"8"
        }),
        newTabNote(@{
            @"positions" : @[
                @{@"str" : @(1), @"fret" : @(5)},
                @{@"str" : @(2), @"fret" : @(5)},
                @{@"str" : @(3), @"fret" : @(6)},
                @{@"str" : @(4), @"fret" : @(7)},
                @{@"str" : @(5), @"fret" : @(7)},
                @{@"str" : @(6), @"fret" : @(5)}
            ],
            @"duration" : @"8"
        })
    ];

    VFStroke* noteStr1 = [VFStroke strokeWithType:VFStrokeBrushDown];
    VFStroke* noteStr2 = [VFStroke strokeWithType:VFStrokeBrushUp];
    VFStroke* noteStr3 = [VFStroke strokeWithType:VFStrokeRollDown];
    VFStroke* noteStr4 = [VFStroke strokeWithType:VFStrokeRollUp];
    VFStroke* noteStr5 = [VFStroke strokeWithType:VFStrokeRasquedoDown];
    VFStroke* noteStr6 = [VFStroke strokeWithType:VFStrokeRasquedoUp];

    [notes1[0] addStroke:noteStr1 atIndex:0];
    [notes1[1] addStroke:noteStr2 atIndex:1];
    [notes1[2] addStroke:noteStr3 atIndex:2];
    [notes1[3] addStroke:noteStr4 atIndex:3];
    [notes1[4] addStroke:noteStr5 atIndex:4];
    [notes1[5] addStroke:noteStr6 atIndex:5];

    VFStroke* tabStr1 = [VFStroke strokeWithType:VFStrokeBrushDown];
    VFStroke* tabStr2 = [VFStroke strokeWithType:VFStrokeBrushUp];
    VFStroke* tabStr3 = [VFStroke strokeWithType:VFStrokeRollDown];
    VFStroke* tabStr4 = [VFStroke strokeWithType:VFStrokeRollUp];
    VFStroke* tabStr5 = [VFStroke strokeWithType:VFStrokeRasquedoDown];
    VFStroke* tabStr6 = [VFStroke strokeWithType:VFStrokeRasquedoUp];

    [tabs1[0] addStroke:tabStr1 atIndex:0];
    [tabs1[1] addStroke:tabStr2 atIndex:0];
    [tabs1[2] addStroke:tabStr3 atIndex:0];
    [tabs1[3] addStroke:tabStr4 atIndex:0];
    [tabs1[4] addStroke:tabStr5 atIndex:0];
    [tabs1[5] addStroke:tabStr6 atIndex:0];

    NotesTabNotesStruct* ret = [[NotesTabNotesStruct alloc] init];
    ret.notes = notes1;
    ret.tabs = tabs1;
    return ret;
}

- (void)renderNotesWithTab:(NotesTabNotesStruct*)notes
                   context:(CGContextRef)ctx
                 dirtyRect:(CGRect)dirtyRect
                     staff:(NotesTabNotesStruct*)staffs
                   justify:(NSUInteger)justify
{
    /*
    Vex.Flow.Test.Strokes.renderNotesWithTab =
    function(notes, ctx, staffs, justify) {
        VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
        VFVoice* tabVoice = [VFVoice voiceWithTimeSignature:VFTime4_4];

        [voice addTickables:notes.notes];
        // Takes a voice and returns it's auto beamsj
        NSArray* beams = Vex.Flow.Beam.applyAndGetBeams(voice);

        tabVoice addTickables:notes.tabs);

        [VFFormatter formatter]
        joinVoices([voice]).joinVoices([tabVoice]).
        format([voice, tabVoice], justify);

        voice.draw(ctx, staffs.notes);
        beams.forEach(function(beam){
            beam draw:ctx];
        });
        tabVoice.draw(ctx, staffs.tabs);
    }
     */
    VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
    VFVoice* tabVoice = [VFVoice voiceWithTimeSignature:VFTime4_4];

    [voice addTickables:notes.notes];
    // Takes a voice and returns it's auto beamsj
    NSArray* beams = [VFBeam applyAndGetBeams:voice];   // Vex.Flow.Beam.applyAndGetBeams(voice);

    [tabVoice addTickables:notes.tabs];

    [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice, tabVoice ] withJustifyWidth:justify];

    // TODO: fix these warnings, they are logic errors
    [voice draw:ctx dirtyRect:CGRectZero toStaff:staffs.notes];
    [beams foreach:^(VFBeam* beam, NSUInteger index, BOOL* stop) {
      [beam draw:ctx];
    }];
    [tabVoice draw:ctx dirtyRect:CGRectZero toStaff:staffs.tabs];
}

- (void)notesWithTab:(TestCollectionItemView*)parent
{
    /*


        Vex.Flow.Test.Strokes.renderNotesWithTab(notes, ctx,
                                                 { notes: staff, tabs: tabstaff });
        ok(YES);

        VFStaff *staff2 = [VFStaff staffWithRect:CGRectMake(10, 250, 400).addTrebleGlyph().
        setContext(ctx).draw();
        var tabstaff2 = new Vex.Flow.TabStaff(10, 350, 400).addTabGlyph().
        setNoteStartX(staff2.getNoteStartX()) draw:ctx];
        var connector = [VFStaffConnector staffConnectorWithTopStaff:(staff2, tabstaff2);
        var line = [VFStaffConnector staffConnectorWithTopStaff:(staff2, tabstaff2);
        connector.setType(Vex.Flow.StaffConnector.type.BRACKET);
        connector.setContext(ctx);
        line.setType(VFStaffConnectorSingle);
        connector.setContext(ctx);
        line.setContext(ctx);
        connector.draw();
        line.draw();

        Vex.Flow.Test.Strokes.renderNotesWithTab(notes, ctx,
                                                 { notes: staff2, tabs: tabstaff2 )}, 385);
        ok(YES);
    }
    */

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(420, 450) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // Get test voices.
      NotesTabNotesStruct* notes = [[self class] getTabNotes];
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 400, 0)] addTrebleGlyph];
      [staff draw:ctx];

      VFTabStaff* tabstaff = [[VFTabStaff staffWithRect:CGRectMake(10, 100, 400, 0)] addTabGlyph];
      [tabstaff setNoteStartX:staff.noteStartX];
      [tabstaff draw:ctx];
      VFStaffConnector* connector = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:tabstaff];
      VFStaffConnector* line = [VFStaffConnector staffConnectorWithTopStaff:staff andBottomStaff:tabstaff];
      connector.type = VFStaffConnectorBracket;
      line.type = VFStaffConnectorSingleLeft;
      [connector draw:ctx];
      [line draw:ctx];

      //        Vex.Flow.Test.Strokes.renderNotesWithTab(notes, ctx,
      //                                                 { notes: staff, tabs: tabstaff });

      NotesTabNotesStruct* tmp = [[NotesTabNotesStruct alloc] init];
      tmp.notes = staff;
      tmp.tabs = tabstaff;
      [[self class] renderNotesWithTab:notes context:ctx dirtyRect:CGRectZero staff:tmp justify:0];

      //      ok(@"YES");

    };
}

@end
