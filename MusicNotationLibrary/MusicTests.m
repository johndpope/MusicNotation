//
//  MusicTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "MusicTests.h"
#import "VexFlowTestHelpers.h"

@implementation MusicTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Valid Notes"  func:@selector(validNotes)];
    [self runTest:@"Valid Keys"  func:@selector(validKeys)];
    [self runTest:@"Note Values"  func:@selector(noteValue)];
    [self runTest:@"Interval Values"  func:@selector(intervalValue)];
    [self runTest:@"Relative Notes"  func:@selector(relativeNotes)];
    [self runTest:@"Relative Note Names"  func:@selector(relativeNoteNames)];
    [self runTest:@"Canonical Notes"  func:@selector(canonicalNotes)];
    [self runTest:@"Canonical Intervals"  func:@selector(canonicalNotes)];
    [self runTest:@"Scale Tones"  func:@selector(scaleTones)];
    [self runTest:@"Scale Intervals"  func:@selector(scaleIntervals)];
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

- (void)validNotes
{
    /*
    Vex.Flow.Test.Music.validNotes = function() {
        expect(10);

        var music = new Vex.Flow.Music();

        var parts = [music getNoteParts(@"c");
        equal(parts.root, @"c");
        equal(parts.accidental, null);

        parts = [music getNoteParts(@"C");
        equal(parts.root, @"c");
        equal(parts.accidental, null);

        parts = [music getNoteParts(@"c#");
        equal(parts.root, @"c");
        equal(parts.accidental, @"#");

        parts = [music getNoteParts(@"c##");
        equal(parts.root, @"c");
        equal(parts.accidental, @"##");

        try {
            [music getNoteParts(@"r");
        } catch (e) {
            equal(e.code, @"BadArguments", @"Invalid note: r");
        }

        try {
            [music getNoteParts(@"");
        } catch (e) {
            equal(e.code, @"BadArguments", @"Invalid note: ''");
        }
    }
     */
}

- (void)validKeys
{
    /*
    Vex.Flow.Test.Music.validKeys = function() {
        expect(18);

        var music = new Vex.Flow.Music();

        var parts = [music getKeyParts(@"c");
        equal(parts.root, @"c");
        equal(parts.accidental, null);
        equal(parts.type, @"M");

        parts = [music getKeyParts(@"d#");
        equal(parts.root, @"d");
        equal(parts.accidental, @"#");
        equal(parts.type, @"M");

        parts = [music getKeyParts(@"fbm");
        equal(parts.root, @"f");
        equal(parts.accidental, @"b");
        equal(parts.type, @"m");

        parts = [music getKeyParts(@"c#mel");
        equal(parts.root, @"c");
        equal(parts.accidental, @"#");
        equal(parts.type, @"mel");

        parts = [music getKeyParts(@"g#harm");
        equal(parts.root, @"g");
        equal(parts.accidental, @"#");
        equal(parts.type, @"harm");

        try {
            [music getKeyParts(@"r");
        } catch (e) {
            equal(e.code, @"BadArguments", @"Invalid key: r");
        }

        try {
            [music getKeyParts(@"");
        } catch (e) {
            equal(e.code, @"BadArguments", @"Invalid key: ''");
        }

        try {
            [music getKeyParts(@"#m");
        } catch (e) {
            equal(e.code, @"BadArguments", @"Invalid key: #m");
        }
    }
     */
}

- (void)noteValue
{
    /*
    Vex.Flow.Test.Music.noteValue = function() {
        expect(3);

        var music = new Vex.Flow.Music();

        var note = [music getNoteValue(@"c");
        equal(note, 0);

        try {
            [music getNoteValue(@"r");
        } catch(e) {
            ok(YES, @"Invalid note");
        }

        note = [music getNoteValue(@"f#");
        equal(note, 6);
    }
     */
}

- (void)intervalValue
{
    /*
    Vex.Flow.Test.Music.intervalValue = function() {
        expect(2);

        var music = new Vex.Flow.Music();

        var value = [music getIntervalValue(@"b2");
        equal(value, 1);

        try {
            [music getIntervalValue(@"7");
        } catch(e) {
            ok(YES, @"Invalid note");
        }
    }
     */
}

- (void)relativeNotes
{
    /*
    Vex.Flow.Test.Music.relativeNotes = function() {
        expect(8);

        var music = new Vex.Flow.Music();

        var value = [music getRelativeNoteValue([music getNoteValue(@"c"),
                                               [music getIntervalValue(@"b5"));
        equal(value, 6);

        try {
            [music getRelativeNoteValue([music getNoteValue(@"bc"),
                                       [music getIntervalValue(@"b2"));
        } catch(e) {
            ok(YES, @"Invalid note");
        }

        try {
            [music getRelativeNoteValue([music getNoteValue(@"b"),
                                       [music getIntervalValue(@"p3"));
        } catch(e) {
            ok(YES, @"Invalid interval");
        }

        // Direction
        value = [music getRelativeNoteValue([music getNoteValue(@"d"),
                                           [music getIntervalValue(@"2"), -1);
        equal(value, 0);

        try {
            [music getRelativeNoteValue([music getNoteValue(@"b"),
                                       [music getIntervalValue(@"p4"), 0);
        } catch(e) {
            ok(YES, @"Invalid direction");
        }

        // Rollover
        value = [music getRelativeNoteValue([music getNoteValue(@"b"),
                                           [music getIntervalValue(@"b5"));
        equal(value, 5);

        // Reverse rollover
        value = [music getRelativeNoteValue([music getNoteValue(@"c"),
                                           [music getIntervalValue(@"b2"), -1);
        equal(value, 11);

        // Practical tests
        value = [music getRelativeNoteValue([music getNoteValue(@"g"),
                                           [music getIntervalValue(@"p5"));
        equal(value, 2);
    }
     */
}

- (void)relativeNoteNames
{
    /*
    Vex.Flow.Test.Music.relativeNoteNames = function() {
        expect(9);

        var music = new Vex.Flow.Music();
        equal([music getRelativeNoteName(@"c", [music getNoteValue(@"c")), @"c");
        equal([music getRelativeNoteName(@"c", [music getNoteValue(@"db")), @"c#");
        equal([music getRelativeNoteName(@"c#", [music getNoteValue(@"db")), @"c#");
        equal([music getRelativeNoteName(@"e", [music getNoteValue(@"f#")), @"e##");
        equal([music getRelativeNoteName(@"e", [music getNoteValue(@"d#")), @"eb");
        equal([music getRelativeNoteName(@"e", [music getNoteValue(@"fb")), @"e");

        try {
            [music getRelativeNoteName(@"e", [music getNoteValue(@"g#"));
        } catch(e) {
            ok(YES, @"Too far");
        }

        equal([music getRelativeNoteName(@"b", [music getNoteValue(@"c#")), @"b##");
        equal([music getRelativeNoteName(@"c", [music getNoteValue(@"b")), @"cb");
    }
     */
}

- (void)canonicalNotes
{
    /*
    Vex.Flow.Test.Music.canonicalNotes = function() {
        expect(3);

        var music = new Vex.Flow.Music();

        equal([music getCanonicalNoteName(0), @"c");
        equal([music getCanonicalNoteName(2), @"d");

        try {
            [music getCanonicalNoteName(-1);
        } catch(e) {
            ok(YES, @"Invalid note value");
        }
    }
     */
}

- (void)canonicalIntervals
{
    /*
    Vex.Flow.Test.Music.canonicalIntervals = function() {
        expect(3);

        var music = new Vex.Flow.Music();

        equal([music getCanonicalIntervalName(0), @"unison");
        equal([music getCanonicalIntervalName(2), @"M2");

        try {
            [music getCanonicalIntervalName(-1);
        } catch(e) {
            ok(YES, @"Invalid interval value");
        }
    }
     */
}

- (void)scaleTones
{
    /*
    Vex.Flow.Test.Music.scaleTones = function() {
        expect(24);

        // C Major
        var music = new Vex.Flow.Music();
        var manager = new Vex.Flow.KeyManager(@"CM");

        var c_major = [music getScaleTones:
                                          [music getNoteValue(@"c"), Vex.Flow.Music.scales.major);
        NSArray *values = @[@"c", @"d", @"e", @"f", @"g", @"a", @"b"];

        equal(c_major.length, 7);

        for (var cm = 0; cm < c_major.length; ++cm) {
            equal([music getCanonicalNoteName(c_major[cm]), values[cm]);
        }

        // Dorian
        var c_dorian = [music getScaleTones:
                                           [music getNoteValue(@"c"), Vex.Flow.Music.scales.dorian);
        values = @[@"c", @"d", @"eb", @"f", @"g", @"a", @"bb"];

        var note = null;
        equal(c_dorian.length,  7);
        for (var cd = 0; cd < c_dorian.length; ++cd) {
            note = [music getCanonicalNoteName(c_dorian[cd]);
            equal(manager.selectNote(note).note, values[cd]);
        }

        // Mixolydian
        var c_mixolydian = [music getScaleTones:
                                               [music getNoteValue(@"c"), Vex.Flow.Music.scales.mixolydian);
        values = @[@"c", @"d", @"e", @"f", @"g", @"a", @"bb"];

        equal(c_mixolydian.length,  7);

        for (var i = 0; i < c_mixolydian.length; ++i) {
            note = [music getCanonicalNoteName(c_mixolydian[i]);
            equal(manager.selectNote(note).note, values[i]);
        }
    }
     */
}

- (void)scaleIntervals
{
    /*
    Vex.Flow.Test.Music.scaleIntervals = function() {
        expect(6);

        var music = new Vex.Flow.Music();

        equal([music getCanonicalIntervalName([music getIntervalBetween(
                                                                      [music getNoteValue(@"c"),
    [music getNoteValue(@"d"))), @"M2");
        equal([music getCanonicalIntervalName([music getIntervalBetween(
                                                                      [music getNoteValue(@"g"),
    [music getNoteValue(@"c"))), @"p4");
        equal([music getCanonicalIntervalName([music getIntervalBetween(
                                                                      [music getNoteValue(@"c"),
    [music getNoteValue(@"c"))), @"unison");
        equal([music getCanonicalIntervalName([music getIntervalBetween(
                                                                      [music getNoteValue(@"f"),
    [music getNoteValue(@"cb"))), @"dim5");

        // Forwards and backwards
        equal([music getCanonicalIntervalName([music getIntervalBetween(
                                                                      [music getNoteValue(@"d"), [music
    getNoteValue(@"c"),
    1)), @"b7");
        equal([music getCanonicalIntervalName([music getIntervalBetween(
                                                                      [music getNoteValue(@"d"), [music
    getNoteValue(@"c"),
    -1)), @"M2");
    }
    */
}

@end
