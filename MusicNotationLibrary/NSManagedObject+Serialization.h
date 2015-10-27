//
//  NSManagedObject+Serialization.h
//  VexFlow
//
//  Created by Scott on 3/21/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;
#import <CoreData/CoreData.h>

@interface NSManagedObject (Serialization)

- (NSDictionary*)toDictionary;

- (void)populateFromDictionary:(NSDictionary*)dict;

+ (NSManagedObject*)createManagedObjectFromDictionary:(NSDictionary*)dict inContext:(NSManagedObjectContext*)context;

@end