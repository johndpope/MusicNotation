//
//  VFTestViewController.h
//  MusicApp
//
//  Created by Scott on 8/3/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "VFVexCore.h"

#define HC_SHORTHAND
#import "OCHamcrest.h"
//#import "IAModelBase.h"
#import "TestCollectionItemView.h"
#import "TestTuple.h"
#import "ViewStaffStruct.h"

@class RenderLayer;

#if TARGET_OS_IPHONE

typedef UIButton VFButton;

@interface TestViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>
@property UITableViewCell* currentCell;

#elif TARGET_OS_MAC

typedef NSButton VFButton;

@interface TestViewController
    : NSViewController <NSCollectionViewDataSource, NSCollectionViewDelegateFlowLayout>   // NSCollectionViewDelegate>
//@property NSView* currentCell;

#endif

- (void)start;

- (CGRect)frameAtIndex:(NSUInteger)index;

- (void)runTest:(NSString*)name func:(SEL)selector;
- (void)runTest:(NSString*)name func:(SEL)selector params:(NSObject*)params;

- (void)runTest:(NSString*)name func:(SEL)selector frame:(CGRect)frame;
- (void)runTest:(NSString*)name func:(SEL)selector frame:(CGRect)frame params:(NSObject*)params;

- (RenderLayer*)renderLayer;

@end
