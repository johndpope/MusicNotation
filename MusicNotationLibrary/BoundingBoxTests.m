//
//  BoundingBoxTests.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "BoundingBoxTests.h"
#import "VexFlowTestHelpers.h"

@implementation BoundingBoxTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Initialization Test" func:@selector(initialization)];
    [self runTest:@"Merging Text" func:@selector(merging)];
}



- (void)initialization
{
    VFBoundingBox* bb = VFBoundingBoxMake(4, 5, 6, 7);
    assertThatFloat(bb.xPosition, describedAs(@"Bad X", equalToFloat(4), nil));
    assertThatFloat(bb.yPosition, describedAs(@"Bad Y", equalToFloat(5), nil));
    assertThatFloat(bb.width, describedAs(@"Bad W", equalToFloat(6), nil));
    assertThatFloat(bb.height, describedAs(@"Bad H", equalToFloat(7), nil));
}

- (void)merging
{
    VFBoundingBox* bb1 = VFBoundingBoxMake(10, 10, 10, 10);
    VFBoundingBox* bb2 = VFBoundingBoxMake(15, 20, 10, 10);

    [bb1 mergeWithBox:bb2];

    assertThatFloat(bb1.xPosition, describedAs(@"Bad X", equalToFloat(10), nil));
    assertThatFloat(bb1.yPosition, describedAs(@"Bad Y", equalToFloat(10), nil));
    assertThatFloat(bb1.width, describedAs(@"Bad W", equalToFloat(15), nil));
    assertThatFloat(bb1.height, describedAs(@"Bad H", equalToFloat(20), nil));
}

@end
