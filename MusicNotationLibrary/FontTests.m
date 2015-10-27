//
//  FontTests.m
//  VexFlow
//
//  Created by Scott on 4/15/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "FontTests.h"
#import "VexFlowTestHelpers.h"

@implementation FontTests

- (void)start   //:(VFTestView*)parent;
{
    //    [super start:parent];
    //    id targetClass = [self class];
    [self runTest:@"Basic"  func:@selector(basic:)];
}




- (void)basic:(TestCollectionItemView*)parent
{
    [VFFont setFont:@"arial"];

    // TODO: finish tests
}

@end
