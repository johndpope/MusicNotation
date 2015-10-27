//
//  VFTablesAccidentalCodes.h
//  VexFlow
//
//  Created by Scott on 3/21/15.
//  Copyright (c) 2015 feedbacksoftware.com. All rights reserved.
//

//#import <Cocoa/Cocoa.h>
#import "IAModelBase.h"

@interface VFTablesAccidentalCodes : IAModelBase
@property(strong, nonatomic) NSString *code;
@property(assign, nonatomic) NSUInteger width;
@property(assign, nonatomic) float gracenote_width;
@property(assign, nonatomic) NSInteger shift_right;
@property(assign, nonatomic) NSInteger shift_down;
@end
