//
//  VFMusicDiatonicAccidentals.m
//  VexFlow
//
//  Created by Scott on 3/21/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFMusicDiatonicAccidentals.h"


@implementation VFMusicDiatonicAccidentals
- (NSDictionary *)propertiesToDictionaryEntriesMapping
{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"obj_unison", @"unison", //correct name of the property, name in dictionary
            @"obj_m2", @"m2",
            @"obj_M2", @"M2",
            @"obj_m3", @"m3",
            @"obj_M3", @"M3",
            @"obj_p4", @"p4",
            @"obj_dim5", @"dim5",
            @"obj_p5", @"p5",
            @"obj_m6", @"m6",
            @"obj_M6", @"M6",
            @"obj_b7", @"b7",
            @"obj_M7", @"M7",
            @"obj_octave", @"octave",
            nil];
}
@end