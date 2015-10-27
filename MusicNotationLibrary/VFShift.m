//
//  VFShift.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFShift.h"

@implementation Shift

- (instancetype)initWithX:(float)shiftX andY:(float)shiftY
         andJustification:(VFShiftDirectionType)justification
{
    self = [super init];
    if (self) {
        _shiftX = shiftX;
        _shiftY = shiftY;
        _justification = justification;
    }
    return self;
}

+ (Shift *)shiftWithX:(float)shiftX andY:(float)shiftY {
    return [[Shift alloc]initWithX:shiftX andY:shiftY andJustification:0];
}

+ (Shift *)shiftWithX:(float)shiftX {
    return [[Shift alloc]initWithX:shiftX andY:0 andJustification:0];
}

+ (Shift *)shiftWithY:(float)shiftY {
    return [[Shift alloc]initWithX:0 andY:shiftY andJustification:0];
}

+ (Shift *)shiftWithY:(float)shiftY justification:(VFShiftDirectionType)justification {
    return [[Shift alloc]initWithX:0 andY:shiftY andJustification:justification];
}


@end
