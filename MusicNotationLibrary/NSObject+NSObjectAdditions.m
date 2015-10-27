 //
//  NSObject+NSObjectAdditions.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "NSObject+NSObjectAdditions.h"
//#import "VFLog.h"
#import <objc/runtime.h>

@implementation NSObject (NSObjectAdditions)

// //======================================================================================================================
// https://github.com/Mantle/Mantle

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict; {
    self = [self init];
    if (self) {
//        if (![self canMergeWithOptionsDict:optionsDict]) {
//            [VFLog LogFatal:@"Invalid options dictionary."];
//            NSLog(@"Invalid options dictionary.");
//        }
//        [self setValuesForKeysWithDictionary:optionsDict];

        [self setValuesForKeyPathsWithDictionary:optionsDict];
    }
    return self;
}

- (void)setValuesForKeyPathsWithDictionary:(NSDictionary *)keyedValues; {
    for (NSString *key_keyPath in keyedValues.allKeys) {
        id object = [keyedValues objectForKey:key_keyPath];
        [self setValue:object forKeyPath:key_keyPath];
    }
}


- (NSDictionary *)dictionaryWithValuesForKeyPaths:(NSArray *)keyPaths; {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    for (NSString *keyPath in keyPaths) {
        [dict setObject:[self valueForKeyPath:keyPath]forKey:keyPath] ;
    }
    return [NSDictionary dictionaryWithDictionary:dict];
}

@end
