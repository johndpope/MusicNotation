//
//  NSString.m
//  VexFlow
//
//  Created by Scott on 6/3/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "NSString+NSStringAdditions.h"

@implementation NSString (NSStringAdditions)

- (BOOL)isNotEqualToString:(NSString*)other;
{
    return ![self isEqualToString:other];
}

@end
