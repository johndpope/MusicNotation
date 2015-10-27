//
//  MTMTestViewController.h
//  MusicApp
//
//  Created by Scott on 8/1/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <ReflectableEnum/ReflectableEnum.h>
#import "TestType.h"

@interface MTMTestViewController : UITableViewController

@property (assign, nonatomic) TestType testType;

@end
