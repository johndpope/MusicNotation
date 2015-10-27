//
//  ViewController.h
//  VexFlow
//
//  Created by Scott Riccardelli on 1/1/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TestType.h"

@interface BrowserWindowController : NSWindowController <
                                         // NSCollectionViewDataSource,
                                         // NSCollectionViewDelegate,
                                         // NSCollectionViewDelegateFlowLayout,
                                         NSSplitViewDelegate,
                                         NSToolbarDelegate>
{
    __weak IBOutlet NSSplitView *_splitView;
    __weak IBOutlet NSCollectionView* _collectionView;
    __weak IBOutlet NSToolbar* _toolbar;
    __weak IBOutlet NSToolbarItem* _showHideToolbarButton;
    __weak IBOutlet NSToolbarItem *windowTitleToolbarItem;
}

@property (assign, nonatomic) TestType testType;

@end
