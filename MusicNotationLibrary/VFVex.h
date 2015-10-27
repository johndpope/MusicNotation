//
//  VFVex.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoft.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
@import UIKit;
#elif TARGET_OS_MAC
@import AppKit;
#endif

#import "VFLog.h"
#import "VFMath.h"
#import "VFUtils.h"
#import "VFPropertyUtil.h"
#import "NSObject+NSObjectAdditions.h"
#import "NSString+NSStringAdditions.h"
#import "NSMutableArray+JSAdditions.h"
#import "NSMutableDictionary+NSMutableDictionaryAdditions.h"
#import "OCTotallyLazy.h"
#import "vfMacros.h"
#import "VFFont.h"

//#import <CocoaLumberjack/CocoaLumberjack.h>

@interface VFVex : NSObject

typedef BOOL (^EqualBlock)(NSNumber *, NSNumber *);

+ (void)RaiseException:(NSString *const)exception
            withFormat:(NSString *)aFormat, ...;

+ (NSArray *)sortAndUnique:(NSArray *)arr
                   withCmp:(NSComparator)cmp
                     andEq:(EqualBlock)eq;

@end
