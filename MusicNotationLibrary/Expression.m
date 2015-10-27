//
//  Expression.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 Ramsay Consulting. All rights reserved.
//

#import "Expression.h"
#import "Term.h"
#import <CoreParse/CoreParse.h>

@implementation Expression

@synthesize value;

- (id)initWithSyntaxTree:(CPSyntaxTree*)syntaxTree
{
    self = [self init];

    if(nil != self)
    {
        NSLog(@"Expression initWithSyntaxTree: %@", syntaxTree);

        Term* t = [syntaxTree valueForTag:@"term"];
        Expression* e = [syntaxTree valueForTag:@"expr"];

        if(nil == e)
        {
            [self setValue:[t value]];
        }
        else if([[syntaxTree valueForTag:@"op"] isEqualToString:@"+"])
        {
            [self setValue:[e value] + [t value]];
        }
        else
        {
            [self setValue:[e value] - [t value]];
        }
    }

    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<Expression: %3.1f>", value];
}

@end
