//
//  Tempo.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "Tempo.h"

@implementation Tempo

- (instancetype)initWithName:(NSString*)name withDuration:(NSString*)duration withDots:(float)dots withBpm:(float)bpm
{
    self = [super init];
    if(self)
    {
        self.name = name;
        self.duration = duration;
        self.dots = dots;
        self.bpm = bpm;
    }
    return self;
}

- (NSMutableDictionary*)propertiesToDictionaryEntriesMapping;
{
    NSMutableDictionary* propertiesEntriesMapping = [super propertiesToDictionaryEntriesMapping];
    //        [propertiesEntriesMapping addEntriesFromDictionaryWithoutReplacing:@{@"virtualName" : @"realName"}];
    return propertiesEntriesMapping;
}

@end
