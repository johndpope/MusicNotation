//
//  VFFont.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

//@import Foundation;

#import <TargetConditionals.h>
#if TARGET_OS_IPHONE
@import UIKit;
//#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
@import AppKit;
#import <Cocoa/Cocoa.h>
#endif

//#define VFFont UIFont
//======================================================================================================================
/** The `VFFont` class performs ...

 The following demonstrates some basic usage of this class.

 ExampleCode
 */
#if TARGET_OS_IPHONE
@interface VFFont : UIFont
#elif TARGET_OS_MAC
@interface VFFont : NSFont
#endif
{
}

@property (assign, nonatomic) BOOL bold;
@property (assign, nonatomic) BOOL italic;
@property (assign, nonatomic, readonly) float size;

+ (NSArray*)fontNames;
+ (VFFont*)fontWithName:(NSString*)fontName size:(CGFloat)fontSize;
+ (VFFont*)fontWithName:(NSString*)fontName size:(CGFloat)fontSize weight:(NSString*)weight;

+ (id)setFont:(NSString*)fontName;
+ (id)setStrokeStyle:(NSString*)strokeStyle;
+ (id)setFillStyle:(NSString*)fillStyle;

@end
