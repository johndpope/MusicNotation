
//  VFTimeSignature.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete
// Refactored

#import "VFTimeSignature.h"
#import "VFVex.h"
#import "VFGlyph.h"
#import "VFStaffModifier.h"
#import "VFMetrics.h"
#import "VFBoundingBox.h"
#import "VFPoint.h"
#import "VFStaff.h"
#import "VFDelegates.h"
#import "VFGlyphList.h"
#import "VFSymbol.h"
#import "VFPoint.h"
#import "VFSymbol.h"
#import "VFPadding.h"
#import "VFSize.h"
#import "VFEnum.h"

// options category
@implementation TimeSignatureOptions
@end

@interface TimeSignatureGlyphMetrics : Metrics
{
   @private
    float _x_min;
    float _x_max;
}
@property (assign, nonatomic) float x_min;
@property (assign, nonatomic) float x_max;
@end

//@interface TimeSignatureGlyph : VFGlyph
//@property (assign, nonatomic) float line;
//@end

//@implementation TimeSignatureGlyph
//@end

@interface VFTimeSignature ()
//@property (strong, nonatomic) VFGlyph* glyph;
@property (assign, nonatomic) float topLine;
@property (assign, nonatomic) float bottomLine;
@property (strong, nonatomic) NSMutableArray* topGlyphs;
@property (strong, nonatomic) NSMutableArray* botGlyphs;
@property (assign, nonatomic) BOOL num;
@property (assign, nonatomic) float line;
@property (strong, nonatomic) NSArray* topCodes;
@property (strong, nonatomic) NSArray* bottomCodes;
@property (strong, nonatomic) NSArray* topNumbers;
@property (strong, nonatomic) NSArray* bottomNumbers;
@end

@implementation TimeSignatureGlyphMetrics
- (float)x_min
{
    return _x_min;
}
- (float)x_max
{
    return _x_max + self.width;
}
@end

@implementation VFTimeSignature
//@dynamic glyph;

#pragma mark - Initialization
/**---------------------------------------------------------------------------------------------------------------------
 * @name Initialization
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        self.num = NO;
        if(self.padding == 0)
        {
            self.padding = 15;
        }
        [self setPadding:15];
        self.topLine = 2;
        self.bottomLine = 4;
        self.point.x = 40;
        BOOL haveGlyph = [self parseTimeSpec:self.timeSpec];
        if(!haveGlyph)
        {
            self.glyph =
                [self makeTimeSignatureGlyphWithTopNumbers:self.topNumbers andBottomNumbers:self.bottomNumbers];
        }
    }
    return self;
}

- (instancetype)initWithTimeSpec:(NSString*)timeSpec andPadding:(float)padding;
{
    self = [self initWithDictionary:@{@"timeSpec" : timeSpec}];
    if(self)
    {
        //        _timeSpec = timeSpec;
        self.padding = padding;
    }
    return self;
}

- (instancetype)initWithTimeType:(VFTimeType)type
{
    self = [self initWithDictionary:@{ @"timeSpec" : [VFEnum simplNameForTimeType:type] }];
    if(self)
    {
        _timeType = type;
        // TODO: implement this method
    }
    return self;
}

+ (VFTimeSignature*)standard_4_4_TimeSignature
{
    return [[VFTimeSignature alloc] initWithTimeType:VFTime4_4];
}

+ (VFTimeSignature*)timeSignatureWithType:(VFTimeType)type;
{
    return [[VFTimeSignature alloc] initWithTimeType:type];
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

/*!
 *  category of this modifier
 *  @return class name
 */
+ (NSString*)CATEGORY
{
    return @"timesignature";
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (NSString*)timeSpec
{
    if(!_timeSpec)
    {
        _timeSpec = [[NSString alloc] init];
    }
    return _timeSpec;
}

- (NSArray*)topCodes
{
    if(!_topCodes)
    {
        //        _topCodes = [NSMutableArray array];
        VFLogError(@"TimeSignatureTopCodeUnitializedException, intiialize top codes first");
    }
    return _topCodes;
}

- (NSArray*)bottomCodes
{
    if(!_bottomCodes)
    {
        //        _bottomCodes = [NSMutableArray array];
        VFLogError(@"TimeSignatureBottomCodeUnitializedException, intiialize bottom codes first");
    }
    return _bottomCodes;
}

//- (NSMutableArray*)topNumbers
//{
//    if(!_topNumbers)
//    {
//        _topNumbers = [NSMutableArray array];
//    }
//    return _topNumbers;
//}
//
//- (NSMutableArray*)bottomNumbers
//{
//    if(!_bottomNumbers)
//    {
//        _bottomNumbers = [NSMutableArray array];
//    }
//    return _bottomNumbers;
//}

//- (VFGlyph*)glyph //(TimeSignatureGlyph*)glyph
//{
//    return _glyph;
//}

//- (void)setGlyph:(TimeSignatureGlyph*)glyph
//{
//    _glyph = glyph;
//}

#pragma mark - LU Tables
/**---------------------------------------------------------------------------------------------------------------------
 * @name LU Tables
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (void)setCodeAndName
{
    switch(self.timeType)
    {
        case VFTime4_4:
            self.name = @"4_4";
            self.timeSpec = [NSString stringWithFormat:@"4/4"];
            break;
        case VFTime3_4:
            self.name = @"3_4";
            self.timeSpec = [NSString stringWithFormat:@"3/4"];
            break;
        case VFTime2_4:
            self.name = @"2_4";
            self.timeSpec = @"2/4";
            break;
        case VFTime4_2:
            self.name = @"4_2";
            self.timeSpec = @"4/2";
            break;
        case VFTime2_2:
            self.name = @"2_2";
            self.timeSpec = @"2/2";
            break;
        case VFTime3_8:
            self.name = @"3_8";
            self.timeSpec = @"3/8";
            break;
        case VFTime6_8:
            self.name = @"6_8";
            self.timeSpec = @"6/8";
            break;
        case VFTime9_8:
            self.name = @"9_8";
            self.timeSpec = @"9/8";
            break;
        case VFTime12_8:
            self.name = @"12_8";
            self.timeSpec = @"12/8";
            break;
        default:
            [VFLog logError:@"bad choice of timeType enum"];
            break;
    }
    [((Metrics*)self->_metrics)setName:self.name];
}

static NSDictionary* _standardTimeSignatures;
+ (NSDictionary*)standardTimeSignatures
{
    if(!_standardTimeSignatures)
    {
        _standardTimeSignatures = @{
            @"C" : @{@"code" : @"v41", @"point" : @40, @"line" : @2},
            @"C|" : @{@"code" : @"vb6", @"point" : @40, @"line" : @2},
        };
    }
    return _standardTimeSignatures;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  <#Description#>
 *  @param timeSpec <#timeSpec description#>
 */
- (BOOL)parseTimeSpec:(NSString*)timeSpec
{
    if(!timeSpec)
    {
        VFLogError(@"MissingTimeSpecTimeSignatureException, Try adding a time spec to this time signature.");
    }

    if([timeSpec isEqualToString:@"C"] || [timeSpec isEqualToString:@"C|"])
    {
        self.num = NO;
        NSDictionary* sig = [self class].standardTimeSignatures[timeSpec];
        self.line = [sig[@"line"] floatValue];
        self.glyph = [[VFGlyph alloc] initWithCode:sig[@"code"] withPointSize:[sig[@"point"] floatValue]];
        return YES;
    }

    // ensure that this timeSpec is of the correct format
    //  using a regex
    NSString* timeSpecRegexString = @"^[0-9]+/[0-9]+$";

    NSString* timeSpecErrMsg =
        [NSString stringWithFormat:@"TimeSignatureFormatException, must be of form: @%@", timeSpecRegexString];
    NSError* ts_error = nil;
    NSRegularExpression* timeSpecRegex =
        [NSRegularExpression regularExpressionWithPattern:timeSpecRegexString
                                                  options:NSRegularExpressionIgnoreMetacharacters
                                                    error:&ts_error];
    NSString* timeSpecMatch = [timeSpecRegexString
        substringWithRange:[timeSpecRegex rangeOfFirstMatchInString:timeSpecRegexString
                                                            options:NSMatchingReportCompletion
                                                              range:NSMakeRange(0, timeSpecRegexString.length)]];
    if(!timeSpecMatch)
    {
        [VFLog logError:timeSpecErrMsg];
    }

    // split the timeSpec string
    NSArray* specComponents = [timeSpec componentsSeparatedByString:@"/"];

    // time signatures are composed of only two digits
    if(specComponents.count != 2)
    {
        VFLogError(@"%@", timeSpecErrMsg);
        VFLogError(@"invalid values: %@%@%@", @"received values=[", [NSString stringWithFormat:@"%@", specComponents],
                   @"]");
    }

    // get a formatter to convert from a string to an actual number
    NSNumberFormatter* f = [[NSNumberFormatter alloc] init];
    [f setNumberStyle:NSNumberFormatterDecimalStyle];

    NSArray* (^split)(NSString*) = ^NSArray*(NSString* inputString)
    {
        NSMutableArray* chars = [[NSMutableArray alloc] initWithCapacity:inputString.length];
        for(NSUInteger i = 0; i < inputString.length; ++i)
        {
            [chars addObject:[NSString stringWithFormat:@"%C", [inputString characterAtIndex:i]]];
        }
        return chars;
    };
    //
    //    self.topCodes = split(specComponents[0]);
    //    self.bottomCodes = split(specComponents[1]);

    NSArray* topNumbers = split(specComponents[0]);
    topNumbers = [topNumbers oct_map:^NSNumber*(NSString* element) {
      return [NSNumber numberWithInteger:[element integerValue]];
    }];
    //    topNumbers = [topNumbers.rac_sequence map:^NSNumber*(NSString* element) {
    //                   return [NSNumber numberWithInteger:[element integerValue]];
    //                 }].array;
    //
        self.topNumbers = topNumbers;

    NSArray* bottomNumbers = split(specComponents[1]);
    bottomNumbers = [bottomNumbers oct_map:^NSNumber*(NSString* element) {
      return [NSNumber numberWithInteger:[element integerValue]];
    }];
    //    bottomNumbers = [bottomNumbers.rac_sequence map:^NSNumber*(NSString* element) {
    //                      return [NSNumber numberWithInteger:[element integerValue]];
    //                    }].array;
    //
        self.bottomNumbers = bottomNumbers;

    self.num = YES;
    return NO;
}

/*!
 *  makes a custom glyph for as the time signature
 *  @return a custom glyph with a custom draw method
 */
- (VFGlyph*)makeTimeSignatureGlyphWithTopNumbers:(NSArray*)topNums andBottomNumbers:(NSArray*)botNums
{
    VFGlyph* glyph = [[VFGlyph alloc] initWithCode:@"v0" withPointSize:1];
    //    glyph.metrics = [[TimeSignatureGlyphMetrics alloc] init];

    NSMutableArray* topGlyphs = [NSMutableArray arrayWithCapacity:topNums.count];
    NSMutableArray* botGlyphs = [NSMutableArray arrayWithCapacity:botNums.count];

    float topWidth = 0;
    NSUInteger num;
    for(NSUInteger i = 0; i < topNums.count; ++i)
    {
        num = [topNums[i] unsignedIntegerValue];
        VFGlyph* topGlyph = [[VFGlyph alloc] initWithCode:[NSString stringWithFormat:@"v%tu", num] withPointSize:1];

        [topGlyphs push:topGlyph];
        topWidth += topGlyph.metrics.width;
    }
    self.topGlyphs = topGlyphs;

    float botWidth = 0;
    for(NSUInteger i = 0; i < botNums.count; ++i)
    {
        num = [botNums[i] unsignedIntegerValue];
        VFGlyph* botGlyph = [[VFGlyph alloc] initWithCode:[NSString stringWithFormat:@"v%tu", num] withPointSize:1];

        [botGlyphs push:botGlyph];
        botWidth += botGlyph.metrics.width;
    }
    self.botGlyphs = botGlyphs;

    float width = (topWidth > botWidth ? topWidth : botWidth);
    glyph.width = width;

    //    float xMin = ((TimeSignatureGlyphMetrics*)glyph.metrics).x_min;
    //    ((TimeSignatureGlyphMetrics*)glyph.metrics).x_min = xMin;
    //    ((TimeSignatureGlyphMetrics*)glyph.metrics).x_max = xMin + width;
    //    ((TimeSignatureGlyphMetrics*)glyph.metrics).width = width;

    //    [self.botGlyphs foreach:^(VFGlyph* element, NSUInteger index, BOOL* stop) {
    //        element.width = width;
    //    }];
    //    [self.topGlyphs foreach:^(VFGlyph* element, NSUInteger index, BOOL* stop) {
    //        element.width = width;
    //    }];

    __block float topStartX = (width - topWidth) / 2.0;
    __block float botStartX = (width - botWidth) / 2.0;

    __block typeof(self) this = self;
    glyph.drawBlock = ^(CGContextRef ctx, float x, float y) {

      float start_x = x + topStartX;
      VFGlyph* g;
      for(NSUInteger i = 0; i < this.topGlyphs.count; ++i)
      {
          g = this.topGlyphs[i];
          [VFGlyph renderGlyph:ctx
                           atX:start_x + g.x_shift
                           atY:[this.staff getYForLine:this.topLine] + 1
                     withScale:1 /*g.scale*/
                  forGlyphCode:g.metrics.code];
          start_x += g.metrics.width;
      }

      start_x = x + botStartX;
      for(NSUInteger i = 0; i < this.botGlyphs.count; ++i)
      {
          g = this.botGlyphs[i];
          //          [this placeGlyphOnLine(g, this.stave, g.line);
          //          [this placeGlyphOnLine:glyph forStaff:this.staff onLine:g.line];
          [VFGlyph renderGlyph:ctx
                           atX:start_x + g.x_shift
                           atY:[this.staff getYForLine:this.bottomLine] + 1
                     withScale:1 /*g.scale*/
                  forGlyphCode:g.metrics.code];
          start_x += g.metrics.width;
      }

    };

    return glyph;
}

/*!
 *  Add the key signature to the `staff`. You probably want to use the
 *  helper method `.addToStaff()` instead
 *  @param staff the staff to add the modifier to
 */
- (void)addModifierToStaff:(VFStaff*)staff
{
    //    [staff addGlyph:self.glyph];
    //
    [staff addGlyph:[staff makeSpacer:10]];

    if(!self.num)
    {
        [self placeGlyphOnLine:self.glyph forStaff:staff onLine:self.line];
    }
    [staff addGlyph:self.glyph];
    [staff addGlyph:[staff makeSpacer:10]];   // CHANGE
}

/*!
 *  Add the key signature to the `staff`. You probably want to use the
 *  helper method `.addToStaff()` instead
 *  @param modifier the staff to add the modifier to
 */
- (void)addEndModifierToStaff:(VFStaff*)staff
{
    [staff addEndGlyph:[staff makeSpacer:10]];

    if(!self.num)
    {
        [self placeGlyphOnLine:self.glyph forStaff:staff onLine:self.line];
    }
    [staff addEndGlyph:self.glyph];
}

@end
