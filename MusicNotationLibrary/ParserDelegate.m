//
//  ParserDelegate.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import "ParserDelegate.h"
#import <CoreParse/CoreParse.h>

@implementation ParserDelegate

- (id)parser:(CPParser*)parser didProduceSyntaxTree:(CPSyntaxTree*)syntaxTree
{
    NSLog(@"ParserDelegate:didProduceSyntaxTree: %@", syntaxTree);

    return [(CPKeywordToken*)[syntaxTree childAtIndex:0] keyword];
}

- (CPRecoveryAction*)parser:(CPParser*)parser
   didEncounterErrorOnInput:(CPTokenStream*)inputStream
                  expecting:(NSSet*)acceptableTokens
{
    NSLog(@"Error");
    return [CPRecoveryAction recoveryActionStop];
}

@end
