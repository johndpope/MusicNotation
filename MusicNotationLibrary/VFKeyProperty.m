//
//  VFKeyProperties.m
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFKeyProperty.h"
#import "VFTables.h"
#import "VFEnum.h"
#import "VFAccidental.h"
#import "VFVex.h"
#import "NSString+Ruby.h"
#import "VFStaff.h"
#import "VFClef.h"

#pragma mark - VFKeyProperties Implementation
/**---------------------------------------------------------------------------------------------------------------------
 * @name VFKeyProperties Implementation
 * ---------------------------------------------------------------------------------------------------------------------
 */
@implementation KeyProperty

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (instancetype)initWithKey:(NSString*)key andClefType:(VFClefType)clefType andOptionsDict:(NSDictionary*)optionsDict;
{
    self = [self initWithDictionary:optionsDict];
    if(self)
    {
        [self setupKeyProperty];
        _clefType = clefType;
        _key = key;
    }
    return self;
}

- (void)setupKeyProperty
{
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

- (NSString*)key
{
    if(!_key)
    {
        _key = @"";
    }
    return _key;
}

- (NSString*)glyphCode
{
    if(!_glyphCode)
    {
        _glyphCode = @"";
    }
    return _glyphCode;
}

- (VFAccidental*)accidental
{
    if(!_accidental)
    {
        _accidental = [[VFAccidental alloc] init];
    }
    return _accidental;
}

#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

//- (NSString*)description
//{
//    NSString* ret = @"";
//
//    ret = [ret concat:[NSString stringWithFormat:@"Key: %@\n", self.key]];
//    ret = [ret concat:[NSString stringWithFormat:@"GlyphCode: %@\n", self.glyphCode]];
//    ret = [ret concat:[NSString stringWithFormat:@"Accidental: %@\n", [self.accidental prettyPrint]]];
//    ret = [ret concat:[NSString stringWithFormat:@"ClefType: %li\n", self.clefType]];
//    ret = [ret concat:[NSString stringWithFormat:@"Octave: %lu\n", (unsigned long)self.octave]];
//    ret = [ret concat:[NSString stringWithFormat:@"Line: %lu\n", (unsigned long)self.line]];
//    ret = [ret concat:[NSString stringWithFormat:@"IntValue: %lu\n", (unsigned long)self.intValue]];
//    ret = [ret concat:[NSString stringWithFormat:@"ShiftRigth:   %f\n", self.shiftRight]];
//    ret = [ret concat:[NSString stringWithFormat:@"Displaced:   %@\n", self.displaced ? @"YES" : @"NO"]];
//    //    ret = [ret concat:[NSString stringWithFormat:@"NoteValues:   %@\n", self.noteValues]];
//    ret = [ret concat:[NSString stringWithFormat:@"RestLine:   %lu\n", (unsigned long)self.restLine]];
//    ret = [ret concat:[NSString stringWithFormat:@"StrokeDirection:   %li\n", self.stroke]];
//
//    return ret;
//}

- (NSDictionary*)dictionarySerialization;
{
    return [self dictionaryWithValuesForKeyPaths:@[
        @"key",
        @"glyphCode",
        @"clefType",
        @"octave",
        @"displaced",
        @"ticks",
    ]];
}

- (VFClefType)clefType
{
    if(_clefType == 0)
    {
        _clefType = [[VFStaff currentStaff] clefType];
    }
    return _clefType;
}

//+ (KeyProperty *)keyPropertyWithKey:(NSString *)key
//                        andClefType:(VFClefType)clefType
//{
//    //[VFTables keyPropertiesForKey:key andClefType:clefType];
////    return [VFTables keyPropertiesForKey:key andClef:clefType];
//    return [VFTables keyPropertiesForKey:key andClef:clefType andOptions:nil];
//}

@end
