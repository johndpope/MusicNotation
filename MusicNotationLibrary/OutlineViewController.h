//
//  OutlineViewController.h
//  HereWeGoAgain
//
//  Created by Scott Riccardelli on 6/6/15.
//  Copyright (c) 2015 Scott Riccardelli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

@interface OutlineViewController : NSObject <NSOutlineViewDataSource, NSOutlineViewDelegate>

@property (strong, nonatomic) NSMutableArray* tests;

@end
