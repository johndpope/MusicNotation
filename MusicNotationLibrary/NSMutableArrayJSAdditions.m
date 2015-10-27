//
//  NSMutableArray+StackAdditions.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "NSMutableArray+JSAdditions.h"

@implementation NSMutableArray (JSAdditions)

- (id)pop
{
    // nil if [self count] == 0
    id lastObject = [self lastObject];
    if (lastObject) {
        [self removeLastObject];
    }
    return lastObject;
}

- (void)push:(id)obj
{
    [self addObject: obj];
}

@end