//
//  TestCollectionItemView.m
//  MusicApp
//
//  Created by Scott on 8/8/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "TestCollectionItemView.h"
#import "RenderLayer.h"
#import "VFVexCore.h"
#import "LayerResponder.h"

@interface TestCollectionItemView ()

@property (assign, nonatomic) BOOL activated;

@end

@implementation TestCollectionItemView

- (instancetype)init
{
    self = [super init];
    if(self)
    {
        _activated = NO;
    }
    return self;
}

- (BOOL)isFlipped
{
#if TARGET_OS_IPHONE
    return NO;
#elif TARGET_OS_MAC
    return YES;
#endif
}

- (VFStaffNote*)showStaffNote:(VFStaffNote*)staffNote
                      onStaff:(VFStaff*)staff
                  withContext:(CGContextRef)ctx
                          atX:(float)x
              withBoundingBox:(BOOL)drawBoundingBox;
{
    return [((RenderLayer*)self.layer)showStaffNote:staffNote
                                            onStaff:staff
                                        withContext:ctx
                                                atX:x
                                    withBoundingBox:drawBoundingBox];
}

- (VFStaffNote*)showNote:(NSDictionary*)noteStruct onStaff:(VFStaff*)staff withContext:(CGContextRef)ctx atX:(float)x
{
    return [((RenderLayer*)self.layer)showNote:noteStruct onStaff:staff withContext:ctx atX:x withBoundingBox:NO];
}

- (VFStaffNote*)showNote:(NSDictionary*)noteStruct
                 onStaff:(VFStaff*)staff
             withContext:(CGContextRef)ctx
                     atX:(float)x
         withBoundingBox:(BOOL)drawBoundingBox
{
    return [((RenderLayer*)self.layer)showNote:noteStruct
                                       onStaff:staff
                                   withContext:ctx
                                           atX:x
                               withBoundingBox:drawBoundingBox];
}

- (void)setLayer:(CALayer*)layer
{
    [super setLayer:layer];
    // if([layer isKindOfClass:[RenderLayer class]])
    //#ifdef TARGET_OS_IPHONE
    //
    //#elif TARGET_OS_MAC
    if([layer conformsToProtocol:@protocol(LayerResponder)])
    {
        self.hostedRenderLayer = (RenderLayer*)layer;
    }
    //#endif
}

- (NSView*)hitTest:(NSPoint)aPoint
{
    // Hit-test against the slide's rounded-rect shape.
    NSPoint pointInSelf = [self convertPoint:aPoint fromView:self.superview];
    NSRect bounds = self.bounds;
    if(!NSPointInRect(pointInSelf, bounds))
    {
        NSLog(@"NO");
        //        self.layer.borderColor = nil;
        return NO;
    }
    else
    {
        //        NSLog(@"YES");
        //        //        self.layer.borderColor = [NSColor orangeColor].CGColor;
        //        if(_activated)
        //        {
        //            self.layer.borderColor = [NSColor blueColor].CGColor;
        //        }
        //        else
        //        {
        //            self.layer.borderColor = nil;
        //        }
        return [super hitTest:aPoint];
    }
}

- (void)mouseDown:(NSEvent*)theEvent
{
    [super mouseDown:theEvent];

    BOOL handled = NO;

    CGPoint pointOfMouseDown = NSPointToCGPoint([self convertPoint:[theEvent locationInWindow] fromView:nil]);
    RenderLayer* theRenderLayer = self.hostedRenderLayer;

    if(theRenderLayer)
    {
        //        for(CALayer* sublayer in theRenderLayer.sublayers.reverseObjectEnumerator)
        //        {
        //            if([sublayer conformsToProtocol:@protocol(LayerResponder)])
        //            {
        CGPoint pointInHostedLayer = [self.layer convertPoint:pointOfMouseDown toLayer:theRenderLayer];
        handled = [theRenderLayer pointingDeviceDownEvent:theEvent atPoint:pointInHostedLayer];
        //            }
        //        }
    }

    if(!handled)
    {
        [self.nextResponder mouseDown:theEvent];
    }

    _activated = YES;
    self.layer.borderColor = [NSColor blueColor].CGColor;
}

- (void)mouseUp:(NSEvent*)theEvent
{
    [super mouseUp:theEvent];

    _activated = NO;
    self.layer.borderColor = nil;
}

@end