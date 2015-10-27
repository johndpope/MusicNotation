//
//  Test.m
//  HereWeGoAgain
//
//  Created by Scott Riccardelli on 6/6/15.
//  Copyright (c) 2015 Scott Riccardelli. All rights reserved.
//

#import "Test.h"

@implementation Test

- (instancetype)initWithName:(NSString*)name
{
    self = [super init];
    if(self)
    {
        _name = name;
        _children = [NSMutableArray array];
    }
    return self;
}

@end
