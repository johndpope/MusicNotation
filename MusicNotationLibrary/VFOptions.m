//
//  VFOptions.m
//  VFVexCore
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

#import "VFColor.h"
#import "VFOptions.h"
#import "NSObject+NSObjectAdditions.h"

@implementation Options
{
    NSString* _font;
    NSString* _code;
    VFColor* _fillColor;
    VFColor* _strokeColor;
    NSMutableArray* _lineConfig;
    float _strokePoints;
}

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
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)init
{
    self = [self initWithDictionary:nil];
    if(self)
    {
        [self setupOptions];
    }
    return self;
}

- (void)setupOptions
{
    _font = nil;
    _code = nil;
    _fillColor = VFColor.blackColor;
    _strokeColor = VFColor.blackColor;
    _lineConfig = [NSMutableArray array];
    _cache = YES;
    _visible = YES;
    _strokePoints = 3.0;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

#pragma mark - Properties
/**---------------------------------------------------------------------------------------------------------------------
 * @name Properties
 * ---------------------------------------------------------------------------------------------------------------------
 */

- (NSString*)font
{
    if(!_font)
    {
        return @"";
    }
    else
    {
        return _font;
    }
}

- (void)setFont:(NSString*)font
{
    // TODO: check that this is a valid font
}

- (NSString*)code
{
    if(!_code)
    {
        return @"";
    }
    else
    {
        return _code;
    }
}

- (void)setCode:(NSString*)code
{
    // TODO: check that this is a valid code
}

- (VFColor*)fillColor
{
    return _fillColor;
}

- (void)setFillColor:(VFColor*)fillColor
{
    // TODO: check that this is a valid color
}

- (VFColor*)strokeColor
{
    return _strokeColor;
}

- (void)setStrokeColor:(VFColor*)strokeColor
{
    // TODO: check that this is a valid color
}

- (void)setLineConfig:(NSMutableArray*)lineConfig
{
    _lineConfig = lineConfig;
}

- (float)strokePoints
{
    return _strokePoints;
}

- (void)setStrokePoints:(float)strokePoints
{
    _strokePoints = strokePoints;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (Options*)options
{
    return [[Options alloc] init];
}

@end
