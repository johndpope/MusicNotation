//
//  RenderLayer.h
//  MusicApp
//
//  Created by Scott on 8/8/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "TestAction.h"
#import "LayerResponder.h"

@class VFStaff, VFStaffNote, TestCollectionItemView;

@interface RenderLayer : CALayer <LayerResponder>
//{
//    NSColor *_borderColor;
//}

@property (weak, nonatomic) TestCollectionItemView* parentView;
@property (strong, nonatomic) TestAction* _Nullable testAction;

//- (nonnull instancetype)initWithTarget:(nonnull id)target selector:(nonnull SEL)sel object:(nullable id)arg;

//- (void)clearLayer;
//
//- (VFStaffNote* _Nonnull)showStaffNote:(VFStaffNote* _Nonnull)staffNote
//                               onStaff:(VFStaff* _Nonnull)staff
//                           withContext:(CGContextRef _Nonnull)ctx
//                                   atX:(float)x
//                       withBoundingBox:(BOOL)drawBoundingBox;
//
//- (VFStaffNote* _Nonnull)showNote:(NSDictionary* _Nonnull)noteStruct
//                          onStaff:(VFStaff* _Nonnull)staff
//                      withContext:(CGContextRef _Nonnull)ctx
//                              atX:(float)x;
//- (VFStaffNote* _Nonnull)showNote:(NSDictionary* _Nonnull)noteStruct
//                 onStaff:(VFStaff* _Nonnull)staff
//             withContext:(CGContextRef _Nonnull)ctx
//                     atX:(float)x
//         withBoundingBox:(BOOL)drawBoundingBox;
//
//@end

//{
//    NSColor *_borderColor;
//}

//@property (weak, nonatomic) TestCollectionItemView* parentView;
//@property (strong, nonatomic) TestAction* _Nullable testAction;

//- (nonnull instancetype)initWithTarget:(nonnull id)target selector:(nonnull SEL)sel object:(nullable id)arg;

- (void)clearLayer;

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
