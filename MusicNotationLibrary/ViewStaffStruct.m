//
//  ViewStaffStruct.m
//  MusicApp
//
//  Created by Scott on 8/8/15.
//  Copyright © 2015 feedbacksoftware.com. All rights reserved.
//

#import "ViewStaffStruct.h"
#import "VFStaff.h"
#import "TestCollectionItemView.h"

@implementation ViewStaffStruct

+ (ViewStaffStruct*)contextWithStaff:(VFStaff*)staff andView:(TestCollectionItemView*)testView;
{
    ViewStaffStruct* ret = [[ViewStaffStruct alloc] init];
    ret.staff = staff;
    ret.view = testView;
    return ret;
}

@end
