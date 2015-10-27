//
//  LayerResponder.h
//  MusicApp
//
//  Created by Scott on 8/11/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//#ifdef TARGET_OS_IPHONE
//@protocol LayerResponder <NSObject>
//@end
//#elif TARGET_OS_MAC
@protocol LayerResponder <NSObject>
@optional
- (BOOL)pointingDeviceDownEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint;
- (BOOL)pointingDeviceUpEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint;
- (BOOL)pointingDeviceDraggedEvent:(NSEvent*)event atPoint:(CGPoint)interactionPoint;
- (BOOL)pointingDeviceCancelledEvent:(NSEvent*)event;

@end

//#endif