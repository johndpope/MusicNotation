//
//  StaffLineTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "StaffLineTests.h"
#import "VexFlowTestHelpers.h"

@implementation StaffLineTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple StaffLine"  func:@selector(simple0:withTitle:)];
    [self runTest:@"StaffLine Arrow Options"  func:@selector(simple1:withTitle:)];
}




- (void)simple0:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    //    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    //    {
    //        return [VFAccidental accidentalWithType:type];
    //    };
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(650, 140) withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 550, 0)] addTrebleGlyph];

      [staff draw:ctx];

      NSArray* notes = [@[
          @{ @"keys" : @[ @"c/4" ],
             @"duration" : @"4",
             @"clefName" : @"treble" },
          @{ @"keys" : @[ @"c/5" ],
             @"duration" : @"4",
             @"clefName" : @"treble" },
          @{ @"keys" : @[ @"c/4", @"g/4", @"b/4" ],
             @"duration" : @"4",
             @"clefName" : @"treble" },
          @{ @"keys" : @[ @"f/4", @"a/4", @"f/5" ],
             @"duration" : @"4",
             @"clefName" : @"treble" }
      ] oct_map:^VFStaffNote*(NSDictionary* d) {
        return newNote(d);
      }];

      VFStaffLine* staffLine = [[VFStaffLine alloc] initWithNotes:[[StaffLineNotesStruct alloc] initWithDictionary:@{
                                                        @"first_note" : notes[0],
                                                        @"last_note" : notes[1],
                                                        @"first_indices" : @[ @(0) ],
                                                        @"last_indices" : @[ @(0) ]
                                                    }]];

      VFStaffLine* staffLine2 = [[VFStaffLine alloc] initWithNotes:[[StaffLineNotesStruct alloc] initWithDictionary:@{
                                                         @"first_note" : notes[2],
                                                         @"last_note" : notes[3],
                                                         @"first_indices" : @[ @(2), @(1), @(0) ],
                                                         @"last_indices" : @[ @(0), @(1), @(2) ]
                                                     }]];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:NO];
      [voice addTickables:notes];

      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];
      [staffLine setText:@"gliss."];

      [staffLine2 setText:@"gliss."];

      // TODO: fix this
      //        [staffLine setFont:@{
      //        @"family" : @"serif",
      //        @"size" : @12,
      //        @"weight" : @"italic"
      //        }];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];
      [staffLine draw:ctx];
      [staffLine2 draw:ctx];

      ok(YES, @"YES");
    };
}

- (void)simple1:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(770, 140) withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 750, 0)] addTrebleGlyph];

      [staff draw:ctx];

      NSArray* notes = [@[
          @{ @"keys" : @[ @"c#/5", @"d/5" ],
             @"duration" : @"4",
             @"clefName" : @"treble",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"c/4" ],
             @"duration" : @"4",
             @"clefName" : @"treble" },
          @{ @"keys" : @[ @"c/4", @"e/4", @"g/4" ],
             @"duration" : @"4",
             @"clefName" : @"treble" },
          @{ @"keys" : @[ @"f/4", @"a/4", @"c/5" ],
             @"duration" : @"4",
             @"clefName" : @"treble" },
          @{
              @"keys" : @[
                  @"c/4",
              ],
              @"duration" : @"4",
              @"clefName" : @"treble"
          },
          @{ @"keys" : @[ @"c#/5", @"d/5" ],
             @"duration" : @"4",
             @"clefName" : @"treble",
             @"stem_direction" : @(-1) },
          @{ @"keys" : @[ @"c/4", @"d/4", @"g/4" ],
             @"duration" : @"4",
             @"clefName" : @"treble" },
          @{ @"keys" : @[ @"f/4", @"a/4", @"c/5" ],
             @"duration" : @"4",
             @"clefName" : @"treble" }
      ] oct_map:^VFStaffNote*(NSDictionary* d) {
        return newNote(d);
      }];

      [notes[0] addDotToAll];
      [notes[1] addAccidental:newAcc(@"#") atIndex:0];   //.addAccidental(0, new Vex.Flow.Accidental(@"#"));
      [notes[3] addAccidental:newAcc(@"#") atIndex:2];   //.addAccidental(2, new Vex.Flow.Accidental(@"#"));
      [notes[4] addAccidental:newAcc(@"#") atIndex:0];   //.addAccidental(0, new Vex.Flow.Accidental(@"#"));
      [notes[7] addAccidental:newAcc(@"#") atIndex:2];   //.addAccidental(2, new Vex.Flow.Accidental(@"#"));

      VFStaffLine* staffLine0 = [[VFStaffLine alloc] initWithNotes:[[StaffLineNotesStruct alloc] initWithDictionary:@{
                                                         @"first_note" : notes[0],
                                                         @"last_note" : notes[1],
                                                         @"first_indices" : @[ @(0) ],
                                                         @"last_indices" : @[ @(0) ]
                                                     }]];

      VFStaffLine* staffLine4 = [[VFStaffLine alloc] initWithNotes:[[StaffLineNotesStruct alloc] initWithDictionary:@{
                                                         @"first_note" : notes[2],
                                                         @"last_note" : notes[3],
                                                         @"first_indices" : @[ @(1) ],
                                                         @"last_indices" : @[ @(1) ]
                                                     }]];

      VFStaffLine* staffLine1 = [[VFStaffLine alloc] initWithNotes:[[StaffLineNotesStruct alloc] initWithDictionary:@{
                                                         @"first_note" : notes[4],
                                                         @"last_note" : notes[5],
                                                         @"first_indices" : @[ @(0) ],
                                                         @"last_indices" : @[ @(0) ]
                                                     }]];

      VFStaffLine* staffLine2 = [[VFStaffLine alloc] initWithNotes:[[StaffLineNotesStruct alloc] initWithDictionary:@{
                                                         @"first_note" : notes[6],
                                                         @"last_note" : notes[7],
                                                         @"first_indices" : @[ @(1) ],
                                                         @"last_indices" : @[ @(0) ]
                                                     }]];

      VFStaffLine* staffLine3 = [[VFStaffLine alloc] initWithNotes:[[StaffLineNotesStruct alloc] initWithDictionary:@{
                                                         @"first_note" : notes[6],
                                                         @"last_note" : notes[7],
                                                         @"first_indices" : @[ @(2) ],
                                                         @"last_indices" : @[ @(2) ]
                                                     }]];

      StaffLineRenderOptions* render_options = [staffLine0 renderOptions];
      render_options.draw_end_arrow = YES;
      [staffLine0 setText:@"Left"];
      render_options.text_justification = 1;
      render_options.text_position_vertical = 2;

      render_options = [staffLine1 renderOptions];
      render_options.draw_end_arrow = YES;
      render_options.arrowhead_length = 30;
      render_options.lineWidth = 5;
      [staffLine1 setText:@"Center"];
      render_options.text_justification = 2;
      render_options.text_position_vertical = 2;

      render_options = [staffLine4 renderOptions];
      render_options.lineWidth = 2;
      render_options.draw_end_arrow = YES;
      render_options.draw_start_arrow = YES;
      render_options.arrowhead_angle = 0.5;
      render_options.arrowhead_length = 20;
      [staffLine4 setText:@"Right"];
      render_options.text_justification = 3;
      render_options.text_position_vertical = 2;

      render_options.draw_start_arrow = YES;
      render_options.line_dash = @[ @5, @4 ];

      render_options = [staffLine3 renderOptions];
      render_options.draw_end_arrow = YES;
      render_options.draw_start_arrow = YES;
      render_options.color = @"red";
      [staffLine3 setText:@"Top"];
      render_options.text_position_vertical = 1;

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      [voice setStrict:NO];
      [voice addTickables:notes];

      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      [staffLine0 draw:ctx];
      [staffLine1 draw:ctx];
      [staffLine2 draw:ctx];
      [staffLine3 draw:ctx];
      [staffLine4 draw:ctx];

      ok(YES, @"YES");
    };
}

@end
