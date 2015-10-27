//
//  VFPair.m
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFPair.h"

@implementation VFPair
- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupPair];
    }
    return self;
}

- (void)setupPair {
    _item1 = 0;
    _item2 = 0;
}
@end
