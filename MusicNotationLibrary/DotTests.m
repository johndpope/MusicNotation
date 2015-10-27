//
//  DotTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "DotTests.h"
#import "VexFlowTestHelpers.h"

@implementation DotTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Basic" func:@selector(basic:withTitle:)];
    [self runTest:@"Multi Voice" func:@selector(multiVoice:withTitle:)];
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

//    TestCollectionItemView* test =
//        self.currentCell;   // VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(w, h) withParent:parent];
    VFStaff* staff = [[VFStaff staffWithRect:CGRectMake(10, 30, w, 0)] addTrebleGlyph];
    return [ViewStaffStruct contextWithStaff:staff andView:nil];
}

+ (VFStaffNote*)showNote:(VFStaffNote*)note staff:(VFStaff*)staff context:(CGContextRef)ctx x:(NSUInteger)x
{
    VFModifierContext* mc = [VFModifierContext modifierContext];
    [note addToModifierContext:mc];

    VFTickContext* tickContext = [[VFTickContext alloc] init];
    [tickContext addTickable:note];
    [tickContext preFormat];
    [tickContext setX:x];
    [tickContext setPixelsUsed:65];

    note.staff = staff;
    [note draw:ctx];
    /*
        ctx.save();
        ctx.font = "10pt Arial"; ctx.strokeStyle = "#579"; ctx.fillStyle = "#345";
        ctx.fillText(@"w: " + note.getWidth(), note.getAbsoluteX() - 25, 200 / 1.5);
     */
    // TODO: test the following text writing
    //    [[[VFFont setFont:@"10 pt Arial"] setStrokeStyle:@"#579"] setFillStyle:@"#345"];
    //    [VFText drawSimpleText:ctx
    //                   atPoint:VFPointMake(note.absoluteX - 25, 200 / 1.5)
    //                  withText:[NSString stringWithFormat:@"w: %f", note.width]];


#if TARGET_OS_IPHONE
    UIFont* descriptionFont = [UIFont fontWithName:@"ArialMT" size:12];
#elif TARGET_OS_MAC
    NSFont* descriptionFont = [NSFont fontWithName:@"ArialMT" size:12];
#endif


    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTTextAlignmentCenter;
    NSAttributedString* description;

    description = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"w: %.01f", note.width]
                                                  attributes:@{
                                                      NSParagraphStyleAttributeName : paragraphStyle,
                                                      NSFontAttributeName : descriptionFont,
                                                      NSForegroundColorAttributeName : VFColor.blackColor
                                                  }];

    [description drawAtPoint:CGPointMake(note.absoluteX - 25, 200 / 1.5)];
    CGContextSaveGState(ctx);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, note.absoluteX - (note.width / 2), 210 / 1.5);
    CGContextMoveToPoint(ctx, note.absoluteX + (note.width / 2), 210 / 1.5);
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
    return note;
}

- (void)basic:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    // VFTestView* test = self.currentCell;   // VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(1000, 240)
                                           // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();

      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 975, 0)];
      // CGContextRef ctx = context.CGContext;
      [staff draw:ctx];

      NSArray* notes = @[
          [newNote(
              @{ @"keys" : @[ @"c/4", @"e/4", @"a/4", @"b/4" ],
                 @"duration" : @"w" }) addDotToAll],

          [newNote(
              @{ @"keys" : @[ @"c/5", @"b/4", @"a/4" ],
                 @"duration" : @"q",
                 @"stem_direction" : @(1) }) addDotToAll],

          [newNote(
              @{ @"keys" : @[ @"b/4", @"a/4", @"g/4" ],
                 @"duration" : @"q",
                 @"stem_direction" : @(-1) }) addDotToAll],

          [newNote(
              @{ @"keys" : @[ @"c/5", @"b/4", @"f/4", @"e/4" ],
                 @"duration" : @"q" }) addDotToAll],

          [newNote(@{
              @"keys" : @[ @"g/5", @"e/5", @"d/5", @"a/4", @"g/4" ],
              @"duration" : @"q",
              @"stem_direction" : @(-1)
          }) addDotToAll],

          [newNote(
              @{ @"keys" : @[ @"e/5", @"d/5", @"b/4", @"g/4" ],
                 @"duration" : @"q",
                 @"stem_direction" : @(-1) }) addDotToAll],

          [newNote(
              @{ @"keys" : @[ @"c/5", @"b/4", @"g/4", @"e/4" ],
                 @"duration" : @"q",
                 @"stem_direction" : @(1) }) addDotToAll],

          [[newNote(
              @{ @"keys" : @[ @"d/4", @"e/4", @"f/4", @"a/4", @"c/5", @"e/5", @"g/5" ],
                 @"duration" : @"h" }) addDotToAll] addDotToAll],

          [[[newNote(@{
              @"keys" : @[ @"f/4", @"g/4", @"a/4", @"b/4", @"c/5", @"e/5", @"g/5" ],
              @"duration" : @"16",
              @"stem_direction" : @(-1)
          }) addDotToAll] addDotToAll] addDotToAll]
      ];

      for(NSUInteger i = 0; i < notes.count; ++i)
      {
          [[self class] showNote:notes[i] staff:staff context:ctx x:30 + (i * 65)];
          NSArray* accidentals = [((VFStaffNote*)notes[i])getDots];
          BOOL result = accidentals.count > 0;
          NSString* message = [NSString stringWithFormat:@"Note %lu has accidentals", i];
          ok(result, message);

          for(NSUInteger j = 0; j < accidentals.count; ++j)
          {
              NSString* message = [NSString stringWithFormat:@"Dot %lu has set width", j];
              BOOL result = ((VFAccidental*)accidentals[j]).width > 0;
              ok(result, message);
          }
      }

      ok(YES, @"Full Dot");
    };
}

- (void)showNotes:(VFStaffNote*)note1
            note2:(VFStaffNote*)note2
            staff:(VFStaff*)staff
          context:(CGContextRef)ctx
                x:(NSUInteger)x
{
    VFModifierContext* mc = [VFModifierContext modifierContext];
    [note1 addToModifierContext:mc];
    [note2 addToModifierContext:mc];

    VFTickContext* tickContext = [[VFTickContext alloc] init];
    [[tickContext addTickable:note1] addTickable:note2];
    [tickContext preFormat];
    [tickContext setX:x];
    [tickContext setPixelsUsed:65];

    note1.staff = staff;
    [note1 draw:ctx];
    note2.staff = staff;
    [note2 draw:ctx];
/*
    ctx.save();
    ctx.font = "10pt Arial"; ctx.strokeStyle = "#579"; ctx.fillStyle = "#345";
    ctx.fillText(@"w: " + note2.getWidth(), note2.getAbsoluteX() + 15, 20 / 1.5);
    ctx.fillText(@"w: " + note1.getWidth(), note1.getAbsoluteX() - 25, 220 / 1.5);
 */
//    [[[VFFont setFont:@"10 pt Arial"] setStrokeStyle:@"#579"] setFillStyle:@"#345"];

#if TARGET_OS_IPHONE
    UIFont* descriptionFont = [UIFont fontWithName:@"ArialMT" size:12];
#elif TARGET_OS_MAC
    NSFont* descriptionFont = [NSFont fontWithName:@"ArialMT" size:12];
#endif

    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = kCTTextAlignmentCenter;
    NSAttributedString* description;

    description = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"w: %.01f", note2.width]
                                                  attributes:@{
                                                      NSParagraphStyleAttributeName : paragraphStyle,
                                                      NSFontAttributeName : descriptionFont,
                                                      NSForegroundColorAttributeName : VFColor.blackColor
                                                  }];

    [description drawAtPoint:CGPointMake(note2.absoluteX + 15, 20 / 1.5)];
    //    [VFText drawSimpleText:ctx
    //                   atPoint:VFPointMake(note2.absoluteX + 15, 20 / 1.5)
    //                  withText:[NSString stringWithFormat:@"w: %f", note2.width]];

    description = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"w: %.01f", note1.width]
                                                  attributes:@{
                                                      NSParagraphStyleAttributeName : paragraphStyle,
                                                      NSFontAttributeName : descriptionFont,
                                                      NSForegroundColorAttributeName : VFColor.blackColor
                                                  }];

    [description drawAtPoint:CGPointMake(note1.absoluteX + 15, 220 / 1.5)];
    //    [VFText drawSimpleText:ctx
    //                   atPoint:VFPointMake(note1.absoluteX + 15, 220 / 1.5)
    //                  withText:[NSString stringWithFormat:@"w: %f", note1.width]];
    CGContextSaveGState(ctx);
    CGContextBeginPath(ctx);
    CGContextMoveToPoint(ctx, note1.absoluteX - (note1.width / 2), 230 / 1.5);
    CGContextMoveToPoint(ctx, note1.absoluteX + (note1.width / 2), 230 / 1.5);
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
}

- (void)multiVoice:(TestCollectionItemView*)parent withTitle:(NSString*)title
{
    VFStaffNote* (^newNote)(NSDictionary*) = ^VFStaffNote*(NSDictionary* note_struct)
    {
        return [[VFStaffNote alloc] initWithDictionary:note_struct];
    };
    // VFTestView* test = self.currentCell;   // VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(400, 250)
                                           // withParent:parent withTitle:title];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
      // CGContextRef ctx = context.CGContext;
      VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 50, 420, 0)];

      [staff draw:ctx];

      VFStaffNote* note1 = [[newNote(
          @{ @"keys" : @[ @"c/4", @"e/4", @"a/4" ],
             @"duration" : @"h",
             @"stem_direction" : @(-1) }) addDotToAll] addDotToAll];
      VFStaffNote* note2 = [newNote(
          @{ @"keys" : @[ @"d/5", @"a/5", @"b/5" ],
             @"duration" : @"h",
             @"stem_direction" : @(1) }) addDotToAll];

      [[self class] showNotes:note1 note2:note2 staff:staff context:ctx x:60];

      note1 = [[[[[[[newNote(
          @{ @"keys" : @[ @"c/4", @"e/4", @"c/5" ],
             @"duration" : @"h",
             @"stem_direction" : @(-1) }) addDotAtIndex:0] addDotAtIndex:0] addDotAtIndex:1] addDotAtIndex:1]
          addDotAtIndex:2] addDotAtIndex:2] addDotAtIndex:2];
      note2 = [[newNote(
          @{ @"keys" : @[ @"d/5", @"a/5", @"b/5" ],
             @"duration" : @"q",
             @"stem_direction" : @(1) }) addDotToAll] addDotToAll];

      [[self class] showNotes:note1 note2:note2 staff:staff context:ctx x:150];

      note1 = [[[newNote(
          @{ @"keys" : @[ @"d/4", @"c/5", @"d/5" ],
             @"duration" : @"h",
             @"stem_direction" : @(-1) }) addDotToAll] addDotToAll] addDotAtIndex:0];
      note2 = [newNote(
          @{ @"keys" : @[ @"d/5", @"a/5", @"b/5" ],
             @"duration" : @"q",
             @"stem_direction" : @(1) }) addDotToAll];

      [[self class] showNotes:note1 note2:note2 staff:staff context:ctx x:250];

      ok(YES, @"Full Dot");
    };
}
@end
