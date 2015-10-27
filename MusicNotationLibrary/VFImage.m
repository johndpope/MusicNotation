//
//  VFImage.m
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

// Not Finished
// Complete

#import "VFImage.h"
#import "VFVex.h"

#if TARGET_OS_IPHONE

#elif TARGET_OS_MAC
@implementation VFImage

- (void)drawAtPoint:(CGPoint)point;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
}

- (CGImageRef)CGImageForProposedRect:(NSRect*)proposedDestRect
                             context:(NSGraphicsContext*)referenceContext
                               hints:(NSDictionary*)hints;
{
    [VFLog logNotYetImplementedForClass:self andSelector:_cmd];
    return nil;
}

@end
#endif
