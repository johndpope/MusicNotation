//
//  VFVex.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFVex.h"

@implementation VFVex

/*!
 *   Take 'arr' and return a new list consisting of the sorted, unique,
 *    contents of arr.
 *  @param arr input array
 *  @param cmp comparator
 *  @param eq  equality compare
 *  @return sorted and uniqued 'arr'
 */
+ (NSArray*)sortAndUnique:(NSArray*)arr withCmp:(NSComparator)cmp andEq:(EqualBlock)eq;
{
    if(arr.count > 1)
    {
        NSMutableArray* newArr = [NSMutableArray array];
        NSNumber* last;
        arr = [arr sortedArrayUsingComparator:cmp];
        for(NSUInteger i = 0; i < arr.count; ++i)
        {
            if(i == 0 || !eq(arr[i], last))
            {
                [newArr addObject:arr[i]];
            }
            last = arr[i];
        }
        return newArr;
    }
    else
    {
        return arr;
    }
}

/*
 **
 * Simple assertion checks.
 *

 **
 * An exception for assertions.
 *
 * @constructor
 * @param {string} message The message to display.
 *
 Vex.AssertException = function(message) { self.message = message; }
 Vex.AssertException.prototype.toString = function() {
 return @"AssertException: " + self.message;
 }
 Vex.Assert = function(exp, message) {
 if (Vex.Debug && !exp) {
 if (!message) message = "Assertion failed.";
 throw new Vex.AssertException(message);
 }
 }

 */

////http://proquest.safaribooksonline.com.ezproxy.lib.utah.edu/book/programming/mobile/9781118449974/chapter-10-tackling-those-pesky-errors/a3_15_9781118449974_ch10_ef_html
//+ (void)Assert:(BOOL)condition withMessage:(NSString *)message {
//    RNAssert(condition,  @"%@", message);
//}

+ (void)RaiseException:(NSString* const)exception withFormat:(NSString*)aFormat, ...
{
    [NSException raise:exception format:aFormat, nil];
}

/*
 **
 * An generic runtime exception. For example:
 *
 *    throw new Vex.RuntimeError("BadNoteError", "Bad note: " + note);
 *
 * @constructor
 * @param {string} message The exception message.
 *
 Vex.RuntimeError = function(code, message) {
 self.code = code;
 self.message = message;
 }
 Vex.RuntimeError.prototype.toString = function() {
 return @"RuntimeError: " + self.message;
 }

 */

#pragma mark - Options

//// merge options
//+ (BOOL)merge:(id)destination
//         with:(id)source {
//    /*
//     Vex.RERR = Vex.RuntimeError;
//
//     **
//     * Merge "destination" hash with "source" hash, overwriting like keys
//     * in "source" if necessary.
//     *
//     Vex.Merge = function(destination, source) {
//     for (var property in source)
//     destination[property] = source[property];
//     return destination;
//     };
//
//     *//*
//        //+ (id<VFTickableDelegate>)merge:(id<VFTickableDelegate>)destination
//        //                                with:(id<VFTickableDelegate>)source {
//        //    Class destinationClass = [destination class];
//        //    Class sourceClass = [source class];
//        //    NSDictionary *destinationProperties = [VFPropertyUtil classPropsFor:destinationClass];
//        //    NSDictionary *sourceProperties = [VFPropertyUtil classPropsFor:sourceClass];
//        //    NSMutableSet *destinationSet = [NSMutableSet setWithArray:[destinationProperties allKeys]];
//        //    NSMutableSet *sourceSet = [NSMutableSet setWithArray:[sourceProperties allKeys]];
//        //    [destinationSet intersectSet:sourceSet];
//        //    for (NSString *key in destinationSet) {
//        //        [destination setValue:[source valueForKey:key] forKey:key];
//        //    }
//        //    return destination;
//        //}
//        //
//        //
//        //    //http://stackoverflow.com/a/9252208/629014
//        //
//        //https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
//        //    unsigned int numOfProperties;
//        //    objc_property_t *properties = class_copyPropertyList([self class], &numOfProperties);
//        //    for ( unsigned int pi = 0; pi < numOfProperties; pi++ ) {
//        //        // Examine the property attributes
//        //        unsigned int numOfAttributes;
//        //        objc_property_attribute_t *propertyAttributes = property_copyAttributeList(properties[pi],
//        &numOfAttributes);
//        //        for ( unsigned int ai = 0; ai < numOfAttributes; ai++ ) {
//        //            switch (propertyAttributes[ai].name[0]) {
//        //                case 'T': // type
//        //                    break;
//        //                case 'R': // readonly
//        //                    break;
//        //                case 'C': // copy
//        //                    break;
//        //                case '&': // retain
//        //                    break;
//        //                case 'N': // nonatomic
//        //                    break;
//        //                case 'G': // custom getter
//        //                    break;
//        //                case 'S': // custom setter
//        //                    break;
//        //                case 'D': // dynamic
//        //                    break;
//        //                default:
//        //                    break;
//        //            }
//        //        }
//        //        free(propertyAttributes);
//        //    }
//        //    free(properties);
//        //
//        //    //TODO: finish this method
//        //
//        //
//        //
//        //    return destination;
//        */
//    /*
//     //    //http://stackoverflow.com/a/10944587/629014
//     //    const char * destinationClassName = class_getName([destination class]);
//     //    const char * sourceClassName = class_getName([source class]);
//     //
//     //    // string comparison, are the two class names equal
//     //    if (strcmp(destinationClassName, sourceClassName) != 0) {
//     //        [VFLog LogError:@"ClassComparisonException, must compare two classes of the same type."];
//     //    }
//     */
//
//    if (source == destination) {
//        [VFLog LogInfo:@"MergeOptionsWarning, attempting to merge two identical options objects together."];
//        return YES;
//    }
//    if ([source conformsToProtocol:@protocol(OptionsDelegate)] &&
//        [destination conformsToProtocol:@protocol(OptionsDelegate)]) {
//    } else {
//        return NO;
//    }
//
//    return YES;
//}

@end
