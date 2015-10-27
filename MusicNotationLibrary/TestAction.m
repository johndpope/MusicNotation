//
//  CarrierTest.m
//  MusicApp
//
//  Created by Scott on 8/8/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "TestAction.h"

@implementation TestAction

- (instancetype)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}

+ (TestAction*)testWithName:(NSString*)name andSelector:(SEL)selector andTarget:(id)target andFrame:(CGRect)frame;
{
    TestAction* ret = [[TestAction alloc] init];
    ret.name = name;
    ret.selector = selector;
    ret.target = target;
    ret.frame = frame;
    return ret;
}

@end
