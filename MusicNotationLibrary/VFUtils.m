//
//  VFUtils.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
#import <objc/runtime.h>
#import "VFUtils.h"
#import "VFVex.h"

//http://stackoverflow.com/a/16045504/629014
@implementation NSObject (MyPrettyPrint)
- (NSString *)prettyPrint
{
    BOOL isColl;
    return [self prettyPrintAtLevel:0 isCollection:&isColl];
}

- (NSString *)prettyPrintAtLevel:(int)level isCollection:(BOOL *)isCollection;
{
    if ([self respondsToSelector:@selector(toDictionary)]) {
        NSDictionary *dict = [(id <ObjectToDictionary>)self toDictionary];
        return [dict prettyPrintAtLevel:level isCollection:isCollection];
    }
    
    NSString *padding = [@"" stringByPaddingToLength:level withString:@" " startingAtIndex:0];
    NSMutableString *desc = [NSMutableString string];
    
    if ([self isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)self;
        NSUInteger cnt = [array count];
        [desc appendFormat:@"%@(\n", padding];
        for (id elem in array) {
            BOOL isColl;
            NSString *s = [elem prettyPrintAtLevel:(level+3) isCollection:&isColl];
            if (isColl) {
                [desc appendFormat:@"%@", s];
            } else {
                [desc appendFormat:@"%@   %@", padding, s];
            }
            if (--cnt > 0)
                [desc appendString:@","];
            [desc appendString:@"\n"];
        }
        [desc appendFormat:@"%@)", padding ];
        *isCollection = YES;
        
    } else if ([self isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)self;
        [desc appendFormat:@"%@{\n", padding];
        for (id key in dict) {
            BOOL isColl;
            id value = dict[key];
            NSString *s = [value prettyPrintAtLevel:(level+3) isCollection:&isColl];
            if (isColl) {
                [desc appendFormat:@"   %@%@ =\n%@\n", padding, key, s];
            } else {
                [desc appendFormat:@"   %@%@ = %@\n", padding, key, s];
            }
        }
        [desc appendFormat:@"%@}", padding ];
        *isCollection = YES;
        
    } /*else {
       [desc appendFormat:@"%@", self];
       *isCollection = NO;
       }*/
    else {
        NSString *className = [NSString stringWithCString:class_getName([self class]) encoding:NSASCIIStringEncoding];
        if (!className) {
            className = @"unknownName";
        }
        [desc appendFormat:@"<%p> %@ %@", self, className, [self description]];
    }
    
    return desc;
}
@end

@implementation NSString (NSStringEnumerator)
//typedef NSString *(^CodeConverter) (NSString *inputString);
- (NSArray *)enumerateEachCharacterWithOptions:(NSStringEnumerationEachCharOptions)options
                                    UsingBlock:(CodeConverter)operation
{
    NSMutableArray *ret = [NSMutableArray array];
    switch (options) {
        case NSStringEnumerationEachChar:
            for (NSUInteger charIndex = 0; charIndex < self.length; ++charIndex) {
                [ret addObject:operation([self substringWithRange:NSMakeRange(charIndex, 1)])];
            }
            break;
        case NSStringEnumerationEachCharReversed:
            for (NSUInteger charIndex = self.length - 1; charIndex > -1; --charIndex) {
                [ret addObject:operation([self substringWithRange:NSMakeRange(charIndex, 1)])];
            }
            break;
        case NSStringEnumerationEachCharCamelCase:
            //            for (NSUInteger charIndex = 0; charIndex < self.count; ++charIndex) {
            //                [ret addObject:operation([self substringWithRange:NSMakeRange(charIndex, 1)])];
            //            }
            [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
            break;
        default:
            break;
    }
    
    
    return [NSArray arrayWithArray:ret];
}
@end

