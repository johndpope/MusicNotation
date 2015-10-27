//
//  TokeniserDelegate.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import "TokeniserDelegate.h"

@implementation TokeniserDelegate

- (BOOL)tokeniser:(CPTokeniser*)tokeniser shouldConsumeToken:(CPToken*)token
{
    return YES;
}

- (void)tokeniser:(CPTokeniser*)tokeniser requestsToken:(CPToken*)token pushedOntoStream:(CPTokenStream*)stream
{
    if(![token isWhiteSpaceToken] && ![[token name] isEqualToString:@"Comment"])
    {
        [stream pushToken:token];
    }
}

@end
