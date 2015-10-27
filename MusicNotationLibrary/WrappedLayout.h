//
//  WrappedLayout.h
//  MusicApp
//
//  Created by Scott on 8/5/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class TestViewController;

@interface WrappedLayout : NSCollectionViewFlowLayout

@property (strong, nonatomic) TestViewController* testViewController;

@end
