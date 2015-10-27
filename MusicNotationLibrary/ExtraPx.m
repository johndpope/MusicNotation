//
//  ExtraPx.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "ExtraPx.h"

@implementation ExtraPx

- (instancetype)initWithLeft:(float)left right:(float)right extraLeft:(float)extraLeft extraRight:(float)extraRight
{
    self = [super init];
    if (self) {
        _left = left;
        _right = right;
        _extraLeft = extraLeft;
        _extraRight = extraRight;
    }
    return self;
}

@end
