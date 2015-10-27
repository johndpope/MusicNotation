//
//  VFImage.h
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
/** The `VFImage` class performs ...
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
//@interface VFImage : UIImage
//
//@end
#elif TARGET_OS_MAC
@import AppKit;
//======================================================================================================================
/** The `VFImage` class performs ...
 
 The following demonstrates some basic usage of this class.
 
 ExampleCode
 */
@interface VFImage : NSImage
#pragma mark - Methods
/**---------------------------------------------------------------------------------------------------------------------
 * @name Methods
 * ---------------------------------------------------------------------------------------------------------------------
 */
- (void)drawAtPoint:(CGPoint)point;
- (CGImageRef)CGImageForProposedRect:(NSRect *)proposedDestRect context:(NSGraphicsContext *)referenceContext hints:(NSDictionary *)hints; 
@end
#endif