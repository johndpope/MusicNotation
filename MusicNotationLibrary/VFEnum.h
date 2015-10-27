//
//  VFEnum.h
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

@import Foundation;

/** Position
 */
typedef NS_ENUM(NSUInteger, VFPositionType)
{
    VFPositionLeft = 1,
    VFPositionRight = 2,
    VFPositionAbove = 3,
    VFPositionBelow = 4,
    VFPositionCenter = 5,
};

typedef NS_ENUM(NSUInteger, VFShiftDirectionType)
{
    VFShiftUp = 1,
    VFShiftDown = -1,
    VFShiftLeft = 2,
    VFShiftRight = 3,
};

///** Renderer
// */
// typedef enum _VFRendererBackendsType : NSUInteger {
//    VFRendererCanvas = 1,
//    VFRendererRaphael = 2,
//    VFRendererSVG = 3,
//    VFRendererVML = 4,
//} VFRendererBackendsType;

/** Renderer line ending
 */
typedef NS_ENUM(NSUInteger, VFRendererLineEndType)
{
    VFLineEndNone = 1,
    VFLineEndUp = 2,
    VFLineEndDown = 3,
};

/** Note
 */
typedef NS_ENUM(NSUInteger, VFNoteNHMRSType)
{
    VFNoteNone = 0,
    VFNoteX = VFNoteNone,   // none ?
    VFNoteSlash = 1,        // slash
    VFNoteHarmonic = 2,     // harmonic
    VFNoteRest = 3,         // rest
    VFNoteNote = 4,         //
    VFNoteMuted = 5,        // muted
};

/** durations
 */
typedef NS_ENUM(NSUInteger, VFBarNoteType)
{
    VFBarNoteSingle = 1,
    VFBarNoteDouble = 2,
    VFBarNoteEnd = 3,
    VFBarNoteRepeatBegin = 4,
    VFBarNoteRepeatEnd = 5,
    VFBarNoteRepeatBoth = 6,
    VFBarNoteNone = 7,
};

/** Bar line
 */
typedef NS_ENUM(NSUInteger, VFBarLineType)
{
    VFBarLineNone = 0,
    VFBarLineSingle = 1,
    VFBarLineDouble = 2,
    VFBarLineEnd = 3,
    VFBarLineRepeatBegin = 4,
    VFBarLineRepeatEnd = 5,
    VFBarLineRepeatBoth = 6,
};

/** Clef
 */
typedef NS_ENUM(NSUInteger, VFClefType)
{
    VFClefNone = 0,
    VFClefTreble = 1,         // "treble"
    VFClefBass = 2,           // "bass"
    VFClefAlto = 3,           // "alto"
    VFClefTenor = 4,          // "tenor"
    VFClefPercussion = 5,     // "percussion"
    VFClefSoprano = 6,        // "soprano"
    VFClefMezzoSoprano = 7,   // "mezzo-soprano"
    VFClefBaritoneC = 8,      // "baritone-c"
    VFClefBaritoneF = 9,      // "baritone-f"
    VFClefSubBass = 10,       // "subbass"
    VFClefFrench = 11,        // "french"
    VFClefMovableC = 12,      // "moveable-c"
};

/* Stem direction
 */
typedef NS_ENUM(NSInteger, VFStemDirectionType)
{
    VFStemDirectionUp = 1,
    VFStemDirectionNone = 0,
    VFStemDirectionDown = -1,
};

/** Log level
 */
typedef NS_ENUM(NSInteger, VFLogLevelType)
{
    debug = 1,
    info = 2,
    logWarn = 3,
    error = 4,
    fatal = 5,
};

/** Modes allow the addition of ticks in three different ways:
 *
 *  STRICT: This is the default. Ticks must fill the voice.
 *  SOFT:   Ticks can be added without restrictions.
 *  FULL:   Ticks do not need to fill the voice, but can't exceed the maximum
 *      tick length.
 */
typedef NS_ENUM(NSUInteger, VFModeType)
{
    //    None = 0,
    VFModeStrict = 1,
    VFModeSoft = 2,
    VFModeFull = 3,
};

/** Standard time signatures
 */
typedef NS_ENUM(NSUInteger, VFTimeType)
{
    VFTime4_4 = 1,
    VFTime3_4 = 2,
    VFTime2_4 = 3,
    VFTime4_2 = 4,
    VFTime2_2 = 5,
    VFTime3_8 = 6,
    VFTime6_8 = 7,
    VFTime9_8 = 8,
    VFTime12_8 = 9,

    VFTime1_2 = 10,
    VFTime3_2 = 11,
    VFTime1_4 = 12,
    VFTime1_8 = 13,
    VFTime2_8 = 14,
    VFTime4_8 = 15,
    VFTime1_16 = 16,
    VFTime2_16 = 17,
    VFTime3_16 = 18,
    VFTime4_16 = 19,

    // TODO : add this to methods
    VFTimeC = 20,
    VFTime5_4 = 21,
    VFTime5_8 = 22,
    VFTime13_16 = 23,
};

/** stroke direction
 */
typedef NS_ENUM(NSInteger, VFStrokeDirectionType)
{
    VFStrokeDirectionDown = -1,
    VFStrokeDirectionUp = 1,
};

/** curve direction
 */
typedef NS_ENUM(NSInteger, VFCurveDirectionType)
{
    VFCurveDirectionDown = -1,
    VFCurveDirectionUp = 1,
};

/** stroke types
 */
typedef NS_ENUM(NSUInteger, VFStrokeType)
{
    VFStrokeBrushDown = 1,
    VFStrokeBrushUp = 2,
    VFStrokeRollDown = 3,   // Arpegiated chord
    VFStrokeRollUp = 4,     // Arpegiated chord
    VFStrokeRasquedoDown = 5,
    VFStrokeRasquedoUp = 6,
};

/** Note durations
 */
typedef NS_ENUM(NSInteger, VFNoteDurationType)
{
    VFDurationNone = -1,
    VFDurationBreveNote = 0,
    VFDurationWholeNote = 1,
    VFDurationHalfNote = 2,
    VFDurationQuarterNote = 4,
    VFDurationEighthNote = 8,
    VFDurationSixteenthNote = 16,
    VFDurationThirtyTwoNote = 32,
    VFDurationSixtyFourNote = 64,
    VFDurationOneTwentyEightNote = 128,
    VFDurationTwoFiftySixNote = 256,
};

/** tuplet types
 */
typedef NS_ENUM(NSUInteger, VFTupletLocationType)
{
    VFTupletLocationNone = 0,
    VFTupletLocationTop = 1,
    VFTupletLocationBottom = -1,
};

///** staff connector types
// */
// typedef NS_ENUM(NSUInteger, VFStaffConnectorType) {
//    VFStaffConnectorSingle = 1,
//    VFStaffConnectorDouble = 2,
//    VFStaffConnectorBrace = 3,
//    VFStaffConnectorBracket = 4,
//};

/** key signatures
 */
typedef NS_ENUM(NSUInteger, VFKeySignatureFlavorType)
{
    VFKeySignatureNone = 0,         //
    VFKeySignatureSharp = 1,        // "sharp"
    VFKeySignatureFlat = 2,         // "flat"
    VFKeySignatureNatural = 3,      // "natural"
    VFKeySignatureTriangle = 4,     // "triangle"
    VFKeySignatureOWithSlash = 5,   // "o-with-slash"
    VFKeySignatureDegrees = 6,      // "degrees"
    VFKeySignatureCircle = 7,       // "circle"
};

/** types of modifier categories
 */
typedef NS_ENUM(NSUInteger, VFSymbolCategoryType)
{
    VFSymbolCategoryStaffNote = 0,
    VFSymbolCategoryTabNote = 1,
    VFSymbolCategoryAccidental = 2,
    VFSymbolCategoryArticulation = 3,
    VFSymbolCategoryBeam = 4,
    VFSymbolCategoryStaffBarLine = 5,
    VFSymbolCategoryStaffConnector = 6,
};

/** staff repetition type
 */
typedef NS_ENUM(NSUInteger, VFRepetitionType)
{
    VFRepNone = 1,         // no coda or segno
    VFRepCodaLeft = 2,     // coda at beginning of Staff
    VFRepCodaRight = 3,    // coda at end of Staff
    VFRepSegnoLeft = 4,    // segno at beginning of Staff
    VFRepSegnoRight = 5,   // segno at end of Staff
    VFRepDC = 6,           // D.C. at end of Staff
    VFRepDCALCoda = 7,     // D.C. al coda at end of Staff
    VFRepDCALFine = 8,     // D.C. al Fine end of Staff
    VFRepDS = 9,           // D.S. at end of Staff
    VFRepDSALCoda = 10,    // D.S. al coda at end of Staff
    VFRepDSALFine = 11,    // D.S. al Fine at end of Staff
    VFRepFine = 12,        // Fine at end of Staff
};

/** volta type
 */
typedef NS_ENUM(NSUInteger, VFVoltaType)
{
    VFVoltaNona = 1,
    VFVoltaBegin = 2,
    VFVoltaMid = 3,
    VFVoltaEnd = 4,
    VFVoltaBeginEnd = 5,
};

/** articulation type
 */
typedef NS_ENUM(NSUInteger, VFArticulationType)
{
    VFArticulationStacato = 0,                     //  a.
    VFArticulationStaccatissimo = 1,               //  av
    VFArticulationAccent = 2,                      //  a>
    VFArticulationTenuto = 3,                      //  a-
    VFArticulationMarcato = 4,                     //  a^
    VFArticulationLeftHandPizzicato = 5,           //  a+
    VFArticulationSnapPizzicato = 6,               //  ao
    VFArticulationNaturalHarmonicOrOpenNote = 7,   //  ah
    VFArticulationFermataAboveStaff = 8,           //  a@a
    VFArticulationFermataBelowStaff = 9,           //  a@u
    VFArticulationBowUpDashUpStroke = 10,          //  a|
    VFArticulationBowDownDashDownStroke = 11,      //  am
    VFArticulationChoked = 12,                     //  a,
};

typedef NS_ENUM(NSUInteger, VFStaffConnectorType)
{
    VFStaffConnectorNone = 0,
    VFStaffConnectorSingleRight = 1,
    VFStaffConnectorSingleLeft = 2,
    VFStaffConnectorSingle = 3,
    VFStaffConnectorDouble = 4,
    VFStaffConnectorBrace = 5,
    VFStaffConnectorBracket = 6,
    VFStaffConnectorBoldDoubleLeft = 7,
    VFStaffConnectorBoldDoubleRight = 8,
    VFStaffConnectorThinDouble = 9
};

typedef NS_ENUM(NSUInteger, VFJustiticationType)
{
    VFJustifyLEFT = 1,
    VFJustifyCENTER = 2,
    VFJustifyRIGHT = 3,
    VFJustifyCENTER_STEM = 4
};

typedef NS_ENUM(NSUInteger, VFVerticalJustifyType)
{
    VFVerticalJustifyTOP = 1,
    VFVerticalJustifyCENTER = 2,
    VFVerticalJustifyBOTTOM = 3,
    VFVerticalJustifyCENTER_STEM = 4
};

typedef NS_ENUM(NSUInteger, VFStaffLineJustiticationType)
{
    VFStaffLineJustifyLEFT = 1,
    VFStaffLineJustifyCENTER = 2,
    VFStaffLineJustifyRIGHT = 3,
};

typedef NS_ENUM(NSUInteger, VFStaffLineVerticalJustifyType)
{
    VFStaffLineVerticalJustifyTOP = 1,
    VFStaffLineVerticalJustifyBOTTOM = 2,
};

// typedef NS_ENUM(NSUInteger, VFBendType) {
//    VFBendUP   = 0,
//    VFBendDOWN = 1,
//};

typedef NS_ENUM(NSUInteger, VFBendDirectionType)
{
    VFBendUP = 1,
    VFBendNONE = 0,
    VFBendX = VFBendNONE,
    VFBendDOWN = -1,
};

typedef NS_ENUM(NSUInteger, VFOrnamentType)
{
    VFOrnament_MORDENT = 0,
    VFOrnament_MORDENT_INVERTED = 1,
    VFOrnament_TURN = 2,
    VFOrnament_TURN_INVERTED = 3,
    VFOrnament_TR = 4,
    VFOrnament_UPPRALL = 5,
    VFOrnament_DOWNPRALL = 6,
    VFOrnament_PRALLUP = 7,
    VFOrnament_PRALLDOWN = 8,
    VFOrnament_UPMORDENT = 9,
    VFOrnament_DOWNMORDENT = 10,
    VFOrnament_LINEPRALL = 11,
    VFOrnament_PRALLPRALL = 12,
};

typedef NS_ENUM(NSUInteger, VFAccidentalType)
{
    VFAccidental_Hash = 0,
    VFAccidental_HashHash = 1,
    VFAccidental_b = 2,
    VFAccidental_bb = 3,
    VFAccidental_n = 4,
    VFAccidental_LeftParen = 5,
    VFAccidental_RightParen = 6,
    VFAccidental_db = 7,
    VFAccidental_d = 8,
    VFAccidental_bbs = 9,
    VFAccidental_PlusPlus = 10,
    VFAccidental_Plus = 11,
};

typedef NS_ENUM(NSUInteger, VFKeySignatureType)
{
    VFKeySignature_C = 0,          //    "C"
    VFKeySignature_Am = 1,         //    "Am"
    VFKeySignature_F = 2,          //    "F"
    VFKeySignature_Dm = 3,         //    "Dm"
    VFKeySignature_Bb = 4,         //    "Bb"
    VFKeySignature_Gm = 5,         //    "Gm"
    VFKeySignature_Eb = 6,         //    "Eb"
    VFKeySignature_Cm = 7,         //    "Cm"
    VFKeySignature_Ab = 8,         //    "Ab"
    VFKeySignature_Fm = 9,         //    "Fm"
    VFKeySignature_Db = 10,        //    "Db"
    VFKeySignature_Bbm = 11,       //    "Bbm"
    VFKeySignature_Gb = 12,        //    "Gb"
    VFKeySignature_Ebm = 13,       //    "Ebm"
    VFKeySignature_Cb = 14,        //    "Cb"
    VFKeySignature_Abm = 15,       //    "Abm"
    VFKeySignature_G = 16,         //    "G"
    VFKeySignature_Em = 17,        //    "Em"
    VFKeySignature_D = 18,         //    "D"
    VFKeySignature_Bm = 19,        //    "Bm"
    VFKeySignature_A = 20,         //    "A"
    VFKeySignature_FSharpm = 21,   //    "F#m"
    VFKeySignature_E = 22,         //    "E"
    VFKeySignature_CSharpm = 23,   //    "C#m"
    VFKeySignature_B = 24,         //    "B"
    VFKeySignature_GSharpm = 25,   //    "G#m"
    VFKeySignature_FSharp = 26,    //    "F#"
    VFKeySignature_DSharpm = 27,   //    "D#m"
    VFKeySignature_CSharp = 28,    //    "C#"
    VFKeySignature_ASharpm = 29,   //    "A#m"
};

typedef NS_ENUM(NSUInteger, VFNotePitchType)
{
    VFNotePitch_C = 0,          //    "C"
    VFNotePitch_C_SHARP = 1,    //    "C#"
    VFNotePitch_D = 2,          //    "D"
    VFNotePitch_D_SHARP = 3,    //    "D#"
    VFNotePitch_E = 4,          //    "E"
    VFNotePitch_F = 5,          //    "F"
    VFNotePitch_F_SHARP = 6,    //    "F#"
    VFNotePitch_G = 7,          //    "G"
    VFNotePitch_G_SHARP = 8,    //    "G#"
    VFNotePitch_A = 9,          //    "A"
    VFNotePitch_A_SHARP = 10,   //    "A#"
    VFNotePitch_B = 11,         //    "B"
};

typedef NS_ENUM(NSInteger, VFStaffHairpinType)
{
    VFStaffHairpinCres = 1,
    VFStaffHairpinDescres = 2,
};

typedef NS_ENUM(NSInteger, VFCurveType)
{
    VFCurveNearHead = 1,
    VFCurveNearTop = 2,
};

typedef NS_ENUM(NSUInteger, VFGlyphNameType)
{
    VFGlyphName_v0 = 0,
    VFGlyphName_v1 = 1,
    VFGlyphName_v2 = 2,
    VFGlyphName_v3 = 3,
    VFGlyphName_v4 = 4,
    VFGlyphName_v5 = 5,
    VFGlyphName_v6 = 6,
    VFGlyphName_v7 = 7,
    VFGlyphName_v8 = 8,
    VFGlyphName_v9 = 9,
    VFGlyphName_va = 10,
    VFGlyphName_vb = 11,
    VFGlyphName_vc = 12,
    VFGlyphName_vd = 13,
    VFGlyphName_ve = 14,
    VFGlyphName_vf = 15,
    VFGlyphName_v10 = 16,
    VFGlyphName_v11 = 17,
    VFGlyphName_v12 = 18,
    VFGlyphName_v13 = 19,
    VFGlyphName_v14 = 20,
    VFGlyphName_v15 = 21,
    VFGlyphName_v16 = 22,
    VFGlyphName_v17 = 23,
    VFGlyphName_v18 = 24,
    VFGlyphName_v19 = 25,
    VFGlyphName_v1a = 26,
    VFGlyphName_v1b = 27,
    VFGlyphName_v1c = 28,
    VFGlyphName_v1d = 29,
    VFGlyphName_v1e = 30,
    VFGlyphName_v1f = 31,
    VFGlyphName_v20 = 32,
    VFGlyphName_v21 = 33,
    VFGlyphName_v22 = 34,
    VFGlyphName_v23 = 35,
    VFGlyphName_v24 = 36,
    VFGlyphName_v25 = 37,
    VFGlyphName_v26 = 38,
    VFGlyphName_v27 = 39,
    VFGlyphName_v28 = 40,
    VFGlyphName_v29 = 41,
    VFGlyphName_v2a = 42,
    VFGlyphName_v2b = 43,
    VFGlyphName_v2c = 44,
    VFGlyphName_v2d = 45,
    VFGlyphName_v2e = 46,
    VFGlyphName_v2f = 47,
    VFGlyphName_v30 = 48,
    VFGlyphName_v31 = 49,
    VFGlyphName_v32 = 50,
    VFGlyphName_v33 = 51,
    VFGlyphName_v34 = 52,
    VFGlyphName_v35 = 53,
    VFGlyphName_v36 = 54,
    VFGlyphName_v37 = 55,
    VFGlyphName_v38 = 56,
    VFGlyphName_v39 = 57,
    VFGlyphName_v3a = 58,
    VFGlyphName_v3b = 59,
    VFGlyphName_v3c = 60,
    VFGlyphName_v3d = 61,
    VFGlyphName_v3e = 62,
    VFGlyphName_v3f = 63,
    VFGlyphName_v40 = 64,
    VFGlyphName_v41 = 65,
    VFGlyphName_v42 = 66,
    VFGlyphName_v43 = 67,
    VFGlyphName_v44 = 68,
    VFGlyphName_v45 = 69,
    VFGlyphName_v46 = 70,
    VFGlyphName_v47 = 71,
    VFGlyphName_v48 = 72,
    VFGlyphName_v49 = 73,
    VFGlyphName_v4a = 74,
    VFGlyphName_v4b = 75,
    VFGlyphName_v4c = 76,
    VFGlyphName_v4d = 77,
    VFGlyphName_v4e = 78,
    VFGlyphName_v4f = 79,
    VFGlyphName_v50 = 80,
    VFGlyphName_v51 = 81,
    VFGlyphName_v52 = 82,
    VFGlyphName_v53 = 83,
    VFGlyphName_v54 = 84,
    VFGlyphName_v55 = 85,
    VFGlyphName_v56 = 86,
    VFGlyphName_v57 = 87,
    VFGlyphName_v58 = 88,
    VFGlyphName_v59 = 89,
    VFGlyphName_v5a = 90,
    VFGlyphName_v5b = 91,
    VFGlyphName_v5c = 92,
    VFGlyphName_v5d = 93,
    VFGlyphName_v5e = 94,
    VFGlyphName_v5f = 95,
    VFGlyphName_v60 = 96,
    VFGlyphName_v61 = 97,
    VFGlyphName_v62 = 98,
    VFGlyphName_v63 = 99,
    VFGlyphName_v64 = 100,
    VFGlyphName_v65 = 101,
    VFGlyphName_v66 = 102,
    VFGlyphName_v67 = 103,
    VFGlyphName_v68 = 104,
    VFGlyphName_v69 = 105,
    VFGlyphName_v6a = 106,
    VFGlyphName_v6b = 107,
    VFGlyphName_v6c = 108,
    VFGlyphName_v6d = 109,
    VFGlyphName_v6e = 110,
    VFGlyphName_v6f = 111,
    VFGlyphName_v70 = 112,
    VFGlyphName_v71 = 113,
    VFGlyphName_v72 = 114,
    VFGlyphName_v73 = 115,
    VFGlyphName_v74 = 116,
    VFGlyphName_v75 = 117,
    VFGlyphName_v76 = 118,
    VFGlyphName_v77 = 119,
    VFGlyphName_v78 = 120,
    VFGlyphName_v79 = 121,
    VFGlyphName_v7a = 122,
    VFGlyphName_v7b = 123,
    VFGlyphName_v7c = 124,
    VFGlyphName_v7d = 125,
    VFGlyphName_v7e = 126,
    VFGlyphName_v7f = 127,
    VFGlyphName_v80 = 128,
    VFGlyphName_v81 = 129,
    VFGlyphName_v82 = 130,
    VFGlyphName_v83 = 131,
    VFGlyphName_v84 = 132,
    VFGlyphName_v85 = 133,
    VFGlyphName_v86 = 134,
    VFGlyphName_v88 = 135,
    VFGlyphName_v89 = 136,
    VFGlyphName_v8a = 137,
    VFGlyphName_v8b = 138,
    VFGlyphName_v8c = 139,
    VFGlyphName_v8d = 140,
    VFGlyphName_v8e = 141,
    VFGlyphName_v8f = 142,
    VFGlyphName_v90 = 143,
    VFGlyphName_v91 = 144,
    VFGlyphName_v92 = 145,
    VFGlyphName_v93 = 146,
    VFGlyphName_v94 = 148,
    VFGlyphName_v95 = 149,
    VFGlyphName_v96 = 150,
    VFGlyphName_v97 = 151,
    VFGlyphName_v98 = 152,
    VFGlyphName_v99 = 153,
    VFGlyphName_v9a = 154,
    VFGlyphName_v9b = 155,
    VFGlyphName_v9c = 156,
    VFGlyphName_v9d = 157,
    VFGlyphName_v9e = 158,
    VFGlyphName_v9f = 159,
    VFGlyphName_va0 = 160,
    VFGlyphName_va1 = 161,
    VFGlyphName_va2 = 162,
    VFGlyphName_va3 = 163,
    VFGlyphName_va4 = 164,
    VFGlyphName_va5 = 165,
    VFGlyphName_va6 = 166,
    VFGlyphName_va7 = 167,
    VFGlyphName_va8 = 168,
    VFGlyphName_va9 = 169,
    VFGlyphName_vaa = 170,
    VFGlyphName_vab = 171,
    VFGlyphName_vac = 172,
    VFGlyphName_vad = 173,
    VFGlyphName_vae = 174,
    VFGlyphName_vaf = 175,
    VFGlyphName_vb0 = 176,
    VFGlyphName_vb1 = 177,
    VFGlyphName_vb2 = 178,
    VFGlyphName_vb3 = 179,
    VFGlyphName_vb4 = 180,
    VFGlyphName_vb5 = 181,
    VFGlyphName_vb6 = 182,
    VFGlyphName_vb7 = 183,
    VFGlyphName_vb8 = 184,
    VFGlyphName_vb9 = 185,
    VFGlyphName_vba = 186,
    VFGlyphName_vbb = 187,
    VFGlyphName_vbc = 188,
    VFGlyphName_vbd = 189,
    VFGlyphName_vbe = 190,
    VFGlyphName_vbf = 191,
    VFGlyphName_vc0 = 192,
    VFGlyphName_vc1 = 193,
    VFGlyphName_vc2 = 194,
    VFGlyphName_vc3 = 195,
};

// TODO: finish naming the notations
// https://www.wikiwand.com/en/List_of_musical_symbols
typedef NS_ENUM(NSUInteger, VFGlyphRealNameType)
{
    VFGlyphRealName_zero = 0,                // v0
    VFGlyphRealName_one = 1,                 // v1
    VFGlyphRealName_two = 2,                 // v2
    VFGlyphRealName_three = 3,               // v3
    VFGlyphRealName_four = 4,                // v4
    VFGlyphRealName_five = 5,                // v5
    VFGlyphRealName_six = 6,                 // v6
    VFGlyphRealName_seven = 7,               // v7
    VFGlyphRealName_eight = 8,               // v8
    VFGlyphRealName_nine = 9,                // v9
    VFGlyphRealName_va = 10,                 // va
    VFGlyphRealName_quarter_note = 11,       // vb
    VFGlyphRealName_vc = 12,                 // vc
    VFGlyphRealName_vd = 13,                 // vd
    VFGlyphRealName_ve = 14,                 // ve
    VFGlyphRealName_vf = 15,                 // vf
    VFGlyphRealName_v10 = 16,                // v10
    VFGlyphRealName_v11 = 17,                // v11
    VFGlyphRealName_v12 = 18,                // v12
    VFGlyphRealName_v13 = 19,                // v13
    VFGlyphRealName_v14 = 20,                // v14
    VFGlyphRealName_v15 = 21,                // v15
    VFGlyphRealName_v16 = 22,                // v16
    VFGlyphRealName_v17 = 23,                // v17
    VFGlyphRealName_v18 = 24,                // v18
    VFGlyphRealName_v19 = 25,                // v19
    VFGlyphRealName_v1a = 26,                // v1a
    VFGlyphRealName_v1b = 27,                // v1b
    VFGlyphRealName_v1c = 28,                // v1c
    VFGlyphRealName_v1d = 29,                // v1d
    VFGlyphRealName_mordent_upper = 30,      // v1e
    VFGlyphRealName_trill = 31,              // v1f
    VFGlyphRealName_v20 = 32,                // v20
    VFGlyphRealName_v21 = 33,                // v21
    VFGlyphRealName_v22 = 34,                // v22
    VFGlyphRealName_v23 = 35,                // v23
    VFGlyphRealName_v24 = 36,                // v24
    VFGlyphRealName_v25 = 37,                // v25
    VFGlyphRealName_v26 = 38,                // v26
    VFGlyphRealName_v27 = 39,                // v27
    VFGlyphRealName_v28 = 40,                // v28
    VFGlyphRealName_v29 = 41,                // v29
    VFGlyphRealName_v2a = 42,                // v2a
    VFGlyphRealName_v2b = 43,                // v2b
    VFGlyphRealName_v2c = 44,                // v2c
    VFGlyphRealName_v2d = 45,                // v2d
    VFGlyphRealName_v2e = 46,                // v2e
    VFGlyphRealName_v2f = 47,                // v2f
    VFGlyphRealName_v30 = 48,                // v30
    VFGlyphRealName_v31 = 49,                // v31
    VFGlyphRealName_v32 = 50,                // v32
    VFGlyphRealName_turn_inverted = 51,      // v33
    VFGlyphRealName_caesura_straight = 52,   // v34
    VFGlyphRealName_v35 = 53,                // v35
    VFGlyphRealName_pedal_open = 54,         // v36
    VFGlyphRealName_v37 = 55,                // v37
    VFGlyphRealName_v38 = 56,                // v38
    VFGlyphRealName_v39 = 57,                // v39
    VFGlyphRealName_v3a = 58,                // v3a
    VFGlyphRealName_v3b = 59,                // v3b
    VFGlyphRealName_v3c = 60,                // v3c
    VFGlyphRealName_v3d = 61,                // v3d
    VFGlyphRealName_v3e = 62,                // v3e
    VFGlyphRealName_v3f = 63,                // v3f
    VFGlyphRealName_v40 = 64,                // v40
    VFGlyphRealName_v41 = 65,                // v41
    VFGlyphRealName_v42 = 66,                // v42
    VFGlyphRealName_v43 = 67,                // v43
    VFGlyphRealName_v44 = 68,                // v44
    VFGlyphRealName_mordent_lower = 69,      // v45
    VFGlyphRealName_v46 = 70,                // v46
    VFGlyphRealName_v47 = 71,                // v47
    VFGlyphRealName_v48 = 72,                // v48
    VFGlyphRealName_v49 = 73,                // v49
    VFGlyphRealName_v4a = 74,                // v4a
    VFGlyphRealName_caesura_curved = 75,     // v4b
    VFGlyphRealName_v4c = 76,                // v4c
    VFGlyphRealName_coda = 77,               // v4d
    VFGlyphRealName_v4e = 78,                // v4e
    VFGlyphRealName_v4f = 79,                // v4f
    VFGlyphRealName_v50 = 80,                // v50
    VFGlyphRealName_v51 = 81,                // v51
    VFGlyphRealName_v52 = 82,                // v52
    VFGlyphRealName_v53 = 83,                // v53
    VFGlyphRealName_v54 = 84,                // v54
    VFGlyphRealName_v55 = 85,                // v55
    VFGlyphRealName_v56 = 86,                // v56
    VFGlyphRealName_v57 = 87,                // v57
    VFGlyphRealName_v58 = 88,                // v58
    VFGlyphRealName_v59 = 89,                // v59
    VFGlyphRealName_v5a = 90,                // v5a
    VFGlyphRealName_v5b = 91,                // v5b
    VFGlyphRealName_v5c = 92,                // v5c
    VFGlyphRealName_pedal_close = 93,        // v5d
    VFGlyphRealName_v5e = 94,                // v5e
    VFGlyphRealName_v5f = 95,                // v5f
    VFGlyphRealName_v60 = 96,                // v60
    VFGlyphRealName_v61 = 97,                // v61
    VFGlyphRealName_v62 = 98,                // v62
    VFGlyphRealName_v63 = 99,                // v63
    VFGlyphRealName_v64 = 100,               // v64
    VFGlyphRealName_v65 = 101,               // v65
    VFGlyphRealName_v66 = 102,               // v66
    VFGlyphRealName_v67 = 103,               // v67
    VFGlyphRealName_v68 = 104,               // v68
    VFGlyphRealName_v69 = 105,               // v69
    VFGlyphRealName_v6a = 106,               // v6a
    VFGlyphRealName_v6b = 107,               // v6b
    VFGlyphRealName_breath = 108,            // v6c
    VFGlyphRealName_v6d = 109,               // v6d
    VFGlyphRealName_v6e = 110,               // v6e
    VFGlyphRealName_tick = 111,              // v6f
    VFGlyphRealName_v70 = 112,               // v70
    VFGlyphRealName_v71 = 113,               // v71
    VFGlyphRealName_turn = 114,              // v72
    VFGlyphRealName_v73 = 115,               // v73
    VFGlyphRealName_v74 = 116,               // v74
    VFGlyphRealName_v75 = 117,               // v75
    VFGlyphRealName_v76 = 118,               // v76
    VFGlyphRealName_v77 = 119,               // v77
    VFGlyphRealName_v78 = 120,               // v78
    VFGlyphRealName_v79 = 121,               // v79
    VFGlyphRealName_v7a = 122,               // v7a
    VFGlyphRealName_v7b = 123,               // v7b
    VFGlyphRealName_v7c = 124,               // v7c
    VFGlyphRealName_v7d = 125,               // v7d
    VFGlyphRealName_v7e = 126,               // v7e
    VFGlyphRealName_v7f = 127,               // v7f
    VFGlyphRealName_v80 = 128,               // v80
    VFGlyphRealName_v81 = 129,               // v81
    VFGlyphRealName_v82 = 130,               // v82
    VFGlyphRealName_v83 = 131,               // v83
    VFGlyphRealName_v84 = 132,               // v84
    VFGlyphRealName_v85 = 133,               // v85
    VFGlyphRealName_v86 = 134,               // v86
    VFGlyphRealName_v88 = 135,               // v88
    VFGlyphRealName_v89 = 136,               // v89
    VFGlyphRealName_v8a = 137,               // v8a
    VFGlyphRealName_v8b = 138,               // v8b
    VFGlyphRealName_segno = 139,             // v8c
    VFGlyphRealName_v8d = 140,               // v8d
    VFGlyphRealName_v8e = 141,               // v8e
    VFGlyphRealName_v8f = 142,               // v8f
    VFGlyphRealName_v90 = 143,               // v90
    VFGlyphRealName_v91 = 144,               // v91
    VFGlyphRealName_v92 = 145,               // v92
    VFGlyphRealName_v93 = 146,               // v93
    VFGlyphRealName_v94 = 148,               // v94
    VFGlyphRealName_v95 = 149,               // v95
    VFGlyphRealName_v96 = 150,               // v96
    VFGlyphRealName_v97 = 151,               // v97
    VFGlyphRealName_v98 = 152,               // v98
    VFGlyphRealName_v99 = 153,               // v99
    VFGlyphRealName_v9a = 154,               // v9a
    VFGlyphRealName_v9b = 155,               // v9b
    VFGlyphRealName_v9c = 156,               // v9c
    VFGlyphRealName_v9d = 157,               // v9d
    VFGlyphRealName_v9e = 158,               // v9e
    VFGlyphRealName_v9f = 159,               // v9f
    VFGlyphRealName_va0 = 160,               // va0
    VFGlyphRealName_va1 = 161,               // va1
    VFGlyphRealName_va2 = 162,               // va2
    VFGlyphRealName_va3 = 163,               // va3
    VFGlyphRealName_va4 = 164,               // va4
    VFGlyphRealName_va5 = 165,               // va5
    VFGlyphRealName_va6 = 166,               // va6
    VFGlyphRealName_va7 = 167,               // va7
    VFGlyphRealName_va8 = 168,               // va8
    VFGlyphRealName_va9 = 169,               // va9
    VFGlyphRealName_vaa = 170,               // vaa
    VFGlyphRealName_vab = 171,               // vab
    VFGlyphRealName_vac = 172,               // vac
    VFGlyphRealName_vad = 173,               // vad
    VFGlyphRealName_vae = 174,               // vae
    VFGlyphRealName_vaf = 175,               // vaf
    VFGlyphRealName_vb0 = 176,               // vb0
    VFGlyphRealName_vb1 = 177,               // vb1
    VFGlyphRealName_vb2 = 178,               // vb2
    VFGlyphRealName_vb3 = 179,               // vb3
    VFGlyphRealName_vb4 = 180,               // vb4
    VFGlyphRealName_vb5 = 181,               // vb5
    VFGlyphRealName_vb6 = 182,               // vb6
    VFGlyphRealName_vb7 = 183,               // vb7
    VFGlyphRealName_vb8 = 184,               // vb8
    VFGlyphRealName_vb9 = 185,               // vb9
    VFGlyphRealName_vba = 186,               // vba
    VFGlyphRealName_vbb = 187,               // vbb
    VFGlyphRealName_vbc = 188,               // vbc
    VFGlyphRealName_vbd = 189,               // vbd
    VFGlyphRealName_vbe = 190,               // vbe
    VFGlyphRealName_vbf = 191,               // vbf
    VFGlyphRealName_vc0 = 192,               // vc0
    VFGlyphRealName_vc1 = 193,               // vc1
    VFGlyphRealName_vc2 = 194,               // vc2
    VFGlyphRealName_vc3 = 195,               // vc3
};

// TODO: update to use https://github.com/fastred/ReflectableEnum

@interface VFEnum : NSObject

+ (NSString*)nameForPosition:(VFPositionType)type;
+ (NSString*)nameForDirection:(VFShiftDirectionType)type;
+ (NSString*)nameForRendererLineEndType:(VFRendererLineEndType)type;
+ (NSString*)nameForNoteType:(VFNoteNHMRSType)type;
+ (VFNoteNHMRSType)typeNoteNHMRSTypeForString:(NSString*)string;
+ (NSString*)nameForBarNoteType:(VFBarNoteType)type;
+ (NSString*)nameForBarLineType:(VFBarLineType)type;
+ (NSString*)nameForClefType:(VFClefType)type;
+ (VFClefType)typeClefTypeForString:(NSString*)string;
+ (NSString*)nameForStemDirectionType:(VFStemDirectionType)type;
+ (NSString*)nameForLogLevelType:(VFLogLevelType)type;
+ (NSString*)nameForModeType:(VFModeType)type;
+ (NSString*)nameForTimeType:(VFTimeType)type;
+ (VFTimeType)typeTimeTypeForString:(NSString*)string;
+ (NSString*)simplNameForTimeType:(VFTimeType)type;
+ (NSString*)nameForStrokeDirectionType:(VFStrokeDirectionType)type;
+ (NSString*)nameForStrokeType:(VFStrokeType)type;
+ (VFStrokeType)typeStrokeTypeForString:(NSString*)string;
+ (NSString*)nameForNoteDurationType:(VFNoteDurationType)type;
+ (VFNoteDurationType)typeNoteDurationTypeForString:(NSString*)string;
+ (NSString*)nameForTupletLocationType:(VFTupletLocationType)type;
+ (NSString*)nameForKeySignatureFlavor:(VFKeySignatureFlavorType)type;
+ (NSString*)nameForSymbolCategory:(VFSymbolCategoryType)type;
+ (NSString*)nameForRepetitionType:(VFRepetitionType)type;
+ (NSString*)nameForVoltaType:(VFVoltaType)type;
+ (NSString*)nameForArticulationType:(VFArticulationType)type;
+ (VFArticulationType)typeArticulationTypeForString:(NSString*)string;
+ (NSString*)nameForStaffConnType:(VFStaffConnectorType)type;
+ (NSString*)nameForJustiticationType:(VFJustiticationType)type;
+ (NSString*)nameForVerticalJustifyType:(VFVerticalJustifyType)type;
+ (NSString*)nameForBendType:(VFBendDirectionType)type;
+ (NSString*)nameForOrnamentType:(VFOrnamentType)type;
+ (VFOrnamentType)typeOrnamentTypeForString:(NSString*)string;
+ (NSString*)nameForAccidentalType:(VFAccidentalType)type;
+ (VFAccidentalType)typeAccidentalTypeForString:(NSString*)string;
+ (NSString*)nameForKeySignatureType:(VFKeySignatureType)type;
+ (VFKeySignatureType)typeKeySignatureTypeForString:(NSString*)string;
+ (NSString*)nameForNotePitchType:(VFNotePitchType)type;
+ (VFNotePitchType)typeNotePitchTypeForString:(NSString*)string;
+ (NSString*)nameForGlyphNameType:(VFGlyphNameType)type;
+ (NSString*)categoryNameForGlyphNameType:(VFGlyphNameType)type;
+ (VFGlyphNameType)typeGlyphNameTypeForString:(NSString*)string;
@end
