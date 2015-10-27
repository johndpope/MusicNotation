//
//  ATFunctionalCollectionExtensions.m
//  Azure Talon
//
//  Created by Kenneth Ballenegger on 5/24/12.
//  Copyright (c) 2012 Kenneth Ballenegger (kswizz.com). All rights reserved.
//

#import "ATFunctionalCollectionExtensions.h"



@implementation NSArray (ATFunctionalCollectionExtensions)

- (void)each:(void(^)(id object))block {
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) { block(obj); }];
}

- (NSArray *)map:(id(^)(id object))block {
    return [[self inject:^(NSMutableArray *acc, id obj) {
        [acc addObject:block(obj)]; return acc;
    } initial:[NSMutableArray array]] copy];
}

- (id)reduce:(id(^)(id a, id b))block {
    if (self.count == 0) return nil;
    
    id accumulator = [self objectAtIndex:0];
    for (NSUInteger i = 0; i < self.count-1; i++) {
        accumulator = block(accumulator, [self objectAtIndex:i+1]);
    }
    return accumulator;
}

- (NSArray *)filter:(BOOL(^)(id object))block {
    return [[self inject:^(NSMutableArray *acc, id obj) {
        if (block(obj)) [acc addObject:obj]; return acc;
    } initial:[NSMutableArray array]] copy];
    
}

- (id)inject:(id(^)(id accumulator, id object))block initial:(id)accumulator {
    __block id acc = accumulator;
    [self each:^(id obj){
        acc = block(acc, obj);
    }];
    return acc;
}

@end

@implementation NSDictionary (ATFunctionalCollectionExtensions)

- (void)each:(void(^)(id key, id object))block {
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) { block(key, obj); }];
}

- (NSDictionary *)map:(id(^)(id key, id object))block {
    return [[self inject:^(NSMutableDictionary *acc, id key, id obj) {
        [acc setObject:block(key, obj) forKey:key]; return acc;
    } initial:[NSMutableDictionary dictionary]] copy];
}

- (NSDictionary *)filter:(BOOL(^)(id key, id object))block {
    return [[self inject:^(NSMutableDictionary *acc, id key, id obj) {
        if (block(key, obj)) [acc setObject:obj forKey:key]; return acc;
    } initial:[NSMutableArray array]] copy];
}

- (id)inject:(id(^)(id accumulator, id key, id object))block initial:(id)accumulator {
    __block id acc = accumulator;
    [self each:^(id key, id obj){
        acc = block(acc, key, obj);
    }];
    return acc;
}

- (NSArray *)keys {
    NSMutableArray *acc = [NSMutableArray array];
    for (id key in self) {
        [acc addObject:key];
    }
    return [acc copy];
}

- (NSArray *)objects {
    NSMutableArray *acc = [NSMutableArray array];
    for (id obj in self.objectEnumerator) {
        [acc addObject:obj];
    }
    return [acc copy];
}

@end

