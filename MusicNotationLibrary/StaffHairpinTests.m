//
//  StaffHairpinTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "StaffHairpinTests.h"
#import "VexFlowTestHelpers.h"

@implementation StaffHairpinTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Simple StaffHairpin"  func:@selector(simple:withTitle:)];
    [self runTest:@"Horizontal Offset StaffHairpin"  func:@selector(ho:withTitle:)];
    [self runTest:@"Vertical Offset StaffHairpin"  func:@selector(vo:withTitle:)];
    [self runTest:@"Height StaffHairpin"  func:@selector(height:withTitle:)];
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

- (void)drawHairpin:(NSArray*)notes
              staff:(VFStaff*)staff
            context:(CGContextRef)ctx
               type:(VFStaffHairpinType)type
           position:(VFPositionType)position
            options:(NSDictionary*)options
{
    VFStaffHairpin* hp = [[VFStaffHairpin alloc] initWithNotes:notes withStaff:staff andType:type options:options];
    hp.position = position;
    [hp setRenderOptions:options];
    [hp draw:ctx];
}

+ (VFStaff*)hairpinNotes:(NSArray*)notes options:(NSDictionary*)options context:(CGContextRef)ctx dirtyRect:(CGRect)dirtyRect
{
    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 400, 0)];

    //    [staff addClefWithName:@"treble"];

    [staff draw:ctx];

    VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
    [voice addTickables:notes];

    [[[VFFormatter formatter] joinVoices:@[ voice ]] formatWith:@[ voice ] withJustifyWidth:250];
    [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

    return staff;
}

static BOOL _debug = NO;
- (void)simple:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(450, 140) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];

    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      NSArray* notes = @[
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }) addAccidental:newAcc(@"b")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],

          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" })
      ];

      //      VFStaff* staff = [[self class] hairpinNotes:notes options:nil context:ctx];
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 400, 0)] addTrebleGlyph];
      [staff draw:ctx];
      [notes foreach:^(VFStaffNote* note, NSUInteger i, BOOL* stop) {
        [[self class] showNote:note onStaff:staff withContext:ctx atX:(i + 1) * 50 withBoundingBox:_debug];
      }];

      [[self class] drawHairpin:@[ notes[0], notes[2] ]
                          staff:staff
                        context:ctx
                           type:VFStaffHairpinCres
                       position:VFPositionBelow
                        options:nil];

      [[self class] drawHairpin:@[ notes[1], notes[3] ]
                          staff:staff
                        context:ctx
                           type:VFStaffHairpinDescres
                       position:VFPositionAbove
                        options:nil];

      ok(YES, @"Simple Test");
    };
}

- (void)ho:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(450, 140) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 400, 0)] addTrebleGlyph];
      [staff draw:ctx];
      NSArray* notes = @[
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }) addAccidental:newAcc(@"b")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],

          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" })
      ];

      [notes foreach:^(VFStaffNote* note, NSUInteger i, BOOL* stop) {
        [[self class] showNote:note onStaff:staff withContext:ctx atX:(i + 1) * 50 withBoundingBox:_debug];
      }];

      NSDictionary* renderOptions1 = @{
          @"height" : @(10),
          @"vo" : @(20),         // vertical offset
          @"left_ho" : @(20),    // left horizontal offset
          @"right_ho" : @(-20)   // right horizontal offset
      };
      [[self class] drawHairpin:@[ notes[0], notes[2] ]
                          staff:staff
                        context:ctx
                           type:VFStaffHairpinCres
                       position:VFPositionAbove
                        options:renderOptions1];

      NSDictionary* renderOptions2 = @{
          @"height" : @(10),
          @"y_shift" : @(0),           // vertical offset
          @"left_shift_px" : @(0),     // left horizontal offset
          @"right_shift_px" : @(120)   // right horizontal offset

      };
      [[self class] drawHairpin:@[ notes[3], notes[3] ]
                          staff:staff
                        context:ctx
                           type:VFStaffHairpinDescres
                       position:VFPositionBelow
                        options:renderOptions2];

      ok(YES, @"Horizontal Offset Test");
    };
}

- (void)vo:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(450, 140) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 400, 0)] addTrebleGlyph];
      [staff draw:ctx];
      NSArray* notes = @[
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }) addAccidental:newAcc(@"b")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],

          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" })
      ];

      [notes foreach:^(VFStaffNote* note, NSUInteger i, BOOL* stop) {
        [[self class] showNote:note onStaff:staff withContext:ctx atX:(i + 1) * 50 withBoundingBox:_debug];
      }];

      NSDictionary* renderOptions1 = @{
          @"height" : @(10),
          @"y_shift" : @(0),         // vertical offset
          @"left_shift_px" : @(0),   // left horizontal offset
          @"right_shift_px" : @(0)   // right horizontal offset
      };
      [[self class] drawHairpin:@[ notes[0], notes[2] ]
                          staff:staff
                        context:ctx
                           type:VFStaffHairpinCres
                       position:VFPositionBelow
                        options:renderOptions1];

      NSDictionary* renderOptions2 = @{
          @"height" : @(10),
          @"y_shift" : @(-10),       // vertical offset
          @"left_shift_px" : @(2),   // left horizontal offset
          @"right_shift_px" : @(0)   // right horizontal offset

      };
      [[self class] drawHairpin:@[ notes[2], notes[3] ]
                          staff:staff
                        context:ctx
                           type:VFStaffHairpinDescres
                       position:VFPositionBelow
                        options:renderOptions2];

      ok(YES, @"Vertical Offset Test");
    };
}

- (void)height:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    VFAccidental* (^newAcc)(NSString*) = ^VFAccidental*(NSString* type)
    {
        return [VFAccidental accidentalWithType:type];
    };

    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(450, 140) withParent:parent withTitle:title];
    // test.backgroundColor = [VFColor randomBGColor:YES];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 10, 400, 0)] addTrebleGlyph];
      [staff draw:ctx];
      NSArray* notes = @[
          [[newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }) addAccidental:newAcc(@"b")
                                             atIndex:0] addAccidental:newAcc(@"#")
                                                              atIndex:1],

          newNote(
              @{ @"keys" : @[ @"d/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"e/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" }),
          newNote(
              @{ @"keys" : @[ @"f/4" ],
                 @"stem_direction" : @(1),
                 @"duration" : @"q" })
      ];

      [notes foreach:^(VFStaffNote* note, NSUInteger i, BOOL* stop) {
        [[self class] showNote:note onStaff:staff withContext:ctx atX:(i + 1) * 50 withBoundingBox:_debug];
      }];

      NSDictionary* renderOptions1 = @{
          @"height" : @(10),
          @"y_shift" : @(0),         // vertical offset
          @"left_shift_px" : @(0),   // left horizontal offset
          @"right_shift_px" : @(0)   // right horizontal offset

      };
      [[self class] drawHairpin:@[ notes[0], notes[2] ]
                          staff:staff
                        context:ctx
                           type:VFStaffHairpinCres
                       position:VFPositionBelow
                        options:renderOptions1];

      NSDictionary* renderOptions2 = @{
          @"height" : @(15),
          @"y_shift" : @(0),         // vertical offset
          @"left_shift_px" : @(2),   // left horizontal offset
          @"right_shift_px" : @(0)   // right horizontal offset

      };
      [[self class] drawHairpin:@[ notes[2], notes[3] ]
                          staff:staff
                        context:ctx
                           type:VFStaffHairpinDescres
                       position:VFPositionBelow
                        options:renderOptions2];

      ok(YES, @"Height Test");
    };
}

+ (VFStaffNote*)showNote:(VFStaffNote*)note
                 onStaff:(VFStaff*)staff
             withContext:(CGContextRef)ctx
                     atX:(float)x
         withBoundingBox:(BOOL)drawBoundingBox
{
    VFTickContext* tickContext = [[VFTickContext alloc] init];
    [[tickContext addTickable:note] preFormat];
    tickContext.x = x;
    tickContext.pixelsUsed = 20;
    note.staff = staff;
    [note draw:ctx];
    if(drawBoundingBox)
    {
        [note.boundingBox draw:ctx];
    }
    return note;
}

@end
