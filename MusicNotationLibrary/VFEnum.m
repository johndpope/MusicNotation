//
//  VFEnum.m
//  VexFlow
//
//  Created by Scott on 3/26/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFEnum.h"
#import "VFVex.h"

@implementation VFEnum

// prevent subclassing
// http://stackoverflow.com/a/19194900/629014
+ (id)allocWithZone:(struct _NSZone*)zone;
{
    if(self != [VFEnum class])
    {
        NSAssert(nil, @"Subclassing VFEnum not allowed.");
        return nil;
    }
    return [super allocWithZone:zone];
}

- (instancetype)init;
{
    self = [super init];
    if(self)
    {
        [NSException raise:NSInternalInconsistencyException
                    format:@"This class is abstract: %@", NSStringFromSelector(_cmd)];
    }
    return self;
}

+ (NSString*)nameForPosition:(VFPositionType)type;
{
    switch(type)
    {
        case VFPositionLeft:
            return @"PositionLeft";
            break;
        case VFPositionRight:
            return @"PositionRight";
            break;
        case VFPositionAbove:
            return @"PositionAbove";
            break;
        case VFPositionBelow:
            return @"PositionBelow";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForDirection:(VFShiftDirectionType)type;
{
    switch(type)
    {
        case VFShiftUp:
            return @"ShiftUp";
            break;
        case VFShiftDown:
            return @"ShiftDown";
            break;
        case VFShiftLeft:
            return @"ShiftLeft";
            break;
        case VFShiftRight:
            return @"ShiftRight";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForRendererLineEndType:(VFRendererLineEndType)type;
{
    switch(type)
    {
        case VFLineEndNone:
            return @"EndTypeNone";
            break;
        case VFLineEndDown:
            return @"Up";
            break;
        case VFLineEndUp:
            return @"Down";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForNoteType:(VFNoteNHMRSType)type;
{
    switch(type)
    {
        //        case VFNoteNone:
        //            return @"NoteNone";
        //            break;
        case VFNoteX:
            return @"NoteX";
            break;
        case VFNoteSlash:
            return @"NoteS";
            break;
        case VFNoteHarmonic:
            return @"NoteH";
            break;
        case VFNoteRest:
            return @"NoteR";
            break;
        case VFNoteNote:
            return @"NoteN";
            break;
        case VFNoteMuted:
            return @"NoteM";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

static NSDictionary* _typeNoteNHMRSTypeForString;
+ (VFNoteNHMRSType)typeNoteNHMRSTypeForString:(NSString*)string;
{
    if(!_typeNoteNHMRSTypeForString)
    {
        _typeNoteNHMRSTypeForString = @{
            @"x" : @(VFNoteX),
            @"s" : @(VFNoteSlash),
            @"h" : @(VFNoteHarmonic),
            @"r" : @(VFNoteRest),
            @"n" : @(VFNoteNote),
            @"m" : @(VFNoteMuted),
            //            @"" : @(VFNoteNone),
        };
    }
    return [_typeNoteNHMRSTypeForString[string] unsignedIntegerValue];
}

+ (NSString*)nameForBarNoteType:(VFBarNoteType)type;
{
    switch(type)
    {
        case VFBarNoteSingle:
            return @"BarNoteSingle";
            break;
        case VFBarNoteDouble:
            return @"BarNoteDouble";
            break;
        case VFBarNoteEnd:
            return @"BarNoteEnd";
            break;
        case VFBarNoteRepeatBegin:
            return @"BarNoteRepeatBegin";
            break;
        case VFBarNoteRepeatEnd:
            return @"BarNoteRepeatEnd";
            break;
        case VFBarNoteRepeatBoth:
            return @"BarNoteRepeatBoth";
            break;
        case VFBarNoteNone:
            return @"BarNoteNone";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForBarLineType:(VFBarLineType)type;
{
    switch(type)
    {
        case VFBarLineNone:
            return @"BarLineNone";
            break;
        case VFBarLineSingle:
            return @"BarLineSingle";
            break;
        case VFBarLineDouble:
            return @"BarLineDouble";
            break;
        case VFBarLineEnd:
            return @"BarLineEnd";
            break;
        case VFBarLineRepeatBegin:
            return @"BarLineRepeatBegin";
            break;
        case VFBarLineRepeatEnd:
            return @"BarLineRepeatEnd";
            break;
        case VFBarLineRepeatBoth:
            return @"BarLineRepeatBoth";
            break;

        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForClefType:(VFClefType)type;
{
    switch(type)
    {
        case VFClefTreble:
            return @"ClefTreble";
            break;
        case VFClefAlto:
            return @"ClefAlto";
            break;
        case VFClefBaritoneC:
            return @"ClefBaritoneC";
            break;
        case VFClefBaritoneF:
            return @"ClefBaritoneF";
            break;
        case VFClefBass:
            return @"ClefBass";
            break;
        case VFClefFrench:
            return @"ClefFrench";
            break;
        case VFClefMezzoSoprano:
            return @"ClefMezzoSoprano";
            break;
        case VFClefMovableC:
            return @"ClefMovableC";
            break;
        case VFClefPercussion:
            return @"ClefPercussion";
            break;
        case VFClefSoprano:
            return @"ClefSoprano";
            break;
        case VFClefSubBass:
            return @"ClefSubBass";
            break;
        case VFClefTenor:
            return @"ClefTenor";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

static NSDictionary* _typeClefTypeForString;
+ (VFClefType)typeClefTypeForString:(NSString*)string;
{
    if(!_typeClefTypeForString)
    {
        _typeClefTypeForString = @{
            @"treble" : @(VFClefTreble),
            @"alto" : @(VFClefAlto),
            @"baritone-c" : @(VFClefBaritoneC),
            @"baritone-f" : @(VFClefBaritoneF),
            @"bass" : @(VFClefBass),
            @"french" : @(VFClefFrench),
            @"soprano" : @(VFClefMezzoSoprano),
            @"moveable-c" : @(VFClefMovableC),
            @"percussion" : @(VFClefPercussion),
            @"soprano" : @(VFClefSoprano),
            @"subbass" : @(VFClefSubBass),
            @"tenor" : @(VFClefTenor),
        };
    }
    return [_typeClefTypeForString[string] unsignedIntegerValue];
}

+ (NSString*)nameForStemDirectionType:(VFStemDirectionType)type;
{
    switch(type)
    {
        case VFStemDirectionUp:
            return @"StemDirectionUp";
            break;
        case VFStemDirectionNone:
            return @"StemDirectionNone";
            break;
        case VFStemDirectionDown:
            return @"StemDirectionDown";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForLogLevelType:(VFLogLevelType)type;
{
    switch(type)
    {
        case debug:
            return @"debug";
            break;
        case info:
            return @"info";
            break;
        case logWarn:
            return @"warn";
            break;
        case error:
            return @"error";
            break;
        case fatal:
            return @"fatal";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForModeType:(VFModeType)type;
{
    switch(type)
    {
        case VFModeStrict:
            return @"ModeStrict";
            break;
        case VFModeSoft:
            return @"ModeSoft";
            break;
        case VFModeFull:
            return @"ModeFull";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForTimeType:(VFTimeType)type;
{
    switch(type)
    {
        case VFTime4_4:
            return @"Time4_4";
            break;
        case VFTime3_4:
            return @"Time3_4";
            break;
        case VFTime2_4:
            return @"Time2_4";
            break;
        case VFTime4_2:
            return @"Time4_2";
            break;
        case VFTime2_2:
            return @"Time2_2";
            break;
        case VFTime3_8:
            return @"Time3_8";
            break;
        case VFTime6_8:
            return @"Time6_8";
            break;
        case VFTime9_8:
            return @"Time9_8";
            break;
        case VFTime12_8:
            return @"Time12_8";
            break;
        case VFTime1_2:
            return @"Time1_2";
            break;
        case VFTime3_2:
            return @"Time3_2";
            break;
        case VFTime1_4:
            return @"Time1_4";
            break;
        case VFTime1_8:
            return @"Time1_8";
            break;
        case VFTime2_8:
            return @"Time2_8";
            break;
        case VFTime4_8:
            return @"Time4_8";
            break;
        case VFTime1_16:
            return @"Time1_16";
            break;
        case VFTime2_16:
            return @"Time2_16";
            break;
        case VFTime3_16:
            return @"Time3_16";
            break;
        case VFTime4_16:
            return @"Time4_16";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)simplNameForTimeType:(VFTimeType)type;
{
    // TODO: this belongs in VFEnum
    NSString* ret;
    switch(type)
    {
        case VFTime4_4:
            ret = @"4/4";
            break;
        case VFTime3_4:
            ret = @"3/4";
            break;
        case VFTime2_4:
            ret = @"2/4";
            break;
        case VFTime4_2:
            ret = @"4/2";
            break;
        case VFTime2_2:
            ret = @"2/2";
            break;
        case VFTime3_8:
            ret = @"3/8";
            break;
        case VFTime6_8:
            ret = @"6/8";
            break;
        case VFTime9_8:
            ret = @"9/8";
            break;
        case VFTime12_8:
            ret = @"12/8";
            break;
        case VFTime1_2:
            ret = @"1/2";
            break;
        case VFTime3_2:
            ret = @"3/2";
            break;
        case VFTime1_4:
            ret = @"1/4";
            break;
        case VFTime1_8:
            ret = @"1/8";
            break;
        case VFTime2_8:
            ret = @"2/8";
            break;
        case VFTime4_8:
            ret = @"4/8";
            break;
        case VFTime1_16:
            ret = @"1/16";
            break;
        case VFTime2_16:
            ret = @"2/16";
            break;
        case VFTime3_16:
            ret = @"3/16";
            break;
        case VFTime4_16:
            ret = @"4/16";
            break;
        case VFTime5_4:
            ret = @"5/4";
            break;
        default:
            VFLogError(@"Unrecognized Time Signature type");
            ret = @"0/0";
            break;
    }
    return ret;
}

static NSDictionary* _typeTimeType;
+ (VFTimeType)typeTimeTypeForString:(NSString*)string;
{
    if(!_typeTimeType)
    {
        _typeTimeType = @{
            @"4/4" : @(VFTime4_4),
            @"3/4" : @(VFTime3_4),
            @"2/4" : @(VFTime2_4),
            @"4/2" : @(VFTime4_2),
            @"2/2" : @(VFTime2_2),
            @"3/8" : @(VFTime3_8),
            @"6/8" : @(VFTime6_8),
            @"9/8" : @(VFTime9_8),
            @"12/8" : @(VFTime12_8),
            @"1/2" : @(VFTime1_2),
            @"3/2" : @(VFTime3_2),
            @"1/4" : @(VFTime1_4),
            @"1/8" : @(VFTime1_8),
            @"2/8" : @(VFTime2_8),
            @"4/8" : @(VFTime4_8),
            @"1/16" : @(VFTime1_16),
            @"2/16" : @(VFTime2_16),
            @"3/16" : @(VFTime3_16),
            @"4/16" : @(VFTime4_16),
        };
    }
    return [_typeTimeType[string] unsignedIntegerValue];
}

+ (NSString*)nameForStrokeDirectionType:(VFStrokeDirectionType)type;
{
    switch(type)
    {
        case VFStrokeDirectionDown:
            return @"StrokeDirectionDown";
            break;
        case VFStrokeDirectionUp:
            return @"StrokeDirectionUp";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForStrokeType:(VFStrokeType)type;
{
    switch(type)
    {
        case VFStrokeBrushDown:
            return @"BrushDown";
            break;
        case VFStrokeBrushUp:
            return @"BrushUp";
            break;
        case VFStrokeRollDown:
            return @"RollDown";
            break;
        case VFStrokeRollUp:
            return @"RollUp";
            break;
        case VFStrokeRasquedoDown:
            return @"RasquedoDown";
            break;
        case VFStrokeRasquedoUp:
            return @"RasquedoUp";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

static NSDictionary* _typeStrokeType;
+ (VFStrokeType)typeStrokeTypeForString:(NSString*)string;
{
    if(!_typeStrokeType)
    {
        _typeStrokeType = @{
            @"brd" : @(VFStrokeBrushDown),
            @"bru" : @(VFStrokeBrushUp),
            @"rod" : @(VFStrokeRollDown),
            @"rou" : @(VFStrokeRollUp),
            @"rad" : @(VFStrokeRasquedoDown),
            @"rau" : @(VFStrokeRasquedoUp),
        };
    }
    return [_typeStrokeType[string] unsignedIntegerValue];
}

+ (NSString*)nameForNoteDurationType:(VFNoteDurationType)type;
{
    switch(type)
    {
        case VFDurationNone:
            return @"Duration None";
            break;
        case VFDurationBreveNote:
            return @"Duration Breve Note";
            break;
        case VFDurationWholeNote:
            return @"Duration Whole Note";
            break;
        case VFDurationHalfNote:
            return @"Duration Half Note";
            break;
        case VFDurationQuarterNote:
            return @"Duration Quarter Note";
            break;
        case VFDurationEighthNote:
            return @"Duration Eighth Note";
            break;
        case VFDurationSixteenthNote:
            return @"Duration Sixteenth Note";
            break;
        case VFDurationThirtyTwoNote:
            return @"Duration Thirty Two Note";
            break;
        case VFDurationSixtyFourNote:
            return @"Duration Sixty Four Note";
            break;
        case VFDurationOneTwentyEightNote:
            return @"Duration One Twenty Eight Note";
            break;
        case VFDurationTwoFiftySixNote:
            return @"Duration Two Fifty Six Note";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

static NSDictionary* _typeNoteDurationTypeForString;
+ (VFNoteDurationType)typeNoteDurationTypeForString:(NSString*)string;
{
    if(!_typeNoteDurationTypeForString)
    {
        _typeNoteDurationTypeForString = @{
            @"-1" : @(VFDurationNone),
            @"0" : @(VFDurationBreveNote),
            @"1" : @(VFDurationWholeNote),
            @"2" : @(VFDurationHalfNote),
            @"4" : @(VFDurationQuarterNote),
            @"8" : @(VFDurationEighthNote),
            @"16" : @(VFDurationSixteenthNote),
            @"32" : @(VFDurationThirtyTwoNote),
            @"64" : @(VFDurationSixtyFourNote),
            @"128" : @(VFDurationOneTwentyEightNote),
            @"256" : @(VFDurationTwoFiftySixNote),
            @"w" : @(VFDurationWholeNote),
            @"h" : @(VFDurationHalfNote),
            @"q" : @(VFDurationQuarterNote),
            //           @"8"  : @(VFDurationEighthNote),
            //           @"16"  : @(VFDurationSixteenthNote),
            //           @"32"  : @(VFDurationThirtyTwoNote),
            //           @"64"  : @(VFDurationSixtyFourNote),
            //           @"128"  : @(VFDurationOneTwentyEight),
            //           @"b"  : @(VFDurationTwoFiftySix),
        };
    }
    return [_typeNoteDurationTypeForString[string] unsignedIntegerValue];
}

+ (NSString*)nameForTupletLocationType:(VFTupletLocationType)type;
{
    switch(type)
    {
        case VFTupletLocationNone:
            return @"TupletLocationNone";
            break;
        case VFTupletLocationTop:
            return @"TupletLocationTop";
            break;
        case VFTupletLocationBottom:
            return @"TupletLocationBottom";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForKeySignatureFlavor:(VFKeySignatureFlavorType)type;
{
    switch(type)
    {
        case VFKeySignatureNone:
            return @"KeySignatureNone";
            break;
        case VFKeySignatureSharp:
            return @"KeySignatureSharp";
            break;
        case VFKeySignatureFlat:
            return @"KeySignatureFlat";
            break;
        case VFKeySignatureCircle:
            return @"KeySignatureCircle";
            break;
        case VFKeySignatureDegrees:
            return @"KeySignatureDegrees";
            break;
        case VFKeySignatureNatural:
            return @"KeySignatureNatural";
            break;
        case VFKeySignatureOWithSlash:
            return @"KeySignatureOWithSlash";
            break;
        case VFKeySignatureTriangle:
            return @"KeySignatureTriangle";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForSymbolCategory:(VFSymbolCategoryType)type;
{
    switch(type)
    {
        case VFSymbolCategoryStaffNote:
            return @"SymbolCategoryStaffNote";
            break;
        case VFSymbolCategoryTabNote:
            return @"SymbolCategoryTabNote";
            break;
        case VFSymbolCategoryAccidental:
            return @"SymbolCategoryAccidental";
            break;
        case VFSymbolCategoryArticulation:
            return @"SymbolCategoryArticulation";
            break;
        case VFSymbolCategoryBeam:
            return @"SymbolCategoryBeam";
            break;
        case VFSymbolCategoryStaffBarLine:
            return @"SymbolCategoryStaffBarLine";
            break;
        case VFSymbolCategoryStaffConnector:
            return @"SymbolCategoryStaffConnector";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForRepetitionType:(VFRepetitionType)type;
{
    switch(type)
    {
        case VFRepNone:
            return @"Rep None";
            break;
        case VFRepCodaLeft:
            return @"Rep Coda Left";
            break;
        case VFRepCodaRight:
            return @"Rep Coda Right";
            break;
        case VFRepSegnoLeft:
            return @"Rep Segno Left";
            break;
        case VFRepSegnoRight:
            return @"Rep Segno Right";
            break;
        case VFRepDC:
            return @"RepDC";
            break;
        case VFRepDCALCoda:
            return @"RepDCALCoda";
            break;
        case VFRepDCALFine:
            return @"RepDCALFine";
            break;
        case VFRepDS:
            return @"RepDS";
            break;
        case VFRepDSALCoda:
            return @"RepDSALCoda";
            break;
        case VFRepDSALFine:
            return @"RepDSALFine";
            break;
        case VFRepFine:
            return @"RepFine";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForVoltaType:(VFVoltaType)type;
{
    switch(type)
    {
        case VFVoltaNona:
            return @"Volta Nona";
            break;
        case VFVoltaBegin:
            return @"Volta Begin";
            break;
        case VFVoltaMid:
            return @"Volta Mid";
            break;
        case VFVoltaEnd:
            return @"Volta End";
            break;
        case VFVoltaBeginEnd:
            return @"Volta Begin End";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForArticulationType:(VFArticulationType)type;
{
    switch(type)
    {
        case VFArticulationStacato:
            return @"Articulation Stacato";
            break;
        case VFArticulationStaccatissimo:
            return @"Articulation Staccatissimo";
            break;
        case VFArticulationAccent:
            return @"Articulation Accent";
            break;
        case VFArticulationTenuto:
            return @"Articulation Tenuto";
            break;
        case VFArticulationMarcato:
            return @"Articulation Marcato";
            break;
        case VFArticulationLeftHandPizzicato:
            return @"Articulation Left Hand Pizzicato";
            break;
        case VFArticulationSnapPizzicato:
            return @"Articulation Snap Pizzicato";
            break;
        case VFArticulationNaturalHarmonicOrOpenNote:
            return @"Articulation Natural Harmonic Or Open Note";
            break;
        case VFArticulationFermataAboveStaff:
            return @"Articulation Fermata Above Staff";
            break;
        case VFArticulationFermataBelowStaff:
            return @"Articulation Fermata Below Staff";
            break;
        case VFArticulationBowUpDashUpStroke:
            return @"Articulation Bow Up Dash Up Stroke";
            break;
        case VFArticulationBowDownDashDownStroke:
            return @"Articulation Bow Down Dash Down Stroke";
            break;
        case VFArticulationChoked:
            return @"Articulation Choked";
            break;

        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

static NSDictionary* _typeArticulationTypeForString;
+ (VFArticulationType)typeArticulationTypeForString:(NSString*)string;
{
    if(!_typeArticulationTypeForString)
    {
        _typeArticulationTypeForString = @{
            @"a." : @(VFArticulationStacato),
            @"av" : @(VFArticulationStaccatissimo),
            @"a>" : @(VFArticulationAccent),
            @"a-" : @(VFArticulationTenuto),
            @"a^" : @(VFArticulationMarcato),
            @"a+" : @(VFArticulationLeftHandPizzicato),
            @"ao" : @(VFArticulationSnapPizzicato),
            @"ah" : @(VFArticulationNaturalHarmonicOrOpenNote),
            @"a@a" : @(VFArticulationFermataAboveStaff),
            @"a@u" : @(VFArticulationFermataBelowStaff),
            @"a|" : @(VFArticulationBowUpDashUpStroke),
            @"am" : @(VFArticulationBowDownDashDownStroke),
            @"a," : @(VFArticulationChoked),
        };
    }
    return [_typeArticulationTypeForString[string] unsignedIntegerValue];
}

+ (NSString*)nameForStaffConnType:(VFStaffConnectorType)type;
{
    switch(type)
    {
        case VFStaffConnectorNone:
            return @"ConnNone";
            break;
        case VFStaffConnectorSingleRight:
            return @"Single Right";
            break;
        case VFStaffConnectorSingleLeft:
            return @"Single Left";
            break;
        case VFStaffConnectorSingle:
            return @"Single";
            break;
        case VFStaffConnectorDouble:
            return @"Double";
            break;
        case VFStaffConnectorBrace:
            return @"Brace";
            break;
        case VFStaffConnectorBracket:
            return @"Bracket";
            break;
        case VFStaffConnectorBoldDoubleLeft:
            return @"Bold Double Left";
            break;
        case VFStaffConnectorBoldDoubleRight:
            return @"Bold Double Right";
            break;
        case VFStaffConnectorThinDouble:
            return @"Thin Double";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForJustiticationType:(VFJustiticationType)type;
{
    switch(type)
    {
        case VFJustifyLEFT:
            return @"Justify LEFT";
            break;
        case VFJustifyCENTER:
            return @"Justify CENTER";
            break;
        case VFJustifyRIGHT:
            return @"Justify RIGHT";
            break;
        case VFJustifyCENTER_STEM:
            return @"Justify CENTER_STEM";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForVerticalJustifyType:(VFVerticalJustifyType)type;
{
    switch(type)
    {
        case VFVerticalJustifyTOP:
            return @"Vertical Justify TOP";
            break;
        case VFVerticalJustifyCENTER:
            return @"Vertical Justify CENTER";
            break;
        case VFVerticalJustifyBOTTOM:
            return @"Vertical Justify BOTTOM";
            break;
        case VFVerticalJustifyCENTER_STEM:
            return @"Vertical Justify CENTER_STEM";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForBendType:(VFBendDirectionType)type;
{
    switch(type)
    {
        case VFBendUP:
            return @"Bend UP";
            break;
        case VFBendDOWN:
            return @"Bend DOWN";
            break;
        case VFBendNONE:
            return @"Bend NONE";
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

+ (NSString*)nameForOrnamentType:(VFOrnamentType)type;
{
    switch(type)
    {
        case VFOrnament_DOWNMORDENT:
            return @"Ornament_DOWNMORDENT";
            break;
        case VFOrnament_DOWNPRALL:
            return @"Ornament_DOWNPRALL";
            break;
        case VFOrnament_LINEPRALL:
            return @"Ornament_LINEPRALL";
            break;
        case VFOrnament_MORDENT:
            return @"Ornament_MORDENT";
            break;
        case VFOrnament_MORDENT_INVERTED:
            return @"Ornament_MORDENT_INVERTED";
            break;
        case VFOrnament_PRALLDOWN:
            return @"Ornament_PRALLDOWN";
            break;
        case VFOrnament_PRALLPRALL:
            return @"Ornament_PRALLPRALL";
            break;
        case VFOrnament_PRALLUP:
            return @"Ornament_PRALLUP";
            break;
        case VFOrnament_TR:
            return @"Ornament_TR";
            break;
        case VFOrnament_TURN:
            return @"Ornament_TURN";
            break;
        case VFOrnament_TURN_INVERTED:
            return @"Ornament_TURN_INVERTED";
            break;
        case VFOrnament_UPMORDENT:
            return @"Ornament_UPMORDENT";
            break;
        case VFOrnament_UPPRALL:
            return @"Ornament_UPPRALL";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

static NSDictionary* _typeOrnamentTypeForString;
+ (VFOrnamentType)typeOrnamentTypeForString:(NSString*)string;
{
    if(!_typeOrnamentTypeForString)
    {
        _typeOrnamentTypeForString = @{
            @"mordent" : @(VFOrnament_MORDENT),
            @"mordent_inverted" : @(VFOrnament_MORDENT_INVERTED),
            @"turn" : @(VFOrnament_TURN),
            @"turn_inverted" : @(VFOrnament_TURN_INVERTED),
            @"tr" : @(VFOrnament_TR),
            @"upprall" : @(VFOrnament_UPPRALL),
            @"downprall" : @(VFOrnament_DOWNPRALL),
            @"prallup" : @(VFOrnament_PRALLUP),
            @"pralldown" : @(VFOrnament_PRALLDOWN),
            @"upmordent" : @(VFOrnament_UPMORDENT),
            @"downmordent" : @(VFOrnament_DOWNMORDENT),
            @"lineprall" : @(VFOrnament_LINEPRALL),
            @"prallprall" : @(VFOrnament_PRALLPRALL),
        };
    }
    return [_typeOrnamentTypeForString[string] unsignedIntegerValue];
}

+ (NSString*)nameForAccidentalType:(VFAccidentalType)type;
{
    switch(type)
    {
        case VFAccidental_b:
            return @"Accidental_b";
            break;
        case VFAccidental_bb:
            return @"Accidental_bb";
            break;
        case VFAccidental_bbs:
            return @"Accidental_bbs";
            break;
        case VFAccidental_d:
            return @"Accidental_d";
            break;
        case VFAccidental_db:
            return @"Accidental_db";
            break;
        case VFAccidental_Hash:
            return @"Accidental_Hash";
            break;
        case VFAccidental_HashHash:
            return @"Accidental_HashHash";
            break;
        case VFAccidental_LeftParen:
            return @"Accidental_LeftParen";
            break;
        case VFAccidental_n:
            return @"Accidental_n";
            break;
        case VFAccidental_Plus:
            return @"Accidental_Plus";
            break;
        case VFAccidental_PlusPlus:
            return @"Accidental_PlusPlus";
            break;
        case VFAccidental_RightParen:
            return @"Accidental_RightParen";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

static NSDictionary* _typeAccidentalTypeForString;
+ (VFAccidentalType)typeAccidentalTypeForString:(NSString*)string;
{
    if(!_typeAccidentalTypeForString)
    {
        _typeAccidentalTypeForString = @{
            @"b" : @(VFAccidental_b),
            @"bb" : @(VFAccidental_bb),
            @"bbs" : @(VFAccidental_bbs),
            @"d" : @(VFAccidental_d),
            @"db" : @(VFAccidental_db),
            @"#" : @(VFAccidental_Hash),
            @"##" : @(VFAccidental_HashHash),
            @"{" : @(VFAccidental_LeftParen),
            @"n" : @(VFAccidental_n),
            @"+" : @(VFAccidental_Plus),
            @"++" : @(VFAccidental_PlusPlus),
            @"}" : @(VFAccidental_RightParen),
        };
    }
    return [_typeAccidentalTypeForString[string] unsignedIntegerValue];
}

+ (NSString*)nameForKeySignatureType:(VFKeySignatureType)type;
{
    switch(type)
    {
        case VFKeySignature_A:
            return @"KeySignature_A";
            break;
        case VFKeySignature_Ab:
            return @"KeySignature_Ab";
            break;
        case VFKeySignature_Abm:
            return @"KeySignature_Abm";
            break;
        case VFKeySignature_Am:
            return @"KeySignature_Am";
            break;
        case VFKeySignature_ASharpm:
            return @"KeySignature_ASharpm";
            break;
        case VFKeySignature_B:
            return @"KeySignature_B";
            break;
        case VFKeySignature_Bb:
            return @"KeySignature_Bb";
            break;
        case VFKeySignature_Bbm:
            return @"KeySignature_Bbm";
            break;
        case VFKeySignature_Bm:
            return @"KeySignature_Bm";
            break;
        case VFKeySignature_C:
            return @"KeySignature_C";
            break;
        case VFKeySignature_Cb:
            return @"KeySignature_Cb";
            break;
        case VFKeySignature_Cm:
            return @"KeySignature_Cm";
            break;
        case VFKeySignature_CSharp:
            return @"KeySignature_CSharp";
            break;
        case VFKeySignature_CSharpm:
            return @"KeySignature_CSharpm";
            break;
        case VFKeySignature_D:
            return @"KeySignature_D";
            break;
        case VFKeySignature_Db:
            return @"KeySignature_Db";
            break;
        case VFKeySignature_Dm:
            return @"KeySignature_Dm";
            break;
        case VFKeySignature_DSharpm:
            return @"KeySignature_DSharp";
            break;
        case VFKeySignature_E:
            return @"KeySignature_E";
            break;
        case VFKeySignature_Eb:
            return @"KeySignature_Eb";
            break;
        case VFKeySignature_Ebm:
            return @"KeySignature_Ebm";
            break;
        case VFKeySignature_Em:
            return @"KeySignature_Em";
            break;
        case VFKeySignature_F:
            return @"KeySignature_F";
            break;
        case VFKeySignature_Fm:
            return @"KeySignature_Fm";
            break;
        case VFKeySignature_FSharp:
            return @"KeySignature_FSharp";
            break;
        case VFKeySignature_FSharpm:
            return @"KeySignature_FSharpm";
            break;
        case VFKeySignature_G:
            return @"KeySignature_G";
            break;
        case VFKeySignature_Gb:
            return @"KeySignature_Gb";
            break;
        case VFKeySignature_Gm:
            return @"KeySignature_Gm";
            break;
        case VFKeySignature_GSharpm:
            return @"KeySignature_GSharpm";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

static NSDictionary* _typeKeySignatureType;
+ (VFKeySignatureType)typeKeySignatureTypeForString:(NSString*)string;
{
    if(!_typeKeySignatureType)
    {
        _typeKeySignatureType = @{
            @"C" : @(VFKeySignature_C),
            @"Am" : @(VFKeySignature_Am),
            @"F" : @(VFKeySignature_F),
            @"Dm" : @(VFKeySignature_Dm),
            @"Bb" : @(VFKeySignature_Bb),
            @"Gm" : @(VFKeySignature_Gm),
            @"Eb" : @(VFKeySignature_Eb),
            @"Cm" : @(VFKeySignature_Cm),
            @"Ab" : @(VFKeySignature_Ab),
            @"Fm" : @(VFKeySignature_Fm),
            @"Db" : @(VFKeySignature_Db),
            @"Bbm" : @(VFKeySignature_Bbm),
            @"Gb" : @(VFKeySignature_Gb),
            @"Ebm" : @(VFKeySignature_Ebm),
            @"Cb" : @(VFKeySignature_Cb),
            @"Abm" : @(VFKeySignature_Abm),
            @"G" : @(VFKeySignature_G),
            @"Em" : @(VFKeySignature_Em),
            @"D" : @(VFKeySignature_D),
            @"Bm" : @(VFKeySignature_Bm),
            @"A" : @(VFKeySignature_A),
            @"F#m" : @(VFKeySignature_FSharpm),
            @"E" : @(VFKeySignature_E),
            @"C#m" : @(VFKeySignature_CSharpm),
            @"B" : @(VFKeySignature_B),
            @"G#m" : @(VFKeySignature_GSharpm),
            @"F#" : @(VFKeySignature_FSharp),
            @"D#m" : @(VFKeySignature_DSharpm),
            @"C#" : @(VFKeySignature_CSharpm),
            @"A#m" : @(VFKeySignature_ASharpm),
        };
    }
    return [_typeKeySignatureType[string] unsignedIntegerValue];
}

+ (NSString*)nameForNotePitchType:(VFNotePitchType)type;
{
    switch(type)
    {
        case VFNotePitch_C:
            return @"C";
            break;
        case VFNotePitch_C_SHARP:
            return @"C#";
            break;
        case VFNotePitch_D:
            return @"D";
            break;
        case VFNotePitch_D_SHARP:
            return @"D#";
            break;
        case VFNotePitch_E:
            return @"E";
            break;
        case VFNotePitch_F:
            return @"F";
            break;
        case VFNotePitch_F_SHARP:
            return @"F#";
            break;
        case VFNotePitch_G:
            return @"G";
            break;
        case VFNotePitch_G_SHARP:
            return @"G#";
            break;
        case VFNotePitch_A:
            return @"A";
            break;
        case VFNotePitch_A_SHARP:
            return @"A#";
            break;
        case VFNotePitch_B:
            return @"B";
            break;
        default:
            return @"UNKNOWN";
            break;
    };
    return nil;
}

static NSDictionary* _typeNotePitchType;
+ (VFNotePitchType)typeNotePitchTypeForString:(NSString*)string;
{
    if(!_typeNotePitchType)
    {
        _typeNotePitchType = @{
            @"C" : @(VFNotePitch_C),
            @"C#" : @(VFNotePitch_C_SHARP),
            @"D" : @(VFNotePitch_D),
            @"D#" : @(VFNotePitch_D_SHARP),
            @"E" : @(VFNotePitch_E),
            @"F" : @(VFNotePitch_F),
            @"F#" : @(VFNotePitch_F_SHARP),
            @"G" : @(VFNotePitch_G),
            @"G#" : @(VFNotePitch_G_SHARP),
            @"A" : @(VFNotePitch_A),
            @"A#" : @(VFNotePitch_A_SHARP),
            @"B" : @(VFNotePitch_B),
        };
    }
    return [_typeNotePitchType[string] unsignedIntegerValue];
}

+ (NSString*)nameForGlyphNameType:(VFGlyphNameType)type;
{
    return @"";
}
+ (NSString*)categoryNameForGlyphNameType:(VFGlyphNameType)type;
{
    //    switch ([self indexForName:name]) {
    // TODO: change to a dictionary

    //    static NSDictionary *_namesDictionary = nil;
    //    - (NSString *)nameForCategoryName:(NSString *)category {
    //        if (!_namesDictionary) {
    //            NSDictionary *tmp = @{ @"pedal_depress" : @"v36",
    //                                   @"pedal_release" : @"v5d" };
    //            _namesDictionary = [NSDictionary dictionaryWithDictionary:tmp];
    //
    //        }
    //        return [_namesDictionary objectForKey:category];
    //    }

    switch(type)
    {
        case 0x0:
            return @"zero";
        case 0x1:
            return @"one";
        case 0x2:
            return @"two";
        case 0x3:
            return @"three";
        case 0x4:
            return @"four";
        case 0x5:
            return @"five";
        case 0x6:
            return @"six";
        case 0x7:
            return @"seven";
        case 0x8:
            return @"eight";
        case 0x9:
            return @"nine";
        case 0xa:
            return @"";
        case 0xb:
            return @"";
        case 0xc:
            return @"";
        case 0xd:
            return @"";
        case 0xe:
            return @"";
        case 0xf:
            return @"";
        case 0x10:
            return @"";
        case 0x11:
            return @"";
        case 0x12:
            return @"";
        case 0x13:
            return @"";
        case 0x14:
            return @"";
        case 0x15:
            return @"";
        case 0x16:
            return @"";
        case 0x17:
            return @"";
        case 0x18:
            return @"";
        case 0x19:
            return @"";
        case 0x1a:
            return @"";
        case 0x1b:
            return @"";
        case 0x1c:
            return @"";
        case 0x1d:
            return @"";
        case 0x1e:
            return @"";
        case 0x1f:
            return @"";
        case 0x20:
            return @"";
        case 0x21:
            return @"";
        case 0x22:
            return @"";
        case 0x23:
            return @"staccato";
        case 0x24:
            return @"";
        case 0x25:
            return @"";
        case 0x26:
            return @"";
        case 0x27:
            return @"";
        case 0x28:
            return @"";
        case 0x29:
            return @"";
        case 0x2a:
            return @"";
        case 0x2b:
            return @"";
        case 0x2c:
            return @"";
        case 0x2d:
            return @"";
        case 0x2e:
            return @"";
        case 0x2f:
            return @"TAB";
        case 0x30:
            return @"";
        case 0x31:
            return @"";
        case 0x32:
            return @"";
        case 0x33:
            return @"";
        case 0x34:
            return @"";
        case 0x35:
            return @"sharp";
        case 0x36:
            return @"";
        case 0x37:
            return @"";
        case 0x38:
            return @"";
        case 0x39:
            return @"";
        case 0x3a:
            return @"";
        case 0x3b:
            return @"";
        case 0x3c:
            return @"";
        case 0x3d:
            return @"";
        case 0x3e:
            return @"";
        case 0x3f:
            return @"";
        case 0x40:
            return @"";
        case 0x41:
            return @"";
        case 0x42:
            return @"";
        case 0x43:
            return @"";
        case 0x44:
            return @"";
        case 0x45:
            return @"";
        case 0x46:
            return @"";
        case 0x47:
            return @"";
        case 0x48:
            return @"";
        case 0x49:
            return @"";
        case 0x4a:
            return @"";
        case 0x4b:
            return @"";
        case 0x4c:
            return @"";
        case 0x4d:
            return @"";
        case 0x4e:
            return @"";
        case 0x4f:
            return @"";
        case 0x50:
            return @"";
        case 0x51:
            return @"";
        case 0x52:
            return @"";
        case 0x53:
            return @"";
        case 0x54:
            return @"";
        case 0x55:
            return @"";
        case 0x56:
            return @"";
        case 0x57:
            return @"";
        case 0x58:
            return @"";
        case 0x59:
            return @"";
        case 0x5a:
            return @"";
        case 0x5b:
            return @"";
        case 0x5c:
            return @"";
        case 0x5d:
            return @"";
        case 0x5e:
            return @"";
        case 0x5f:
            return @"";
        case 0x60:
            return @"";
        case 0x61:
            return @"";
        case 0x62:
            return @"";
        case 0x63:
            return @"";
        case 0x64:
            return @"";
        case 0x65:
            return @"";
        case 0x66:
            return @"";
        case 0x67:
            return @"";
        case 0x68:
            return @"";
        case 0x69:
            return @"";
        case 0x6a:
            return @"";
        case 0x6b:
            return @"";
        case 0x6c:
            return @"";
        case 0x6d:
            return @"";
        case 0x6e:
            return @"";
        case 0x6f:
            return @"";
        case 0x70:
            return @"";
        case 0x71:
            return @"";
        case 0x72:
            return @"";
        case 0x73:
            return @"";
        case 0x74:
            return @"";
        case 0x75:
            return @"";
        case 0x76:
            return @"";
        case 0x77:
            return @"";
        case 0x78:
            return @"";
        case 0x79:
            return @"";
        case 0x7a:
            return @"";
        case 0x7b:
            return @"";
        case 0x7c:
            return @"";
        case 0x7d:
            return @"";
        case 0x7e:
            return @"";
        case 0x7f:
            return @"";
        case 0x80:
            return @"";
        case 0x81:
            return @"";
        case 0x82:
            return @"";
        case 0x83:
            return @"trebleclef";
        case 0x84:
            return @"";
        case 0x85:
            return @"flat";
        case 0x86:
            return @"";
        case 0x87:
            return @"";
        case 0x88:
            return @"";
        case 0x89:
            return @"";
        case 0x8a:
            return @"";
        case 0x8b:
            return @"";
        case 0x8c:
            return @"";
        case 0x8d:
            return @"";
        case 0x8e:
            return @"";
        case 0x8f:
            return @"";
        case 0x90:
            return @"";
        case 0x91:
            return @"";
        case 0x92:
            return @"";
//        case 0x93:
//            return @"";
        case 0x94:
            return @"";
        case 0x95:
            return @"";
        case 0x96:
            return @"";
        case 0x97:
            return @"";
        case 0x98:
            return @"";
        case 0x99:
            return @"";
        case 0x9a:
            return @"";
        case 0x9b:
            return @"";
        case 0x9c:
            return @"";
        case 0x9d:
            return @"";
        case 0x9e:
            return @"";
        case 0x9f:
            return @"";
        case 0xa0:
            return @"";
        case 0xa1:
            return @"";
        case 0xa2:
            return @"";
        case 0xa3:
            return @"";
        case 0xa4:
            return @"";
        case 0xa5:
            return @"";
        case 0xa6:
            return @"";
        case 0xa7:
            return @"";
        case 0xa8:
            return @"";
        case 0xa9:
            return @"";
        case 0xaa:
            return @"";
        case 0xab:
            return @"";
        case 0xac:
            return @"";
        case 0xad:
            return @"";
        case 0xae:
            return @"";
        case 0xaf:
            return @"";
        case 0xb0:
            return @"";
        case 0xb1:
            return @"";
        case 0xb2:
            return @"";
        case 0xb3:
            return @"";
        case 0xb4:
            return @"";
        case 0xb5:
            return @"";
        case 0xb6:
            return @"";
        case 0xb7:
            return @"";
        case 0xb8:
            return @"";
        case 0xb9:
            return @"";
        case 0xba:
            return @"";
        case 0xbb:
            return @"";
        case 0xbc:
            return @"";
        case 0xbd:
            return @"";
        case 0xbe:
            return @"";
        case 0xbf:
            return @"";
        case 0xc0:
            return @"";
        case 0xc1:
            return @"";
        case 0xc2:
            return @"";
        case 0xc3:
            return @"";
        default:
            return @"ERROR";
    }
}

static NSDictionary* _typeGlyphNameType;
+ (VFGlyphNameType)typeGlyphNameTypeForString:(NSString*)string;
{
    if(!_typeGlyphNameType)
    {
        _typeGlyphNameType = @{
            @"v0" : @(VFGlyphName_v0),
            @"v1" : @(VFGlyphName_v1),
            @"v2" : @(VFGlyphName_v2),
            @"v3" : @(VFGlyphName_v3),
            @"v4" : @(VFGlyphName_v4),
            @"v5" : @(VFGlyphName_v5),
            @"v6" : @(VFGlyphName_v6),
            @"v7" : @(VFGlyphName_v7),
            @"v8" : @(VFGlyphName_v8),
            @"v9" : @(VFGlyphName_v9),
            @"va" : @(VFGlyphName_va),
            @"vb" : @(VFGlyphName_vb),
            @"vc" : @(VFGlyphName_vc),
            @"vd" : @(VFGlyphName_vd),
            @"ve" : @(VFGlyphName_ve),
            @"vf" : @(VFGlyphName_vf),
            @"v10" : @(VFGlyphName_v10),
            @"v11" : @(VFGlyphName_v11),
            @"v12" : @(VFGlyphName_v12),
            @"v13" : @(VFGlyphName_v13),
            @"v14" : @(VFGlyphName_v14),
            @"v15" : @(VFGlyphName_v15),
            @"v16" : @(VFGlyphName_v16),
            @"v17" : @(VFGlyphName_v17),
            @"v18" : @(VFGlyphName_v18),
            @"v19" : @(VFGlyphName_v19),
            @"v1a" : @(VFGlyphName_v1a),
            @"v1b" : @(VFGlyphName_v1b),
            @"v1c" : @(VFGlyphName_v1c),
            @"v1d" : @(VFGlyphName_v1d),
            @"v1e" : @(VFGlyphName_v1e),
            @"v1f" : @(VFGlyphName_v1f),
            @"v20" : @(VFGlyphName_v20),
            @"v21" : @(VFGlyphName_v21),
            @"v22" : @(VFGlyphName_v22),
            @"v23" : @(VFGlyphName_v23),
            @"v24" : @(VFGlyphName_v24),
            @"v25" : @(VFGlyphName_v25),
            @"v26" : @(VFGlyphName_v26),
            @"v27" : @(VFGlyphName_v27),
            @"v28" : @(VFGlyphName_v28),
            @"v29" : @(VFGlyphName_v29),
            @"v2a" : @(VFGlyphName_v2a),
            @"v2b" : @(VFGlyphName_v2b),
            @"v2c" : @(VFGlyphName_v2c),
            @"v2d" : @(VFGlyphName_v2d),
            @"v2e" : @(VFGlyphName_v2e),
            @"v2f" : @(VFGlyphName_v2f),
            @"v30" : @(VFGlyphName_v30),
            @"v31" : @(VFGlyphName_v31),
            @"v32" : @(VFGlyphName_v32),
            @"v33" : @(VFGlyphName_v33),
            @"v34" : @(VFGlyphName_v34),
            @"v35" : @(VFGlyphName_v35),
            @"v36" : @(VFGlyphName_v36),
            @"v37" : @(VFGlyphName_v37),
            @"v38" : @(VFGlyphName_v38),
            @"v39" : @(VFGlyphName_v39),
            @"v3a" : @(VFGlyphName_v3a),
            @"v3b" : @(VFGlyphName_v3b),
            @"v3c" : @(VFGlyphName_v3c),
            @"v3d" : @(VFGlyphName_v3d),
            @"v3e" : @(VFGlyphName_v3e),
            @"v3f" : @(VFGlyphName_v3f),
            @"v40" : @(VFGlyphName_v40),
            @"v41" : @(VFGlyphName_v41),
            @"v42" : @(VFGlyphName_v42),
            @"v43" : @(VFGlyphName_v43),
            @"v44" : @(VFGlyphName_v44),
            @"v45" : @(VFGlyphName_v45),
            @"v46" : @(VFGlyphName_v46),
            @"v47" : @(VFGlyphName_v47),
            @"v48" : @(VFGlyphName_v48),
            @"v49" : @(VFGlyphName_v49),
            @"v4a" : @(VFGlyphName_v4a),
            @"v4b" : @(VFGlyphName_v4b),
            @"v4c" : @(VFGlyphName_v4c),
            @"v4d" : @(VFGlyphName_v4d),
            @"v4e" : @(VFGlyphName_v4e),
            @"v4f" : @(VFGlyphName_v4f),
            @"v50" : @(VFGlyphName_v50),
            @"v51" : @(VFGlyphName_v51),
            @"v52" : @(VFGlyphName_v52),
            @"v53" : @(VFGlyphName_v53),
            @"v54" : @(VFGlyphName_v54),
            @"v55" : @(VFGlyphName_v55),
            @"v56" : @(VFGlyphName_v56),
            @"v57" : @(VFGlyphName_v57),
            @"v58" : @(VFGlyphName_v58),
            @"v59" : @(VFGlyphName_v59),
            @"v5a" : @(VFGlyphName_v5a),
            @"v5b" : @(VFGlyphName_v5b),
            @"v5c" : @(VFGlyphName_v5c),
            @"v5d" : @(VFGlyphName_v5d),
            @"v5e" : @(VFGlyphName_v5e),
            @"v5f" : @(VFGlyphName_v5f),
            @"v60" : @(VFGlyphName_v60),
            @"v61" : @(VFGlyphName_v61),
            @"v62" : @(VFGlyphName_v62),
            @"v63" : @(VFGlyphName_v63),
            @"v64" : @(VFGlyphName_v64),
            @"v65" : @(VFGlyphName_v65),
            @"v66" : @(VFGlyphName_v66),
            @"v67" : @(VFGlyphName_v67),
            @"v68" : @(VFGlyphName_v68),
            @"v69" : @(VFGlyphName_v69),
            @"v6a" : @(VFGlyphName_v6a),
            @"v6b" : @(VFGlyphName_v6b),
            @"v6c" : @(VFGlyphName_v6c),
            @"v6d" : @(VFGlyphName_v6d),
            @"v6e" : @(VFGlyphName_v6e),
            @"v6f" : @(VFGlyphName_v6f),
            @"v70" : @(VFGlyphName_v70),
            @"v71" : @(VFGlyphName_v71),
            @"v72" : @(VFGlyphName_v72),
            @"v73" : @(VFGlyphName_v73),
            @"v74" : @(VFGlyphName_v74),
            @"v75" : @(VFGlyphName_v75),
            @"v76" : @(VFGlyphName_v76),
            @"v77" : @(VFGlyphName_v77),
            @"v78" : @(VFGlyphName_v78),
            @"v79" : @(VFGlyphName_v79),
            @"v7a" : @(VFGlyphName_v7a),
            @"v7b" : @(VFGlyphName_v7b),
            @"v7c" : @(VFGlyphName_v7c),
            @"v7d" : @(VFGlyphName_v7d),
            @"v7e" : @(VFGlyphName_v7e),
            @"v7f" : @(VFGlyphName_v7f),
            @"v80" : @(VFGlyphName_v80),
            @"v81" : @(VFGlyphName_v81),
            @"v82" : @(VFGlyphName_v82),
            @"v83" : @(VFGlyphName_v83),
            @"v84" : @(VFGlyphName_v84),
            @"v85" : @(VFGlyphName_v85),
            @"v86" : @(VFGlyphName_v86),
            @"v88" : @(VFGlyphName_v88),
            @"v89" : @(VFGlyphName_v89),
            @"v8a" : @(VFGlyphName_v8a),
            @"v8b" : @(VFGlyphName_v8b),
            @"v8c" : @(VFGlyphName_v8c),
            @"v8d" : @(VFGlyphName_v8d),
            @"v8e" : @(VFGlyphName_v8e),
            @"v8f" : @(VFGlyphName_v8f),
            @"v90" : @(VFGlyphName_v90),
            @"v91" : @(VFGlyphName_v91),
            @"v92" : @(VFGlyphName_v92),
            @"v93" : @(VFGlyphName_v93),
            @"v94" : @(VFGlyphName_v94),
            @"v95" : @(VFGlyphName_v95),
            @"v96" : @(VFGlyphName_v96),
            @"v97" : @(VFGlyphName_v97),
            @"v98" : @(VFGlyphName_v98),
            @"v99" : @(VFGlyphName_v99),
            @"v9a" : @(VFGlyphName_v9a),
            @"v9b" : @(VFGlyphName_v9b),
            @"v9c" : @(VFGlyphName_v9c),
            @"v9d" : @(VFGlyphName_v9d),
            @"v9e" : @(VFGlyphName_v9e),
            @"v9f" : @(VFGlyphName_v9f),
            @"va0" : @(VFGlyphName_va0),
            @"va1" : @(VFGlyphName_va1),
            @"va2" : @(VFGlyphName_va2),
            @"va3" : @(VFGlyphName_va3),
            @"va4" : @(VFGlyphName_va4),
            @"va5" : @(VFGlyphName_va5),
            @"va6" : @(VFGlyphName_va6),
            @"va7" : @(VFGlyphName_va7),
            @"va8" : @(VFGlyphName_va8),
            @"va9" : @(VFGlyphName_va9),
            @"vaa" : @(VFGlyphName_vaa),
            @"vab" : @(VFGlyphName_vab),
            @"vac" : @(VFGlyphName_vac),
            @"vad" : @(VFGlyphName_vad),
            @"vae" : @(VFGlyphName_vae),
            @"vaf" : @(VFGlyphName_vaf),
            @"vb0" : @(VFGlyphName_vb0),
            @"vb1" : @(VFGlyphName_vb1),
            @"vb2" : @(VFGlyphName_vb2),
            @"vb3" : @(VFGlyphName_vb3),
            @"vb4" : @(VFGlyphName_vb4),
            @"vb5" : @(VFGlyphName_vb5),
            @"vb6" : @(VFGlyphName_vb6),
            @"vb7" : @(VFGlyphName_vb7),
            @"vb8" : @(VFGlyphName_vb8),
            @"vb9" : @(VFGlyphName_vb9),
            @"vba" : @(VFGlyphName_vba),
            @"vbb" : @(VFGlyphName_vbb),
            @"vbc" : @(VFGlyphName_vbc),
            @"vbd" : @(VFGlyphName_vbd),
            @"vbe" : @(VFGlyphName_vbe),
            @"vbf" : @(VFGlyphName_vbf),
            @"vc0" : @(VFGlyphName_vc0),
            @"vc1" : @(VFGlyphName_vc1),
            @"vc2" : @(VFGlyphName_vc2),
            @"vc3" : @(VFGlyphName_vc3),
        };
    }
    return [_typeGlyphNameType[string] unsignedIntegerValue];
}

@end
