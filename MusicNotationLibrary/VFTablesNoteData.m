//
//  VFTablesNoteData.m
//  VexFlow
//
//  Created by Scott on 3/21/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFTablesNoteData.h"

@implementation VFTablesNoteInputData
//- (NSDictionary*)dictionarySerialization;
//{
//    return [self dictionaryWithValuesForKeyPaths:@[
//        @"durationStringData",
//        @"ticks",
//    ]];
//}
- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
    }
    return self;
}
- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    [propertiesEntriesMapping addEntriesFromDictionary:@{
        @"duration" : @"durationString",
    }];
    return propertiesEntriesMapping;
}
@end

@implementation VFTablesNoteStringData

- (id)initWithDictionary:(NSDictionary*)optionsDict;
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        _noteDurationType = [VFEnum typeNoteDurationTypeForString:_durationString];
        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (NSDictionary*)dictionarySerialization;
{
    return [self dictionaryWithValuesForKeyPaths:@[
        @"durationString",
        @"noteDurationType",
        @"noteNHMRSString",
        @"noteNHMRSType",
        @"dots",
        @"ticks",
    ]];
}

@end
