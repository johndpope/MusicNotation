//
//  TableTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "TableTests.h"
#import "VexFlowTestHelpers.h"

@implementation TableTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Tables - Clef Properties"  func:@selector(clefProperties)];
    [self runTest:@"Tables - Key Properties"  func:@selector(keyProperties)];
    [self runTest:@"Tables - Integer to Note"  func:@selector(integerToNote)];
    [self runTest:@"Tables - Tab to Glyph"  func:@selector(tabToGlyph)];
    [self runTest:@"Tables - Accidetal Codes"  func:@selector(accidentalCodes)];
    [self runTest:@"Tables - Key Signature"  func:@selector(keySignature)];
    [self runTest:@"Tables - Accidental List"  func:@selector(accidentalList)];
    [self runTest:@"Tables - Note Duration"  func:@selector(noteDuration)];
    [self runTest:@"Tables - Duration to Glyph"  func:@selector(durationToGlyph)];
    [self runTest:@"Tables - Misc."  func:@selector(misc)];
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

- (void)clefProperties
{
    /*
    Vex.Flow.Test.Table.clefProperties = function() {
        var expected = {
            'treble':      { line_shift:  0 },
            'bass':        { line_shift:  6 },
            'tenor':       { line_shift:  4 },
            'alto':        { line_shift:  3 },
            'percussion':  { line_shift:  0 }
        };

        deepEqual(Vex.Flow.clefProperties.values, expected, 'Found expected values successfully');

        throws(function() {
            Vex.Flow.clefProperties();
        }, 'Throws exception on undefined clef');

        throws(function() {
            Vex.Flow.clefProperties('invalid');
        }, 'Throws exception on invalid clef');

        var clef = 'treble';
        deepEqual( Vex.Flow.clefProperties( clef ), expected[clef], 'Successfully got the value of clef [' + clef +
    ']');
    };
     */
}

- (void)keyProperties
{
    /*
    Vex.Flow.Test.Table.keyProperties = function() {
        var expectedNoteValues = {
            'C':    { index:  0 , int_val:  0  , accidental:   null } ,
            'CN':   { index:  0 , int_val:  0  , accidental:   "n" }  ,
            'C#':   { index:  0 , int_val:  1  , accidental:   "#" }  ,
            'C##':  { index:  0 , int_val:  2  , accidental:   "##" } ,
            'CB':   { index:  0 , int_val:  -1 , accidental:  "b" }   ,
            'CBB':  { index:  0 , int_val:  -2 , accidental:  "bb" }  ,
            'D':    { index:  1 , int_val:  2  , accidental:   null } ,
            'DN':   { index:  1 , int_val:  2  , accidental:   "n" }  ,
            'D#':   { index:  1 , int_val:  3  , accidental:   "#" }  ,
            'D##':  { index:  1 , int_val:  4  , accidental:   "##" } ,
            'DB':   { index:  1 , int_val:  1  , accidental:   "b" }  ,
            'DBB':  { index:  1 , int_val:  0  , accidental:   "bb" } ,
            'E':    { index:  2 , int_val:  4  , accidental:   null } ,
            'EN':   { index:  2 , int_val:  4  , accidental:   "n" }  ,
            'E#':   { index:  2 , int_val:  5  , accidental:   "#" }  ,
            'E##':  { index:  2 , int_val:  6  , accidental:   "##" } ,
            'EB':   { index:  2 , int_val:  3  , accidental:   "b" }  ,
            'EBB':  { index:  2 , int_val:  2  , accidental:   "bb" } ,
            'F':    { index:  3 , int_val:  5  , accidental:   null } ,
            'FN':   { index:  3 , int_val:  5  , accidental:   "n" }  ,
            'F#':   { index:  3 , int_val:  6  , accidental:   "#" }  ,
            'F##':  { index:  3 , int_val:  7  , accidental:   "##" } ,
            'FB':   { index:  3 , int_val:  4  , accidental:   "b" }  ,
            'FBB':  { index:  3 , int_val:  3  , accidental:   "bb" } ,
            'G':    { index:  4 , int_val:  7  , accidental:   null } ,
            'GN':   { index:  4 , int_val:  7  , accidental:   "n" }  ,
            'G#':   { index:  4 , int_val:  8  , accidental:   "#" }  ,
            'G##':  { index:  4 , int_val:  9  , accidental:   "##" } ,
            'GB':   { index:  4 , int_val:  6  , accidental:   "b" }  ,
            'GBB':  { index:  4 , int_val:  5  , accidental:   "bb" } ,
            'A':    { index:  5 , int_val:  9  , accidental:   null } ,
            'AN':   { index:  5 , int_val:  9  , accidental:   "n" }  ,
            'A#':   { index:  5 , int_val:  10 , accidental:  "#" }   ,
            'A##':  { index:  5 , int_val:  11 , accidental:  "##" }  ,
            'AB':   { index:  5 , int_val:  8  , accidental:   "b" }  ,
            'ABB':  { index:  5 , int_val:  7  , accidental:   "bb" } ,
            'B':    { index:  6 , int_val:  11 , accidental:  null }  ,
            'BN':   { index:  6 , int_val:  11 , accidental:  "n" }   ,
            'B#':   { index:  6 , int_val:  12 , accidental:  "#" }   ,
            'B##':  { index:  6 , int_val:  13 , accidental:  "##" }  ,
            'BB':   { index:  6 , int_val:  10 , accidental:  "b" }   ,
            'BBB':  { index:  6 , int_val:  9  , accidental:   "bb" } ,
            'R':    { index:  6 , int_val:  9  , rest:         YES } , // Rest
            'X':    {
            index:        6,
            accidental:   "",
            octave:       4,
            code:         "v3e",
            shift_right:  5.5
            }
        };

        var expectedNoteGlyph = {
            // Diamond /
            'D0':  { code: "v27", shift_right: -0.5 },
            'D1':  { code: "v2d", shift_right: -0.5 },
            'D2':  { code: "v22", shift_right: -0.5 },
            'D3':  { code: "v70", shift_right: -0.5 },

            // Triangle /
            'T0':  { code: "v49", shift_right: -2 },
            'T1':  { code: "v93", shift_right: 0.5 },
            'T2':  { code: "v40", shift_right: 0.5 },
            'T3':  { code: "v7d", shift_right: 0.5 },

            // Cross
            'X0':  { code: "v92", shift_right: -2 },
            'X1':  { code: "v95", shift_right: -0.5 },
            'X2':  { code: "v7f", shift_right: 0.5 },
            'X3':  { code: "v3b", shift_right: -2 }
        };

        deepEqual(Vex.Flow.keyProperties.note_values, expectedNoteValues, 'Found expected values successfully');
        deepEqual(Vex.Flow.keyProperties.note_glyph, expectedNoteGlyph, 'Found expected values successfully');

        throws( function() {
            Vex.Flow.keyProperties('invalid');
        }, 'Throws exception on invalid key' );
        throws( function() {
            Vex.Flow.keyProperties('h/5');
        }, 'Throws exception on invalid key' );

        var expected = {
        key:          "C",
        octave:       "5",
        line:         3.5,
        int_value:    60,
        accidental:   null,
        code:         undefined,
        stroke:       0,
        shift_right:  undefined,
        displaced:    NO,
        };
        var key = 'c/5';
        deepEqual( Vex.Flow.keyProperties(key), expected, 'Successfully got properties for key [' + key + '] and default
    clef');

        var clef = 'bass';
        expected.line = 9.5;
        deepEqual( Vex.Flow.keyProperties(key, clef), expected, 'Successfully got properties for key [' + key + '] and
    clef
    [' + clef + ']');

    };
     */
}

- (void)integerToNote
{
    /*
    Vex.Flow.Test.Table.integerToNote = function() {
        var expected = {
            0: "C",
            1: "C#",
            2: "D",
            3: "D#",
            4: "E",
            5: "F",
            6: "F#",
            7: "G",
            8: "G#",
            9: "A",
            10: "A#",
            11: "B"
        };

        deepEqual( Vex.Flow.integerToNote.table, expected, 'Found expected value successfully' );

        throws( function() {
            Vex.Flow.integerToNote();
        }, 'Throws exception on undefined integer');
        throws( function() {
            Vex.Flow.integerToNote(-3);
        }, 'Throws exception on integer < -2');
        throws( function() {
            Vex.Flow.integerToNote(12);
        }, 'Throws exception on unknown value');

        equal( Vex.Flow.integerToNote(1), 'C#', 'Successfully got expected value' );

    };
     */
}

- (void)tabToGlyph
{
    /*
    Vex.Flow.Test.Table.tabToGlyph = function() {

        var fret = '1';
        var expected = {
        text:     fret,
        code:     null,
        width:    6,
        shift_y:  0
        };

        deepEqual( Vex.Flow.tabToGlyph(fret), expected, 'Successfully got the expected value for fret ['+ fret + ']' );

        fret = 'X';
        expected.text    = fret;
        expected.code    = 'v7f';
        expected.width   = 7;
        expected.shift_y = -4.5;
        deepEqual( Vex.Flow.tabToGlyph(fret), expected, 'Successfully got the expected value for fret ['+ fret + ']' );

    };
     */
}

- (void)articulationCodes
{
    /*
    Vex.Flow.Test.Table.articulationCodes = function() {
        var expected = {
            "a.": {   // Staccato
            code:           "v23",
            width:          4,
            shift_right:    -2,
            shift_up:       8,
            shift_down:     0,
            between_lines:  YES
            },
            "av": {   // Staccatissimo
            code:           "v28",
            width:          4,
            shift_right:    0,
            shift_up:       11,
            shift_down:     5,
            between_lines:  YES
            },
            "a>": {   // Accent
            code:           "v42",
            width:          10,
            shift_right:    5,
            shift_up:       8,
            shift_down:     1,
            between_lines:  YES
            },
            "a-": {   // Tenuto
            code:           "v25",
            width:          9,
            shift_right:    -4,
            shift_up:       17,
            shift_down:     10,
            between_lines:  YES
            },
            "a^": {   // Marcato
            code:           "va",
            width:          8,
            shift_right:    0,
            shift_up:       -4,
            shift_down:     -2,
            between_lines:  NO
            },
            "a+": {   // Left hand pizzicato
            code:           "v8b",
            width:          9,
            shift_right:    -4,
            shift_up:       12,
            shift_down:     12,
            between_lines:  NO
            },
            "ao": {   // Snap pizzicato
            code:           "v94",
            width:          8,
            shift_right:    0,
            shift_up:       -4,
            shift_down:     6,
            between_lines:  NO
            },
            "ah": {   // Natural harmonic or open note
            code:           "vb9",
            width:          7,
            shift_right:    0,
            shift_up:       -4,
            shift_down:     4,
            between_lines:  NO
            },
            "a@a": {   // Fermata above staff
            code:           "v43",
            width:          25,
            shift_right:    0,
            shift_up:       8,
            shift_down:     10,
            between_lines:  NO
            },
            "a@u": {   // Fermata below staff
            code:           "v5b",
            width:          25,
            shift_right:    0,
            shift_up:       0,
            shift_down:     -4,
            between_lines:  NO
            },
            "a|": {   // Bow up - up stroke
            code:           "v75",
            width:          8,
            shift_right:    0,
            shift_up:       8,
            shift_down:     10,
            between_lines:  NO
            },
            "am": {   // Bow down - down stroke
            code:           "v97",
            width:          13,
            shift_right:    0,
            shift_up:       10,
            shift_down:     12,
            between_lines:  NO
            },
            "a,": {   // Choked
            code:           "vb3",
            width:          6,
            shift_right:    8,
            shift_up:       -4,
            shift_down:     4,
            between_lines:  NO
            }
        };

        deepEqual( Vex.Flow.articulationCodes.articulations, expected, 'Found expected values successfully');

        var artic = 'a.';
        deepEqual( Vex.Flow.articulationCodes(artic), expected[artic], 'Successfully got the value for articulation [' +
    artic + ']' );

    };
     */
}

- (void)accidentalCodes
{
    /*
    Vex.Flow.Test.Table.accidentalCodes = function() {
        var expected = {
            "#": {
            code:         "v18",
            width:        10,
            shift_right:  0,
            shift_down:   0
            },
            "##": {
            code:         "v7f",
            width:        13,
            shift_right:  -1,
            shift_down:   0
            },
            "b": {
            code:         "v44",
            width:        8,
            shift_right:  0,
            shift_down:   0
            },
            "bb": {
            code:         "v26",
            width:        14,
            shift_right:  -3,
            shift_down:   0
            },
            "n": {
            code:         "v4e",
            width:        8,
            shift_right:  0,
            shift_down:   0
            },
            "{": {   // Left paren for cautionary accidentals
            code:         "v9c",
            width:        5,
            shift_right:  2,
            shift_down:   0
            },
            "}": {   // Right paren for cautionary accidentals
            code:         "v84",
            width:        5,
            shift_right:  0,
            shift_down:   0
            }
        };

        deepEqual( Vex.Flow.accidentalCodes.accidentals, expected, 'Found expected values successfully');

        var acc = '#';
        deepEqual( Vex.Flow.accidentalCodes(acc), expected[acc], 'Successfully got the value for accidental [' + acc +
    ']'
    );

    };
     */
}

- (void)keySignature
{
    /*
    Vex.Flow.Test.Table.keySignature = function() {
        var expected = {
            "C":    {acc:  null, num:  0},
            "Am":   {acc:  null, num:  0},
            "F":    {acc:  "b", num:   1},
            "Dm":   {acc:  "b", num:   1},
            "Bb":   {acc:  "b", num:   2},
            "Gm":   {acc:  "b", num:   2},
            "Eb":   {acc:  "b", num:   3},
            "Cm":   {acc:  "b", num:   3},
            "Ab":   {acc:  "b", num:   4},
            "Fm":   {acc:  "b", num:   4},
            "Db":   {acc:  "b", num:   5},
            "Bbm":  {acc:  "b", num:   5},
            "Gb":   {acc:  "b", num:   6},
            "Ebm":  {acc:  "b", num:   6},
            "Cb":   {acc:  "b", num:   7},
            "Abm":  {acc:  "b", num:   7},
            "G":    {acc:  "#", num:   1},
            "Em":   {acc:  "#", num:   1},
            "D":    {acc:  "#", num:   2},
            "Bm":   {acc:  "#", num:   2},
            "A":    {acc:  "#", num:   3},
            "F#m":  {acc:  "#", num:   3},
            "E":    {acc:  "#", num:   4},
            "C#m":  {acc:  "#", num:   4},
            "B":    {acc:  "#", num:   5},
            "G#m":  {acc:  "#", num:   5},
            "F#":   {acc:  "#", num:   6},
            "D#m":  {acc:  "#", num:   6},
            "C#":   {acc:  "#", num:   7},
            "A#m":  {acc:  "#", num:   7}
        };

        deepEqual( Vex.Flow.keySignature.keySpecs, expected, 'Found expected values successfully');

        throws(function() {
            [VFKeySignature keySignatureWithKey:);
        }, 'Throws exception on undefined spec');

        deepEqual( [VFKeySignature keySignatureWithKey:'C'), [], 'Successfully got expected value for null acc' );

        expected = [
                    {
                    glyphCode: "v44",
                    line: 2
                    }
                    ];
        deepEqual( [VFKeySignature keySignatureWithKey:'F'), expected, 'Successfully got expected value' );

    };
     */
}
- (void)accidentalList
{
    /*
    Vex.Flow.Test.Table.accidentalList = function() {
        var expected = [2, 0.5, 2.5, 1, 3, 1.5, 3.5];
        var acc = 'b';
        deepEqual( Vex.Flow.keySignature.accidentalList(acc), expected, 'Successfully got the value for acc ['+acc+']'
    );

        expected = [0, 1.5, -0.5, 1, 2.5, 0.5, 2];
        acc = '#';
        deepEqual( Vex.Flow.keySignature.accidentalList(acc), expected, 'Successfully got the value for acc ['+acc+']'
    );
    };
     */
}

- (void)noteDuration
{
    /*
    Vex.Flow.Test.Table.noteDuration = function() {

        var expectedDurationToTicks = {
            "1":    kRESOLUTION / 1,
            "2":    kRESOLUTION / 2,
            "4":    kRESOLUTION / 4,
            "8":    kRESOLUTION / 8,
            "16":   kRESOLUTION / 16,
            "32":   kRESOLUTION / 32,
            "64":   kRESOLUTION / 64,
            "128":  kRESOLUTION / 128,
            "256":  kRESOLUTION / 256
        };
        deepEqual( Vex.Flow.durationToTicks.durations, expectedDurationToTicks, 'Found expected values successfully');

        var expectedDurationAliases = {
            "w": "1",
            "h": "2",
            "q": "4",
            "b": "256"
        };
        deepEqual( Vex.Flow.durationAliases, expectedDurationAliases, 'Found expected values successfully');

    };
     */
}

- (void)durationToGlyph
{
    /*
    Vex.Flow.Test.Table.durationToGlyph = function() {
        var expected = {
            "1": {
            common: {
            head_width: 15.5,
            stem: NO,
            stem_offset: 0,
            flag: NO,
            dot_shiftY: 0,
            line_above: 0,
            line_below: 0
            },
            type: {
                "n": { // Whole note
                code_head: "v1d"
                },
                "h": { // Whole note harmonic
                code_head: "v46"
                },
                "m": { // Whole note muted
                code_head: "v92",
                stem_offset: -3
                },
                "r": { // Whole rest
                code_head: "v5c",
                head_width: 12.5,
                rest: YES,
                position: "D/5",
                dot_shiftY: 0.5
                },
                "s": { // Whole note slash
                    // Drawn with canvas primitives
                head_width: 15,
                position: "B/4"
                }
            }
            },
            "2": {
            common: {
            head_width: 9.5,
            stem: YES,
            stem_offset: 0,
            flag: NO,
            dot_shiftY: 0,
            line_above: 0,
            line_below: 0
            },
            type: {
                "n": { // Half note
                code_head: "v81"
                },
                "h": { // Half note harmonic
                code_head: "v2d"
                },
                "m": { // Half note muted
                code_head: "v95",
                stem_offset: -3
                },
                "r": { // Half rest
                code_head: "vc",
                head_width: 12.5,
                stem: NO,
                rest: YES,
                position: "B/4",
                dot_shiftY: -0.5
                },
                "s": { // Half note slash
                    // Drawn with canvas primitives
                head_width: 15,
                position: "B/4"
                }
            }
            },
            "4": {
            common: {
            head_width: 9.5,
            stem: YES,
            stem_offset: 0,
            flag: NO,
            dot_shiftY: 0,
            line_above: 0,
            line_below: 0
            },
            type: {
                "n": { // Quarter note
                code_head: "vb"
                },
                "h": { // Quarter harmonic
                code_head: "v22"
                },
                "m": { // Quarter muted
                code_head: "v3e",
                stem_offset: -3
                },
                "r": { // Quarter rest
                code_head: "v7c",
                head_width: 8,
                stem: NO,
                rest: YES,
                position: "B/4",
                dot_shiftY: -0.5,
                line_above: 1.5,
                line_below: 1.5
                },
                "s": { // Quarter slash
                    // Drawn with canvas primitives
                head_width: 15,
                position: "B/4"
                }
            }
            },
            "8": {
            common: {
            head_width: 9.5,
            stem: YES,
            stem_offset: 0,
            flag: YES,
            beam_count: 1,
            code_flag_upstem: "v54",
            code_flag_downstem: "v9a",
            dot_shiftY: 0,
            line_above: 0,
            line_below: 0
            },
            type: {
                "n": { // Eighth note
                code_head: "vb"
                },
                "h": { // Eighth note harmonic
                code_head: "v22"
                },
                "m": { // Eighth note muted
                code_head: "v3e"
                },
                "r": { // Eighth rest
                code_head: "va5",
                stem: NO,
                flag: NO,
                rest: YES,
                position: "B/4",
                dot_shiftY: -0.5,
                line_above: 1.0,
                line_below: 1.0
                },
                "s": { // Eight slash
                    // Drawn with canvas primitives
                head_width: 15,
                position: "B/4"
                }
            }
            },
            "16": {
            common: {
            beam_count: 2,
            head_width: 9.5,
            stem: YES,
            stem_offset: 0,
            flag: YES,
            code_flag_upstem: "v3f",
            code_flag_downstem: "v8f",
            dot_shiftY: 0,
            line_above: 0,
            line_below: 0
            },
            type: {
                "n": { // Sixteenth note
                code_head: "vb"
                },
                "h": { // Sixteenth note harmonic
                code_head: "v22"
                },
                "m": { // Sixteenth note muted
                code_head: "v3e"
                },
                "r": { // Sixteenth rest
                code_head: "v3c",
                head_width: 13,
                stem: NO,
                flag: NO,
                rest: YES,
                position: "B/4",
                dot_shiftY: -0.5,
                line_above: 1.0,
                line_below: 2.0
                },
                "s": { // Sixteenth slash
                    // Drawn with canvas primitives
                head_width: 15,
                position: "B/4"
                }
            }
            },
            "32": {
            common: {
            beam_count: 3,
            head_width: 9.5,
            stem: YES,
            stem_offset: 0,
            flag: YES,
            code_flag_upstem: "v47",
            code_flag_downstem: "v2a",
            dot_shiftY: 0,
            line_above: 0,
            line_below: 0
            },
            type: {
                "n": { // Thirty-second note
                code_head: "vb"
                },
                "h": { // Thirty-second harmonic
                code_head: "v22"
                },
                "m": { // Thirty-second muted
                code_head: "v3e"
                },
                "r": { // Thirty-second rest
                code_head: "v55",
                head_width: 16,
                stem: NO,
                flag: NO,
                rest: YES,
                position: "B/4",
                dot_shiftY: -1.5,
                line_above: 2.0,
                line_below: 2.0
                },
                "s": { // Thirty-second slash
                    // Drawn with canvas primitives
                head_width: 15,
                position: "B/4"
                }
            }
            },
            "64": {
            common: {
            beam_count: 4,
            head_width: 9.5,
            stem: YES,
            stem_offset: 0,
            flag: YES,
            code_flag_upstem: "va9",
            code_flag_downstem: "v58",
            dot_shiftY: 0,
            line_above: 0,
            line_below: 0
            },
            type: {
                "n": { // Sixty-fourth note
                code_head: "vb"
                },
                "h": { // Sixty-fourth harmonic
                code_head: "v22"
                },
                "m": { // Sixty-fourth muted
                code_head: "v3e"
                },
                "r": { // Sixty-fourth rest
                code_head: "v38",
                head_width: 18,
                stem: NO,
                flag: NO,
                rest: YES,
                position: "B/4",
                dot_shiftY: -1.5,
                line_above: 2.0,
                line_below: 3.0
                },
                "s": { // Sixty-fourth slash
                    // Drawn with canvas primitives
                head_width: 15,
                position: "B/4"
                }
            }
            },
            "128": {
            common: {
            beam_count: 5,
            head_width: 9.5,
            stem: YES,
            stem_offset:0,
            flag: YES,
            code_flag_upstem: "v9b",
            code_flag_downstem: "v30",
            dot_shiftY: 0,
            line_above: 0,
            line_below: 0
            },
            type: {
                "n": {  // Hundred-twenty-eight note
                code_head: "vb"
                },
                "h": { // Hundred-twenty-eight harmonic
                code_head: "v22"
                },
                "m": { // Hundred-twenty-eight muted
                code_head: "v3e"
                },
                "r": {  // Hundred-twenty-eight rest
                code_head: "vaa",
                head_width: 20,
                stem: NO,
                flag: NO,
                rest: YES,
                position: "B/4",
                dot_shiftY: 1.5,
                line_above: 3.0,
                line_below: 3.0
                },
                "s": { // Hundred-twenty-eight rest
                    // Drawn with canvas primitives
                head_width: 15,
                position: "B/4"
                }
            }
            }
        };

        deepEqual( Vex.Flow.durationToGlyph.duration_codes, expected, 'Found expected values successfully');

        expected = {
        code_head:    "v1d",
        dot_shiftY:   0,
        flag:         NO,
        head_width:   15.5,
        line_above:   0,
        line_below:   0,
        stem:         NO,
        stem_offset:  0
        };
        var dur = 'w';
        deepEqual( Vex.Flow.durationToGlyph(dur), expected, 'Successfuly got the value for duration [' + dur + ']');
    };
     */
}

- (void)misc
{
    /*
    Vex.Flow.Test.Table.misc = function() {
        var expected = {
        num_beats: 4,
        beat_value: 4,
        resolution: kRESOLUTION
        };
        deepEqual( Vex.Flow.TIME4_4, expected, 'Found expected values successfully' );

        equal( Vex.Flow.STEM_WIDTH, 1.5, 'Found expected values for stem width' );
        equal( Vex.Flow.STEM_HEIGHT, 35, 'Found expected values for stem height' );
        equal( Vex.Flow.STAVE_LINE_THICKNESS, 2, 'Found expected values for staff line thickness' );

    };

    */
}

@end
