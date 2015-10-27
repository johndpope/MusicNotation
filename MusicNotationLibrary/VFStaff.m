//
//  VFStaff.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
@import Foundation;
#elif TARGET_OS_MAC
@import AppKit;
#endif
#import <objc/runtime.h>
#import "VFStaff.h"
#import "VFColor.h"
#import "VFFont.h"
#import "VFBezierPath.h"
#import "VFVex.h"
#import "VFMetrics.h"
#import "VFOptions.h"
#import "VFBoundingBox.h"
#import "VFEnum.h"
#import "VFGlyph.h"
#import "VFModifier.h"
#import "VFStaffModifier.h"
#import "VFKeySignature.h"
#import "VFClef.h"
#import "VFTimeSignature.h"
#import "VFStaffBarLine.h"
#import "OCTotallyLazy.h"
#import "NSString+Ruby.h"
#import "VFShift.h"
#import "VFStaffModifier.h"
#import "VFStaffSection.h"
#import "VFPadding.h"
#import "NSObject+NSObjectAdditions.h"
#import "NSMutableArray+JSAdditions.h"
#import "VFPoint.h"
#import "VFTables.h"
#import "NSMutableArray+JSAdditions.h"
#import "VFStaffText.h"
#import "VFStaffTempo.h"
#import "VFStaffVolta.h"
#import "VFStaffRepetition.h"
#import "NSObject+AutoDescription.h"

@implementation StaffOptions
{
    NSUInteger _numLines;
}

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        _verticalBarWidth = 10;   // Width around vertical bar end-marker
        _glyphSpacingPoints = 10;
        _numLines = 5;
        _pointsBetweenLines = 10;   // in points
        _spaceAboveStaffLine = 4;   // in staff lines
        _spaceBelowStaffLine = 4;   // in staff lines
        _topTextPosition = 1;       // in staff lines
        _bottomTextPosition = 6;
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

+ (StaffOptions*)staffOptions
{
    return [[StaffOptions alloc] initWithDictionary:nil];
}

- (NSMutableArray*)lineConfig
{
    if(!_lineConfig)
    {
        _lineConfig = [NSMutableArray arrayWithCapacity:_numLines];
        for(NSUInteger i = 0; i < _numLines; ++i)
        {
            [_lineConfig addObject:[NSMutableDictionary dictionaryWithDictionary:@{ @"visible" : @(YES) }]];
        }
    }
    return _lineConfig;
}

- (void)setNumLines:(NSUInteger)numLines
{
    _numLines = numLines;
    if(_numLines > self.lineConfig.count)
    {
        for(NSUInteger i = 0; i < (_numLines - self.lineConfig.count); ++i)
        {
            [_lineConfig addObject:[NSMutableDictionary dictionaryWithDictionary:@{ @"visible" : @(YES) }]];
        }
    }
}

@end

static VFStaff* _currentStaff;

@interface VFStaff (private)
@property (strong, nonatomic) StaffOptions* options;
@end

@implementation VFStaff

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        _postFormatted = NO;
        _thickNess = kTHICKNESS > 1 ? kTHICKNESS : 0;
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

+ (VFStaff*)currentStaff;
{
    if(!_currentStaff)
    {
        VFLogError(@"StaffNotYetCreatedError, need to create a staff first.");
    }
    return _currentStaff;
}

- (instancetype)initAtX:(float)x
                    atY:(float)y
                  width:(float)width
                 height:(float)height
            optionsDict:(NSDictionary*)optionsDict;
{
    self = [self initWithDictionary:optionsDict];
    if(self)
    {
        _x = x;
        _y = y;
        _width = width;

        _glyph_start_x = _x + 0;
        _glyph_end_x = _x + _width;
        _start_x = _glyph_start_x + 20;
        _end_x = _glyph_end_x;

        // TODO: move these to property methods
        _modifiers = [NSMutableArray array];   // non-glyph Staff items (barlines, coda, segno, etc.)
        _measure = 0;
        //        _clef = [VFClef clefWithType:VFClefTreble];
        //        _font = [VFFont fontWithName:@"sans-serif" size:8 weight:@""];

        _boundingBox = [VFBoundingBox boundingBoxAtX:x atY:y withWidth:width andHeight:height];
        if(_boundingBox.height == 0)
        {
            _boundingBox.height = _options.pointsBetweenLines * 4;
        }

        //        // reset lines
        //        for(NSUInteger line = 0; line < self.options.numLines; ++line)
        //        {
        //            self.options.lineConfig[line][@"visible"] = @(YES);   //  @{
        //                                                                  //                @"visible" : @(YES)
        //            //            };   // addObject:[NSMutableDictionary dictionaryWithDictionary:@{ @"visible" :
        //            @(YES) }]];
        //        }
        self.height = (_options.numLines + _options.spaceAboveStaffLine) * _options.pointsBetweenLines;
        self.options.bottomTextPosition = _options.numLines + 1;

        // beginning bar
        VFStaffBarLine* leftStaffBarLine = [VFStaffBarLine barLineWithType:VFBarLineSingle atX:self.x];
        leftStaffBarLine.staff = self;
        [self.modifiers push:leftStaffBarLine];

        // ending bar
        VFStaffBarLine* rightStaffBarLine = [VFStaffBarLine barLineWithType:VFBarLineSingle atX:self.x + self.width];
        rightStaffBarLine.staff = self;
        [self.modifiers push:rightStaffBarLine];

        _fillColor = VFColor.blackColor;
        _strokeColor = VFColor.blackColor;
        _preFormatted = NO;
        _currentStaff = self;

        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

+ (VFStaff*)staffWithBoundingBox:(VFBoundingBox*)frame;
{
    return [VFStaff staffWithRect:frame.rect];
}

+ (VFStaff*)staffWithRect:(CGRect)rect;
{
    return [VFStaff staffAtX:CGRectGetMinX(rect)
                         atY:CGRectGetMinY(rect)
                       width:CGRectGetWidth(rect)
                      height:CGRectGetHeight(rect)];
}

+ (VFStaff*)staffAtX:(float)x atY:(float)y width:(float)width height:(float)height;
{
    return [[VFStaff alloc] initAtX:x atY:y width:width height:height optionsDict:nil];
}

+ (VFStaff*)staffWithRect:(CGRect)rect optionsDict:(NSDictionary*)optionsDict;
{
    return [[VFStaff alloc] initAtX:CGRectGetMinX(rect)
                                atY:CGRectGetMinY(rect)
                              width:CGRectGetWidth(rect)
                             height:CGRectGetHeight(rect)
                        optionsDict:optionsDict];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

#pragma mark - Configuration
/**---------------------------------------------------------------------------------------------------------------------
 * @name Configuration
 * ---------------------------------------------------------------------------------------------------------------------
 */

/**
 * Get the current configuration for the staff.
 * @return {Array} An array of NSDictionaries configuration objects.
 */
- (NSMutableArray*)getConfigForLines;
{
    return self.options.lineConfig;
}

/*!
 *  Configure properties of the lines in the staff
 *  @param lineNumber The index of the line to configure.
 *  @param lineConfig An configuration object for the specified line.
 *  @return this object
 */
- (id)setConfigForLine:(NSInteger)lineNumber withConfig:(NSDictionary*)lineConfig;
{
    // are there a valid number of lines
    if(lineNumber >= self.options.numLines || lineNumber < 0.0)
    {
        VFLogError(@"StaffConfigError, The line number must be within the range "
                   @"of the number of lines in the Staff.");
    }

    // is the 'visible' key stored in the line configuration dictionary passed in
    if(![lineConfig objectForKey:@"visible"])
    {
        VFLogError(@"StaffConfigError, The line configuration object is missing the 'visible' property.");
    }

    // is a boolean stored in the line configuration collection
    if(strcmp(@encode(BOOL), [[lineConfig objectForKey:@"visible"] objCType]))
    {
        VFLogError(@"StaffConfigError, The line configuration objects 'visible' property must be YES or NO.");
    }

    for(NSString* key in lineConfig.allKeys)
    {
        self.options.lineConfig[lineNumber][key] = lineConfig[key];
    }
    return self;
}

/*!
 *  Set the staff line configuration array for all of the lines at once.
 *  @param linesConfiguration An array of line configuration dictionaries.  These objects
 *   are of the same format as the single one passed in to setLineConfiguration().
 *   The caller can set null for any line config entry if it is desired that the default be used
 *  @return this object
 */
- (id)setConfigForLines:(NSArray*)linesConfiguration;
{
    NSMutableArray* tmpLinesConfiguration = [NSMutableArray arrayWithCapacity:linesConfiguration.count];
    for(int i = 0; i < linesConfiguration.count; ++i)
    {
        tmpLinesConfiguration[i] = linesConfiguration[i];
    }

    if(linesConfiguration.count != self.options.numLines)
    {
        VFLogError(@"StaffConfigError, The length of the lines configuration "
                   @"array must match the number of lines in " @"the Staff");
    }

    // Make sure the defaults are present in case an incomplete set of
    //  configuration options were supplied.
    for(int i = 0; i < linesConfiguration.count; ++i)
    {
        // Allow 'nil' to be used if the caller just wants the default for a particular node.
        //        if(tmpLinesConfiguration[i] != nil)
        if(((NSDictionary*)tmpLinesConfiguration[i]).allKeys.count == 0)
        {
            tmpLinesConfiguration[i] = self.options.lineConfig[i];
        }
        //        self.options.lineConfig[i] = [NSMutableDictionary merge:self.options.lineConfig[i]
        //        with:tmpLinesConfiguration[i]];

        else
        {
            for(NSString* key in((NSDictionary*)tmpLinesConfiguration[i]).allKeys)
            {
                self.options.lineConfig[i][key] = tmpLinesConfiguration[i][key];
            }
        }
    }
    return self;
}

- (float)spacingBetweenLines
{
    return self.options.pointsBetweenLines;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (NSString*)description;
{
    // TODO: figure this out
    return [self autoDescription];
}

//    NSString* ret = @"";
//    ret = [ret concat:[NSString stringWithFormat:@"KeySignature: %@", [self.keySignature description]]];
//    ret = [ret concat:[NSString stringWithFormat:@"TimeSignature: %@", [self.timeSignature description]]];
//    ret = [ret concat:[NSString stringWithFormat:@"Clef: %@", [self.clef description]]];
//    ret = [ret concat:[NSString stringWithFormat:@"BoundingBox: %@", [self.boundingBox description]]];
//    return ret;
//}

//- (NSString*)debugDescription;
//{
//    return self.description;
//}

//- (VFKeySignature*)keySignature
//{
//    if(!_keySignature)
//    {
//        _keySignature = [[VFTables keySpecsDictionary] objectForKey:@"C"];
//    }
//    return _keySignature;
//}

- (void)setKeySignature:(VFKeySignature*)keySignature
{
    if(_keySignature)
    {
        VFLogError(@"already added a keySignature.");
    }
    _keySignature = keySignature;
    [self addKeySignature:_keySignature];
}

- (VFTimeSignature*)timeSignature
{
    if(!_timeSignature)
    {
        _timeSignature = [VFTimeSignature timeSignatureWithType:VFTime4_4];
    }
    return _timeSignature;
}

- (StaffOptions*)options
{
    if(!_options)
    {
        _options = [StaffOptions staffOptions];
    }
    return _options;
}

- (NSMutableArray*)glyphs
{
    if(!_glyphs)
    {
        _glyphs = [[NSMutableArray alloc] init];
    }
    return _glyphs;
}

- (NSMutableArray*)endGlyphs
{
    if(!_endGlyphs)
    {
        _endGlyphs = [[NSMutableArray alloc] init];
    }
    return _endGlyphs;
}

- (NSMutableArray*)modifiers
{
    if(!_modifiers)
    {
        _modifiers = [[NSMutableArray alloc] init];
    }
    return _modifiers;
}

/*!
 *  reset the lines options
 */
- (void)resetLines
{
    self.options.lineConfig = nil;
    for(NSUInteger i = 0; i < self.options.numLines; ++i)
    {
        [self.options.lineConfig push:@{ @"visible" : @(YES) }];
    }
    self.height = (self.options.numLines + self.options.spaceAboveStaffLine) * self.options.spacing_between_lines_px;
    self.options.bottomTextPosition = self.options.numLines + 1;
}

- (id)setNoteStartX:(float)x
{
    _start_x = x;
    return self;
}

- (float)getNoteStartX
{
    float start_x = _start_x;

    // Add additional space if left barline is REPEAT_BEGIN and there are other
    // start modifiers than barlines
    if(((VFStaffBarLine*)self.modifiers[0]).barLinetype == VFBarLineRepeatBegin && self.modifiers.count > 2)
    {
        start_x += 20;
    }

    return start_x;
}

- (float)getNoteEndX
{
    return self.end_x;   // self.start_x + self.width;
}

- (float)getTieStartX
{
    return _start_x;
}

- (float)getTieEndX
{
    return self.x + self.width;
}

- (NSUInteger)getNumLines
{
    return self.options.numLines;
}

/*!
 *  sets the total width of this staff
 *  @param width the new width
 *  @return this object
 */
- (id)setWidth:(float)width
{
    _width = width;
    _glyph_end_x = self.x + width;
    self.boundingBox.width = _glyph_end_x;

    // reset the x position of the end barline (TODO(0xfe): This makes no sense)
    // this.modifiers[1].setX(this.end_x);
    return self;
}

/*!
 *  sets the measure of this particular staff
 *  @param measure the number to display
 */
- (void)setMeasure:(NSUInteger)measure
{
    _measure = measure;
}

/*!
 *  Bar Line functions
 *  @param begBarType beginning bar type
 *  @return this object
 */
- (id)setBegBarType:(VFBarLineType)begBarType;
{
    // only valid bar types at beginning of Staff is `none`, `single` or `begin repeat`
    if(begBarType == VFBarLineSingle || begBarType == VFBarLineRepeatBegin || begBarType == VFBarLineNone)
    {
        VFStaffBarLine* leftStaffBarLine = [VFStaffBarLine barLineWithType:begBarType atX:self.x];
        self.modifiers[0] = leftStaffBarLine;
        leftStaffBarLine.staff = self;
    }
    else
    {
        VFLogError(@"InvalidBegBarType, beginning bar type not set to: %li", begBarType);
    }
    return self;
}

/*!
 *  Bar Line functions
 *  @param endBarType ending bar type
 *  @return this object
 */
- (id)setEndBarType:(VFBarLineType)endBarType;
{
    // repeat end not valid at end of staff
    if(endBarType != VFBarLineRepeatBegin)
    {
        VFStaffBarLine* rightStaffBarLine = [VFStaffBarLine barLineWithType:endBarType atX:self.endX];
        self.modifiers[1] = rightStaffBarLine;
        rightStaffBarLine.staff = self;
    }
    return self;
}

/*!
 *  Gets the pixels to shift from the beginning of the stave
 *  following the modifier at the provided index
 *  @return The amount of pixels shifted
 */
- (float)getModifierXShift
{
    return [self getModifierXShift:-1];   // -1 indicates nil
}

/*!
 *  Gets the pixels to shift from the beginning of the stave
 *  following the modifier at the provided index
 *  @param index The index from which to determine the shift
 *  @return The amount of pixels shifted
 */
- (float)getModifierXShift:(NSInteger)index;
{
    if(index < 0)
    {
        index = self.glyphs.count - 1;
    }

    float x = self.glyph_start_x;
    float bar_x_shift = 0;

    for(NSUInteger i = 0; i < index + 1; ++i)
    {
        VFGlyph* glyph = self.glyphs[i];
        // TODO: memoize
        x += glyph.metrics.width;
        bar_x_shift += glyph.metrics.width;
    }

    // Add padding after clef, time sig, key sig
    if(bar_x_shift > 0)
    {
        bar_x_shift += self.options.verticalBarWidth + 10;
    }

    return bar_x_shift;
};

/*!
 *  Coda & Segno Symbol functions
 *  @param type repetition type
 *  @param y    y position relative to staff origin
 *  @return this object
 */
- (id)setRepetitionTypeLeft:(VFRepetitionType)type atY:(float)y;
{
    [self.modifiers push:[[VFStaffRepetition alloc] initWithType:type x:self.x y_shift:y]];
    return self;
}

/*!
 *  Coda & Segno Symbol functions
 *  @param type repetition type
 *  @param y    y position relative to staff origin
 *  @return this object
 */
- (id)setRepetitionTypeRight:(VFRepetitionType)type atY:(float)y;
{
    [self.modifiers push:[[VFStaffRepetition alloc] initWithType:type x:self.x y_shift:y]];
    return self;
}

/*!
 *  Volta functions
 *  @param type    volta type
 *  @param numberT number of 'times' to repeat displayed
 *  @param y       y position relative to staff origin
 *  @return this object
 */
- (id)setVoltaType:(VFVoltaType)type withNumber:(NSString*)numberT atY:(float)y;
{
    [self.modifiers push:[[VFStaffVolta alloc] initWithType:type number:numberT atX:self.x yShift:y]];
    return self;
}

/*!
 *  Section functions
 *  @param section the section
 *  @param y       shift up from staff origin
 *  @return this object
 */
- (id)setSectionWithSection:(NSString*)section atY:(float)y;
{
    [self.modifiers push:[VFStaffSection staffSectionWithSection:section withX:self.x yShift:y]];
    return self;
}

/*!
 *  sets the tempo label for the staff
 *  @param tempo options for the tempo:
 *                  `name`, `duration`, `dots`, `bpm`
 *  @param y     y position relative to staff origin
 *  @return this object
 */
- (id)setTempoWithTempo:(TempoOptionsStruct*)tempo atY:(float)y;
{
    [self.modifiers push:[[VFStaffTempo alloc] initWithTempo:tempo atX:self.x withShiftY:y]];
    return self;
}

/*!
 *  Text functions
 *  @param text     text to add
 *  @param position position of the text relative to the staff origin
 *  @param options  the following options to set text position:
 *                      `shift_x`
 *                      `shift_y`
 *                      `justification`
 *  @return this object
 */
- (id)setTextWithText:(NSString*)text atPosition:(VFPositionType)position withOptions:(NSDictionary*)options;
{
    [self.modifiers push:[[VFStaffText alloc] initWithText:text atPosition:position WithOptions:options]];
    return self;
}

/*!
 *  Text functions
 *  @param text     text to add
 *  @param position position of the text relative to the staff origin
 *  @param options  the following options to set text position:
 *  @return this object
 */
- (id)setTextWithText:(NSString*)text atPosition:(VFPositionType)position;
{
    return [self setTextWithText:text atPosition:position withOptions:nil];
}

/*!
 *  returns bounding box around this staff
 *  @return a bounding box instance
 */
- (VFBoundingBox*)boundingBox
{
    if(!_boundingBox)
    {
        float y = [self getYForLine:self.options.numLines];
        float height = ABS(y - [self getYForLine:0]);
        _boundingBox = [VFBoundingBox boundingBoxAtX:self.x atY:y withWidth:self.width andHeight:height];
        _boundingBox.height = self.options.pointsBetweenLines * self.options.numLines;
    }
    return _boundingBox;
}

- (VFPoint*)point
{
    VFBoundingBox* bb = [self boundingBox];
    return VFPointMake(bb.xPosition, bb.yPosition);
}

//- (VFColor*)strokeColor
//{
//    if(!_strokeColor)
//    {
//        _strokeColor = VFColor.blackColor;
//    }
//    return _strokeColor;
//}
//
//- (void)setStrokeColor:(VFColor*)strokeColor
//{
//    _strokeColor = strokeColor;
//}
//
//- (VFColor*)fillColor
//{
//    if(!_fillColor)
//    {
//        _fillColor = VFColor.blackColor;
//    }
//    return _fillColor;
//}
//
//- (void)setFillColor:(VFColor*)fillColor
//{
//    _fillColor = fillColor;
//}

- (void)setXPosition:(float)xPosition
{
    //    _boundingBox.xPosition = xPosition;
    _x = xPosition;
}
//
//- (float)startXPosition {
//    return self.x;
//}

- (float)x
{
    //    return _boundingBox.xPosition;
    return _x;
}

- (float)y
{
    //    return _boundingBox.xPosition;
    return _y;
}

- (void)setYPosition:(float)yPosition
{
    _boundingBox.yPosition = yPosition;
}

- (float)yPosition
{
    return _boundingBox.yPosition;
}

// defined above
//- (void)setWidth:(float)width {
//    _boundingBox.width = width;
//}

- (float)width
{
    return _boundingBox.width;
}

- (void)setHeight:(float)height
{
    //    _boundingBox.height = height;
    // TODO: height is set in StaffOptions
}

- (float)height
{
    //    return self.boundingBox.height;
    float y = [self getYForLine:self.options.numLines];
    float height = ABS(y - [self getYForLine:0]);
    return height;
}

- (float)endX
{
    return self.x + self.width;
}

//- (VFKeySignatureFlavorType)getFlavorForLine:(NSInteger)line
//{
//    // staff.cleftype
//
//    //    NSArray *flatPositionsGClef = @[ @(3), @(4.5), @(2.5), @(4), @(2), @(3.5), @(1.5), ];
//    //
//    //    NSArray *sharpPositionsGClef = @[ @(5), @(3.5), @(5.5), @(4), @(2.5), @(4.5), @(3), ];
//    //
//
//    return VFKeySignatureNone;
//}

//- (VFPoint *)startPosition {
//    if (!_start_x) {
//        _startPosition = [VFPoint pointZero];
//    }
//    return [_startPosition copy];
//}

- (void)setClefName:(NSString*)clefName
{
    _clefName = clefName;
    NSString* lookup = [clefName lowercaseString];
    typedef void (^CaseBlock)();
    _clefType = 0;
    NSDictionary* d = @{
        @"treble" : ^{
          _clefType = VFClefTreble;
        },
        @"bass" : ^{
          _clefType = VFClefBass;
        },
        @"alto" : ^{
          _clefType = VFClefAlto;
        },
        @"tenor" : ^{
          _clefType = VFClefTenor;
        },
        @"percussion" : ^{
          _clefType = VFClefPercussion;
        },
        @"soprano" : ^{
          _clefType = VFClefSoprano;
        },
        @"mezzo-soprano" : ^{
          _clefType = VFClefMezzoSoprano;
        },
        @"baritone-c" : ^{
          _clefType = VFClefBaritoneC;
        },
        @"baritone-f" : ^{
          _clefType = VFClefBaritoneF;
        },
        @"subbass" : ^{
          _clefType = VFClefSubBass;
        },
        @"french" : ^{
          _clefType = VFClefFrench;
        },
        @"moveable-c" : ^{
          _clefType = VFClefMovableC;
        },
    };

    ((CaseBlock)d[lookup])();
    if(_clefType == 0)
    {
        VFLogError(@"BadArgument, unknown name passed as clef type: %@", clefName);
    }
}

- (void)setClefType:(VFClefType)clefType
{
    switch(clefType)
    {
        case VFClefAlto:
            _clefName = @"alto";
            break;
        case VFClefBass:
            _clefName = @"bass";
            break;
        case VFClefPercussion:
            _clefName = @"percussion";
            break;
        case VFClefTenor:
            _clefName = @"tenor";
            break;
        case VFClefTreble:
            _clefName = @"treble";
            break;
        case VFClefSoprano:
            _clefName = @"soprano";
            break;
        case VFClefMezzoSoprano:
            _clefName = @"mezzo-soprano";
            break;
        case VFClefBaritoneC:
            _clefName = @"baritone-c";
            break;
        case VFClefBaritoneF:
            _clefName = @"baritone-f";
            break;
        case VFClefSubBass:
            _clefName = @"subbass";
            break;
        case VFClefFrench:
            _clefName = @"french";
            break;
        case VFClefMovableC:
            _clefName = @"moveable-c";
            break;
        default:
            VFLogError(@"BadArgument, unknown clef type");
            break;
    }

    [self addClefWithName:_clefName];

    // TODO: using the following creates an infinite loop
    //    [self addClefWithType:clefType];
}

- (NSUInteger)numberOfLines
{
    return self.options.numLines;
}

- (void)setNumberOfLines:(NSUInteger)numberOfLines
{
    self.options.numLines = numberOfLines;
}

#pragma mark - Get y positions Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Get y positions Methods
 * ---------------------------------------------------------------------------------------------------------------------
 *
 *   staff lines are arranged as follows
 *
 *
 *                FLIPPED
 *       ---        -1   6
 *                  -0.5 5.5
 *  +--------------  0   5
 *  |                0.5 4.5
 *  +--------------  1   4
 *  |                1.5 3.5
 *  +--------------  2   3
 *  |                2.5 2.5
 *  +--------------  3   2
 *  |                3.5 1.5
 *  +--------------  4   1
 *                   4.5 0.5
 *       ---         5   0
 */

/*!
 *  gets the bottom y coordinate in global space
 *  @return the bottom y coordinate
 */
- (float)getBottomY;
{
    StaffOptions* options = self.options;
    float spacing = options.spacing_between_lines_px;
    float score_bottom = [self getYForLine:options.numLines] + (options.spaceBelowStaffLine * spacing);
    return score_bottom;
}

- (float)translateLine:(float)line
{
    return -1 * line + 5;
}

/*!
 *  gets absolute y position for line
 *  @param line staff line
 *  @return y position
 */
- (float)getYForLine:(float)line;
{
    //    line = [self translateLine:line];

    float spacing = self.options.pointsBetweenLines;
    float headroom = self.options.spaceAboveStaffLine;
    //    float y = self.yPosition + line * spacing + headroom;
    float y = self.yPosition + ((line * spacing) + (headroom * spacing)) - (kTHICKNESS / 2);
    return y;
}

/*!
 *  gets absolute y position for top text line
 *  @param line staff line
 *  @return y position
 */
- (float)getYForTopTextWithLine:(float)line;
{
    return [self getYForLine:(-line - self.options.topTextPosition)];
}

/*!
 *  gets absolute y position for top text line
 *  @return y position
 */
- (float)getYForTopText;
{
    return [self getYForTopTextWithLine:0];
}

/*!
 *  gets absolute y position for bottom text line
 *  @param line staff line
 *  @return y position
 */
- (float)getYForBottomTextWithLine:(float)line;
{
    return [self getYForLine:(line + self.options.topTextPosition)];
}

/*!
 *  gets absolute y position for top text line
 *  @return y position
 */
- (float)getYForBottomText;
{
    return [self getYForBottomTextWithLine:0];
}

/*!
 *  gets absolute y position for a note
 *  @param line staff line
 *  @return y position
 */
- (float)getYForNoteWithLine:(float)line;
{
    StaffOptions* options = _options;
    float spacing = options.pointsBetweenLines;
    float headroom = options.spaceAboveStaffLine;
    float y = self.yPosition + ((headroom * spacing) + (5. * spacing) - (line * spacing));
    return y;
}

/*!
 *  gets absolute y position for glyphs
 *  @return y position
 */
- (float)getYForGlyphs;
{
    return [self getYForLine:3];
}

#pragma mark - Add Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Add Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  adds a glyph
 *  @param glyph the glyph object
 *  @return this object
 */
- (id)addGlyph:(VFGlyph*)glyph;
{
    if((!glyph.metrics.code || glyph.metrics.code.length == 0) && !glyph.drawBlock)
    {
        VFLogError(@"EmptyGlyphCodeException");
    }
    glyph.parent = self;
    [self.glyphs push:glyph];
    float glyphWidth = glyph.metrics.width;
    _start_x += glyphWidth;
    return self;
}

/*!
 *  adds a glyph to end
 *  @param glyph the glyph object
 *  @return this object
 */
- (id)addEndGlyph:(VFGlyph*)glyph;
{
    glyph.parent = self;
    [self.endGlyphs push:glyph];
    float glyphWidth = glyph.metrics.width;
    //    self.endXPosition -= glyphWidth;
    _end_x -= glyphWidth;
    return self;
}

/*!
 *  creates a blank glyph that does not render anything except it takes up space
 *  @param padding amount of space the blank glyph occupies
 *  @return a blank glyph
 */
- (VFGlyph*)makeSpacer:(float)padding
{
    VFGlyph* ret = [[VFGlyph alloc] init];
    ret.metrics.width = padding;
    ret.drawBlock = ^(CGContextRef context, float x, float y) { /* do nothing */ };
    //    ret.metrics.bounds =
    //        [VFBoundingBox boundingBoxAtX:0
    //                                  atY:0
    //                            withWidth:padding
    //                            andHeight:50];
    //  NOTE: the height is arbitrary, perhaps there's a better way

    return ret;
}

/*!
 *  adds a modifier
 *  @param modifier a staff modifier
 *  @return this object
 */
- (id)addModifier:(VFStaffModifier*)modifier;
{
    [self.modifiers push:modifier];
    modifier.staff = self;   // CHANGE
    [modifier addToStaff:self firstGlyph:(self.glyphs.count == 0)];
    return self;
}

/*!
 *  adds a modifier to end
 *  @param modifier a staff modifier
 *  @return this object
 */
- (id)addEndModifier:(VFStaffModifier*)modifier;
{
    [self.modifiers push:modifier];
    modifier.staff = self;   // CHANGE
    [modifier addToStaffEnd:self firstGlyph:(self.glyphs.count == 0)];
    return self;
}

/*!
 *  adds a key signature to the start of this staff
 *  @param signature the specifier for the signature
 *  @return this object
 */
- (id)addKeySignature:(NSString*)signature;
{
    [self addModifier:[VFKeySignature keySignatureWithKey:signature]];
    return self;
}

/*!
 *  adds a key signature to the start of this staff
 *  @param keySpec. one of:
 *              'C', 'CN', 'C#', 'C##', 'CB', 'CBB', 'D', 'DN', 'D#',
 *              'D##', 'DB', 'DBB', 'E', 'EN', 'E#', 'E##', 'EB',
 *              'EBB', 'F', 'FN', 'F#', 'F##', 'FB', 'FBB', 'G', 'GN', 'G#',
 *              'G##', 'GB', 'GBB', 'A', 'AN', 'A#', 'A##',
 *              'AB', 'ABB', 'B', 'BN', 'B#', 'B##', 'BB', 'BBB', 'R', 'X'
 *  @return this object
 */
- (id)addKeySignatureWithSpec:(NSString*)keySpec;
{
    // TODO: this is possibly broken
    [self addModifier:[VFTables keySignatureWithString:keySpec]];
    return self;
}

/*!
 *  adds a treble clef to the start of this staff
 *  @return this object
 */
- (id)addTrebleGlyph;
{
    self.clefType = VFClefTreble;
    //    VFClef* clef = [VFClef clefWithType:self.clefType];
    //    [self addModifier:clef];
    return self;
}

/*!
 *  adds a clef to the start of this staff
 *  @param clefType the clef type enum value
 *  @return this object
 */
- (id)addClefWithType:(VFClefType)clefType;
{
    self.clefType = clefType;
    VFClef* clef = [VFClef clefWithType:clefType];
    [self addModifier:clef];
    return self;
}

/*!
 *  adds a clef to the start of this staff
 *  @param clefName name of the clef. one of
 *                      `treble`, `alto`, `baritone-c`, `baritone-f`, `bass`, `french`,
 *                      `soprano`, `moveable-c`, percussion, soprano,
 *                      `subbass`, `tenor`
 *  @return this object
 */
- (id)addClefWithName:(NSString*)clefName;
{
    self.clefName = clefName;
    VFClef* clef = [VFClef clefWithName:clefName];
    self.clef = clef;
    [self addModifier:clef];
    return self;
}

/*!
 *  adds a clef to the end of this staff
 *  @param clefName name of the clef. one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @return this object
 */
- (id)addEndClefWithName:(NSString*)clefName
{
    self.clefName = clefName;
    VFClef* clef = [VFClef clefWithName:clefName];
    [self addEndModifier:clef];
    return self;
}

/*!
 *  adds a clef to the start of this staff
 *  @param clef the clef object
 *  @return thix object
 */
- (id)addClef:(VFClef*)clef;
{
    self.clefName = clef.clefName;
    [self addModifier:clef];
    return self;
}

/*!
 *  adds a clef to the start of this staff
 *  @param clefName name of the clef. one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @param size     the size of the clef
 *  @return this object
 */
- (id)addClefWithName:(NSString*)clefName size:(NSString*)size;
{
    self.clefName = clefName;
    VFClef* clef = [VFClef clefWithName:clefName size:size];
    [self addModifier:clef];
    return self;
}

/*!
 *  adds a clef to the start of this staff
 *  @param clefName   name of the clef. one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @param size       the size of the clef
 *  @param annotation a clef annotation
 *  @return this object
 */
- (id)addClefWithName:(NSString*)clefName size:(NSString*)size annotation:(NSString*)annotation;
{
    self.clefName = clefName;
    VFClef* clef = [VFClef clefWithName:clefName size:size annotationName:annotation];
    [self addModifier:clef];
    return self;
}

/*!
 *  adds a clef to the end of this staff
 *  @param clefName name of the clef. one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @param size     the size of the clef
 *  @return this object
 */
- (id)addEndClefWithName:(NSString*)clefName size:(NSString*)size;
{
    self.clefName = clefName;
    [self addEndModifier:[VFClef clefWithName:clefName size:size]];
    return self;
}

/*!
 *  adds a clef to the end of this staff
 *  @param clefName   the name of the clef, one of
 *                      treble, alto, baritone-c, baritone-f, bass, french, soprano, moveable-c, percussion, soprano,
 *                      subbass, tenor
 *  @param size       the size of the clef
 *  @param annotation an annotation
 *  @return this object
 */
- (id)addEndClefWithName:(NSString*)clefName size:(NSString*)size annotation:(NSString*)annotation;
{
    self.clefName = clefName;
    [self addEndModifier:[VFClef clefWithName:clefName size:size annotationName:annotation]];
    return self;
}

/*!
 *  adds a time signature to the start
 *  @param signature time signature name
 *  @return this object
 */
- (id)addTimeSignatureWithName:(NSString*)signature;
{
    //[self addModifier:[[VFTimeSignature alloc] initWithTimeSpec:signature andPadding:0]];

    float padding = 5;
    VFTimeSignature* timeSignature = [[VFTimeSignature alloc] initWithTimeSpec:signature andPadding:padding];
    [self addModifier:timeSignature];
    _glyph_start_x += timeSignature.width;
    return self;
}

/*!
 *  adds a time signature to the end
 *  @param signature time signature name
 *  @return this object
 */
- (id)addEndTimeSignatureWithName:(NSString*)signature;
{
    float padding = 5;
    VFTimeSignature* timeSignature = [[VFTimeSignature alloc] initWithTimeSpec:signature andPadding:padding];
    [self addEndModifier:timeSignature];
    _glyph_end_x -= timeSignature.width;
    return self;
}

/*!
 *  adds a time signature to the start
 *  @param signature time signature name
 *  @param padding   amount of space between time siganture and next glyph
 *  @return this object
 */
- (id)addTimeSignatureWithName:(NSString*)signature padding:(float)padding;
{
    [self addModifier:[[VFTimeSignature alloc] initWithTimeSpec:signature andPadding:padding]];
    return self;
}

/*!
 *  adds a time signature to the start
 *  @param signature time signature object
 *  @param padding   amount of space between time siganture and next glyph
 *  @return this object
 */
- (id)addTimeSignature:(VFTimeSignature*)signature padding:(float)padding;
{
    signature.padding = padding;
    [self addModifier:signature];
    return self;
}

/*!
 *  adds a time signature to the end
 *  @param signature     time signature object
 *  @return this object
 */
- (id)addEndTimeSignature:(VFTimeSignature*)signature;
{
    [self addEndModifier:signature];
    return self;
}

#pragma mark Draw Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Draw
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  draw line numbers for debugging
 */
- (void)drawLineNumbers
{
    float x = self.boundingBox.xPosition;
    float y;
    float w = self.width;   // self.boundingBox.width;

    for(NSUInteger line = 0; line < self.options.numLines; line++)
    {
        y = [self getYForLine:line];
        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = kCTTextAlignmentLeft;
        VFFont* font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:8];
        NSString* text = [NSString stringWithFormat:@"%lu, %.01f", line, y];
        NSAttributedString* title = [[NSAttributedString alloc]
            initWithString:text
                attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
        [title drawAtPoint:CGPointMake(x + w + 10, y - 5)];
    }

    NSArray* arr = @[ @(-1), @(5) ];
    for(NSNumber* n in arr)
    {
        NSInteger line = [n floatValue];
        float y = [self getYForLine:line];
        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = kCTTextAlignmentLeft;
        VFFont* font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:8];
        NSString* text = [NSString stringWithFormat:@"%li, %.01f", line, y];
        NSAttributedString* title = [[NSAttributedString alloc]
            initWithString:text
                attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
        [title drawAtPoint:CGPointMake(x + w + 10, y - 5)];
    }
}

/*!
 *  draw everything
 *  @param ctx graphics context
 */
- (void)draw:(CGContextRef)ctx
{
    [self.strokeColor setStroke];
    [self.fillColor setFill];
    //    [VFColor.blackColor setStroke];
    //    [VFColor.blackColor setFill];

    float x = self.boundingBox.xPosition;
    float y;
    float w = self.width;   // self.boundingBox.width;

    // draw horizontal lines
    VFBezierPath* path;
    for(NSUInteger line = 0; line < self.options.numLines; line++)
    {
        y = [self getYForLine:line];
        if([[(self.options.lineConfig[line])objectForKey:@"visible"] boolValue])
        {
            path = (VFBezierPath*)[VFBezierPath bezierPathWithRect:CGRectMake(x, y, w, kSTAFF_LINE_THICKNESS)];
            [path fill];
            //                        CGContextBeginPath(ctx);
            //                        CGContextMoveToPoint(ctx, x, y);
            //                        CGContextAddRect(ctx, CGRectMake(x, y, w, 1));
            //                        CGContextDrawPath(ctx, kCGPathFillStroke);
        }
    }

    //    [self drawLineNumbers];

    // Render glyphs
    x = self.glyph_start_x;
    for(NSUInteger i = 0; i < self.glyphs.count; ++i)
    {
        VFGlyph* glyph = self.glyphs[i];
        Metrics* metrics = glyph.metrics;
        //        [glyph renderWithContext:ctx atX:x atY:[self getYForGlyphs]];
        [glyph renderWithContext:ctx toStaff:self atX:x];
        x += metrics.width;
    }

    // Render end glyphs
    x = self.glyph_end_x;
    for(NSUInteger i = 0; i < self.endGlyphs.count; ++i)
    {
        VFGlyph* glyph = self.endGlyphs[i];
        Metrics* metrics = glyph.metrics;
        x -= metrics.width;
        //        [glyph renderWithContext:ctx atX:x atY:[self getYForGlyphs]];
        [glyph renderWithContext:ctx toStaff:self atX:x];
    }

    [[self.modifiers filter:^BOOL(VFModifier* modifier) {
      return [modifier isKindOfClass:[VFTimeSignature class]];
    }] foreach:^(VFTimeSignature* staffModifier, NSUInteger index, BOOL* stop) {
      [staffModifier drawWithContext:ctx toStaff:self withShiftX:[self getModifierXShift]];
    }];

    // Draw the modifiers (bar lines, coda, segno, repeat brackets, etc.)
    [[self.modifiers filter:^BOOL(VFModifier* modifier) {
      return [modifier isKindOfClass:[VFStaffModifier class]];
    }] foreach:^(VFStaffModifier* staffModifier, NSUInteger index, BOOL* stop) {
      [staffModifier drawWithContext:ctx toStaff:self withShiftX:[self getModifierXShift]];
    }];

    [[self.modifiers filter:^BOOL(VFModifier* modifier) {
      return ([modifier isKindOfClass:[VFStaffText class]]);
    }] foreach:^(VFStaffText* staffText, NSUInteger index, BOOL* stop) {
      [staffText drawWithContext:ctx toStaff:self];
    }];

    // Render measure numbers
    if(self.measure > 0)
    {
        float y = [self getYForTopText];
        NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = kCTTextAlignmentLeft;
        VFFont* font1 = [VFFont fontWithName:@"TimesNewRomanPS-BoldMT" size:10];
        NSString* text = [NSString stringWithFormat:@"%lu", self.measure];
        NSAttributedString* title = [[NSAttributedString alloc]
            initWithString:text
                attributes:@{NSParagraphStyleAttributeName : paragraphStyle, NSFontAttributeName : font1}];
        [title drawInRect:CGRectMake(self.x, y - 3, 50, 100)];
    }
}

- (void)drawVertical:(CGContextRef)ctx x:(float)x
{
    [self drawVertical:ctx x:x isDouble:NO];
}

- (void)drawVertical:(CGContextRef)ctx x:(float)x isDouble:(BOOL)isDouble
{
    [self drawVerticalFixed:ctx x:(self.x + x)isDouble:isDouble];
}

- (void)drawVerticalFixed:(CGContextRef)ctx x:(float)x isDouble:(BOOL)isDouble
{
    if(!ctx)
    {
        [VFLog logError:@"NoCanvasContext, Can't draw Staff without canvas context."];
    }
    float top_line = [self getYForLine:0];
    float bottom_line = [self getYForLine:(self.options.numLines - 1)];
    if(isDouble)
    {
        CGMutablePathRef path = CGPathCreateMutable();
        CGRect rectangle = CGRectMake(x - 3, top_line, 1, bottom_line - top_line + 1);
        CGPathAddRect(path, NULL, rectangle);
        CGContextAddPath(ctx, path);
        [self.strokeColor setStroke];
        [self.fillColor setFill];
        CGContextSetLineWidth(ctx, 1.0f);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        CGPathRelease(path);
    }
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rectangle = CGRectMake(x, top_line, 1, bottom_line - top_line + 1);
    CGPathAddRect(path, NULL, rectangle);
    CGContextAddPath(ctx, path);
    [self.strokeColor setStroke];
    [self.fillColor setFill];
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGPathRelease(path);
}

- (void)drawVerticalBar:(CGContextRef)ctx x:(float)x
{
    [self drawVerticalBarFixed:ctx x:(self.x + x)];
}

- (void)drawVerticalBarFixed:(CGContextRef)ctx x:(float)x
{
    if(!ctx)
    {
        [VFLog logError:@"NoCanvasContext, Can't draw Staff without canvas context."];
    }
    float top_line = [self getYForLine:0];
    float bottom_line = [self getYForLine:(self.options.numLines - 1)];
    CGMutablePathRef path = CGPathCreateMutable();
    CGRect rectangle = CGRectMake(x, top_line, 1, bottom_line - top_line + 1);
    CGPathAddRect(path, NULL, rectangle);
    CGContextAddPath(ctx, path);
    [self.strokeColor setStroke];
    [self.fillColor setFill];
    CGContextSetLineWidth(ctx, 1.0f);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    CGPathRelease(path);
}

- (void)drawBoundingBox:(CGContextRef)ctx
{
    //    VFBoundingBox* box = [VFBoundingBox boundingBoxWithRect:_boundingBox.rect];
    //    box.yPosition = [self getYForLine:0] - 10;
    //    box.xPosition -= 10;
    //    box.height += 20;
    //    box.width += 20;
    float y = [self getYForLine:0] - 10;
    //    float height = ABS(y - [self getYForLine:self.options.numLines]);
    VFBoundingBox* box = [VFBoundingBox boundingBoxAtX:self.x - 10 atY:y withWidth:self.width + 20 andHeight:0];
    box.height = self.options.pointsBetweenLines * (1 + self.options.numLines);

    [box draw:ctx];
}

@end
