//
//  NSMutableDictionary+NSMutableDictionaryAdditions.m
//  VexFlow
//
//  Created by Scott on 5/14/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import "NSMutableDictionary+NSMutableDictionaryAdditions.h"
#import "VFLog.h"

@implementation NSMutableDictionary (NSMutableDictionaryAdditions)

// FROM: http://stackoverflow.com/a/4028209/629014
+ (NSDictionary*)dictionaryByMerging:(NSDictionary*)destination with:(NSDictionary*)source
{
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithDictionary:destination];

    [source enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
      if(![destination objectForKey:key])
      {
          if([obj isKindOfClass:[NSDictionary class]])
          {
              NSDictionary* newVal = [[destination objectForKey:key] dictionaryByMergingWith:(NSDictionary*)obj];
              [result setObject:newVal forKey:key];
          }
          else
          {
              [result setObject:obj forKey:key];
          }
      }
    }];

    return (NSDictionary*)[result copy];
}

- (NSDictionary*)dictionaryByMergingWith:(NSDictionary*)dict
{
    return [[self class] dictionaryByMerging:self with:dict];
}

+ (NSDictionary*)merge:(NSDictionary*)destination with:(NSDictionary*)source;
{
    destination = [[self class] dictionaryByMerging:destination with:source];
    return destination;
}

- (NSDictionary*)mergeWith:(NSDictionary*)other
{
    NSMutableDictionary* result = [NSMutableDictionary dictionaryWithDictionary:other];
    [other enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL* stop) {
      if(![other objectForKey:key])
      {
          if([obj isKindOfClass:[NSDictionary class]])
          {
              NSDictionary* newVal = [[self objectForKey:key] mergeWith:(NSDictionary*)obj];
              [self setObject:newVal forKey:key];
          }
          else
          {
              [self setObject:obj forKey:key];
          }
      }
    }];

    return (NSDictionary*)[result copy];
}

- (void)addObjectWithoutReplacing:(id)obj forKey:(id)key
{
    if([self objectForKey:key] == nil)
    {
        [self setObject:obj forKey:key];
    }
    else
    {
        [VFLog logError:@"attempting to add an already existing key"];
    }
}

- (void)addEntriesFromDictionaryWithoutReplacing:(NSDictionary*)dictionary
{
    for(id key in dictionary.allKeys)
    {
        [self addObjectWithoutReplacing:dictionary[key] forKey:key];
    }
}

@end
