//
//  VFLog.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
@import UIKit;
#elif TARGET_OS_MAC
@import AppKit;
#endif

//#import <CocoaLumberjack/CocoaLumberjack.h>

@class VFColor;

//======================================================================================================================
/** The `VFVex` class performs logging, merging of data structurs

 */
@interface VFLog : NSObject
#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */

+ (void)drawDotWithContext:(CGContextRef)ctx atX:(CGFloat)x atY:(CGFloat)y withColor:(VFColor*)color;

+ (void)logDebug:(NSString*)format, ...;
+ (void)logInfo:(NSString*)format, ...;
+ (void)logWarn:(NSString*)format, ...;
+ (void)logError:(NSString*)format, ...;
+ (void)logFatal:(NSString*)format, ...;

+ (void)logVexDump:(NSString*)msg;

+ (void)logNotYetImplementedForClass:(id)obj andSelector:(SEL)sel;

+ (NSString*)formatObject:(id)objString;

//+ (void)Assert:(BOOL)condition withMessage:(NSString *)message;
//+ (void)RaiseException:(NSString * const)exception withFormat:(NSString *)aFormat, ...;

@end
