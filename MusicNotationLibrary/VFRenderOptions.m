//
//  VFRenderOptions.m
//  VexFlow
//
//  Created by Scott on 3/22/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFRenderOptions.h"

@implementation RenderOptions
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
    }
    return self;
}
@end
