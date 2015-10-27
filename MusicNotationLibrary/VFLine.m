//
//  VFLine.m
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFLine.h"

@implementation VFLine

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupLine];
    }
    return self;
}

- (instancetype)initAtStartX:(float)x startY:(float)y endX:(float)endX endY:(float)endY {
    self = [super init];
    if (self) {
        //        [self setup];
        _startX = x;
        _startY = y;
        _endX = endX;
        _endY = endY;
    }
    return self;
}

- (void)setupLine {
    _startX = _startY = _endX = _endY = 0.0;
}

+ (VFLine *)lineAtStartX:(float)x startY:(float)y endX:(float)endX endY:(float)endY {
    return [[VFLine alloc]initAtStartX:x startY:y endX:endX endY:endY];
}


@end