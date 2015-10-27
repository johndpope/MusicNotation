//
//  VFPoint.m
//  VFVexCore
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFPoint.h"

@interface VFPoint() {
    float _x;
    float _y;
}
@end

@implementation VFPoint

- (instancetype)init {
    self = [super init];
    if (self) {
        _x = 0;
        _y = 0;
    }
    return self;
}

- (instancetype)initWithX:(float)x andY:(float)y {
    self = [super init];
    if (self) {
        _x = x;
        _y = y;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    return [VFPoint pointWithX:_x andY:_y];
}

+ (VFPoint *)pointWithX:(float)x andY:(float)y {
    return [[VFPoint alloc]initWithX:x andY:y];
}

+ (VFPoint *)pointZero {
    return [VFPoint pointWithX:0 andY:0];
}

- (NSString *)toString {
    return [NSString stringWithFormat:@"(%f, %f)", _x, _y];
}

- (void)translateByX:(float)x andY:(float)y {
    self.x += x;
    self.y += y;
}

- (void)setX:(float)x
        andY:(float)y {
    _x = x;
    _y = y;
}

- (float)distance:(VFPoint *)otherPoint {
    return sqrtf(powf(self.x - otherPoint.x, 2.0) +  powf(self.y - otherPoint.y, 2.0));
}

- (CGPoint)CGPoint {
    return CGPointMake(self.x, self.y);
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%f, %f", self.x, self.y];
}

@end
