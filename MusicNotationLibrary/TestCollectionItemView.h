//
//  TestCollectionItemView.h
//  MusicApp
//
//  Created by Scott on 8/8/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import <TargetConditionals.h>

#if TARGET_OS_IPHONE
#import <UIKit/UIKit.h>
#elif TARGET_OS_MAC
#import <AppKit/AppKit.h> //<Cocoa/Cocoa.h>
#endif


@class VFStaffNote, VFStaff, RenderLayer;

#if TARGET_OS_IPHONE
@interface TestCollectionItemView : UIView
#elif TARGET_OS_MAC
@interface TestCollectionItemView : NSView
#endif

@property (weak, nonatomic) RenderLayer* hostedRenderLayer;


- (VFStaffNote*)showStaffNote:(VFStaffNote*)staffNote
                      onStaff:(VFStaff*)staff
                  withContext:(CGContextRef)ctx
                          atX:(float)x
              withBoundingBox:(BOOL)drawBoundingBox;
- (VFStaffNote*)showNote:(NSDictionary*)noteStruct onStaff:(VFStaff*)staff withContext:(CGContextRef)ctx atX:(float)x;
- (VFStaffNote*)showNote:(NSDictionary*)noteStruct
                 onStaff:(VFStaff*)staff
             withContext:(CGContextRef)ctx
                     atX:(float)x
         withBoundingBox:(BOOL)drawBoundingBox;

@end
