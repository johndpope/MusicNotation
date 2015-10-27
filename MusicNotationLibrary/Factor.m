//
//  Factor.m
//  ParseTest
//
//  Created by Gavin Eadie on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Factor.h"
#import "Expression.h"

@implementation Factor

@synthesize value;

- (id)initWithSyntaxTree:(CPSyntaxTree*)syntaxTree
{
    self = [self init];

    if(nil != self)
    {
        NSLog(@"Factor initWithSyntaxTree: %@", syntaxTree);

        Expression* e = [syntaxTree valueForTag:@"expr"];

        [self setValue:nil == e ? [[[syntaxTree valueForTag:@"num"] number] floatValue] : [e value]];
    }

    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"<Factor: %3.1f>", value];
}

@end
