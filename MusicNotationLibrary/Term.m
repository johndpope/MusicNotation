//
//  Term.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import "Term.h"
#import "Factor.h"

@implementation Term

@synthesize value;

- (id)initWithSyntaxTree:(CPSyntaxTree*)syntaxTree
{
    self = [self init];

    if(nil != self)
    {
        NSLog(@"Term initWithSyntaxTree: %@", syntaxTree);

        Factor* f = [syntaxTree valueForTag:@"fact"];
        Term* t = [syntaxTree valueForTag:@"term"];

        if(nil == t)
        {
            [self setValue:[f value]];
        }
        else if([[syntaxTree valueForTag:@"op"] isEqualToString:@"*"])
        {
            [self setValue:[f value] * [t value]];
        }
        else
        {
            [self setValue:[f value] / [t value]];
        }
    }

    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<Term: %3.1f>", value];
}

@end
