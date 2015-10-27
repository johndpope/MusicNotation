//
//  VFShapeLayer.m
//  MusicApp
//
//  Created by Scott on 8/13/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFShapeLayer.h"

@implementation VFShapeLayer

//- (BOOL)pointingDeviceDownEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint
//{
//    BOOL handled = NO;
//    
//    for(CALayer* sublayer in self.sublayers.reverseObjectEnumerator)
//    {
//        if(sublayer && [sublayer conformsToProtocol:@protocol(LayerResponder)])   //||
//            //           [sublayer respondsToSelector:@selector(pointingDeviceDownEvent:atPoint:)])
//        {
//            CGPoint pointInHostedLayer = [self convertPoint:interactionPoint toLayer:sublayer];
//            handled = [((id<LayerResponder>)sublayer)pointingDeviceDownEvent:event atPoint:pointInHostedLayer];
//            if(handled)
//            {
//                break;
//            }
//        }
//    }
//    
//    return handled;
//}

- (void)animate
{
    POPSpringAnimation* scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
    scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
    scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.3f, 1.3f)];
    scaleAnimation.springBounciness = 18.0f;
    [self pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
    self.opacity = 0.5;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        POPSpringAnimation* scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerScaleXY];
        scaleAnimation.velocity = [NSValue valueWithCGSize:CGSizeMake(3.f, 3.f)];
        scaleAnimation.toValue = [NSValue valueWithCGSize:CGSizeMake(1.f, 1.f)];
        scaleAnimation.springBounciness = 18.0f;
        [self pop_addAnimation:scaleAnimation forKey:@"layerScaleSpringAnimation"];
        self.opacity = 1.0;
    });
}

- (BOOL)pointingDeviceDownEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint
{
    BOOL handled = NO;
    
    //    for(CALayer* sublayer in self.sublayers.reverseObjectEnumerator)
    //    {
    //        if(sublayer || [sublayer conformsToProtocol:@protocol(LayerResponder)] ||
    //           [sublayer respondsToSelector:@selector(pointingDeviceDownEvent:atPoint:)])
    //        {
    //            CGPoint pointInHostedLayer = [self convertPoint:interactionPoint toLayer:sublayer];
    //            handled = [self pointingDeviceDownEvent:event atPoint:pointInHostedLayer];
    //        }
    //    }
    
    if(CGRectContainsPoint(self.bounds, interactionPoint))
    {
        static NSUInteger i = 1;
        NSLog(@"clicked: %lu", i++);
        [self animate];
        handled = YES;
    }
    
    return handled;
}

- (BOOL)pointingDeviceUpEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint
{
    return NO;
}

- (BOOL)pointingDeviceDraggedEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint
{
    return NO;
}

- (BOOL)pointingDeviceCancelledEvent:(NSEvent*)event
{
    return NO;
}

@end
