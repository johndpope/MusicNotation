//
//  VFMetrics.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFMetrics.h"
#import "VFVex.h"
#import "VFPadding.h"
#import "VFGlyphList.h"
#import "NSString+Ruby.h"
#import <objc/runtime.h>
#import "VFColor.h"
#import "VFPadding.h"
#import "VFPoint.h"
#import "VFBoundingBox.h"
#import "VFSize.h"
#import "VFTables.h"

@implementation Metrics
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
        [self setupMetrics];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
    }
    return self;
}

- (instancetype)initWithMetrics:(Metrics*)other
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        _xMin = other.xMin;
        _xMax = other.xMax;
        _width = other.width;
        _scale = other.scale;
        _length = other.length;

        _size = other.size;

        _parent = other.parent;
        _line = other.line;
        _lineAbove = other.lineAbove;
        _lineBelow = other.lineBelow;
        _textLine = other.textLine;
        _spacing = other.spacing;

        _cached = NO;
//        _font = other.font;
        _code = other.code;
        //        _key = other.key;
        _name = other.name;
        _arrayOutline = other.arrayOutline;
        _stringOutline = other.stringOutline;

        _point = other.point;
//        _shift = other.shift;
        _bounds = other.bounds;
//        _padding = other.padding;

        //        _graphicsContext = other.graphicsContext;
    }
    return self;
}

- (void)setupMetrics
{
    _xMin = 0;
    _xMax = 0;
    _width = 0;
    _scale = 1;
    _length = 0;

    _size = [[VFFloatSize alloc] init];

    _parent = nil;
    _line = 0;
    _lineAbove = 0;
    _lineBelow = 0;
    _textLine = 0;
    _spacing = 0;

    _cached = NO;
//    _font = @"";
    _code = @"";
    //    _key = @"";
    _name = @"";
    _arrayOutline = @[];
    _stringOutline = @"";

    _point = [VFPoint pointZero];
    _point.x = 0;
//    _shift = [VFPoint pointZero];
    _bounds = [VFBoundingBox boundingBoxZero];
//    _padding = [VFPadding paddingZero];

    //    _graphicsContext = nil;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

/*!
 *  gets a short description of this object
 *  @return a string showing properties of this object
 */
- (NSString*)description
{
    return [[NSString stringWithFormat:@"<%@:%p>\n", self.class, self] concat:[NSString stringWithFormat:@"%@", [self dictionarySerialization]]];
}

/*!
 *  helps create a debug description from the specified string to properties dictionary
 *  @return a dictionary of property names
 */
- (NSDictionary*)dictionarySerialization;
{
    return [self dictionaryWithValuesForKeyPaths:@[
        @"name",
        @"scale",
        @"code",
        @"point",
        @"point",
    ]];
}

- (float)xMax
{
    return _xMin * self.scale;
}

- (float)xMin
{
    return _xMax * self.scale;
}

- (float)width
{
    // return (_xMax - _xMin) * _scale;
    return _width;
}

- (VFBoundingBox*)bounds
{
    if(!_bounds)
    {
        _bounds = [[VFBoundingBox alloc] initWithRect:CGRectMake(0, 0, 0, 0)];
    }
    return _bounds;
}

//- (NSString *)key {
//    return  _key;
//}
//
//- (void)setKey:(NSString *)key {
//    _key = key;
//
//    _code = _key;
//    _name = _key;

- (VFPoint*)point
{
    if(!_point)
    {
        _point = VFPointMake(0, 0);
    }
    return _point;
}

- (void)setCode:(NSString*)code
{
    _code = code;
    [self setOutline];
}

- (NSString*)code
{
    return _code;
}

- (void)setOutline
{
    if(self.cached)
    {
        [VFLog logInfo:@"VFMetricsSetOutlineAgain, already set the outline. Enable caching mechanism."];
        self.arrayOutline = [[[VFGlyphList sharedInstance] availableGlyphStructsDictionary] objectForKey:self.code];
    }

    if(!self.code)
    {
        [VFLog logError:@"EmptyCodeEception, no code set for this metrics object."];
    }

    if(!self.cached)
    {
        self.arrayOutline = [[[VFGlyphList sharedInstance] availableGlyphStructsDictionary] objectForKey:self.code];
    }

    self.cached = YES;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
*/

+ (Metrics*)metricsZero
{
    return [[Metrics alloc] init];
}

+ (Metrics*)standardMetrics
{
    Metrics* ret = [[Metrics alloc] init];
    ret.xMin = 0;
    ret.xMax = 600;
    ret.width = 10;
//    ret.font = [NSString stringWithFormat:@""];
    ret.cached = NO;
    ret.length = 0.03;
    ret.scale = 1;
    return ret;
}

@end
