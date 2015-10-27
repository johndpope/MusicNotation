//
//  VFKit.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
@import Foundation;
//======================================================================================================================
/** The `VFKit` class performs ...
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFKit : NSObject

@end
#elif TARGET_OS_MAC
@import AppKit;
//======================================================================================================================
/** The `VFKit` class performs ...
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFKit : NSObject

@end
#endif


