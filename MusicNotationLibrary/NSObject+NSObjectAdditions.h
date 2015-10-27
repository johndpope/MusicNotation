//
//  NSObject+NSObjectAdditions.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;

@interface NSObject (NSObjectAdditions)

- (instancetype)initWithDictionary:(NSDictionary*)optionsDict;
- (void)setValuesForKeyPathsWithDictionary:(NSDictionary *)keyedValues;
- (NSDictionary *)dictionaryWithValuesForKeyPaths:(NSArray *)keyPaths;
@end
