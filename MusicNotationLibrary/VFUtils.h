//
//  VFUtils.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

typedef enum _NSStringEnumerationEachCharOptions : NSUInteger
{
    NSStringEnumerationEachChar = 0,
    NSStringEnumerationEachCharReversed = 1,
    NSStringEnumerationEachCharCamelCase = 2,
} NSStringEnumerationEachCharOptions;
typedef NSString* (^CodeConverter)(NSString* inputString);
@interface NSString (NSStringEnumerator)
- (NSArray*)enumerateEachCharacterWithOptions:(NSStringEnumerationEachCharOptions)options
                                   UsingBlock:(CodeConverter)operation;
@end

@protocol ObjectToDictionary <NSObject>
- (NSDictionary*)toDictionary;
@end

@interface NSObject (MyPrettyPrint)
- (NSString*)prettyPrint;
@end

//@interface NSObject (VFMergeObject)
//
////+ (NSDictionary *) dictionaryByMerging:(NSDictionary *) dict1 with:(NSDictionary *) dict2;
//+ (BOOL)merge:(id)destination with:(id)source;
//
//
//@end
