//
//  NSArray+JSAdditions.m
//  VexFlow
//
//  Created by Scott on 3/19/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "NSArray+JSAdditions.h"

@implementation Slice
@end

@implementation NSNumber (SliceCreation)

// TODO: implement. javascript slice allows for arr.slice(n)
/*
 > var arr = [1,2,3,4,5]
 undefined
 > arr
 [ 1, 2, 3, 4, 5 ]
 > arr.slice(0)
 [ 1, 2, 3, 4, 5 ]
 > arr.slice(1)
 [ 2, 3, 4, 5 ]
 > arr.slice(1,3)
 [ 2, 3 ]
 > arr.slice(0,arr.length)
 [ 1, 2, 3, 4, 5 ]
 > arr.slice(0)
 [ 1, 2, 3, 4, 5 ]
 */

- (Slice*):(NSInteger)end
{
    Slice* slice = [[Slice alloc] init];
    slice.start = self.integerValue;
    slice.end = end;
    return slice;
}

@end

@implementation NSArray (JSAdditions)

- (id)objectForKeyedSubscript:(id)subscript
{
    Slice* slice = subscript;
    return [self subarrayWithRange:NSMakeRange(slice.start, (slice.end - slice.start))];
}

- (NSArray*)slice:(Slice*)slice
{
    return self[slice];
}

@end
