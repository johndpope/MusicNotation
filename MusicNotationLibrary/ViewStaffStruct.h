//
//  ViewStaffStruct.h
//  MusicApp
//
//  Created by Scott on 8/8/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "IAModelBase.h"

@class VFStaff, TestCollectionItemView;

@interface ViewStaffStruct : IAModelBase

@property (strong, nonatomic) VFStaff* staff;
@property (strong, nonatomic) TestCollectionItemView* view;
+ (ViewStaffStruct*)contextWithStaff:(VFStaff*)staff andView:(TestCollectionItemView*)testView;

@end
