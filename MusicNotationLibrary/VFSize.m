//
//  VFSize.m
//  VexFlow
//
//  Created by Scott on 3/23/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFSize.h"

@implementation VFFloatSize

+ (VFFloatSize*)sizeWithWidth:(float)width andHeight:(float)height;
{
    VFFloatSize* ret = [[VFFloatSize alloc] init];
    ret.width = width;
    ret.height = height;
    return ret;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _width = 0;
        _height = 0;
    }
    return self;
}

- (float)width
{
    return _width;
}

- (void)setWidth:(float)width
{
    _width = width;
}

- (float)height
{
    return _height;
}

- (void)setHeight:(float)height
{
    _height = height;
}

@end

@implementation VFUIntSize

+ (VFUIntSize*)sizeWithWidth:(NSUInteger)width andHeight:(NSUInteger)height;
{
    VFUIntSize* ret = [[VFUIntSize alloc] init];
    ret.width = width;
    ret.height = height;
    return ret;
}

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _width = 0;
        _height = 0;
    }
    return self;
}

- (NSUInteger)width
{
    return _width;
}

- (void)setWidth:(NSUInteger)width
{
    _width = width;
}

- (NSUInteger)height
{
    return _height;
}

- (void)setHeight:(NSUInteger)height
{
    _height = height;
}

@end