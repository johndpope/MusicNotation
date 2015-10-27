//
//  JSONSerialization.h
//  VexFlow
//
//  Created by Scott on 3/21/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

@protocol JSONSerialization <NSObject>

@required
-(NSDictionary *)dictionarySerialization;

@optional
-(id)initFromDictionarySerialization:(NSDictionary *)dictionary;

@end
