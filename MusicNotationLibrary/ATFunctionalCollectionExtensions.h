//
//  ATFunctionalCollectionExtensions.h
//  Azure Talon
//
//  Created by Kenneth Ballenegger on 5/24/12.
//  Copyright (c) 2012 Kenneth Ballenegger (kswizz.com). All rights reserved.
//

#define $a(...) ([NSArray arrayWithObjects:__VA_ARGS__, nil])
#define $d(...) ([NSDictionary dictionaryWithObjectsAndKeys:__VA_ARGS__, nil])


@import Foundation;


@interface NSArray (ATFunctionalCollectionExtensions)

// Calls the block for each item in the collection.
- (void)each:(void(^)(id object))block;

// Calls the block for each item in the collection, collects the return values and returns them in a new array.
- (NSArray *)map:(id(^)(id object))block;

// Reduces the array using the block provided.
// Return value should itself be reducible.
- (id)reduce:(id(^)(id a, id b))block;

// Filters the array using the provided block.
// The block should return YES if the object should be kept.
- (NSArray *)filter:(BOOL(^)(id object))block;

// Accumulates the array using the provided block and the initial value for the accumulator.
- (id)inject:(id(^)(id accumulator, id object))block initial:(id)accumulator;

@end



@interface NSDictionary (ATFunctionalCollectionExtensions)

// Calls the block for each item in the collection.
- (void)each:(void(^)(id key, id object))block;

// Calls the block for each item in the collection, collects the return values and returns them in a new dictionary.
- (NSDictionary *)map:(id(^)(id key, id object))block;

// Filters the array using the provided block.
// The block should return YES if the object should be kept.
- (NSDictionary *)filter:(BOOL(^)(id key, id object))block;

// Accumulates the dictionary using the provided block and the initial value for the accumulator.
- (id)inject:(id(^)(id accumulator, id key, id object))block initial:(id)accumulator;

// Returns all keys.
- (NSArray *)keys;

// Returns all values;
- (NSArray *)objects;

@end
