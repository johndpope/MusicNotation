//
//  NSMutableDictionary+NSMutableDictionaryAdditions.h
//  VexFlow
//
//  Created by Scott on 5/14/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (NSMutableDictionaryAdditions)

+ (NSDictionary*)merge:(NSDictionary*)destination with:(NSDictionary*)source;
- (void)addObjectWithoutReplacing:(id)obj forKey:(id)key;
- (void)addEntriesFromDictionaryWithoutReplacing:(NSDictionary*)dict;

@end
