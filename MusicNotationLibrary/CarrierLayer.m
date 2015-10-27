//
//  CarrierLayer.m
//  MusicApp
//
//  Created by Scott on 8/12/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "CarrierLayer.h"


#ifdef TARGET_OS_IPHONE
@implementation CarrierLayer
@end
#elif TARGET_OS_MAC



- (BOOL)pointingDeviceDownEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint
{
    BOOL handled = NO;
    
    for(CALayer* sublayer in self.sublayers.reverseObjectEnumerator)
    {
        if(sublayer && [sublayer conformsToProtocol:@protocol(LayerResponder)])   //||
            //           [sublayer respondsToSelector:@selector(pointingDeviceDownEvent:atPoint:)])
        {
            CGPoint pointInHostedLayer = [self convertPoint:interactionPoint toLayer:sublayer];
            handled = [((id<LayerResponderMAC>)sublayer) pointingDeviceDownEvent:event atPoint:pointInHostedLayer];
            if(handled)
            {
                break;
            }
        }
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


#endif
