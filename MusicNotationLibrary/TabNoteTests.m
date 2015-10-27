//
//  TabNoteTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TabNoteTests.h"
#import "VexFlowTestHelpers.h"

@implementation TabNoteTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Tick"  func:@selector(ticks)];
    [self runTest:@"TabStaff Line"  func:@selector(tabStaffLine)];
    [self runTest:@"Width"  func:@selector(width)];
    [self runTest:@"TickContext"  func:@selector(tickContext)];
    [self runTest:@"TabNote Draw"  func:@selector(draw:)];
    [self runTest:@"TabNote Stems Up"  func:@selector(drawStemsUp:)];
    [self runTest:@"TabNote Stems Down"  func:@selector(drawStemsDown:)];
    [self runTest:@"TabNote Stems Up Through Staff"
           
             func:@selector(drawStemsUpThrough:)
        ];
    [self runTest:@"TabNote Stems Down Through Staff"
           
             func:@selector(drawStemsDownThrough:)
        ];
    [self runTest:@"TabNote Stems with Dots"  func:@selector(drawStemsDotted:)];
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

- (void)ticks
{
    float BEAT = 1 * kRESOLUTION / 4;

    VFTabNote* note = [[VFTabNote alloc] initWithDictionary:@{
        @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ],
        @"duration" : @"w"
    }];
    assertThatFloat(note.ticks.floatValue, describedAs(@"Whole note has 4 beats", closeTo(BEAT * 4, 0.01), nil));

    note = [[VFTabNote alloc] initWithDictionary:@{
        @"positions" : @[ @{@"str" : @(3), @"fret" : @(4)} ],
        @"duration" : @"q"
    }];
    assertThatFloat(note.ticks.floatValue, describedAs(@"Quarter note has 1 beat", closeTo(BEAT, 0.01), nil));
}

- (void)tabStaffLine
{
    VFTabNote* note = [[VFTabNote alloc] initWithDictionary:@{
        @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
        @"duration" : @"w"
    }];
    NSArray* positions = note.positions;
    assertThatUnsignedInteger(((TabNotePositionsStruct*)positions[0]).str,
                              describedAs(@"String 6, Fret 6", equalToUnsignedInteger(6), nil));
    assertThatUnsignedInteger(((TabNotePositionsStruct*)positions[0]).fret,
                              describedAs(@"String 6, Fret 6", equalToUnsignedInteger(6), nil));
    assertThatUnsignedInteger(((TabNotePositionsStruct*)positions[1]).str,
                              describedAs(@"String 4, Fret 5", equalToUnsignedInteger(4), nil));
    assertThatUnsignedInteger(((TabNotePositionsStruct*)positions[1]).fret,
                              describedAs(@"String 4, Fret 5", equalToUnsignedInteger(5), nil));

    VFStaff* staff = [VFStaff staffWithRect:CGRectMake(10, 10, 300, 0)];
    note.staff = staff;

    NSArray* ys = note.ys;
    assertThatUnsignedInteger(ys.count,
                              describedAs(@"Chord should be rendered on two lines", equalToUnsignedInteger(2), nil));
    assertThatUnsignedInteger(((NSNumber*)ys[0]).unsignedIntegerValue,
                              describedAs(@"Line for String 6, Fret 6", equalToUnsignedInteger(99), nil));
    assertThatUnsignedInteger(((NSNumber*)ys[1]).unsignedIntegerValue,
                              describedAs(@"Line for String 4, Fret 5", equalToUnsignedInteger(79), nil));
}

- (void)width
{
    expect(@"1");
    VFTabNote* note = [[VFTabNote alloc] initWithDictionary:@{
        @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
        @"duration" : @"w"
    }];

    [VFLog logInfo:@"expect: \"UnformattedNote\" error"];
    assertThatFloat(note.width, describedAs(@"Unformatted note should have no width", equalToFloat(MAXFLOAT), nil));
}

- (void)tickContext
{
    VFTabNote* note = [[VFTabNote alloc] initWithDictionary:@{
        @"positions" : @[ @{@"str" : @(6), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
        @"duration" : @"w"
    }];

    VFTickContext* tickContext = [[VFTickContext alloc] init];
    [tickContext addTickable:note];
    [tickContext preFormat];
    tickContext.x = 10;
    tickContext.padding = 0;
    assertThatFloat(tickContext.width, describedAs(@"", equalToFloat(6), nil));
}

+ (VFTabNote*)showNote:(NSDictionary*)tabStruct staff:(VFTabStaff*)staff context:(CGContextRef)ctx x:(float)x
{
    VFTabNote* note = [[VFTabNote alloc] initWithDictionary:tabStruct];
    VFTickContext* tickContext = [[VFTickContext alloc] init];
    [[tickContext addTickable:note] preFormat];
    tickContext.x = x;
    tickContext.pixelsUsed = 20;
    note.staff = staff;
    [note draw:ctx];
    return note;
}

- (void)draw:(TestCollectionItemView*)parent;
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 140) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // ctx.font = "10pt Arial";
      VFTabStaff* staff = [VFTabStaff staffWithRect:CGRectMake(10, 30, 550, 0)];
      [staff draw:ctx];

      NSArray* notes = @[
          @{@"positions" : @[ @{@"str" : @(6), @"fret" : @(6)} ], @"duration" : @"q"},
          @{
             @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
             @"duration" : @"q"
          },
          @{
             @"positions" : @[ @{@"str" : @(2), @"fret" : @("x")}, @{@"str" : @(5), @"fret" : @(15)} ],
             @"duration" : @"q"
          },
          @{
             @"positions" : @[ @{@"str" : @(2), @"fret" : @("x")}, @{@"str" : @(5), @"fret" : @(5)} ],
             @"duration" : @"q"
          },
          @{
             @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
             @"duration" : @"q"
          },
          @{
             @"positions" : @[
                 @{@"str" : @(6), @"fret" : @(0)},
                 @{@"str" : @(5), @"fret" : @(5)},
                 @{@"str" : @(4), @"fret" : @(5)},
                 @{@"str" : @(3), @"fret" : @(4)},
                 @{@"str" : @(2), @"fret" : @(3)},
                 @{@"str" : @(1), @"fret" : @(0)}
             ],
             @"duration" : @"q"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"q"
          }
      ];

      [notes foreach:^(NSDictionary* note, NSUInteger i, BOOL* stop) {

        VFTabNote* staffNote = [[self class] showNote:note staff:staff context:ctx x:(i + 1) * 25];

        BOOL success = staffNote.x > 0;
        NSString* message = [NSString stringWithFormat:@"Note %li has X value", i];
        ok(success, message);
        success = staffNote.ys.count > 0;
        message = [NSString stringWithFormat:@"Note %li has Y values", i];
        ok(success, message);
      }];
    };
}

- (void)drawStemsUp:(TestCollectionItemView*)parent;
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // ctx.font = "10pt Arial";
      VFTabStaff* staff = [VFTabStaff staffWithRect:CGRectMake(10, 30, 550, 0)];
      [staff draw:ctx];

      NSArray* specs = @[
          @{
             @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
             @"duration" : @"4"
          },
          @{
             @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
             @"duration" : @"8"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"8"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"16"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"32"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"64"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"128"
          }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* noteSpec) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:noteSpec];
        [tabNote->_renderOptions setDraw_stem:YES];
        return tabNote;
      }];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];

//      VFFormatter* formatter =
        [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"TabNotes successfully drawn");
    };
}

- (void)drawStemsDown:(TestCollectionItemView*)parent;
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // ctx.font = "10pt Arial";
      VFTabStaff* staff = [VFTabStaff staffWithRect:CGRectMake(10, 30, 550, 0)];
      [staff draw:ctx];

      NSArray* specs = @[
          @{
             @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
             @"duration" : @"4"
          },
          @{
             @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
             @"duration" : @"8"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"8"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"16"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"32"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"64"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"128"
          }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* noteSpec) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:noteSpec];
        [tabNote->_renderOptions setDraw_stem:YES];    // .draw_stem = YES;
        tabNote.stemDirection = VFStemDirectionDown;   //(-1);
        return tabNote;
      }];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;
      ;

      [voice addTickables:notes];

      //      VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"All objects have been drawn");
    };
}

- (void)drawStemsUpThrough:(TestCollectionItemView*)parent;
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 200) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // ctx.font = "10pt Arial";
      VFTabStaff* staff = [VFTabStaff staffWithRect:CGRectMake(10, 30, 550, 0)];
      [staff draw:ctx];

      NSArray* specs = @[
          @{
             @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
             @"duration" : @"4"
          },
          @{
             @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
             @"duration" : @"8"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"8"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"16"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"32"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"64"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"128"
          }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* noteSpec) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:noteSpec];
        [tabNote->_renderOptions setDraw_stem:YES];
        [tabNote->_renderOptions setDraw_stem_through_staff:YES];
        return tabNote;
      }];

      // ctx.setFont(@"sans-serif", 10, @"bold");

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];

      // VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"TabNotes successfully drawn");
    };
}

- (void)drawStemsDownThrough:(TestCollectionItemView*)parent;
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 250) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // ctx.font = "10pt Arial";
      VFTabStaff* staff = [VFTabStaff staffWithRect:CGRectMake(10, 30, 550, 0)];
      [staff draw:ctx];

      NSArray* specs = @[
          @{
             @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
             @"duration" : @"4"
          },
          @{
             @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
             @"duration" : @"8"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"8"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"16"
          },
          @{
             @"positions" : @[
                 @{@"str" : @(1), @"fret" : @(6)},
                 @{@"str" : @(4), @"fret" : @(5)},
                 @{@"str" : @(6), @"fret" : @(10)}
             ],
             @"duration" : @"32"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"64"
          },
          @{
             @"positions" : @[
                 @{@"str" : @(1), @"fret" : @(6)},
                 @{@"str" : @(3), @"fret" : @(5)},
                 @{@"str" : @(5), @"fret" : @(5)},
                 @{@"str" : @(7), @"fret" : @(5)}
             ],
             @"duration" : @"128"
          }
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* noteSpec) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:noteSpec];
        [tabNote->_renderOptions setDraw_stem:YES];
        [tabNote->_renderOptions setDraw_stem_through_staff:YES];
        tabNote.stemDirection = VFStemDirectionDown;   // (-1);
        return tabNote;
      }];

      // ctx.setFont(@"Arial", 10, @"bold");

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];

      // VFFormatter *formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"All objects have been drawn");
    };
}

- (void)drawStemsDotted:(TestCollectionItemView*)parent;
{
    // VFTestView* test = self.currentCell;  //VFTestView* test = [VFTestView createCanvasTest:CGSizeMake(600, 250) withParent:parent];
    // [parent addSubview:test];
    //    test.drawBlock = ^(CGRect dirtyRect, CGRect bounds, CGContextRef ctx) {
    {
        CGContextRef ctx = VFGraphicsContext();
       // CGContextRef ctx = context.CGContext;
      // ctx.font = "10pt Arial";
      VFTabStaff* staff = [VFTabStaff staffWithRect:CGRectMake(10, 30, 550, 0)];
      [staff draw:ctx];

      NSArray* specs = @[
          @{
             @"positions" : @[ @{@"str" : @(3), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(25)} ],
             @"duration" : @"4d"
          },
          @{
             @"positions" : @[ @{@"str" : @(2), @"fret" : @(10)}, @{@"str" : @(5), @"fret" : @(12)} ],
             @"duration" : @"8"
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"4dd",
             @"stem_direction" : @(-1)
          },
          @{
             @"positions" : @[ @{@"str" : @(1), @"fret" : @(6)}, @{@"str" : @(4), @"fret" : @(5)} ],
             @"duration" : @"16",
             @"stem_direction" : @(-1)
          },
      ];

      NSArray* notes = [specs oct_map:^VFTabNote*(NSDictionary* noteSpec) {
        VFTabNote* tabNote = [[VFTabNote alloc] initWithDictionary:noteSpec];
        tabNote.drawStem = YES;
        return tabNote;
      }];

      [notes[0] addDot];
      [notes[2] addDot];
      [notes[2] addDot];

      VFVoice* voice = [VFVoice voiceWithTimeSignature:VFTime4_4];
      voice.mode = VFModeSoft;

      [voice addTickables:notes];

      // VFFormatter* formatter =
      [[[VFFormatter formatter] joinVoices:@[ voice ]] formatToStaff:@[ voice ] staff:staff];

      [voice draw:ctx dirtyRect:CGRectZero toStaff:staff];

      ok(YES, @"TabNotes successfully drawn");
    };
}

@end
