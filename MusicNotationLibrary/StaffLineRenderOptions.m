//
//  StaffLineRenderOptions.m
//  VexFlow
//
//  Created by Scott on 6/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "StaffLineRenderOptions.h"

@implementation StaffLineRenderOptions

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict
{
    self = [super initWithDictionary:optionsDict];
    if(self)
    {
        //        [self setValuesForKeyPathsWithDictionary:optionsDict];
        self.lineDash = NO;
        self.lineDashPhase = 0;
        self.lineDashLengths = @[];
        self.lineDashCount = 0;
        self.lineWidth = 1;
        self.lineCap = kCGLineCapButt;
        self.padding_left = 0;
        self.padding_right = 0;
    }
    return self;
}
@end