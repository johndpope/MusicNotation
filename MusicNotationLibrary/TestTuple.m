//
//  TestTuple.m
//  MusicApp
//
//  Created by Scott on 8/7/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "TestTuple.h"
#import "VFVexCore.h"

@implementation TestTuple

#pragma mark - Constructors

- (instancetype)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

+ (TestTuple*)testTuple;
{
    return [[TestTuple alloc] init];
}

#pragma mark - Properties

- (NSMutableArray*)formatters
{
    if(!_formatters)
    {
        _formatters = [NSMutableArray array];
    }
    return _formatters;
}

- (NSMutableArray*)voices
{
    if(!_voices)
    {
        _voices = [NSMutableArray array];
    }
    return _voices;
}

- (NSMutableArray*)staves
{
    if(!_staves)
    {
        _staves = [NSMutableArray array];
    }
    return _staves;
}

- (NSMutableArray*)beams
{
    if(!_beams)
    {
        _beams = [NSMutableArray array];
    }
    return _beams;
}

@end
