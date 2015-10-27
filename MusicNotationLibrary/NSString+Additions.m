//
//  NSString+NSString_Additions.m
//  MusicApp
//
//  Created by Scott on 8/9/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "NSString+Additions.h"

@implementation NSString (Additions)

- (NSString*)camelCaseToTitleCase
{
    NSString* camelCaseString = self;   // REFStringForMemberInTestType([numType integerValue]);
    NSMutableString* titleCaseString = [NSMutableString string];
    for(NSInteger i = 0; i < camelCaseString.length; i++)
    {
        NSString* ch = [camelCaseString substringWithRange:NSMakeRange(i, 1)];
        if([ch rangeOfCharacterFromSet:[NSCharacterSet uppercaseLetterCharacterSet]].location != NSNotFound)
        {
            [titleCaseString appendString:@" "];
        }
        [titleCaseString appendString:ch];
    }

    return [NSString stringWithString:titleCaseString];
}

@end
