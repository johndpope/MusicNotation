//
//  NSArray+JSAdditions.h
//  VexFlow
//
//  Created by Scott on 3/19/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@import Foundation;

@interface Slice : NSObject
@property (assign, nonatomic) NSInteger start;
@property (assign, nonatomic) NSInteger end;
@end

@interface NSNumber (SliceCreation)

- (Slice*):(NSInteger)length;

@end

@interface NSArray (JSAdditions)

- (id)objectForKeyedSubscript:(id)subscript;

- (NSArray*)slice:(Slice*)slice;

@end
